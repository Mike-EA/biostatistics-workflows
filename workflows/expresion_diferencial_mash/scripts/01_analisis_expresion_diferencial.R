# ==============================================================================
# EXPRESION DIFERENCIAL EN MASH: WORKFLOW COMPLETO CON DESeq2
# Dataset: GSE126848, higado humano
# Contraste: NASH/MASH vs obesidad con histologia hepatica normal
# ==============================================================================

suppressPackageStartupMessages({
  library(DESeq2)
  library(AnnotationDbi)
  library(org.Hs.eg.db)
  library(EnhancedVolcano)
  library(pheatmap)
  library(RColorBrewer)
  # Se carga al final para que select() y filter() sean las versiones de dplyr.
  library(tidyverse)
})

# ----------------------------------------------------------------------------
# 0. PARAMETROS. Cambiarlos aqui modifica todo el analisis.
# ----------------------------------------------------------------------------

archivo_conteos <- "datos/conteos_GSE126848_MASH_vs_obesidad.csv"
archivo_metadata <- "datos/metadata_GSE126848_MASH_vs_obesidad.csv"
carpeta_resultados <- "resultados"

padj_corte <- 0.05
lfc_corte <- 1
n_heatmap <- 30

dir.create(carpeta_resultados, showWarnings = FALSE, recursive = TRUE)

# ----------------------------------------------------------------------------
# 1. IMPORTAR CONTEOS CRUDOS Y METADATOS
# ----------------------------------------------------------------------------

conteos_df <- read_csv(archivo_conteos, show_col_types = FALSE)
metadata <- read_csv(archivo_metadata, show_col_types = FALSE)

stopifnot(
  "ensembl_id" %in% names(conteos_df),
  all(c("sample_id", "grupo") %in% names(metadata)),
  !anyDuplicated(conteos_df$ensembl_id),
  !anyDuplicated(metadata$sample_id)
)

conteos <- conteos_df |>
  column_to_rownames("ensembl_id") |>
  as.matrix()

storage.mode(conteos) <- "integer"

# El orden debe coincidir: columna de conteos i = fila de metadatos i.
metadata <- metadata |>
  slice(match(colnames(conteos), sample_id)) |>
  mutate(grupo = factor(grupo, levels = c("Obeso_sin_MASLD", "NASH_MASH"))) |>
  column_to_rownames("sample_id")

stopifnot(identical(colnames(conteos), rownames(metadata)))

# ----------------------------------------------------------------------------
# 2. CONTROL DE CALIDAD BASICO Y FILTRADO
# ----------------------------------------------------------------------------

tamanos_biblioteca <- tibble(
  muestra = colnames(conteos),
  lecturas_asignadas = colSums(conteos),
  grupo = metadata$grupo
)

p_bibliotecas <- ggplot(
  tamanos_biblioteca,
  aes(x = reorder(muestra, lecturas_asignadas), y = lecturas_asignadas, fill = grupo)
) +
  geom_col(width = 0.82) +
  coord_flip() +
  scale_fill_manual(values = c("Obeso_sin_MASLD" = "#167D8D", "NASH_MASH" = "#B33A3A")) +
  scale_y_continuous(labels = scales::label_number(scale_cut = scales::cut_short_scale())) +
  labs(
    title = "Tamano de biblioteca por muestra",
    x = NULL,
    y = "Conteos asignados",
    fill = "Grupo"
  ) +
  theme_minimal(base_size = 12) +
  theme(panel.grid.major.y = element_blank())

ggsave(
  file.path(carpeta_resultados, "00_control_calidad_bibliotecas.png"),
  p_bibliotecas,
  width = 8.5,
  height = 7,
  dpi = 300
)

# Se retienen genes con al menos 10 conteos en 5 o mas muestras.
mantener <- rowSums(conteos >= 10) >= 5
conteos_filtrados <- conteos[mantener, ]

message("Genes originales: ", nrow(conteos))
message("Genes despues del filtro: ", nrow(conteos_filtrados))

# ----------------------------------------------------------------------------
# 3. MODELO DESEQ2 Y NORMALIZACION
# ----------------------------------------------------------------------------

dds <- DESeqDataSetFromMatrix(
  countData = conteos_filtrados,
  colData = metadata,
  design = ~ grupo
)

dds <- DESeq(dds)

# VST estabiliza la varianza para PCA y heatmap. No sustituye a los conteos
# crudos dentro del modelo de expresion diferencial.
vsd <- vst(dds, blind = FALSE)

