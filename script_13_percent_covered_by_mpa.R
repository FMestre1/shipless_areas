################################################################################
#         Plotting the percentage of shipless areas covered by MPA            
################################################################################

#FMestre
#02-02-2025

#Define the working directory
setwd("~/github/shipless_areas")

#Load library
library(terra)

#Clear environment
rm(list = ls())

#Load rasters
priority_global <- terra::rast("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/last_files_fernando/priority_global_20250129.tif")
shipless_areas <- terra::rast("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/last_files_fernando/shipless_global_20250129_RECLASS_FM.tif")
#plot(priority_global)
#plot(shipless_Areas)

#Load MPA
mpa <- terra::vect("D:/shipless_areas_paper/datasets/MPA/mpa_simplified_assis_CORRECTED_2.shp")
continents <- terra::vect("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/continents_close_seas.shp")
#plot(continents, add=TRUE)

#1. SHIPLESS AREAS #####################

#Zonal statistics
shipless_in_mpa <- terra::mask(shipless_areas, mpa)

# Calculate total shipless area (sum of non-NA values)
total_shipless_area <- sum(terra::values(shipless_areas, na.rm = TRUE))

# Calculate shipless area within MPAs
mpa_shipless_area <- sum(terra::values(shipless_in_mpa, na.rm = TRUE))

# Compute percentage
percentage_covered <- (mpa_shipless_area / total_shipless_area) * 100

#2. PPA (1) #####################
#select the PPA from priority_global, the value 1 in the raster
ppa <- priority_global == 1  # This creates a boolean (TRUE/FALSE) raster
ppa[ppa == 0] <- NA   # Set all FALSE values (not 1) to NA
ppa <- ppa*priority_global
#plot(ppa)

#Zonal statistics
ppa_in_mpa <- terra::mask(ppa, mpa)

# Calculate total ppa area (sum of non-NA values)
total_ppa_area <- sum(terra::values(ppa, na.rm = TRUE))

# Calculate ppa area within MPAs
mpa_ppa_area <- sum(terra::values(ppa_in_mpa, na.rm = TRUE))

# Compute percentage
percentage_covered2 <- (mpa_ppa_area / total_ppa_area) * 100

#3. PMA (2) #####################

#select the pma from priority_global, the value 1 in the raster
pma <- priority_global == 2  # This creates a boolean (TRUE/FALSE) raster
pma[pma == 0] <- NA   # Set all FALSE values (not 1) to NA
pma <- pma*priority_global
pma[pma == 2] <- 1
#plot(pma)

#Zonal statistics
pma_in_mpa <- terra::mask(pma, mpa)

# Calculate total pma area (sum of non-NA values)
total_pma_area <- sum(terra::values(pma, na.rm = TRUE))

# Calculate pma area within MPAs
mpa_pma_area <- sum(terra::values(pma_in_mpa, na.rm = TRUE))

# Compute percentage
percentage_covered3 <- (mpa_pma_area / total_pma_area) * 100

