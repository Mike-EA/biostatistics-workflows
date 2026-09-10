Guía definitiva de estadística descriptiva y visualización biomédica en
R
================
Biostatistics Workflows
Septiembre de 2026

- [1 Propósito de esta guía](#1-propósito-de-esta-guía)
  - [1.1 Archivos relacionados](#11-archivos-relacionados)
  - [1.2 Reproducibilidad y datos
    clínicos](#12-reproducibilidad-y-datos-clínicos)
- [2 Presentación principal, sesión 1: estadística descriptiva en
  R](#2-presentación-principal-sesión-1-estadística-descriptiva-en-r)
  - [2.1 La pregunta que organiza el
    flujo](#21-la-pregunta-que-organiza-el-flujo)
  - [2.2 Preparación de los paquetes](#22-preparación-de-los-paquetes)
    - [2.2.1 Qué hace cada línea](#221-qué-hace-cada-línea)
    - [2.2.2 Cómo modificarlo](#222-cómo-modificarlo)
  - [2.3 Carga del archivo CSV](#23-carga-del-archivo-csv)
    - [2.3.1 Explicación detallada](#231-explicación-detallada)
    - [2.3.2 Cómo modificarlo](#232-cómo-modificarlo)
  - [2.4 Estructura del dataframe
    biomédico](#24-estructura-del-dataframe-biomédico)
  - [2.5 Inspección inicial](#25-inspección-inicial)
    - [2.5.1 `glimpse(datos)`](#251-glimpsedatos)
    - [2.5.2 `summary(datos)`](#252-summarydatos)
    - [2.5.3 `is.na(datos)` y `colSums()`](#253-isnadatos-y-colsums)
    - [2.5.4 Cómo modificarlo](#254-cómo-modificarlo)
  - [2.6 Limpieza de valores ausentes](#26-limpieza-de-valores-ausentes)
    - [2.6.1 Lectura línea por línea](#261-lectura-línea-por-línea)
    - [2.6.2 Propósito estadístico](#262-propósito-estadístico)
    - [2.6.3 Advertencia biomédica](#263-advertencia-biomédica)
    - [2.6.4 Cómo modificarlo](#264-cómo-modificarlo)
  - [2.7 Transformación a formato
    largo](#27-transformación-a-formato-largo)
    - [2.7.1 Por qué se realiza](#271-por-qué-se-realiza)
    - [2.7.2 Significado de los
      argumentos](#272-significado-de-los-argumentos)
    - [2.7.3 Cómo modificarlo](#273-cómo-modificarlo)
  - [2.8 Inspección gráfica de la
    distribución](#28-inspección-gráfica-de-la-distribución)
    - [2.8.1 Histogramas](#281-histogramas)
    - [2.8.2 Gráficos Q-Q](#282-gráficos-q-q)
  - [2.9 Prueba de Shapiro-Wilk](#29-prueba-de-shapiro-wilk)
    - [2.9.1 Hipótesis e
      interpretación](#291-hipótesis-e-interpretación)
    - [2.9.2 Lectura del código](#292-lectura-del-código)
    - [2.9.3 Resultado del ejemplo](#293-resultado-del-ejemplo)
    - [2.9.4 Cómo modificarlo](#294-cómo-modificarlo)
  - [2.10 Estadística descriptiva paramétrica y no
    paramétrica](#210-estadística-descriptiva-paramétrica-y-no-paramétrica)
    - [2.10.1 Qué representa cada
      estadístico](#2101-qué-representa-cada-estadístico)
    - [2.10.2 Cómo modificarlo](#2102-cómo-modificarlo)
  - [2.11 Unión entre prueba y
    descriptivos](#211-unión-entre-prueba-y-descriptivos)
    - [2.11.1 Por qué se usa
      `left_join()`](#2111-por-qué-se-usa-left_join)
    - [2.11.2 Formato con `sprintf()`](#2112-formato-con-sprintf)
    - [2.11.3 Cómo modificarlo](#2113-cómo-modificarlo)
- [3 Presentación principal, sesión 2: reporte de
  resultados](#3-presentación-principal-sesión-2-reporte-de-resultados)
  - [3.1 Tabla académica con `gt`](#31-tabla-académica-con-gt)
    - [3.1.1 Explicación de las capas de la
      tabla](#311-explicación-de-las-capas-de-la-tabla)
    - [3.1.2 Vancouver y tablas](#312-vancouver-y-tablas)
    - [3.1.3 Exportación](#313-exportación)
  - [3.2 Figura paramétrica:
    hemoglobina](#32-figura-paramétrica-hemoglobina)
    - [3.2.1 Explicación](#321-explicación)
    - [3.2.2 Modificaciones útiles](#322-modificaciones-útiles)
  - [3.3 Figura no paramétrica: proteína C
    reactiva](#33-figura-no-paramétrica-proteína-c-reactiva)
    - [3.3.1 Por qué se combinan cajas y
      puntos](#331-por-qué-se-combinan-cajas-y-puntos)
    - [3.3.2 Escala logarítmica](#332-escala-logarítmica)
  - [3.4 Redacción de resultados](#34-redacción-de-resultados)
- [4 Infografía complementaria: funcionamiento de ggplot2 por
  capas](#4-infografía-complementaria-funcionamiento-de-ggplot2-por-capas)
  - [4.1 La gramática general](#41-la-gramática-general)
  - [4.2 Preparación y orden clínico](#42-preparación-y-orden-clínico)
  - [4.3 Paso 1: base y gráfica de
    cajas](#43-paso-1-base-y-gráfica-de-cajas)
  - [4.4 Paso 2: pacientes
    individuales](#44-paso-2-pacientes-individuales)
    - [4.4.1 Propósito de cada
      argumento](#441-propósito-de-cada-argumento)
  - [4.5 Paso 3: colores y consistencia
    visual](#45-paso-3-colores-y-consistencia-visual)
  - [4.6 Paso 4: unidades, tamaño muestral y
    tema](#46-paso-4-unidades-tamaño-muestral-y-tema)
    - [4.6.1 Cálculo del tamaño
      muestral](#461-cálculo-del-tamaño-muestral)
    - [4.6.2 `inherit.aes = FALSE`](#462-inheritaes--false)
    - [4.6.3 Etiquetas y coordenadas](#463-etiquetas-y-coordenadas)
    - [4.6.4 Tema](#464-tema)
  - [4.7 Exportación para publicación](#47-exportación-para-publicación)
- [5 Recetas para adaptar el flujo](#5-recetas-para-adaptar-el-flujo)
  - [5.1 Sustituir los biomarcadores](#51-sustituir-los-biomarcadores)
  - [5.2 Dos grupos en lugar de tres](#52-dos-grupos-en-lugar-de-tres)
  - [5.3 Varias visitas por paciente](#53-varias-visitas-por-paciente)
  - [5.4 Paneles para varios
    biomarcadores](#54-paneles-para-varios-biomarcadores)
  - [5.5 Cambiar colores](#55-cambiar-colores)
- [6 Errores frecuentes y solución](#6-errores-frecuentes-y-solución)
- [7 Lista de comprobación final](#7-lista-de-comprobación-final)
- [8 Referencias bibliográficas](#8-referencias-bibliográficas)

# 1 Propósito de esta guía

Este documento constituye la **guía definitiva para comprender, enseñar
y modificar** los dos materiales de la sesión:

1.  La presentación **Estadística descriptiva en R para biomedicina**.
2.  La infografía **ggplot2 por capas: gráfica de cajas para publicación
    científica**.

La presentación introduce el flujo completo, desde la importación de un
archivo CSV hasta la producción de tablas y figuras. La infografía
examina con mayor profundidad la lógica de `ggplot2` y construye una
gráfica de cajas capa por capa.

La prioridad no consiste en memorizar instrucciones. El objetivo es
comprender qué decisión representa cada bloque, por qué se ejecuta en
ese punto y qué debe modificarse cuando cambia el conjunto de datos.

> **Alcance docente.** Los datos son completamente sintéticos. Imitan la
> estructura de un estudio clínico piloto, pero no corresponden a
> pacientes reales y no deben utilizarse para conclusiones médicas.

## 1.1 Archivos relacionados

| Recurso                                      | Función                                                     |
|:---------------------------------------------|:------------------------------------------------------------|
| `datos/biomarcadores_clinicos.csv`           | Datos clínicos sintéticos utilizados en todos los ejemplos. |
| `scripts/01_estadistica_descriptiva.R`       | Flujo completo de la primera presentación.                  |
| `scripts/02_ggplot_caja_publicacion.R`       | Construcción por capas de la infografía.                    |
| `diapositivas/estadistica_descriptiva_R.pdf` | Presentación principal de las dos sesiones.                 |
| `diapositivas/infografia_ggplot_capas.pdf`   | Infografía complementaria de la sesión 2.                   |
| `resultados/`                                | Datos limpios, tablas y figuras generadas.                  |

#### 1.1.0.1 Cómo utilizar el R Markdown

Un archivo R Markdown combina texto, código ejecutable y resultados en
un mismo documento. Esta característica permite comprobar que las cifras
descritas en la explicación proceden realmente del código mostrado
(referencia 1).

En RStudio:

1.  Abra `biostatistics-workflows.Rproj`.
2.  Abra `GUIA_DEFINITIVA.Rmd`.
3.  Ejecute un bloque con el botón verde situado en su esquina superior
    derecha.
4.  Use **Knit** para reconstruir el documento completo.

Los encabezados de bloque tienen esta forma:

```` markdown

``` r
# Código de R
```
````

El nombre permite localizar errores. Las opciones como `echo`, `warning`
o `fig.width` controlan si se muestra el código, si aparecen
advertencias y qué tamaño tendrá la figura.

## 1.2 Reproducibilidad y datos clínicos

Un flujo reproducible conserva:

- el archivo original sin modificar;
- las instrucciones de limpieza;
- las decisiones estadísticas;
- el código que genera tablas y figuras;
- las versiones de R y de los paquetes cuando el análisis se destina a
  publicación.

En investigación biomédica, la reproducibilidad no autoriza la
publicación de información identificable. Antes de colocar datos reales
en un repositorio deben considerarse el consentimiento, la aprobación
ética, la anonimización y las reglas institucionales de acceso.

# 2 Presentación principal, sesión 1: estadística descriptiva en R

## 2.1 La pregunta que organiza el flujo

La presentación sigue una secuencia deliberada:

1.  Importar.
2.  Inspeccionar.
3.  Limpiar.
4.  Explorar la distribución.
5.  Calcular estadísticos descriptivos.
6.  Elegir el resumen que se reportará.
7.  Construir una tabla y una figura.

Este orden evita un error frecuente: calcular resultados antes de
comprobar qué representan las columnas o si existen valores ausentes.

## 2.2 Preparación de los paquetes

``` r
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(gt)
library(knitr)
```

### 2.2.1 Qué hace cada línea

| Paquete   | Propósito en el flujo                                       | Ejemplos utilizados                     |
|:----------|:------------------------------------------------------------|:----------------------------------------|
| `readr`   | Importar y exportar archivos de texto.                      | `read_csv()`, `write_csv()`             |
| `dplyr`   | Seleccionar, modificar, agrupar y resumir datos.            | `mutate()`, `group_by()`, `summarise()` |
| `tidyr`   | Limpiar ausencias y reorganizar tablas.                     | `drop_na()`, `pivot_longer()`           |
| `ggplot2` | Crear gráficos mediante capas.                              | `ggplot()`, `geom_*()`, `theme_*()`     |
| `gt`      | Construir tablas para HTML y documentos.                    | `gt()`, `cols_label()`, `gtsave()`      |
| `knitr`   | Integrar código con documentos y exportar tablas sencillas. | `kable()`                               |

`library()` carga un paquete ya instalado. No instala nada. Si R
responde que un paquete no existe, se instala una sola vez:

``` r
install.packages(c("readr", "dplyr", "tidyr", "ggplot2", "gt", "knitr"))
```

### 2.2.2 Cómo modificarlo

- Añada otro paquete dentro de `c()` durante la instalación.
- Añada después su correspondiente `library()` al inicio del script.
- No coloque `install.packages()` como una instrucción activa en un
  análisis que se ejecutará muchas veces. Podría actualizar paquetes de
  forma inesperada y reducir la reproducibilidad.

## 2.3 Carga del archivo CSV

``` r
datos <- read_csv(
  "datos/biomarcadores_clinicos.csv",
  show_col_types = FALSE
)
```

### 2.3.1 Explicación detallada

- `datos <-` significa “guarde el resultado en un objeto llamado
  `datos`”. El nombre puede cambiar, pero debe utilizarse de forma
  coherente después.
- `read_csv()` interpreta un archivo separado por comas y devuelve un
  dataframe moderno llamado *tibble*.
- `"datos/biomarcadores_clinicos.csv"` es una ruta relativa. Parte de la
  carpeta donde se abrió el proyecto de RStudio.
- `show_col_types = FALSE` oculta el mensaje informativo sobre los tipos
  detectados. No cambia los datos.

### 2.3.2 Cómo modificarlo

Para utilizar otro archivo:

``` r
datos <- read_csv("datos/mi_estudio.csv", show_col_types = FALSE)
```

Si el archivo utiliza punto y coma, una situación frecuente en
exportaciones regionales:

``` r
datos <- read_csv2("datos/mi_estudio.csv", show_col_types = FALSE)
```

No conviene usar rutas absolutas como `C:/Usuarios/...` o `/home/...`
dentro de un repositorio compartido. Esas rutas solo funcionan en una
computadora.

## 2.4 Estructura del dataframe biomédico

``` r
head(datos)
```

    ## # A tibble: 6 × 4
    ##   id_paciente grupo              hemoglobina_g_dl pcr_mg_l
    ##   <chr>       <chr>                         <dbl>    <dbl>
    ## 1 PX01        Control                        12.4      0.2
    ## 2 PX02        Enfermedad estable             11.9      0.6
    ## 3 PX03        Enfermedad activa              11.5      0.8
    ## 4 PX04        Control                        13.1      0.3
    ## 5 PX05        Enfermedad estable             12.7      0.8
    ## 6 PX06        Enfermedad activa              12.2      1

| Variable           | Tipo esperado              | Significado                                      |
|:-------------------|:---------------------------|:-------------------------------------------------|
| `id_paciente`      | Texto                      | Identificador sintético y anonimizado.           |
| `grupo`            | Texto o factor             | Control, enfermedad estable o enfermedad activa. |
| `hemoglobina_g_dl` | Numérica continua          | Concentración de hemoglobina en g/dL.            |
| `pcr_mg_l`         | Numérica continua positiva | Proteína C reactiva en mg/L.                     |

Una fila representa un paciente. Una columna representa una variable.
Esta estructura es fundamental: si un paciente aparece en varias filas
porque se midió en varios tiempos, el diseño deja de ser transversal y
el análisis debe reconocer la dependencia entre observaciones.

## 2.5 Inspección inicial

``` r
glimpse(datos)
```

    ## Rows: 36
    ## Columns: 4
    ## $ id_paciente      <chr> "PX01", "PX02", "PX03", "PX04", "PX05", "PX06", "PX07", "PX08", "PX09", "…
    ## $ grupo            <chr> "Control", "Enfermedad estable", "Enfermedad activa", "Control", "Enferme…
    ## $ hemoglobina_g_dl <dbl> 12.4, 11.9, 11.5, 13.1, 12.7, 12.2, NA, 13.0, 12.6, 13.7, 13.2, 12.9, 13.…
    ## $ pcr_mg_l         <dbl> 0.2, 0.6, 0.8, 0.3, 0.8, 1.0, 0.4, 0.9, 1.2, 0.5, 1.0, NA, 0.6, 1.1, 1.8,…

``` r
summary(datos)
```

    ##     id_paciente       grupo    hemoglobina_g_dl    pcr_mg_l     
    ##  Length   :36   Length   :36   Min.   :11.50    Min.   : 0.200  
    ##  N.unique :36   N.unique : 3   1st Qu.:13.10    1st Qu.: 0.800  
    ##  N.blank  : 0   N.blank  : 0   Median :13.75    Median : 1.150  
    ##  Min.nchar: 4   Min.nchar: 7   Mean   :13.69    Mean   : 2.385  
    ##  Max.nchar: 4   Max.nchar:18   3rd Qu.:14.35    3rd Qu.: 2.175  
    ##                                Max.   :15.50    Max.   :18.600  
    ##                                NAs    :2        NAs    :2

``` r
colSums(is.na(datos))
```

    ##      id_paciente            grupo hemoglobina_g_dl         pcr_mg_l 
    ##                0                0                2                2

### 2.5.1 `glimpse(datos)`

Muestra el número de filas y columnas, el nombre de cada variable, su
tipo y algunos valores. Permite detectar problemas como una
concentración almacenada como texto debido a símbolos, comas decimales o
códigos especiales.

### 2.5.2 `summary(datos)`

Produce un resumen rápido. Para columnas numéricas muestra mínimo,
cuartiles, mediana, media, máximo y cantidad de `NA`. Su función aquí es
diagnóstica. Todavía no constituye la tabla final.

### 2.5.3 `is.na(datos)` y `colSums()`

`is.na(datos)` crea una matriz de valores `TRUE` y `FALSE`. `TRUE`
indica ausencia. `colSums()` cuenta los `TRUE` por columna porque, en
una suma, R trata `TRUE` como 1 y `FALSE` como 0.

### 2.5.4 Cómo modificarlo

Para contar ausencias por fila:

``` r
rowSums(is.na(datos))
```

Para observar solo las filas que tienen al menos una ausencia:

``` r
datos |>
  filter(if_any(everything(), is.na))
```

## 2.6 Limpieza de valores ausentes

``` r
datos_limpios <- datos |>
  drop_na(hemoglobina_g_dl, pcr_mg_l)

nrow(datos)
```

    ## [1] 36

``` r
nrow(datos_limpios)
```

    ## [1] 32

### 2.6.1 Lectura línea por línea

- `datos |>` envía el dataframe a la siguiente función. El operador `|>`
  puede leerse como “y después”.
- `drop_na(hemoglobina_g_dl, pcr_mg_l)` conserva solo las filas que
  tienen valores para ambos biomarcadores.
- El resultado se guarda en `datos_limpios`. El objeto `datos` permanece
  intacto.
- `nrow()` compara el tamaño antes y después. En el ejemplo se pasa de
  36 a 32 pacientes.

### 2.6.2 Propósito estadístico

Las funciones `mean()`, `sd()` y `shapiro.test()` no deben recibir
ausencias sin que se les indique cómo manejarlas. El ejemplo utiliza
eliminación por casos completos para mantener sencillo el flujo docente.

### 2.6.3 Advertencia biomédica

Eliminar casos no siempre es una decisión neutral. Si las ausencias se
relacionan con la gravedad, el tratamiento, el pronóstico o cualquier
característica clínica, el subconjunto completo puede quedar sesgado. En
un análisis real deben describirse el patrón y la causa probable de los
datos faltantes. Según el diseño, podrían requerirse análisis de
sensibilidad o imputación.

### 2.6.4 Cómo modificarlo

Para analizar la hemoglobina sin exigir que PCR esté disponible:

``` r
datos_hemoglobina <- datos |>
  drop_na(hemoglobina_g_dl)
```

Para conservar las filas y permitir que cada estadístico ignore sus
propios `NA`:

``` r
mean(datos$hemoglobina_g_dl, na.rm = TRUE)
```

Ambas estrategias producen tamaños muestrales distintos. El valor de `n`
debe reportarse para cada variable.

## 2.7 Transformación a formato largo

``` r
datos_largos <- datos_limpios |>
  pivot_longer(
    cols = c(hemoglobina_g_dl, pcr_mg_l),
    names_to = "variable",
    values_to = "valor"
  )

head(datos_largos)
```

    ## # A tibble: 6 × 4
    ##   id_paciente grupo              variable         valor
    ##   <chr>       <chr>              <chr>            <dbl>
    ## 1 PX01        Control            hemoglobina_g_dl  12.4
    ## 2 PX01        Control            pcr_mg_l           0.2
    ## 3 PX02        Enfermedad estable hemoglobina_g_dl  11.9
    ## 4 PX02        Enfermedad estable pcr_mg_l           0.6
    ## 5 PX03        Enfermedad activa  hemoglobina_g_dl  11.5
    ## 6 PX03        Enfermedad activa  pcr_mg_l           0.8

### 2.7.1 Por qué se realiza

Antes de la transformación hay dos columnas de biomarcadores. Después,
sus nombres quedan en `variable` y sus mediciones en `valor`. Este
formato permite agrupar por variable y repetir la misma prueba o el
mismo gráfico sin copiar el código.

### 2.7.2 Significado de los argumentos

- `cols = c(...)` selecciona las columnas que se apilarán.
- `names_to = "variable"` define dónde se guardarán los nombres
  originales.
- `values_to = "valor"` define dónde se guardarán las mediciones.

### 2.7.3 Cómo modificarlo

Para añadir glucosa:

``` r
datos_largos <- datos_limpios |>
  pivot_longer(
    cols = c(hemoglobina_g_dl, pcr_mg_l, glucosa_mg_dl),
    names_to = "variable",
    values_to = "valor"
  )
```

Todas las columnas apiladas deben tener tipos compatibles. No mezcle
texto clínico con concentraciones numéricas dentro de `valor`.

## 2.8 Inspección gráfica de la distribución

### 2.8.1 Histogramas

``` r
grafico_histograma <- ggplot(datos_largos, aes(x = valor)) +
  geom_histogram(bins = 10, fill = "#2A9D8F", color = "white") +
  facet_wrap(~ variable, scales = "free") +
  labs(x = NULL, y = "Frecuencia") +
  theme_minimal(base_size = 13)

grafico_histograma
```

<div class="figure" style="text-align: center">

<img src="resultados/guia_definitiva/grafico-histograma-1.png" alt="Histogramas de los dos biomarcadores después de eliminar casos incompletos." width="92%" />

<p class="caption">

Histogramas de los dos biomarcadores después de eliminar casos
incompletos.

</p>

</div>

#### 2.8.1.1 Qué aporta cada parte

- `ggplot(datos_largos, aes(x = valor))` define los datos y coloca las
  mediciones en el eje horizontal.
- `geom_histogram()` divide el intervalo de valores en clases y cuenta
  cuántas observaciones caen en cada una.
- `bins = 10` solicita diez intervalos. Cambiarlo puede alterar la
  apariencia, por lo que conviene probar varias opciones.
- `facet_wrap(~ variable)` crea un panel para cada biomarcador.
- `scales = "free"` permite que cada panel tenga su propia escala. Esto
  es necesario porque hemoglobina y PCR tienen unidades y rangos
  diferentes.

#### 2.8.1.2 Qué buscar

Se evalúan simetría, concentración central, colas, huecos y
observaciones alejadas. La hemoglobina se aproxima a una forma
simétrica. La PCR presenta una cola derecha larga, frecuente en
biomarcadores inflamatorios.

#### 2.8.1.3 Cómo modificarlo

Para fijar el ancho de cada intervalo en lugar de su número:

``` r
geom_histogram(binwidth = 0.5)
```

El ancho debe expresarse en las mismas unidades de la variable.

### 2.8.2 Gráficos Q-Q

``` r
grafico_qq <- ggplot(datos_largos, aes(sample = valor)) +
  stat_qq(color = "#264653", alpha = 0.75) +
  stat_qq_line(color = "#E76F51", linewidth = 0.8) +
  facet_wrap(~ variable, scales = "free") +
  labs(x = "Cuantiles teóricos", y = "Cuantiles observados") +
  theme_minimal(base_size = 13)

grafico_qq
```

<div class="figure" style="text-align: center">

<img src="resultados/guia_definitiva/grafico-qq-1.png" alt="Gráficos Q-Q utilizados como apoyo visual para evaluar normalidad." width="92%" />

<p class="caption">

Gráficos Q-Q utilizados como apoyo visual para evaluar normalidad.

</p>

</div>

Un gráfico Q-Q compara los cuantiles observados con los cuantiles que se
esperarían bajo una distribución normal. Una alineación aproximada apoya
la compatibilidad con normalidad. Curvaturas sistemáticas o desviaciones
grandes en los extremos indican asimetría o colas diferentes.

- `aes(sample = valor)` declara la variable cuya distribución se
  comparará.
- `stat_qq()` dibuja los puntos.
- `stat_qq_line()` añade una referencia.
- `alpha = 0.75` hace los puntos parcialmente transparentes.

El gráfico Q-Q no produce una decisión automática. Su lectura se combina
con el histograma, la naturaleza de la variable y la prueba formal.

## 2.9 Prueba de Shapiro-Wilk

``` r
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
      "Mediana (Q1-Q3)"
    )
  )

normalidad |>
  mutate(across(c(W, p), ~ signif(.x, 4))) |>
  kable()
```

| variable         | n_total |      W |      p | decision                     | resumen_a_reportar |
|:-----------------|--------:|-------:|-------:|:-----------------------------|:-------------------|
| hemoglobina_g_dl |      32 | 0.9771 | 0.7129 | Compatible con normalidad    | Media ± DE         |
| pcr_mg_l         |      32 | 0.5307 | 0.0000 | No compatible con normalidad | Mediana (Q1-Q3)    |

### 2.9.1 Hipótesis e interpretación

La hipótesis nula de Shapiro-Wilk establece que los datos son
compatibles con una distribución normal (referencias 2 y 3).

- Si `p < 0.05`, el ejercicio rechaza la hipótesis nula y clasifica la
  variable como no normal.
- Si `p >= 0.05`, el ejercicio no encuentra evidencia suficiente para
  rechazarla.

“No rechazar” no demuestra normalidad. Con pocas observaciones, la
prueba puede carecer de potencia. Con muestras muy grandes, puede
detectar desviaciones pequeñas sin relevancia práctica. Por eso la
prueba debe acompañarse de gráficos (referencia 3).

### 2.9.2 Lectura del código

- `group_by(variable)` separa internamente hemoglobina y PCR.
- `summarise()` devuelve una fila por variable.
- `n()` cuenta observaciones.
- `shapiro.test(valor)$statistic` extrae W.
- `shapiro.test(valor)$p.value` extrae el valor p.
- `unname()` elimina el nombre interno del estadístico para facilitar su
  almacenamiento.
- `.groups = "drop"` devuelve un dataframe sin agrupación activa.
- `if_else()` traduce una condición lógica a una frase pedagógica.

### 2.9.3 Resultado del ejemplo

- Hemoglobina: `W ≈ 0.977`, `p ≈ 0.713`.
- PCR: `W ≈ 0.531`, `p < 0.001`.

### 2.9.4 Cómo modificarlo

Para evaluar normalidad dentro de cada grupo:

``` r
datos_largos |>
  group_by(variable, grupo) |>
  summarise(
    n = n(),
    W = unname(shapiro.test(valor)$statistic),
    p = shapiro.test(valor)$p.value,
    .groups = "drop"
  )
```

Esta modificación puede ser más coherente cuando se comparan grupos,
pero los tamaños pequeños vuelven inestable la prueba. En modelos
inferenciales suele ser más apropiado evaluar los residuos que aplicar
Shapiro-Wilk directamente a cada variable.

## 2.10 Estadística descriptiva paramétrica y no paramétrica

``` r
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

descriptivos |>
  mutate(across(where(is.numeric), ~ round(.x, 2))) |>
  kable()
```

| variable         | grupo              |   n | media |   DE | mediana |    Q1 |    Q3 | minimo | maximo |
|:-----------------|:-------------------|----:|------:|-----:|--------:|------:|------:|-------:|-------:|
| hemoglobina_g_dl | Control            |  10 | 14.00 | 0.80 |   14.10 | 13.72 | 14.55 |   12.4 |   15.0 |
| hemoglobina_g_dl | Enfermedad activa  |  11 | 13.40 | 1.02 |   13.50 | 12.85 | 14.00 |   11.5 |   15.0 |
| hemoglobina_g_dl | Enfermedad estable |  11 | 13.61 | 0.93 |   13.60 | 13.10 | 14.10 |   11.9 |   15.2 |
| pcr_mg_l         | Control            |  10 |  0.73 | 0.33 |    0.75 |  0.52 |  0.98 |    0.2 |    1.2 |
| pcr_mg_l         | Enfermedad activa  |  11 |  5.05 | 5.66 |    2.80 |  1.50 |  5.40 |    0.8 |   18.6 |
| pcr_mg_l         | Enfermedad estable |  11 |  1.44 | 0.77 |    1.20 |  0.95 |  1.65 |    0.6 |    3.2 |

### 2.10.1 Qué representa cada estadístico

- `n`: cantidad de pacientes incluidos.
- `media`: suma de los valores dividida entre `n`. Es sensible a
  observaciones extremas.
- `DE`: desviación estándar. Resume la dispersión alrededor de la media.
- `mediana`: valor central después de ordenar las observaciones. Es más
  resistente a extremos.
- `Q1`: percentil 25.
- `Q3`: percentil 75.
- `Q3 - Q1`: rango intercuartílico o RIQ.
- `minimo` y `maximo`: extremos observados, útiles para control de
  calidad.

La práctica calcula ambas familias para que puedan compararse. El
reporte principal utiliza media ± DE para la hemoglobina y mediana
(Q1-Q3) para PCR.

### 2.10.2 Cómo modificarlo

Para añadir coeficiente de variación, apropiado solo cuando tiene
sentido dividir la DE entre una media positiva:

``` r
CV_porcentaje = 100 * DE / media
```

Para cambiar el algoritmo de cuartiles debe utilizarse el argumento
`type` de `quantile()`. R ofrece varios métodos, y programas distintos
pueden producir pequeñas diferencias en muestras pequeñas.

## 2.11 Unión entre prueba y descriptivos

``` r
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
      sprintf("%.1f (%.1f-%.1f)", mediana, Q1, Q3)
    ),
    p_shapiro = if_else(
      p < 0.001,
      "<0.001",
      sprintf("%.3f", p)
    )
  ) |>
  select(medida, grupo, n, resultado, p_shapiro, resumen_a_reportar)

tabla_reporte |>
  kable()
```

| medida                     | grupo              |   n | resultado     | p_shapiro | resumen_a_reportar |
|:---------------------------|:-------------------|----:|:--------------|:----------|:-------------------|
| Hemoglobina (g/dL)         | Control            |  10 | 14.00 ± 0.80  | 0.713     | Media ± DE         |
| Hemoglobina (g/dL)         | Enfermedad activa  |  11 | 13.40 ± 1.02  | 0.713     | Media ± DE         |
| Hemoglobina (g/dL)         | Enfermedad estable |  11 | 13.61 ± 0.93  | 0.713     | Media ± DE         |
| Proteína C reactiva (mg/L) | Control            |  10 | 0.8 (0.5-1.0) | \<0.001   | Mediana (Q1-Q3)    |
| Proteína C reactiva (mg/L) | Enfermedad activa  |  11 | 2.8 (1.5-5.4) | \<0.001   | Mediana (Q1-Q3)    |
| Proteína C reactiva (mg/L) | Enfermedad estable |  11 | 1.2 (0.9-1.6) | \<0.001   | Mediana (Q1-Q3)    |

### 2.11.1 Por qué se usa `left_join()`

`descriptivos` tiene una fila por combinación de variable y grupo.
`normalidad` tiene una fila por variable.
`left_join(..., by = "variable")` copia la decisión correspondiente a
todas las filas de esa variable.

### 2.11.2 Formato con `sprintf()`

- `%.2f` imprime dos decimales.
- `%.1f` imprime un decimal.
- El texto alrededor de los marcadores se conserva.

Los decimales deben decidirse según la precisión del instrumento y la
convención clínica. No se deben añadir cifras que el método de medición
no puede justificar.

### 2.11.3 Cómo modificarlo

Para reportar un decimal en media y DE:

``` r
sprintf("%.1f ± %.1f", media, DE)
```

Para usar otro umbral pedagógico, cambie `0.05` en ambos `if_else()`. En
investigación, el umbral debe definirse antes de observar los resultados
y no reemplaza el razonamiento sobre supuestos.

# 3 Presentación principal, sesión 2: reporte de resultados

## 3.1 Tabla académica con `gt`

``` r
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
    md("DE: desviación estándar; Q1-Q3: rango intercuartílico.")
  ) |>
  opt_row_striping() |>
  tab_options(
    table.font.names = "Arial",
    table.font.size = px(13),
    heading.align = "left",
    data_row.padding = px(5)
  )

if (identical(knitr::opts_knit$get("rmarkdown.pandoc.to"), "html")) {
  tabla_academica
} else {
  tabla_reporte |>
    kable(caption = "Tabla 1. Estadística descriptiva de los biomarcadores")
}
```

| medida                     | grupo              |   n | resultado     | p_shapiro | resumen_a_reportar |
|:---------------------------|:-------------------|----:|:--------------|:----------|:-------------------|
| Hemoglobina (g/dL)         | Control            |  10 | 14.00 ± 0.80  | 0.713     | Media ± DE         |
| Hemoglobina (g/dL)         | Enfermedad activa  |  11 | 13.40 ± 1.02  | 0.713     | Media ± DE         |
| Hemoglobina (g/dL)         | Enfermedad estable |  11 | 13.61 ± 0.93  | 0.713     | Media ± DE         |
| Proteína C reactiva (mg/L) | Control            |  10 | 0.8 (0.5-1.0) | \<0.001   | Mediana (Q1-Q3)    |
| Proteína C reactiva (mg/L) | Enfermedad activa  |  11 | 2.8 (1.5-5.4) | \<0.001   | Mediana (Q1-Q3)    |
| Proteína C reactiva (mg/L) | Enfermedad estable |  11 | 1.2 (0.9-1.6) | \<0.001   | Mediana (Q1-Q3)    |

Tabla 1. Estadística descriptiva de los biomarcadores

### 3.1.1 Explicación de las capas de la tabla

- `gt()` convierte un dataframe en una tabla presentable.
- `groupname_col = "medida"` utiliza el biomarcador como encabezado de
  grupo.
- `cols_label()` cambia nombres técnicos sin renombrar el dataframe
  original.
- `tab_header()` añade número y título.
- `tab_source_note()` explica abreviaturas y decisiones necesarias.
- `opt_row_striping()` alterna un sombreado ligero. Puede eliminarse si
  la revista exige fondo blanco.
- `tab_options()` controla tipografía, alineación y espaciado.

### 3.1.2 Vancouver y tablas

Vancouver regula principalmente la citación y la lista de referencias.
No define una única apariencia universal de tabla. Una tabla biomédica
suele incluir número, título breve, unidades, `n`, abreviaturas
explicadas y pocas líneas. Siempre prevalecen las instrucciones de la
revista.

### 3.1.3 Exportación

``` r
gtsave(tabla_academica, "resultados/tabla_1_descriptivos.html")
write_csv(tabla_reporte, "resultados/tabla_1_descriptivos.csv")
```

El HTML conserva el formato visual. El CSV conserva el contenido en una
forma fácil de revisar. Una tabla de publicación debe verificarse
después de insertarla en el manuscrito.

## 3.2 Figura paramétrica: hemoglobina

``` r
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
  labs(x = NULL, y = "Hemoglobina (g/dL)") +
  theme_classic(base_size = 13) +
  theme(legend.position = "none")

grafico_hemoglobina
```

<div class="figure" style="text-align: center">

<img src="resultados/guia_definitiva/figura-hemoglobina-1.png" alt="Hemoglobina por grupo clínico. Los puntos muestran pacientes individuales; el punto grande y las barras representan media y una desviación estándar." width="92%" />

<p class="caption">

Hemoglobina por grupo clínico. Los puntos muestran pacientes
individuales; el punto grande y las barras representan media y una
desviación estándar.

</p>

</div>

### 3.2.1 Explicación

- `aes(color = grupo)` vincula el color a una variable. Por ello cada
  grupo recibe un color consistente.
- `geom_jitter()` desplaza ligeramente los puntos en horizontal para
  evitar superposición. No modifica su valor vertical.
- El primer `stat_summary()` calcula y dibuja la media.
- El segundo calcula media ± una DE porque `mult = 1`.
- `scale_color_manual()` fija los colores. Sin esta línea, ggplot2 elige
  una paleta automáticamente.
- `theme_classic()` elimina el fondo gris y conserva los ejes.
- La leyenda se elimina porque los nombres ya aparecen en el eje
  horizontal.

### 3.2.2 Modificaciones útiles

Para mostrar error estándar en lugar de DE tendría que definirse
explícitamente. No cambie la medida sin actualizar el pie de figura. La
DE describe variabilidad entre pacientes; el error estándar describe la
precisión de la media. No son intercambiables.

## 3.3 Figura no paramétrica: proteína C reactiva

``` r
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
  labs(x = NULL, y = "Proteína C reactiva (mg/L)") +
  theme_classic(base_size = 13) +
  theme(legend.position = "none")

grafico_pcr
```

<div class="figure" style="text-align: center">

<img src="resultados/guia_definitiva/figura-pcr-1.png" alt="Proteína C reactiva por grupo clínico. Las cajas muestran mediana y rango intercuartílico; los puntos representan pacientes individuales." width="92%" />

<p class="caption">

Proteína C reactiva por grupo clínico. Las cajas muestran mediana y
rango intercuartílico; los puntos representan pacientes individuales.

</p>

</div>

### 3.3.1 Por qué se combinan cajas y puntos

Un boxplot resume mediana, cuartiles y extensión de los datos, pero
puede ocultar el tamaño muestral y la forma exacta de una muestra
pequeña. Mostrar los puntos individuales permite evaluar agrupaciones,
huecos y observaciones extremas. Esta práctica responde a
recomendaciones para mejorar la transparencia de figuras biomédicas
(referencia 4).

`outlier.shape = NA` evita que `geom_boxplot()` dibuje por segunda vez
los puntos situados fuera de los bigotes. No elimina observaciones:
`geom_jitter()` sigue mostrando todas.

### 3.3.2 Escala logarítmica

PCR suele ser asimétrica. Si la pregunta y la revista lo justifican,
puede considerarse una escala logarítmica:

``` r
grafico_pcr +
  scale_y_log10()
```

La escala debe declararse en el eje o en el pie. No puede aplicarse
directamente si existen ceros o valores negativos. Una transformación
visual tampoco convierte automáticamente el análisis estadístico en
apropiado.

## 3.4 Redacción de resultados

Un reporte descriptivo debe indicar variable, criterio de distribución,
medida elegida y unidades. Ejemplos:

> La hemoglobina fue compatible con una distribución normal
> (Shapiro-Wilk, W = 0.977, p = 0.713), por lo que se resumió como media
> ± DE.

> La proteína C reactiva mostró una distribución asimétrica
> (Shapiro-Wilk, W = 0.531, p \< 0.001), por lo que se resumió como
> mediana (Q1-Q3).

Estas frases no prueban diferencias entre grupos. Para afirmar una
diferencia se necesita una prueba inferencial coherente con la pregunta,
el diseño, la independencia de las observaciones y los supuestos.

# 4 Infografía complementaria: funcionamiento de ggplot2 por capas

## 4.1 La gramática general

ggplot2 utiliza una gramática declarativa: se especifican datos, mapeos
y capas, y el sistema construye la figura (referencias 5 y 6). La
estructura general es:

``` r
ggplot(datos, aes(x, y)) +
  geom_*() +
  scale_*() +
  labs() +
  theme_*()
```

| Componente     | Responsabilidad                                       | Ejemplo                        |
|:---------------|:------------------------------------------------------|:-------------------------------|
| Datos          | Proporcionan las filas que se representarán.          | `datos_limpios`                |
| Mapeo estético | Relaciona variables con ejes, color, forma o tamaño.  | `aes(x = grupo, y = pcr_mg_l)` |
| Geometría      | Decide cómo se dibujan las observaciones o resúmenes. | `geom_boxplot()`               |
| Estadística    | Calcula resúmenes cuando la geometría lo requiere.    | Cuartiles del boxplot          |
| Escala         | Traduce datos a posiciones, colores o etiquetas.      | `scale_fill_manual()`          |
| Coordenadas    | Define la región y el sistema de representación.      | `coord_cartesian()`            |
| Facetas        | Divide una figura en paneles.                         | `facet_wrap()`                 |
| Tema           | Controla elementos no asociados a datos.              | `theme_classic()`              |

El signo `+` añade una capa al objeto gráfico. No añade columnas al
dataframe.

## 4.2 Preparación y orden clínico

``` r
datos_caja <- datos_limpios |>
  mutate(
    grupo = factor(
      grupo,
      levels = c("Control", "Enfermedad estable", "Enfermedad activa")
    )
  )
```

`factor()` transforma el grupo en una categoría con orden explícito. Sin
`levels`, ggplot2 suele ordenar alfabéticamente. El orden control,
enfermedad estable y enfermedad activa comunica mejor la progresión
clínica.

Para invertirlo, basta con invertir `levels`. Para añadir otro grupo,
agregue su nombre exactamente como aparece en el CSV.

## 4.3 Paso 1: base y gráfica de cajas

``` r
paso_1 <- ggplot(
  datos_caja,
  aes(x = grupo, y = pcr_mg_l)
) +
  geom_boxplot()

paso_1
```

<div class="figure" style="text-align: center">

<img src="resultados/guia_definitiva/caja-paso-1-1.png" alt="Paso 1. Gráfica de cajas con los valores predeterminados de ggplot2." width="92%" />

<p class="caption">

Paso 1. Gráfica de cajas con los valores predeterminados de ggplot2.

</p>

</div>

`ggplot()` crea la especificación. `aes()` define que cada grupo ocupa
una posición horizontal y que PCR determina la posición vertical.
`geom_boxplot()` añade una capa que calcula:

- mediana;
- primer y tercer cuartil;
- rango intercuartílico;
- bigotes hasta las observaciones compatibles con 1.5 veces el RIQ;
- puntos fuera de los bigotes.

Un punto fuera de los bigotes no es sinónimo de error. Puede ser una
observación biológica válida que requiere comprobación.

## 4.4 Paso 2: pacientes individuales

``` r
paso_2 <- ggplot(
  datos_caja,
  aes(x = grupo, y = pcr_mg_l)
) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(
    position = position_jitter(width = 0.10, seed = 123),
    alpha = 0.75,
    size = 2
  )

paso_2
```

<div class="figure" style="text-align: center">

<img src="resultados/guia_definitiva/caja-paso-2-1.png" alt="Paso 2. La segunda capa muestra todos los pacientes y evita duplicar los puntos fuera de los bigotes." width="92%" />

<p class="caption">

Paso 2. La segunda capa muestra todos los pacientes y evita duplicar los
puntos fuera de los bigotes.

</p>

</div>

### 4.4.1 Propósito de cada argumento

- `outlier.shape = NA` oculta únicamente la representación automática de
  extremos del boxplot.
- `geom_point()` dibuja una marca por fila.
- `position_jitter(width = 0.10)` introduce una pequeña separación
  horizontal.
- `seed = 123` conserva la misma separación al regenerar la figura.
- `alpha = 0.75` controla transparencia.
- `size = 2` controla el tamaño en unidades gráficas, no en unidades
  clínicas.

Para muestras grandes, reduzca `size` y `alpha`. Para datos pareados, no
utilice puntos dispersos como si fueran independientes: considere líneas
que conecten mediciones del mismo paciente.

## 4.5 Paso 3: colores y consistencia visual

``` r
colores_grupo <- c(
  "Control" = "#264653",
  "Enfermedad estable" = "#2A9D8F",
  "Enfermedad activa" = "#E76F51"
)

paso_3 <- ggplot(
  datos_caja,
  aes(x = grupo, y = pcr_mg_l, fill = grupo)
) +
  geom_boxplot(width = 0.52, alpha = 0.55, outlier.shape = NA) +
  geom_point(
    position = position_jitter(width = 0.10, seed = 123),
    shape = 21,
    size = 2.2,
    alpha = 0.80
  ) +
  scale_fill_manual(values = colores_grupo)

paso_3
```

<div class="figure" style="text-align: center">

<img src="resultados/guia_definitiva/caja-paso-3-1.png" alt="Paso 3. Los colores se asignan a los grupos mediante una escala manual." width="92%" />

<p class="caption">

Paso 3. Los colores se asignan a los grupos mediante una escala manual.

</p>

</div>

`fill = grupo` se encuentra dentro de `aes()` porque el relleno depende
de una variable. `scale_fill_manual()` traduce cada categoría a un
código hexadecimal. `shape = 21` permite que los puntos tengan relleno y
borde.

Si se escribe `fill = "#2A9D8F"` fuera de `aes()`, todas las cajas
reciben un color fijo. Dentro de `aes()`, una cadena se interpreta como
una categoría y puede crear una leyenda accidental.

## 4.6 Paso 4: unidades, tamaño muestral y tema

``` r
n_grupos <- datos_caja |>
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

grafico_publicacion
```

<div class="figure" style="text-align: center">

<img src="resultados/guia_definitiva/caja-final-1.png" alt="Figura final. Gráfica de cajas apta para integrarse en un manuscrito después de ajustarla a las instrucciones de la revista." width="92%" />

<p class="caption">

Figura final. Gráfica de cajas apta para integrarse en un manuscrito
después de ajustarla a las instrucciones de la revista.

</p>

</div>

### 4.6.1 Cálculo del tamaño muestral

`count(grupo)` cuenta filas por categoría. `paste0("n = ", n)` construye
las etiquetas. Esta tabla pequeña se proporciona solo a `geom_text()`.

### 4.6.2 `inherit.aes = FALSE`

La gráfica principal espera `y = pcr_mg_l`, pero `n_grupos` no tiene esa
columna. `inherit.aes = FALSE` impide que la capa de texto herede ese
mapeo y permite definir uno nuevo.

### 4.6.3 Etiquetas y coordenadas

- `x = NULL` elimina un título redundante del eje horizontal.
- El eje vertical incluye el nombre completo y la unidad.
- `coord_cartesian(ylim = c(0, 20))` define la ventana visible sin
  descartar datos antes del cálculo del boxplot.

No debe confundirse con `ylim()`, que puede eliminar observaciones fuera
del intervalo y cambiar el resumen calculado.

### 4.6.4 Tema

`theme_classic(base_size = 12)` establece una base limpia. `theme()`
modifica elementos concretos. La tipografía debe juzgarse al tamaño
físico final, no solo con la gráfica ampliada en pantalla.

## 4.7 Exportación para publicación

``` r
ggsave(
  "resultados/infografia_ggplot/pcr_cajas_publicacion.png",
  grafico_publicacion,
  width = 170,
  height = 120,
  units = "mm",
  dpi = 600,
  bg = "white"
)
```

- El primer argumento define el archivo.
- El segundo identifica qué objeto gráfico se exporta.
- `width` y `height` definen el tamaño físico.
- `units = "mm"` evita ambigüedad.
- `dpi = 600` controla la densidad de píxeles del PNG.
- `bg = "white"` evita transparencias inesperadas.

Para una versión vectorial:

``` r
ggsave(
  "resultados/infografia_ggplot/pcr_cajas_publicacion.pdf",
  grafico_publicacion,
  width = 170,
  height = 120,
  units = "mm",
  bg = "white"
)
```

El PDF conserva texto y líneas como elementos vectoriales. Algunas
revistas solicitan TIFF, EPS o dimensiones exactas. Siempre debe
consultarse la guía editorial antes de la exportación final.

# 5 Recetas para adaptar el flujo

## 5.1 Sustituir los biomarcadores

Suponga un nuevo archivo con `glucosa_mg_dl` y `insulina_uUI_ml`.

1.  Cambie los nombres dentro de `drop_na()`.
2.  Cámbielos dentro de `pivot_longer()`.
3.  Actualice `recode()` para crear nombres legibles.
4.  Cambie las variables `y` de las figuras.
5.  Revise unidades, decimales y límites del eje.

No use búsqueda y reemplazo sin revisar el significado clínico. Una
variable binaria, ordinal o de conteo requiere otra descripción.

## 5.2 Dos grupos en lugar de tres

``` r
datos_dos_grupos <- datos |>
  filter(grupo %in% c("Control", "Enfermedad activa")) |>
  mutate(grupo = droplevels(factor(grupo)))
```

Después puede reutilizarse el mismo código. Actualice la paleta para que
contenga exactamente esos grupos.

## 5.3 Varias visitas por paciente

Si cada paciente tiene basal y seguimiento, debe existir una columna
`visita`. Los datos ya no son independientes. Una visualización inicial
puede conectar mediciones:

``` r
ggplot(datos_pareados, aes(x = visita, y = biomarcador,
                           group = id_paciente)) +
  geom_line(alpha = 0.35) +
  geom_point()
```

El análisis inferencial correspondiente también debe reconocer el
emparejamiento.

## 5.4 Paneles para varios biomarcadores

``` r
ggplot(datos_largos, aes(x = grupo, y = valor, fill = grupo)) +
  geom_boxplot() +
  facet_wrap(~ variable, scales = "free_y")
```

`free_y` facilita ver variables con escalas distintas, pero impide
comparar alturas absolutas entre paneles. Cada panel debe conservar
unidades claras.

## 5.5 Cambiar colores

``` r
colores_grupo <- c(
  "Control" = "#0072B2",
  "Enfermedad estable" = "#009E73",
  "Enfermedad activa" = "#D55E00"
)
```

Una paleta debe mantener contraste también en impresión y para lectores
con deficiencias en la visión del color. El color no debería ser la
única señal cuando las categorías pueden identificarse mediante
posición, forma o etiquetas.

# 6 Errores frecuentes y solución

| Problema                                                   | Causa probable                                       | Solución                                                   |
|:-----------------------------------------------------------|:-----------------------------------------------------|:-----------------------------------------------------------|
| “No se encuentra el archivo”                               | El proyecto se abrió desde otra carpeta.             | Abra el `.Rproj` y confirme la ruta relativa.              |
| “No se encuentra la función”                               | Falta cargar el paquete.                             | Ejecute el `library()` correspondiente.                    |
| Una columna numérica aparece como texto                    | Símbolos, comas decimales o códigos no numéricos.    | Inspeccione valores únicos y defina reglas de importación. |
| `shapiro.test()` falla                                     | Hay `NA`, valores idénticos o un tamaño no admitido. | Limpie ausencias y compruebe variabilidad y tamaño.        |
| Los grupos aparecen en orden alfabético                    | La variable sigue siendo texto.                      | Conviértala en factor con `levels`.                        |
| Los puntos extremos aparecen dos veces                     | Boxplot y puntos los dibujan simultáneamente.        | Use `outlier.shape = NA` y conserve `geom_point()`.        |
| Aparece una leyenda inesperada                             | Un valor constante se colocó dentro de `aes()`.      | Coloque propiedades constantes fuera de `aes()`.           |
| La gráfica cambia cada vez                                 | `jitter` utiliza posiciones aleatorias.              | Defina `seed` en `position_jitter()`.                      |
| La figura se ve bien en pantalla pero mal en el manuscrito | Tamaño físico o tipografía inadecuados.              | Exporte con dimensiones finales y revise al 100 %.         |

# 7 Lista de comprobación final

Antes de dar por terminado el análisis:

- [ ] El archivo original permanece sin cambios.
- [ ] Las variables y unidades se verificaron.
- [ ] Se documentaron los valores ausentes.
- [ ] El tamaño muestral coincide con la limpieza realizada.
- [ ] La distribución se examinó gráficamente.
- [ ] La prueba de normalidad se interpretó con cautela.
- [ ] El resumen corresponde a la distribución y al propósito clínico.
- [ ] La tabla explica abreviaturas y unidades.
- [ ] La figura muestra datos individuales cuando el tamaño lo permite.
- [ ] El pie identifica la medida central y la dispersión.
- [ ] La exportación cumple las instrucciones de la revista.
- [ ] Los resultados descriptivos no se presentan como evidencia
  inferencial.

# 8 Referencias bibliográficas

1.  Xie Y, Allaire JJ, Grolemund G. *R Markdown: The Definitive Guide*.
    Boca Raton: Chapman and Hall/CRC; 2019. Disponible en:
    <https://bookdown.org/yihui/rmarkdown/>.

2.  Shapiro SS, Wilk MB. An analysis of variance test for normality
    (complete samples). *Biometrika*. 1965;52(3-4):591-611. doi:
    [10.1093/biomet/52.3-4.591](https://doi.org/10.1093/biomet/52.3-4.591).

3.  Ghasemi A, Zahediasl S. Normality tests for statistical analysis: a
    guide for non-statisticians. *Int J Endocrinol Metab*.
    2012;10(2):486-489. doi:
    [10.5812/ijem.3505](https://doi.org/10.5812/ijem.3505).

4.  Weissgerber TL, Milic NM, Winham SJ, Garovic VD. Beyond bar and line
    graphs: time for a new data presentation paradigm. *PLoS Biol*.
    2015;13(4):e1002128. doi:
    [10.1371/journal.pbio.1002128](https://doi.org/10.1371/journal.pbio.1002128).

5.  Wickham H. A layered grammar of graphics. *J Comput Graph Stat*.
    2010;19(1):3-28. doi:
    [10.1198/jcgs.2009.07098](https://doi.org/10.1198/jcgs.2009.07098).

6.  Wickham H. *ggplot2: Elegant Graphics for Data Analysis*. 2nd
    ed. Cham: Springer; 2016. doi:
    [10.1007/978-3-319-24277-4](https://doi.org/10.1007/978-3-319-24277-4).

7.  R Core Team. *R: A Language and Environment for Statistical
    Computing*. Vienna: R Foundation for Statistical Computing; 2026.
    doi: [10.32614/R.manuals](https://doi.org/10.32614/R.manuals).
    Disponible en: <https://www.R-project.org/>.

8.  ggplot2 developers. Introduction to ggplot2. Disponible en:
    <https://ggplot2.tidyverse.org/articles/ggplot2.html>. Consultado el
    9 de septiembre de 2026.
