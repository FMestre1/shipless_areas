################################################################################
#                    Plot ship density by area - MAPS
################################################################################

#FMestre
#22-10-2024

source("config.R")

#Define the working directory
setwd("~/github/shipless_areas")

#Load density rasters (terciles)
terciles_reclassified_all_summed <- terra::rast("tercile_rasters/terciles_reclassified_all_summed_02FEV25.tif")
terciles_reclassified_all_summed[is.na(terciles_reclassified_all_summed)] <- 0

#Vectors of the areas
mpa <- terra::vect("shapes/WDPA_info.gpkg")
#ebsa <- terra::vect("shapes/Ecologically_or_Biologically_Significant_Marine_Areas_(EBSAs).shp")
#marine_realms <- terra::vect("shapes/marineRealms.shp")
eez <- terra::vect("shapes/eez_v12_aggregated.shp")
#data.frame(table(eez$SOVEREIGN1))
#meow <- terra::vect("shapes/meow_ecos.shp")
mpa_agg_large <- terra::vect("shapes/mpa_big_greater_100000.shp")

#Coastline
coastline <- terra::vect("shapes/coastline.shp")


# Zonal statistics
counted_values_MBR <- terra::zonal(terciles_reclassified_all_summed, 
                                   marine_realms, fun = "mean",
                                   as.raster = TRUE)

counted_values_MPA <- terra::zonal(terciles_reclassified_all_summed, 
                                   mpa, fun = "mean",
                                   as.raster = TRUE)

counted_values_EBSA <- terra::zonal(terciles_reclassified_all_summed, 
                                    ebsa, fun = "mean",
                                    as.raster = TRUE)

counted_values_EEZ <- terra::zonal(terciles_reclassified_all_summed, 
                                   eez, fun = "mean",
                                   as.raster = TRUE)

counted_values_MEOW <- terra::zonal(terciles_reclassified_all_summed, 
                                    meow, fun = "mean",
                                    as.raster = TRUE)


terra::writeRaster(counted_values_MBR, "counted_values_MBR.tif")
terra::writeRaster(counted_values_MPA, "counted_values_MPA.tif")
terra::writeRaster(counted_values_EBSA, "counted_values_EBSA.tif")
terra::writeRaster(counted_values_EEZ, "counted_values_EEZ.tif")
terra::writeRaster(counted_values_MBR, "counted_values_MBR.tif")
terra::writeRaster(counted_values_MEOW, "counted_values_MEOW.tif")

# Define a custom palette from green to red
green_to_red_palette <- colorRampPalette(c("navajowhite", "#CD8500", "#CD0000"))

# Plot using the custom palette

png("map_mbr.png", width = 2000, height = 1000)
terra::plot(counted_values_MBR, col = green_to_red_palette(100))
terra::plot(coastline, add = TRUE)
dev.off()

png("map_mpa.png", width = 2000, height = 1000)
terra::plot(counted_values_MPA, col = green_to_red_palette(100))
terra::plot(coastline, add = TRUE)
dev.off()

png("map_ebsa.png", width = 2000, height = 1000)
terra::plot(counted_values_EBSA, col = green_to_red_palette(100))
terra::plot(coastline, add = TRUE)
dev.off()

png("map_eez.png", width = 2000, height = 1000)
terra::plot(counted_values_EEZ, col = green_to_red_palette(100))
terra::plot(coastline, add = TRUE)
dev.off()

png("map_meow.png", width = 2000, height = 1000)
terra::plot(counted_values_MEOW, col = green_to_red_palette(100))
terra::plot(coastline, add = TRUE)
dev.off()

################################################################################
#         Plotting the percentage of shipless areas covered by MPA            
################################################################################

#FMestre
#02-02-2025

#Load library
source("config.R")

#Load rasters
priority_global <- terra::rast("outputs_fernando_ships_13_maio_25/priority_global_20250129.tif")
shipless_areas <- terra::rast("PMA_PPA_shipless_areas/shipless_global_20250129_RECLASS_FM.tif")
#plot(priority_global)
#plot(shipless_areas)

#Load vectors
#Vectors of the areas
mpa <- terra::vect("shapes/WDPA_info.gpkg")
eez <- terra::vect("shapes/eez_v12_aggregated.shp")
mpa_agg_large <- terra::vect("shapes/mpa_big_greater_100000.shp")
continents <- terra::vect("C:/Users/mestr/Documents/github/shipless_areas/shapes/continents_close_seas.shp")

#1. SHIPLESS AREAS #####################

