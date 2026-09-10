# ================================================================
# GGPLOT2 POR CAPAS: GRÁFICA DE CAJAS PARA PUBLICACIÓN
# Material complementario de la sesión 2
# ================================================================

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

dir.create("resultados/infografia_ggplot", recursive = TRUE,
           showWarnings = FALSE)


# 1. DATOS --------------------------------------------------------

datos <- read_csv(
  "datos/biomarcadores_clinicos.csv",
  show_col_types = FALSE
)

datos_limpios <- datos |>
  drop_na(hemoglobina_g_dl, pcr_mg_l) |>
  mutate(
    grupo = factor(
      grupo,
      levels = c("Control", "Enfermedad estable", "Enfermedad activa")
    )
  )


# 2. CAPA GEOMÉTRICA: LA CAJA ------------------------------------

paso_1 <- ggplot(
  datos_limpios,
  aes(x = grupo, y = pcr_mg_l)
) +
  geom_boxplot()

ggsave(
  "resultados/infografia_ggplot/paso_1_caja.png",
  paso_1, width = 7, height = 4.5, dpi = 300, bg = "white"
)


# 3. SEGUNDA CAPA: OBSERVACIONES INDIVIDUALES --------------------

paso_2 <- ggplot(
  datos_limpios,
  aes(x = grupo, y = pcr_mg_l)
) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(
    position = position_jitter(width = 0.10, seed = 123),
    alpha = 0.75,
    size = 2
  )

ggsave(
  "resultados/infografia_ggplot/paso_2_puntos.png",
  paso_2, width = 7, height = 4.5, dpi = 300, bg = "white"
)


# 4. ESCALA: ORDEN Y COLORES -------------------------------------

colores_grupo <- c(
  "Control" = "#264653",
  "Enfermedad estable" = "#2A9D8F",
  "Enfermedad activa" = "#E76F51"
)

paso_3 <- ggplot(
  datos_limpios,
  aes(x = grupo, y = pcr_mg_l, fill = grupo)
) +
  geom_boxplot(
    width = 0.52,
    alpha = 0.55,
    outlier.shape = NA
  ) +
  geom_point(
    position = position_jitter(width = 0.10, seed = 123),
    shape = 21,
    size = 2.2,
    alpha = 0.80
  ) +
  scale_fill_manual(values = colores_grupo)

ggsave(
  "resultados/infografia_ggplot/paso_3_colores.png",
  paso_3, width = 7, height = 4.5, dpi = 300, bg = "white"
)


# 5. ETIQUETAS, TEMA Y TAMAÑO MUESTRAL ----------------------------

n_grupos <- datos_limpios |>
  count(grupo) |>
  mutate(etiqueta = paste0("n = ", n))

grafico_publicacion <- paso_3 +
  geom_text(
    data = n_grupos,
    aes(x = grupo, y = 19.5, label = etiqueta),
    inherit.aes = FALSE,
    size = 3.6
  ) +
  labs(
    x = NULL,
    y = "Proteína C reactiva (mg/L)"
  ) +
  coord_cartesian(ylim = c(0, 20)) +
  theme_classic(base_size = 12) +
  theme(
    legend.position = "none",
    axis.text.x = element_text(color = "#263238"),
    axis.text.y = element_text(color = "#263238"),
    axis.title.y = element_text(margin = margin(r = 8))
  )

if (interactive()) print(grafico_publicacion)


# 6. EXPORTACIÓN --------------------------------------------------

# PNG de alta resolución para presentaciones y algunos manuscritos.
ggsave(
  "resultados/infografia_ggplot/pcr_cajas_publicacion.png",
  grafico_publicacion,
  width = 170,
  height = 120,
  units = "mm",
  dpi = 600,
  bg = "white"
)

# PDF vectorial para conservar líneas y texto nítidos.
ggsave(
  "resultados/infografia_ggplot/pcr_cajas_publicacion.pdf",
  grafico_publicacion,
  width = 170,
  height = 120,
  units = "mm",
  bg = "white"
)
