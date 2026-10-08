# ==============================================================================
# PREPARACION REPRODUCIBLE DEL DATASET DOCENTE GSE126848
# Este script es para el docente. Los alumnos reciben los CSV ya preparados.
# ==============================================================================

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(stringr)
  library(purrr)
  library(tibble)
})

ruta_conteos_geo <- "datos/GSE126848_Gene_counts_raw.txt.gz"
ruta_soft_geo <- "datos/GSE126848_family.soft.gz"

if (!file.exists(ruta_conteos_geo) || !file.exists(ruta_soft_geo)) {
  stop(
    "Faltan los archivos originales de GEO en datos/. ",
    "Consulte datos/README_fuente_datos.md."
  )
}

leer_bloques_soft <- function(ruta) {
  lineas <- readLines(gzfile(ruta), warn = FALSE)
  inicios <- which(startsWith(lineas, "^SAMPLE = "))

  extraer_campo <- function(bloque, patron) {
    valor <- bloque[startsWith(bloque, patron)]
    if (length(valor) == 0) return(NA_character_)
    str_trim(str_remove(valor[[1]], fixed(patron)))
  }

  map_dfr(seq_along(inicios), function(i) {
    fin <- if (i < length(inicios)) inicios[i + 1] - 1 else length(lineas)
    bloque <- lineas[inicios[i]:fin]
    caracteristicas <- bloque[startsWith(bloque, "!Sample_characteristics_ch1 = ")]

    genero <- caracteristicas[str_detect(caracteristicas, "gender:")]
    enfermedad <- caracteristicas[str_detect(caracteristicas, "disease:")]

    tibble(
      geo_accession = extraer_campo(bloque, "!Sample_geo_accession = "),
      titulo_original = extraer_campo(bloque, "!Sample_title = "),
      id_descripcion = extraer_campo(bloque, "!Sample_description = "),
      sexo = str_trim(str_remove(genero[[1]], ".*gender:")),
      enfermedad_original = str_trim(str_remove(enfermedad[[1]], ".*disease:"))
    )
  })
}

conteos_geo <- read_tsv(ruta_conteos_geo, show_col_types = FALSE)
metadata_completa <- leer_bloques_soft(ruta_soft_geo) |>
  mutate(
    sample_id = if_else(
      as.integer(id_descripcion) < 1000,
      str_pad(id_descripcion, width = 4, side = "left", pad = "0"),
      id_descripcion
    ),
    cohorte_original = case_when(
      str_starts(titulo_original, "Normal-weight") ~ "Normal_peso",
      str_starts(titulo_original, "Obese") ~ "Obeso_sin_MASLD",
      str_starts(titulo_original, "NAFL_") ~ "NAFL_esteatosis",
      str_starts(titulo_original, "NASH_") ~ "NASH_MASH",
      TRUE ~ NA_character_
    )
  ) |>
  select(sample_id, geo_accession, titulo_original, sexo,
         enfermedad_original, cohorte_original)

if (!all(metadata_completa$sample_id %in% names(conteos_geo))) {
  stop("Hay muestras de metadatos que no aparecen en la matriz de conteos.")
}

# Contraste docente principal: NASH/MASH frente a personas con obesidad y
# histologia hepatica normal. Asi se estudia la enfermedad mas alla de la
# obesidad, sin exigir que el alumnado modele cuatro grupos en su primera clase.
metadata_docente <- metadata_completa |>
  filter(cohorte_original %in% c("Obeso_sin_MASLD", "NASH_MASH")) |>
  mutate(
    grupo = factor(
      cohorte_original,
      levels = c("Obeso_sin_MASLD", "NASH_MASH")
    ),
    descripcion_grupo = recode(
      cohorte_original,
      Obeso_sin_MASLD = "Obesidad con histologia hepatica normal",
      NASH_MASH = "NASH (terminologia historica; equivalente a MASH)"
    )
  ) |>
  arrange(grupo, sample_id)

conteos_docente <- conteos_geo |>
  select(ensembl_id = key, all_of(metadata_docente$sample_id))

dir.create("datos", showWarnings = FALSE, recursive = TRUE)
write_csv(metadata_completa, "datos/metadata_GSE126848_57_muestras.csv")
write_csv(metadata_docente, "datos/metadata_GSE126848_MASH_vs_obesidad.csv")
write_csv(conteos_docente, "datos/conteos_GSE126848_MASH_vs_obesidad.csv")

message("Dataset docente creado:")
message("  Genes: ", nrow(conteos_docente))
message("  Muestras: ", nrow(metadata_docente))
print(count(metadata_docente, grupo, name = "n"))
