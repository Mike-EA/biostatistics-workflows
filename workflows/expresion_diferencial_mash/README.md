# Práctica de expresión diferencial en MASH con R

Módulo para estudiantes basado en el estudio humano GSE126848. El objetivo es conectar la fisiopatología molecular de MASH con una pregunta transcriptómica y producir un volcano plot y un heatmap interpretables.

## Orden de uso

1. Abra `expresion_diferencial_mash.Rproj` en RStudio. Así esta carpeta se convierte automáticamente en el directorio de trabajo.
2. Ejecute `scripts/00_instalar_dependencias.R` una sola vez.
3. Revise `datos/README_fuente_datos.md` y los metadatos.
4. Abra `GUIA_PRACTICA_MASH.Rmd` y ejecute sus secciones en orden.
5. Teja el documento para generar `GUIA_PRACTICA_MASH.html` y consulte los productos creados localmente en `resultados/`.

Si trabaja desde el proyecto principal del repositorio, cambie primero al directorio del módulo o abra su archivo `.Rproj`. Los scripts usan rutas relativas para que el análisis sea reproducible en cualquier computadora.

## Archivos para estudiantes

- `GUIA_PRACTICA_MASH.Rmd`: guía principal con explicación, código, preguntas y resultados integrados.
- `GUIA_PRACTICA_MASH.html`: versión ejecutada que puede abrirse en un navegador.
- `Clase_expresion_diferencial_MASH.pptx`: presentación de la clase, incluida una descripción detallada de ambos CSV y su función en el análisis.
- `TAREA.md`: instrucciones y rúbrica de la actividad autónoma.
- `datos/`: conteos crudos preparados, metadatos y documentación de la fuente.
- `scripts/00_instalar_dependencias.R`: instalación de bibliotecas.
- `scripts/01_analisis_expresion_diferencial.R`: versión continua del análisis para consulta.

## Productos del workflow

- Control de tamaño de biblioteca y PCA
- Tabla completa de resultados de DESeq2
- Tabla de genes que cumplen `padj < 0.05` y `|log2FC| >= 1`
- Volcano plot en PNG y PDF
- Heatmap de los genes con mayor evidencia estadística en PNG y PDF
- Resumen del análisis y `sessionInfo()`

La carpeta `resultados/` se genera al ejecutar la guía y no se conserva en GitHub. Cada estudiante produce así sus propias salidas y puede comprobar que el análisis es reproducible.

## Interpretación mínima

- `log2FoldChange > 0`: mayor expresión en NASH/MASH que en el grupo con obesidad e histología normal.
- `log2FoldChange < 0`: menor expresión en NASH/MASH.
- `padj`: valor p ajustado por comparaciones múltiples con Benjamini-Hochberg.
- Un cambio de ARN es una asociación del tejido total. Puede reflejar estado celular, abundancia de tipos celulares o ambos.

## Reproducibilidad

La guía y el script detienen la ejecución si los nombres o el orden de las muestras no coinciden. Las decisiones modificables están reunidas al inicio: umbral de `padj`, umbral de `log2FC` y número de genes del heatmap.
