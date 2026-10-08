<div align="center">

# Biostatistics Workflows

**Flujos reproducibles de bioestadística aplicada a ciencias biomédicas**

![R](https://img.shields.io/badge/R-%E2%89%A54.3-276DC3?logo=r&logoColor=white)
![ggplot2](https://img.shields.io/badge/ggplot2-visualizaci%C3%B3n-2A9D8F)
![R Markdown](https://img.shields.io/badge/R%20Markdown-reproducible-264653?logo=rstudio&logoColor=white)
![Área](https://img.shields.io/badge/%C3%A1rea-biomedicina-E76F51)
![Estado](https://img.shields.io/badge/estado-activo-success)

</div>

## Propósito

Este repositorio reúne **workflows claros, reproducibles y orientados a la práctica** para enseñar bioestadística, visualización y análisis de datos ómicos en ciencias biomédicas con R.

Cada módulo integra datos sintéticos o públicos con procedencia documentada, código comentado, resultados verificables y material docente listo para utilizar en clase.

## Contenido actual

| Workflow | Temas | Materiales | Acceso |
|---|---|---|---|
| Estadística descriptiva | Importación, limpieza, normalidad, media/DE y mediana/RIQ | Scripts, datos sintéticos, guía y figuras | [Abrir guía](GUIA_DEFINITIVA.md) |
| Visualización con ggplot2 | Capas, boxplots, observaciones individuales y exportación científica | Script, infografía y figuras | [Abrir script](scripts/02_ggplot_caja_publicacion.R) |
| Expresión diferencial en MASH | RNA-seq bulk, DESeq2, control de calidad, PCA, volcano plot y heatmap | Guía R Markdown, datos humanos de GEO, scripts y tarea | [Abrir módulo](workflows/expresion_diferencial_mash/README.md) |

## Inicio rápido

1. Descarga o clona el repositorio.
2. Abre `biostatistics-workflows.Rproj` en RStudio.
3. Selecciona el workflow en la tabla anterior.
4. Lee el `README` del módulo antes de ejecutar sus scripts.

Para el material introductorio de estadística descriptiva:

```r
source("scripts/01_estadistica_descriptiva.R")
source("scripts/02_ggplot_caja_publicacion.R")
```

Para la práctica de expresión diferencial, abre como proyecto la carpeta
`workflows/expresion_diferencial_mash/` y ejecuta:

```r
source("scripts/00_instalar_dependencias.R") # sólo la primera vez
source("scripts/01_analisis_expresion_diferencial.R")
```

La ruta principal de aprendizaje es `GUIA_PRACTICA_MASH.Rmd`. El script continuo permite repetir el mismo análisis sin detenerse entre secciones.

## Estructura

```text
biostatistics-workflows/
├── datos/                         Datos del workflow introductorio
├── scripts/                       Scripts de estadística descriptiva y ggplot2
├── diapositivas/                  Material visual introductorio
├── resultados/                    Resultados del workflow introductorio
└── workflows/
    └── expresion_diferencial_mash/
        ├── GUIA_PRACTICA_MASH.Rmd Guía reproducible para estudiantes
        ├── TAREA.md               Instrucciones y rúbrica
        ├── datos/                 Conteos y metadatos de GSE126848
        └── scripts/               Instalación y análisis continuo
```

El [índice de workflows](workflows/README.md) resume la organización prevista para añadir módulos futuros.

## Principios

- Datos sintéticos, anónimos o procedentes de repositorios públicos, siempre con su fuente documentada.
- Decisiones estadísticas explicadas, no solo ejecutadas.
- Código sencillo que puede adaptarse a nuevos estudios.
- Tablas y figuras preparadas con criterios de comunicación científica.
- Resultados de ejemplo y registro de versiones para comprobar la reproducibilidad.

## Audiencia

Estudiantes, docentes e investigadores de medicina, biología, ciencias de la salud y áreas afines que desean aprender R mediante análisis reproducibles.

---

<div align="center">
Material educativo abierto al aprendizaje, la adaptación y la mejora continua.
</div>