#Zonal statistics
shipless_in_mpa_all <- terra::mask(shipless_areas, mpa)

# Calculate total shipless area (sum of non-NA values)
total_shipless_area <- sum(terra::values(shipless_areas, na.rm = TRUE))

# Calculate shipless area within MPAs
all_mpa_shipless_area <- sum(terra::values(shipless_in_mpa_all, na.rm = TRUE))

# Compute percentage
percentage_covered_0 <- (all_mpa_shipless_area / total_shipless_area) * 100

##-----------------------------

#Zonal statistics
shipless_in_mpa <- terra::mask(shipless_areas, mpa_agg_large)

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

## -----------------------------------------------------------------------------
#teste1 <- exact_extract(shipless_areas, sf::st_as_sf(mpa), "frac")
#length(teste1)
#nrow(mpa)

################################################################################
#                             MPA with no-take zones            
################################################################################

#FMestre
#30-04-2025

#Define the working directory
setwd("~/github/shipless_areas")

#Load library
library(terra)

#Clear environment
rm(list = ls())

#Load rasters
priority_global <- terra::rast("outputs_fernando_ships_13_maio_25/priority_global_20250129.tif")
shipless_areas <- terra::rast("PMA_PPA_shipless_areas/shipless_global_20250129_RECLASS_FM.tif")
#plot(priority_global)
#plot(shipless_areas)

#Load vectors
#Vectors of the areas
mpa <- terra::vect("shapes/WDPA_info.gpkg")
continents <- terra::vect("C:\\Users\\mestr\\Documents\\0. Artigos\\4. SUBMETIDOS\\shipless_areas\\gis\\continents_close_seas.shp")
#plot(continents, add=TRUE)
#head(mpa)
#unique(mpa$WDPA_NoTake)

#Create new column with no take zones being 1 and all the rest being 0
mpa$noTake_01 <- 0
rows_to_update <- mpa$WDPA_NoTake %in% c("Part", "All")
mpa$noTake_01[rows_to_update] <- 1
#

#Isolate those with some area reported as no-take
mpa_noTake <- mpa[mpa$noTake_01 == 1, ]
#plot(mpa_noTake, add=TRUE)

#1. SHIPLESS AREAS #####################

#Zonal statistics
shipless_in_mpa_notake <- terra::mask(shipless_areas, mpa_noTake)

# Calculate total shipless area (sum of non-NA values)
total_shipless_area <- sum(terra::values(shipless_areas, na.rm = TRUE))

# Calculate shipless area within MPAs
mpa_shipless_area_notake <- sum(terra::values(shipless_in_mpa_notake, na.rm = TRUE))

# Compute percentage
percentage_covered_notake <- (mpa_shipless_area_notake / total_shipless_area) * 100
round(percentage_covered_notake, 2)

#2. PPA (1) #####################
#select the PPA from priority_global, the value 1 in the raster
ppa <- priority_global == 1  # This creates a boolean (TRUE/FALSE) raster
ppa[ppa == 0] <- NA   # Set all FALSE values (not 1) to NA
ppa <- ppa*priority_global
#plot(ppa)

#Zonal statistics
ppa_in_mpa_notake <- terra::mask(ppa, mpa_noTake)

# Calculate total ppa area (sum of non-NA values)
total_ppa_area <- sum(terra::values(ppa, na.rm = TRUE))

# Calculate ppa area within MPAs
mpa_ppa_area_notake <- sum(terra::values(ppa_in_mpa_notake, na.rm = TRUE))

# Compute percentage
percentage_covered2_notake <- (mpa_ppa_area_notake / total_ppa_area) * 100
round(percentage_covered2_notake, 2)

#3. PMA (2) #####################

#select the pma from priority_global, the value 1 in the raster
pma <- priority_global == 2  # This creates a boolean (TRUE/FALSE) raster
pma[pma == 0] <- NA   # Set all FALSE values (not 1) to NA
pma <- pma*priority_global
pma[pma == 2] <- 1
#plot(pma)

#Zonal statistics
pma_in_mpa_notake <- terra::mask(pma, mpa_noTake)

# Calculate total pma area (sum of non-NA values)
total_pma_area <- sum(terra::values(pma, na.rm = TRUE))

# Calculate pma area within MPAs
mpa_pma_area_notake <- sum(terra::values(pma_in_mpa_notake, na.rm = TRUE))

# Compute percentage
percentage_covered3 <- (mpa_pma_area_notake / total_pma_area) * 100
round(percentage_covered3, 2)

