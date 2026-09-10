# ================================================================
# ESTADÍSTICA DESCRIPTIVA EN R: UN FLUJO REPRODUCIBLE
# Datos sintéticos de ejemplo: biomarcadores de un estudio clínico
# ================================================================

# Trabajaremos de arriba hacia abajo. Ejecute una sección cada vez.
# En RStudio puede ejecutar una línea con Ctrl + Enter (Cmd + Enter en Mac).


# 0. PREPARACIÓN --------------------------------------------------

# Esta línea se ejecuta UNA SOLA VEZ para instalar los paquetes.
# Quite el símbolo # de la siguiente línea si necesita instalarlos.
# install.packages(c("readr", "dplyr", "tidyr", "ggplot2", "gt", "knitr"))

# Estas líneas se ejecutan cada vez que iniciamos R.
library(readr)    # leer archivos CSV
library(dplyr)    # ordenar y resumir datos
library(tidyr)    # cambiar la forma de una tabla
library(ggplot2)  # crear gráficos
library(gt)       # crear tablas académicas
library(knitr)    # exportar una tabla para LaTeX

# Crear la carpeta de resultados si todavía no existe.
dir.create("resultados", showWarnings = FALSE)


# ================================================================
# SESIÓN 1. DE CSV A ESTADÍSTICA DESCRIPTIVA
# ================================================================


# 1. CARGA DEL DATAFRAME ------------------------------------------

datos <- read_csv(
  "datos/biomarcadores_clinicos.csv",
  show_col_types = FALSE
)

# La asignación <- puede leerse como "guardar en".
# Aquí guardamos el CSV en un objeto llamado datos.


# 2. VISUALIZACIÓN E INSPECCIÓN -----------------------------------

if (interactive()) View(datos)  # abre la tabla cuando usamos RStudio
head(datos)       # muestra las primeras 6 filas
glimpse(datos)    # muestra columnas y tipos de variables
summary(datos)    # ofrece un primer resumen e informa los NA

# ¿Cuántos NA hay en cada columna?
colSums(is.na(datos))

# Diccionario de variables:
# id_paciente       = identificador anonimizado
# grupo             = categoría clínica
# hemoglobina_g_dl  = concentración de hemoglobina en g/dL
# pcr_mg_l          = proteína C reactiva en mg/L


# 3. LIMPIEZA DE DATOS --------------------------------------------

# En este ejercicio eliminaremos filas incompletas únicamente para
# las variables que analizaremos. En investigación real, primero hay
# que estudiar por qué faltan los datos.
datos_limpios <- datos |>
  drop_na(hemoglobina_g_dl, pcr_mg_l)

nrow(datos)          # antes: 36 filas
nrow(datos_limpios)  # después: 32 filas

# Guardamos una copia limpia para conservar el rastro del análisis.
write_csv(datos_limpios, "resultados/datos_limpios.csv")


# 4. VISUALIZACIÓN DE LAS DISTRIBUCIONES --------------------------

# Convertimos las dos mediciones en una sola columna llamada valor.
datos_largos <- datos_limpios |>
  pivot_longer(
    cols = c(hemoglobina_g_dl, pcr_mg_l),
    names_to = "variable",
    values_to = "valor"
  )

# Histogramas: buscamos simetría, colas y valores extremos.
grafico_histograma <- ggplot(datos_largos, aes(x = valor)) +
  geom_histogram(bins = 10, fill = "#2A9D8F", color = "white") +
  facet_wrap(~ variable, scales = "free") +
  labs(x = NULL, y = "Frecuencia") +
  theme_minimal(base_size = 13)

if (interactive()) print(grafico_histograma)

ggsave(
  "resultados/01_histogramas.png",
  grafico_histograma,
  width = 8, height = 4.5, dpi = 300
)

# Gráficos Q-Q: los puntos cercanos a la línea apoyan normalidad.
grafico_qq <- ggplot(datos_largos, aes(sample = valor)) +
  stat_qq(color = "#264653", alpha = 0.75) +
  stat_qq_line(color = "#E76F51", linewidth = 0.8) +
  facet_wrap(~ variable, scales = "free") +
  labs(x = "Cuantiles teóricos", y = "Cuantiles observados") +
  theme_minimal(base_size = 13)

if (interactive()) print(grafico_qq)

ggsave(
  "resultados/02_graficos_qq.png",
  grafico_qq,
  width = 8, height = 4.5, dpi = 300
)


# 5. PRUEBA DE NORMALIDAD -----------------------------------------

# Hipótesis de Shapiro-Wilk:
# H0: los datos son compatibles con una distribución normal.
# Si p >= 0.05, no rechazamos H0.
# Si p < 0.05, rechazamos H0.

normalidad <- datos_largos |>
  group_by(variable) |>
  summarise(
    n_total = n(),
    W = unname(shapiro.test(valor)$statistic),
    p = shapiro.test(valor)$p.value,
    .groups = "drop"
  ) |>
  mutate(
    decision = if_else(
      p >= 0.05,
      "Compatible con normalidad",
      "No compatible con normalidad"
    ),
    resumen_a_reportar = if_else(
      p >= 0.05,
      "Media ± DE",
      "Mediana (Q1–Q3)"
    )
  )

normalidad

# La decisión usa tanto los gráficos como la prueba. El valor 0.05
# es una regla práctica, no una frontera biológica absoluta.


# 6. ESTADÍSTICA DESCRIPTIVA --------------------------------------

