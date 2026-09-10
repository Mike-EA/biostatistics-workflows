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

Este repositorio difunde **workflows claros, reproducibles y orientados a la práctica** para enseñar bioestadística y análisis de datos en ciencias biomédicas con R.

Cada módulo integra datos sintéticos, código comentado, resultados verificables y material docente listo para utilizar en clase.

## Contenido actual

| Workflow | Temas | Materiales |
|---|---|---|
| Estadística descriptiva | Importación, limpieza, normalidad, media/DE y mediana/RIQ | Script, datos, presentación y guía |
| Visualización con ggplot2 | Capas, boxplots, observaciones individuales y exportación científica | Script, infografía y figuras |

## Inicio rápido

1. Descarga o clona el repositorio.
2. Abre `biostatistics-workflows.Rproj` en RStudio.
3. Consulta la [guía definitiva](GUIA_DEFINITIVA.md).
4. Ejecuta los scripts por secciones y revisa los archivos generados en `resultados/`.

```r
source("scripts/01_estadistica_descriptiva.R")
source("scripts/02_ggplot_caja_publicacion.R")
```

## Estructura

```text
datos/          Datos biomédicos sintéticos
scripts/        Workflows reproducibles en R
diapositivas/   Presentaciones e infografías en LaTeX y PDF
resultados/     Tablas y figuras generadas
```

## Principios

- Datos clínicos sintéticos y anónimos.
- Decisiones estadísticas explicadas, no solo ejecutadas.
- Código sencillo que puede adaptarse a nuevos estudios.
- Tablas y figuras preparadas con criterios de comunicación científica.

## Audiencia

Estudiantes, docentes e investigadores de medicina, biología, ciencias de la salud y áreas afines que desean aprender R mediante análisis reproducibles.

---

<div align="center">
Material educativo abierto al aprendizaje, la adaptación y la mejora continua.
</div>
