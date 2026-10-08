# Guía docente: expresión diferencial aplicada a MASH

## Resultado de aprendizaje

Al finalizar la sesión, el estudiante podrá explicar cómo una matriz de conteos y un diseño experimental se convierten en una estimación de cambio de expresión, una medida de incertidumbre y dos visualizaciones complementarias: volcano plot y heatmap.

## Duración sugerida: 100 minutos

| Minutos | Actividad | Pregunta docente |
|---:|---|---|
| 0–10 | Recuperación de la clase de fisiopatología | ¿Qué programas moleculares esperaríamos encontrar alterados en MASH? |
| 10–20 | Diseño del contraste y revisión del dataset | ¿Qué comparación separa enfermedad hepática del efecto general de obesidad? |
| 20–35 | Conteos, metadatos y control de identidad | ¿Qué error ocurre si el orden de las muestras no coincide? |
| 35–50 | Filtrado, normalización y PCA | ¿Por qué una biblioteca grande no implica mayor expresión biológica de todos los genes? |
| 50–65 | Modelo DESeq2, log2FC y ajuste de p | ¿Qué aporta cada eje del volcano plot? |
| 65–80 | Construcción e interpretación del volcano | ¿Qué genes tienen efecto grande y evidencia estadística suficiente? |
| 80–92 | Heatmap y agrupamiento | ¿El patrón separa muestras o revela heterogeneidad? |
| 92–100 | Limitaciones y encargo de tarea | ¿Qué parte del patrón puede deberse a composición celular? |

## Fundamento por etapa

### 1. Pregunta y contraste

El contraste principal es NASH/MASH respecto a obesidad con histología hepática normal. El signo positivo del `log2FoldChange` siempre se interpreta como mayor expresión en MASH. Escriba el contraste en palabras antes de ejecutar código.

### 2. Conteos y metadatos

La matriz contiene genes por muestras. El metadata contiene variables de las muestras. DESeq2 asume que la columna i de la matriz corresponde exactamente a la fila i del metadata. La verificación con `identical()` es una condición del análisis, no un detalle de programación.

### 3. Filtrado

Los genes con conteos casi nulos aportan poca información y aumentan la carga de pruebas. El umbral de 10 conteos en al menos 5 muestras es una decisión didáctica explícita. No es una constante universal.

### 4. Normalización y dispersión

DESeq2 estima factores de tamaño para hacer comparables las bibliotecas y modela conteos con una distribución binomial negativa. La dispersión representa variabilidad entre réplicas biológicas. El modelo usa conteos crudos; la transformación VST se reserva para PCA y heatmap.

### 5. Cambio y evidencia

El `log2FoldChange` mide magnitud y dirección. Un valor de 1 equivale a un cambio de dos veces; −1 equivale a la mitad. El valor p cuantifica incompatibilidad con la hipótesis nula bajo el modelo. El `padj` controla la proporción esperada de falsos descubrimientos entre los hallazgos al probar miles de genes.

### 6. Volcano plot

El eje x muestra el tamaño del cambio. El eje y muestra evidencia estadística como `−log10(padj)`. Las esquinas superiores concentran genes con ambas propiedades. El gráfico no demuestra mecanismo, causalidad ni relevancia clínica.

### 7. Heatmap

El heatmap responde una pregunta distinta: ¿cómo se distribuye el patrón de los genes seleccionados entre las muestras? Cada fila se estandariza. Por ello, el color compara una muestra con la media de ese mismo gen, no niveles absolutos entre genes.

### 8. Regreso a la fisiopatología

Agrupe los genes por programas, por ejemplo matriz extracelular, reclutamiento inmune, metabolismo lipídico y respuesta al estrés. Después contraste esas hipótesis con literatura. Evite elegir primero un mecanismo y forzar la lectura del gráfico.

## Mensajes de cautela

- RNA de tejido total mezcla cambios del estado celular con cambios en proporciones celulares.
- Asociación transcriptómica no equivale a actividad proteica, flujo metabólico o causalidad.
- La cohorte original usa NASH/NAFLD porque se publicó antes de la nomenclatura MASLD/MASH.
- El estudio incluyó enfermedad de severidad relativamente baja y el contraste docente simplifica covariables clínicas.

## Referencias esenciales

- Suppli MP et al. 2019. DOI: 10.1152/ajpgi.00358.2018.
- Love MI, Huber W, Anders S. *Genome Biology*. 2014;15:550. DOI: 10.1186/s13059-014-0550-8.
- Benjamini Y, Hochberg Y. *J Royal Stat Soc B*. 1995;57:289–300.
