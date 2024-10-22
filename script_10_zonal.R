################################################################################
#                    Plot ship density by area - MAPS
################################################################################

#FMestre
#22-10-2024

#Load packages
library(terra)
library(dplyr)

#Load density rasters (terciles)
terciles_reclassified_all_summed_2 <- terra::rast("terciles_reclassified_all_summed.tif")
terciles_reclassified_all_summed_2[is.na(terciles_reclassified_all_summed_2)] <- 0

# Vectors of the areas
mpa <- terra::vect("shapes/mpa_simplified.shp")
ebsa <- terra::vect("shapes/Ecologically_or_Biologically_Significant_Marine_Areas_(EBSAs).shp")
marine_realms <- terra::vect("shapes/marineRealms.shp")
eez <- terra::vect("shapes/eez_v12.shp")
meow <- terra::vect("shapes/meow_ecos.shp")

#Coastline
coastline <- terra::vect("shapes/coastline.shp")

# Aonal statistics
counted_values_MBR <- terra::zonal(terciles_reclassified_all_summed_2, 
                                   marine_realms, fun = "mean",
                                   as.raster = TRUE)

counted_values_MPA <- terra::zonal(terciles_reclassified_all_summed_2, 
                                   mpa, fun = "mean",
                                   as.raster = TRUE)

counted_values_EBSA <- terra::zonal(terciles_reclassified_all_summed_2, 
                                    ebsa, fun = "mean",
                                   as.raster = TRUE)

counted_values_EEZ <- terra::zonal(terciles_reclassified_all_summed_2, 
                                    eez, fun = "mean",
                                    as.raster = TRUE)

counted_values_MEOW <- terra::zonal(terciles_reclassified_all_summed_2, 
                                    meow, fun = "mean",
                                   as.raster = TRUE)


terra::writeRaster(counted_values_MBR, "counted_values_MBR.tif")
terra::writeRaster(counted_values_MPA, "counted_values_MPA.tif")
terra::writeRaster(counted_values_EBSA, "counted_values_EBSA.tif")
terra::writeRaster(counted_values_EEZ, "counted_values_EEZ.tif")
terra::writeRaster(counted_values_MBR, "counted_values_MBR.tif")
terra::writeRaster(counted_values_MEOW, "counted_values_MEOW.tif")



library(terra)

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
