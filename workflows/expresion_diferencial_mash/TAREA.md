# Tarea: replicar un análisis de expresión diferencial

## Propósito

Aplicar de forma autónoma el mismo razonamiento de la práctica a un dataset distinto y comunicar qué puede concluirse a partir de un volcano plot.

## Dataset asignado

Cada equipo debe utilizar un estudio público de RNA-seq **bulk** con:

- dos grupos biológicos claramente definidos;
- al menos tres réplicas biológicas por grupo;
- matriz de conteos crudos a nivel de gen;
- metadatos suficientes para identificar las muestras;
- una publicación o registro público que describa el diseño.

No se aceptan TPM, FPKM, porcentajes, intensidades de microarreglo ni matrices de célula única como entrada a DESeq2. El dataset no debe ser GSE126848.

## Entregables

1. Script de R comentado y ejecutable desde una carpeta de proyecto.
2. Tabla de metadatos usada en el modelo.
3. Tabla completa de resultados con identificador de gen, `log2FoldChange`, `pvalue` y `padj`.
4. Volcano plot con título, ejes, leyenda, umbrales y contraste explícito.
5. Texto de 250 a 400 palabras que interprete el patrón general y discuta dos genes relevantes.
6. Archivo `sessionInfo.txt`.
7. Opcional: heatmap de 20 a 40 genes con anotación de grupos.

## Pasos mínimos que deben aparecer en el script

1. Importación de conteos y metadatos.
2. Verificación de identificadores, duplicados y orden de las muestras.
3. Filtro explícito de genes con baja expresión.
4. Construcción del modelo en DESeq2 y definición del grupo de referencia.
5. Contraste expresado en palabras: “grupo A respecto a grupo B”.
6. Ajuste por comparaciones múltiples.
7. Clasificación de genes con umbrales justificados.
8. Exportación de resultados y figura.

## Preguntas que debe responder el informe

- ¿Cuál es la unidad experimental y cuántas réplicas biológicas existen?
- ¿Qué significa el signo del `log2FoldChange` en su contraste?
- ¿Por qué se usa `padj` en lugar de seleccionar genes sólo por `pvalue`?
- ¿El diseño permite inferir causalidad? Explique por qué.
- ¿Qué factor clínico o técnico podría confundir el resultado?
- ¿Los genes elegidos forman un patrón biológico coherente o son observaciones aisladas?

## Criterios de evaluación

| Criterio | Puntos |
|---|---:|
| Pregunta biológica y elección del contraste | 15 |
| Integridad de conteos y metadatos | 15 |
| Filtro, modelo y control de comparaciones múltiples | 25 |
| Volcano plot correcto y legible | 20 |
| Interpretación biológica prudente y con fuentes | 15 |
| Reproducibilidad y claridad del script | 10 |
| **Total** | **100** |

El heatmap opcional puede sumar hasta 10 puntos de recuperación, sin exceder 100 puntos totales. Debe usar datos transformados, estandarización por gen y una anotación visible de los grupos.

## Errores que invalidan el análisis

- Cambiar manualmente el signo del fold change para que coincida con una expectativa.
- Usar `pvalue < 0.05` sin reportar `padj`.
- Introducir datos normalizados como si fueran conteos enteros crudos.
- Mezclar réplicas técnicas con réplicas biológicas sin explicarlo.
- Seleccionar sólo genes conocidos y ocultar el resultado global.
