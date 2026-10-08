# Fuente y alcance del dataset

## Estudio

- Acceso GEO: **GSE126848**
- Organismo y tejido: *Homo sapiens*, biopsia hepática
- Tecnología: RNA-seq, Illumina NextSeq 500
- Publicación: Suppli MP et al. *Hepatic transcriptome signatures in patients with varying degrees of nonalcoholic fatty liver disease compared with healthy normal-weight individuals*. Am J Physiol Gastrointest Liver Physiol. 2019;316:G462-G472. DOI: [10.1152/ajpgi.00358.2018](https://doi.org/10.1152/ajpgi.00358.2018)
- Registro: [NCBI GEO GSE126848](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE126848)

El estudio original incluyó 57 biopsias: peso normal (n = 14), obesidad con histología hepática normal (n = 12), NAFL (n = 15) y NASH (n = 16).

## Contraste docente

El dataset listo para clase contiene 28 muestras:

- `Obeso_sin_MASLD`: n = 12
- `NASH_MASH`: n = 16

El término `NASH` se conserva al documentar la clasificación original de 2019. En la clase se presenta como la nomenclatura histórica que corresponde, de forma aproximada, a la categoría actual MASH. No se deben reclasificar retrospectivamente las muestras sin los criterios clínicos completos de MASLD/MASH.

Comparar con personas con obesidad pero histología hepática normal ayuda a centrar la pregunta en cambios asociados con la lesión hepática, más allá de la obesidad. Aun así, es un análisis docente y observacional: no demuestra causalidad ni controla todos los posibles factores clínicos.

## Archivos

- `conteos_GSE126848_MASH_vs_obesidad.csv`: matriz de conteos crudos, genes en filas y muestras en columnas.
- `metadata_GSE126848_MASH_vs_obesidad.csv`: grupo, sexo e identificadores GEO de las 28 muestras del contraste.

Los dos archivos son una selección docente derivada de la matriz pública de conteos y de los metadatos de GSE126848. Los datos originales y la cohorte completa pueden recuperarse desde el registro GEO enlazado arriba.

Los conteos crudos no deben transformarse a porcentajes, TPM ni z-scores antes de introducirlos en DESeq2. El heatmap sí usa una transformación estabilizadora de varianza y estandarización por gen, porque su objetivo es visualizar patrones relativos.
