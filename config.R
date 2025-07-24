################################################################################
#                               Config File
################################################################################

#FMestre

closeAllConnections()
rm(list=(ls()))
gc(reset=TRUE)

# Load packages ----------------------------------------------------------------

# List of required packages
packages <- c(
  "biscale", "classInt", "cowplot", "data.table", "dplyr",
  "exactextractr", "ggplot2", "ggprism", "ggrepel", "gridExtra",
  "patchwork", "rnaturalearth", "rnaturalearthdata", "sf", 
  "stringr", "terra", "tidyr", "tidyterra", "ggpubr"
)

# Install any that are missing
installed <- rownames(installed.packages())
to_install <- setdiff(packages, installed)
if (length(to_install) > 0) {
  install.packages(to_install)
}

# Load all packages
invisible(lapply(packages, library, character.only = TRUE))
