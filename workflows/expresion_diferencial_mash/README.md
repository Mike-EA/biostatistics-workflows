# Práctica de expresión diferencial en MASH con R

Paquete docente reproducible basado en el estudio humano GSE126848. El objetivo es que el alumnado conecte la fisiopatología molecular de MASH con una pregunta transcriptómica y produzca un volcano plot y un heatmap interpretables.

## Orden de uso

1. Abra `expresion_diferencial_mash.Rproj` en RStudio. Así esta carpeta se convierte automáticamente en el directorio de trabajo.
2. Ejecute `scripts/00_instalar_dependencias.R` una sola vez.
3. Revise `datos/README_fuente_datos.md` y los metadatos.
4. Ejecute `scripts/02_analisis_expresion_diferencial.R` por secciones.
5. Consulte los productos en `resultados/`.

`scripts/01_preparar_dataset_GSE126848.R` documenta cómo se obtuvieron los CSV docentes a partir de los archivos originales de GEO. No hace falta ejecutarlo durante la clase.

Si trabaja desde el proyecto principal del repositorio, cambie primero al directorio del módulo o abra su archivo `.Rproj`. Los scripts usan rutas relativas para que el análisis sea reproducible en cualquier computadora.

## Productos del workflow

- Control de tamaño de biblioteca y PCA
- Tabla completa de resultados de DESeq2
- Tabla de genes que cumplen `padj < 0.05` y `|log2FC| >= 1`
- Volcano plot en PNG y PDF
- Heatmap de los genes con mayor evidencia estadística en PNG y PDF
- Resumen del análisis y `sessionInfo()`

## Interpretación mínima

- `log2FoldChange > 0`: mayor expresión en NASH/MASH que en el grupo con obesidad e histología normal.
- `log2FoldChange < 0`: menor expresión en NASH/MASH.
- `padj`: valor p ajustado por comparaciones múltiples con Benjamini-Hochberg.
- Un cambio de ARN es una asociación del tejido total. Puede reflejar estado celular, abundancia de tipos celulares o ambos.

## Reproducibilidad

El script detiene la ejecución si los nombres o el orden de las muestras no coinciden. Las decisiones modificables están reunidas al inicio del script principal: umbral de `padj`, umbral de `log2FC` y número de genes del heatmap.
