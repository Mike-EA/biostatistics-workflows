# Workflows modulares

Esta carpeta contiene prácticas autocontenidas que pueden abrirse y ejecutarse sin modificar los materiales introductorios almacenados en la raíz del repositorio.

## Módulos disponibles

| Módulo | Pregunta principal | Producto final |
|---|---|---|
| [Expresión diferencial en MASH](expresion_diferencial_mash/README.md) | ¿Qué genes cambian en biopsias hepáticas con NASH/MASH frente a obesidad con histología normal? | Tabla DESeq2, volcano plot y heatmap |

## Convención de directorios

Cada módulo puede contener:

```text
datos/          Datos de entrada y documentación de su procedencia
scripts/        Código numerado en orden de ejecución
resultados/     Salidas verificadas producidas por los scripts
presentacion/   Material editable para impartir la clase
docencia/       Guías, tareas, rúbricas y notas complementarias
```

El `README.md` de cada módulo define el directorio de trabajo, el orden de ejecución, las dependencias y el alcance de la inferencia.