# Calculamos AMBAS aproximaciones para practicar.
descriptivos <- datos_largos |>
  group_by(variable, grupo) |>
  summarise(
    n = n(),
    media = mean(valor),
    DE = sd(valor),
    mediana = median(valor),
    Q1 = quantile(valor, 0.25),
    Q3 = quantile(valor, 0.75),
    minimo = min(valor),
    maximo = max(valor),
    .groups = "drop"
  )

descriptivos

# Agregamos la decisión de normalidad a cada variable.
tabla_reporte <- descriptivos |>
  left_join(normalidad, by = "variable") |>
  mutate(
    medida = recode(
      variable,
      hemoglobina_g_dl = "Hemoglobina (g/dL)",
      pcr_mg_l = "Proteína C reactiva (mg/L)"
    ),
    resultado = if_else(
      p >= 0.05,
      sprintf("%.2f ± %.2f", media, DE),
      sprintf("%.1f (%.1f–%.1f)", mediana, Q1, Q3)
    ),
    p_shapiro = if_else(p < 0.001, "<0.001", sprintf("%.3f", p))
  ) |>
  select(medida, grupo, n, resultado,
         p_shapiro, resumen_a_reportar)

tabla_reporte


# ================================================================
# SESIÓN 2. REPORTE DE RESULTADOS
# ================================================================


# 7. TABLA ACADÉMICA ----------------------------------------------

tabla_academica <- tabla_reporte |>
  gt(groupname_col = "medida") |>
  cols_label(
    grupo = "Grupo clínico",
    n = "n",
    resultado = "Resumen",
    p_shapiro = "p de Shapiro-Wilk",
    resumen_a_reportar = "Medida reportada"
  ) |>
  tab_header(
    title = md("**Tabla 1. Estadística descriptiva de los biomarcadores**")
  ) |>
  tab_source_note(
    md("DE: desviación estándar; Q1–Q3: rango intercuartílico. La normalidad se evaluó por variable, además de inspeccionar histogramas y gráficos Q-Q.")
  ) |>
  opt_row_striping() |>
  tab_options(
    table.font.names = "Arial",
    table.font.size = px(13),
    heading.align = "left",
    data_row.padding = px(5)
  )

tabla_academica
gtsave(tabla_academica, "resultados/tabla_1_descriptivos.html")

# También exportamos la información como CSV.
write_csv(tabla_reporte, "resultados/tabla_1_descriptivos.csv")

# Versión LaTeX simple para manuscritos o diapositivas.
tabla_latex <- kable(
  tabla_reporte,
  format = "latex",
  booktabs = TRUE,
  escape = TRUE,
  caption = "Estadística descriptiva de los biomarcadores."
)
writeLines(tabla_latex, "resultados/tabla_1_descriptivos.tex")


# 8. GRÁFICOS PARA REPORTAR ---------------------------------------

# Variable compatible con normalidad: puntos + media ± DE.
grafico_hemoglobina <- ggplot(
  datos_limpios,
  aes(x = grupo, y = hemoglobina_g_dl, color = grupo)
) +
  geom_jitter(width = 0.12, alpha = 0.65, size = 2) +
  stat_summary(fun = mean, geom = "point", size = 4) +
  stat_summary(
    fun.data = mean_sdl,
    fun.args = list(mult = 1),
    geom = "errorbar",
    width = 0.12,
    linewidth = 0.9
  ) +
  scale_color_manual(values = c(
    "Control" = "#264653",
    "Enfermedad estable" = "#2A9D8F",
    "Enfermedad activa" = "#E76F51"
  )) +
  labs(
    x = NULL,
    y = "Hemoglobina (g/dL)",
    caption = "Punto grande: media. Barras: ± 1 DE."
  ) +
  theme_classic(base_size = 13) +
  theme(legend.position = "none")

if (interactive()) print(grafico_hemoglobina)

ggsave(
  "resultados/03_hemoglobina_media_DE.png",
  grafico_hemoglobina,
  width = 6.5, height = 4.8, dpi = 300
)

# Variable asimétrica: puntos + caja con mediana y RIQ.
grafico_pcr <- ggplot(
  datos_limpios,
  aes(x = grupo, y = pcr_mg_l, fill = grupo)
) +
  geom_boxplot(width = 0.5, alpha = 0.45, outlier.shape = NA) +
  geom_jitter(width = 0.12, alpha = 0.70, size = 2) +
  scale_fill_manual(values = c(
    "Control" = "#264653",
    "Enfermedad estable" = "#2A9D8F",
    "Enfermedad activa" = "#E76F51"
  )) +
  labs(
    x = NULL,
    y = "Proteína C reactiva (mg/L)",
    caption = "Línea central: mediana. Caja: Q1 a Q3."
  ) +
  theme_classic(base_size = 13) +
  theme(legend.position = "none")

if (interactive()) print(grafico_pcr)

ggsave(
  "resultados/04_pcr_mediana_RIQ.png",
  grafico_pcr,
  width = 6.5, height = 4.8, dpi = 300
)


# 9. FRASES MODELO PARA EL REPORTE --------------------------------

# Hemoglobina: "La hemoglobina fue compatible con una distribución
# normal (Shapiro-Wilk, W = 0.977, p = 0.713), por lo que se resumió como
# media ± DE."

# Proteína C reactiva: "La proteína C reactiva mostró una distribución
# asimétrica (Shapiro-Wilk, W = 0.531, p < 0.001), por lo que se resumió como
# mediana (Q1–Q3)."

# Importante: estas son descripciones. Para afirmar diferencias entre
# grupos necesitaríamos una prueba inferencial, que veremos en
# otro flujo de trabajo.
