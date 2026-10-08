# ==============================================================================
# INSTALACION DE DEPENDENCIAS PARA LA PRACTICA DE EXPRESION DIFERENCIAL
# Ejecutar una sola vez antes de la clase.
# ==============================================================================

options(repos = c(CRAN = "https://cloud.r-project.org"))

paquetes_cran <- c(
  "tidyverse",
  "ggrepel",
  "pheatmap",
  "RColorBrewer"
)

paquetes_bioconductor <- c(
  "DESeq2",
  "EnhancedVolcano",
  "AnnotationDbi",
  "org.Hs.eg.db"
)

instalar_si_falta <- function(paquetes, instalador) {
  faltantes <- paquetes[!vapply(paquetes, requireNamespace, logical(1), quietly = TRUE)]

  if (length(faltantes) == 0) {
    message("Todos los paquetes de este bloque ya estan instalados.")
    return(invisible(NULL))
  }

  message("Instalando: ", paste(faltantes, collapse = ", "))
  instalador(faltantes)
}

instalar_si_falta(
  paquetes_cran,
  function(x) install.packages(x, dependencies = TRUE)
)

if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

instalar_si_falta(
  paquetes_bioconductor,
  function(x) BiocManager::install(x, ask = FALSE, update = FALSE)
)

todos <- c(paquetes_cran, paquetes_bioconductor)
estado <- tibble::tibble(
  paquete = todos,
  instalado = vapply(todos, requireNamespace, logical(1), quietly = TRUE),
  version = vapply(
    todos,
    function(x) if (requireNamespace(x, quietly = TRUE)) {
      as.character(utils::packageVersion(x))
    } else {
      NA_character_
    },
    character(1)
  )
)

print(estado)

if (!all(estado$instalado)) {
  stop("Al menos un paquete no pudo instalarse. Revise los mensajes anteriores.")
}

message(
  "\nInstalacion completa. Abra GUIA_PRACTICA_MASH.Rmd o ejecute ",
  "scripts/01_analisis_expresion_diferencial.R"
)
