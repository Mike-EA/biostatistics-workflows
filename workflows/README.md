# Workflows modulares

Esta carpeta contiene prácticas autocontenidas que pueden abrirse y ejecutarse sin modificar los materiales introductorios almacenados en la raíz del repositorio.

## Módulos disponibles

| Módulo | Pregunta principal | Producto final |
|---|---|---|
| [Expresión diferencial en MASH](expresion_diferencial_mash/README.md) | ¿Qué genes cambian en biopsias hepáticas con NASH/MASH frente a obesidad con histología normal? | Tabla DESeq2, volcano plot y heatmap |

## Convención de directorios

Cada módulo puede contener:

```text
GUIA_*.Rmd      Guía ejecutable para estudiantes
GUIA_*.html     Versión renderizada de la guía
TAREA.md        Actividad autónoma y criterios de evaluación
datos/          Datos de entrada y documentación de su procedencia
scripts/        Instalación y versión continua del análisis
```

Los resultados generados y los materiales exclusivos del docente se conservan localmente, no en el repositorio público. El `README.md` de cada módulo define el directorio de trabajo, el orden de ejecución, las dependencias y el alcance de la inferencia.