pca_datos <- plotPCA(vsd, intgroup = "grupo", returnData = TRUE)
varianza <- round(100 * attr(pca_datos, "percentVar"))

p_pca <- ggplot(pca_datos, aes(PC1, PC2, color = grupo, label = name)) +
  geom_point(size = 3.2, alpha = 0.9) +
  ggrepel::geom_text_repel(size = 2.7, max.overlaps = 8, show.legend = FALSE) +
  scale_color_manual(values = c("Obeso_sin_MASLD" = "#167D8D", "NASH_MASH" = "#B33A3A")) +
  labs(
    title = "PCA de la expresion transformada",
    x = paste0("PC1: ", varianza[1], "%"),
    y = paste0("PC2: ", varianza[2], "%"),
    color = "Grupo"
  ) +
  theme_classic(base_size = 13)

ggsave(
  file.path(carpeta_resultados, "01_PCA.png"),
  p_pca,
  width = 8,
  height = 6,
  dpi = 300
)

# ----------------------------------------------------------------------------
# 4. CONTRASTE: NASH/MASH RESPECTO AL GRUPO DE REFERENCIA
# ----------------------------------------------------------------------------

res_crudo <- results(
  dds,
  contrast = c("grupo", "NASH_MASH", "Obeso_sin_MASLD"),
  alpha = padj_corte
)

# La contraccion del log2FC reduce magnitudes inestables en genes con poca
# informacion. Los p ajustados proceden del mismo modelo DESeq2.
coeficiente <- grep("grupo_NASH_MASH_vs_Obeso_sin_MASLD", resultsNames(dds), value = TRUE)
if (length(coeficiente) != 1) {
  stop("No se encontro el coeficiente esperado. Revise resultsNames(dds).")
}

res_shrink <- lfcShrink(dds, coef = coeficiente, type = "normal")

res <- as.data.frame(res_crudo) |>
  rownames_to_column("ensembl_id") |>
  select(ensembl_id, baseMean, lfcSE, stat, pvalue, padj) |>
  left_join(
    as.data.frame(res_shrink) |>
      rownames_to_column("ensembl_id") |>
      select(ensembl_id, log2FoldChange),
    by = "ensembl_id"
  )

res$symbol <- mapIds(
  org.Hs.eg.db,
  keys = res$ensembl_id,
  keytype = "ENSEMBL",
  column = "SYMBOL",
  multiVals = "first"
) |> unname()

res <- res |>
  mutate(
    gene = if_else(is.na(symbol) | symbol == "", ensembl_id, symbol),
    categoria = case_when(
      !is.na(padj) & padj < padj_corte & log2FoldChange >= lfc_corte ~ "Mayor en MASH",
      !is.na(padj) & padj < padj_corte & log2FoldChange <= -lfc_corte ~ "Menor en MASH",
      TRUE ~ "No cumple ambos cortes"
    )
  ) |>
  arrange(padj)

write_csv(res, file.path(carpeta_resultados, "resultados_DESeq2_todos_los_genes.csv"))
write_csv(
  filter(res, categoria != "No cumple ambos cortes"),
  file.path(carpeta_resultados, "resultados_DESeq2_significativos.csv")
)

# ----------------------------------------------------------------------------
# 5. VOLCANO PLOT
# ----------------------------------------------------------------------------

res_volcano <- res |>
  filter(!is.na(log2FoldChange), !is.na(padj)) |>
  mutate(
    padj_plot = pmax(padj, .Machine$double.xmin),
    etiqueta = if_else(row_number() <= 15 & categoria != "No cumple ambos cortes", gene, "")
  )

colores_volcano <- case_when(
  res_volcano$categoria == "Menor en MASH" ~ "#167D8D",
  res_volcano$categoria == "Mayor en MASH" ~ "#B33A3A",
  TRUE ~ "#A7ADB4"
)
names(colores_volcano) <- case_when(
  res_volcano$categoria == "Menor en MASH" ~ "Menor en MASH",
  res_volcano$categoria == "Mayor en MASH" ~ "Mayor en MASH",
  TRUE ~ "No cumple ambos cortes"
)

p_volcano <- EnhancedVolcano(
  res_volcano,
  lab = res_volcano$gene,
  selectLab = res_volcano$gene[res_volcano$etiqueta != ""],
  x = "log2FoldChange",
  y = "padj_plot",
  xlab = bquote(Log[2] ~ "fold change (MASH / obesidad sin MASLD)"),
  ylab = bquote(-Log[10] ~ "p ajustado"),
  title = "Expresion diferencial en higado humano",
  subtitle = "NASH/MASH vs obesidad con histologia hepatica normal",
  pCutoff = padj_corte,
  FCcutoff = lfc_corte,
  pointSize = 2.1,
  labSize = 3.5,
  colCustom = colores_volcano,
  colAlpha = 0.72,
  drawConnectors = TRUE,
  widthConnectors = 0.35,
  max.overlaps = Inf,
  legendPosition = "right",
  caption = paste0("Cortes: padj < ", padj_corte, "; |log2FC| >= ", lfc_corte)
)

ggsave(
  file.path(carpeta_resultados, "02_volcano_MASH_vs_obesidad.png"),
  p_volcano,
  width = 9,
  height = 7,
  dpi = 320
)
ggsave(
  file.path(carpeta_resultados, "02_volcano_MASH_vs_obesidad.pdf"),
  p_volcano,
  width = 9,
  height = 7
)

# ----------------------------------------------------------------------------
# 6. HEATMAP DE LOS GENES CON MAYOR EVIDENCIA
# ----------------------------------------------------------------------------

genes_heatmap <- res |>
  filter(!is.na(padj), padj < padj_corte) |>
  slice_head(n = n_heatmap) |>
  pull(ensembl_id)

if (length(genes_heatmap) < 2) {
  stop("Hay menos de dos genes con padj significativo; no se puede construir el heatmap.")
}

matriz_heatmap <- assay(vsd)[genes_heatmap, , drop = FALSE]

nombres_filas <- res |>
  filter(ensembl_id %in% genes_heatmap) |>
  select(ensembl_id, gene) |>
  distinct(ensembl_id, .keep_all = TRUE)

rownames(matriz_heatmap) <- make.unique(
  nombres_filas$gene[match(rownames(matriz_heatmap), nombres_filas$ensembl_id)]
)

# Estandarizacion por fila: para cada gen, 0 es su media entre muestras.
matriz_z <- t(scale(t(matriz_heatmap)))
matriz_z[!is.finite(matriz_z)] <- 0

anotacion_columnas <- data.frame(
  Grupo = metadata[colnames(matriz_z), "grupo", drop = TRUE],
  row.names = colnames(matriz_z)
)

colores_anotacion <- list(
  Grupo = c("Obeso_sin_MASLD" = "#167D8D", "NASH_MASH" = "#B33A3A")
)

png(
  file.path(carpeta_resultados, "03_heatmap_top_genes.png"),
  width = 3000,
  height = 2200,
  res = 300
)
pheatmap(
  matriz_z,
  annotation_col = anotacion_columnas,
  annotation_colors = colores_anotacion,
  color = colorRampPalette(c("#173F5F", "#F7F7F2", "#B33A3A"))(101),
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  show_colnames = FALSE,
  fontsize_row = 8,
  border_color = NA,
  main = paste0("Top ", length(genes_heatmap), " genes por p ajustado")
)
dev.off()

pdf(
  file.path(carpeta_resultados, "03_heatmap_top_genes.pdf"),
  width = 10,
  height = 7.3
)
pheatmap(
  matriz_z,
  annotation_col = anotacion_columnas,
  annotation_colors = colores_anotacion,
  color = colorRampPalette(c("#173F5F", "#F7F7F2", "#B33A3A"))(101),
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  show_colnames = FALSE,
  fontsize_row = 8,
  border_color = NA,
  main = paste0("Top ", length(genes_heatmap), " genes por p ajustado")
)
dev.off()

# ----------------------------------------------------------------------------
# 7. RESUMEN REPRODUCIBLE
# ----------------------------------------------------------------------------

resumen <- tibble(
  metrica = c(
    "muestras_control",
    "muestras_MASH",
    "genes_antes_filtro",
    "genes_despues_filtro",
    "genes_mayores_en_MASH",
    "genes_menores_en_MASH"
  ),
  valor = c(
    sum(metadata$grupo == "Obeso_sin_MASLD"),
    sum(metadata$grupo == "NASH_MASH"),
    nrow(conteos),
    nrow(conteos_filtrados),
    sum(res$categoria == "Mayor en MASH"),
    sum(res$categoria == "Menor en MASH")
  )
)

write_csv(resumen, file.path(carpeta_resultados, "resumen_analisis.csv"))
writeLines(capture.output(sessionInfo()), file.path(carpeta_resultados, "sessionInfo.txt"))

print(resumen)
message("\nAnalisis finalizado. Revise la carpeta resultados/.")
