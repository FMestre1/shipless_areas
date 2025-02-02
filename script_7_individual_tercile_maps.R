################################################################################
#                    Individual Tercile-Reclassified Maps
################################################################################

#FMestre
#18-09-2024

#Load library
library(biscale)
library(terra)

#Clear environment
rm(list = ls())

#Define the working directory
setwd("~/github/shipless_areas")

all_summed_resampled <- terra::rast("final_rasters/all_summed_resampled_no_2011_NA.tif")
cargo_summed_resampled <- terra::rast("final_rasters/cargo_summed_resampled_NA.tif")
tankers_summed_resampled <- terra::rast("final_rasters/tankers_summed_resampled_NA.tif")
fishing_summed_resampled <- terra::rast("final_rasters/fishing_summed_resampled_NA.tif")

cetaceans_sr_raster <- terra::rast("final_rasters/cetaceans_sr_raster_NA.tif")
testudines_sr_raster <- terra::rast("final_rasters/testudines_sr_raster_NA.tif")
pinnipeds_sr_raster <- terra::rast("final_rasters/pinnipeds_sr_raster_NA.tif")
seabirds_sr_raster_resampled_cropped_ext <- terra::rast("final_rasters/seabirds_sr_raster_resampled_cropped_ext_NA.tif")
all_biodiv_sr_raster <- cetaceans_sr_raster + testudines_sr_raster + pinnipeds_sr_raster + seabirds_sr_raster_resampled_cropped_ext

# Calculate the tercile breakpoints
terciles_all_summed <- quantile(values(all_summed_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_cargo_summed <- quantile(values(cargo_summed_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_tankers_summed <- quantile(values(tankers_summed_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_fishing_summed <- quantile(values(fishing_summed_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
#
terciles_cetaceans_sr_raster <- quantile(values(cetaceans_sr_raster), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_testudines_sr_raster <- quantile(values(testudines_sr_raster), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_pinnipeds_sr_raster <- quantile(values(pinnipeds_sr_raster), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_seabirds_sr_raster_resampled_cropped_ex <- quantile(values(seabirds_sr_raster_resampled_cropped_ext), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_biodiv_sr_raster <- quantile(values(all_biodiv_sr_raster), probs = c(1/3, 2/3), na.rm = TRUE)

# Classify the raster into terciles
# Create a matrix for classification
class_matrix_all_summed <- matrix(c(-1, terciles_all_summed[1], 1,  # First tercile
                                 terciles_all_summed[1], terciles_all_summed[2], 2,  # Second tercile
                                 terciles_all_summed[2], as.numeric(global(all_summed_resampled, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                 ncol = 3, byrow = TRUE)

class_matrix_cargo_summed <- matrix(c(-1, terciles_cargo_summed[1], 1,  # First tercile
                                  terciles_cargo_summed[1], terciles_cargo_summed[2], 2,  # Second tercile
                                  terciles_cargo_summed[2], as.numeric(global(cargo_summed_resampled, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                  ncol = 3, byrow = TRUE)

class_matrix_tankers_summed <- matrix(c(-1, terciles_tankers_summed[1], 1,  # First tercile
                                  terciles_tankers_summed[1], terciles_tankers_summed[2], 2,  # Second tercile
                                  terciles_tankers_summed[2], as.numeric(global(tankers_summed_resampled, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                   ncol = 3, byrow = TRUE)

class_matrix_fishing_summed <- matrix(c(-1, terciles_fishing_summed[1], 1,  # First tercile
                                   terciles_fishing_summed[1], terciles_fishing_summed[2], 2,  # Second tercile
                                   terciles_fishing_summed[2], as.numeric(global(fishing_summed_resampled, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                   ncol = 3, byrow = TRUE)

class_matrix_cetaceans <- matrix(c(-1, terciles_cetaceans_sr_raster[1], 1,  # First tercile
                                   terciles_cetaceans_sr_raster[1], terciles_cetaceans_sr_raster[2], 2,  # Second tercile
                                   terciles_cetaceans_sr_raster[2], as.numeric(global(cetaceans_sr_raster, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                   ncol = 3, byrow = TRUE)

class_matrix_testudines <- matrix(c(-1, terciles_testudines_sr_raster[1], 1,  # First tercile
                                    terciles_testudines_sr_raster[1], terciles_testudines_sr_raster[2], 2,  # Second tercile
                                    terciles_testudines_sr_raster[2], as.numeric(global(testudines_sr_raster, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                    ncol = 3, byrow = TRUE)

class_matrix_pinnipeds <- matrix(c(-1, terciles_pinnipeds_sr_raster[1], 1,  # First tercile
                                  terciles_pinnipeds_sr_raster[1], terciles_pinnipeds_sr_raster[2], 2,  # Second tercile
                                  terciles_pinnipeds_sr_raster[2], as.numeric(global(pinnipeds_sr_raster, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                  ncol = 3, byrow = TRUE)

class_matrix_seabirds <- matrix(c(-1, terciles_seabirds_sr_raster_resampled_cropped_ex[1], 1,  # First tercile
                                  terciles_seabirds_sr_raster_resampled_cropped_ex[1], terciles_seabirds_sr_raster_resampled_cropped_ex[2], 2,  # Second tercile
                                  terciles_seabirds_sr_raster_resampled_cropped_ex[2], as.numeric(global(seabirds_sr_raster_resampled_cropped_ext, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                   ncol = 3, byrow = TRUE)

class_matrix_all_biodiv <- matrix(c(-1, terciles_biodiv_sr_raster[1], 1,  # First tercile
                                    terciles_biodiv_sr_raster[1], terciles_biodiv_sr_raster[2], 2,  # Second tercile
                                    terciles_biodiv_sr_raster[2], as.numeric(global(all_biodiv_sr_raster, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                    ncol = 3, byrow = TRUE)

# Apply the classification
terciles_reclassified_all_summed <- terra::classify(all_summed_resampled, class_matrix_all_summed)
terciles_reclassified_cargo_summed <- terra::classify(cargo_summed_resampled, class_matrix_cargo_summed)
terciles_reclassified_tankers_summed <- terra::classify(tankers_summed_resampled, class_matrix_tankers_summed)
terciles_reclassified_fishing_summed <- terra::classify(fishing_summed_resampled, class_matrix_fishing_summed)
#
terciles_reclassified_cetaceans <- terra::classify(cetaceans_sr_raster, class_matrix_cetaceans)
terciles_reclassified_testudines <- terra::classify(testudines_sr_raster, class_matrix_testudines)
terciles_reclassified_pinnipeds <- terra::classify(pinnipeds_sr_raster, class_matrix_pinnipeds)
terciles_reclassified_seabirds <- terra::classify(seabirds_sr_raster_resampled_cropped_ext, class_matrix_seabirds)
terciles_reclassified_all_biodiv <- terra::classify(all_biodiv_sr_raster, class_matrix_all_biodiv)

# Plot the result
terra::plot(terciles_reclassified_all_summed)
terra::plot(terciles_reclassified_cargo_summed)
terra::plot(terciles_reclassified_tankers_summed)
terra::plot(terciles_reclassified_fishing_summed)
#
terra::plot(terciles_reclassified_cetaceans)
terra::plot(terciles_reclassified_testudines)
terra::plot(terciles_reclassified_pinnipeds)
terra::plot(terciles_reclassified_seabirds)
terra::plot(terciles_reclassified_all_biodiv)

################################################################################

# Plot
tiff("terciles_reclassified_all_summed_02FEv25.tif", width=5000, height=2900, res=300)
plot(terciles_reclassified_all_summed, col = c("#E1BFAC" ,"#A6626D", "#6B062F"))
dev.off()

tiff("terciles_reclassified_cargo_summed_02FEv25.tif", width=5000, height=2900, res=300)
plot(terciles_reclassified_cargo_summed, col = c("#E1BFAC" ,"#A6626D", "#6B062F"))
dev.off()

tiff("terciles_reclassified_tankers_summed_02FEv25.tif", width=5000, height=2900, res=300)
plot(terciles_reclassified_tankers_summed, col = c("#E1BFAC" ,"#A6626D", "#6B062F"))
dev.off()

tiff("terciles_reclassified_fishing_summed_02FEv25.tif", width=5000, height=2900, res=300)
plot(terciles_reclassified_fishing_summed, col = c("#E1BFAC" ,"#A6626D", "#6B062F"))
dev.off()

####

tiff("terciles_reclassified_cetaceans_02FEv25.tif", width=5000, height=2900, res=300)
plot(terciles_reclassified_cetaceans, col = c("#C3B3D8" ,"#735F9B", "#240D5E"))
dev.off()

tiff("terciles_reclassified_testudines_02FEv25.tif", width=5000, height=2900, res=300)
plot(terciles_reclassified_testudines, col = c("#C3B3D8" ,"#735F9B", "#240D5E"))
dev.off()

tiff("terciles_reclassified_pinnipeds_02FEv25.tif", width=5000, height=2900, res=300)
plot(terciles_reclassified_pinnipeds, col = c("#C3B3D8" ,"#735F9B", "#240D5E"))
dev.off()

tiff("terciles_reclassified_seabirds_02FEv25.tif", width=5000, height=2900, res=300)
plot(terciles_reclassified_seabirds, col = c("#C3B3D8" ,"#735F9B", "#240D5E"))
dev.off()

tiff("terciles_reclassified_all_biodiversity_02FEv25.tif", width=5000, height=2900, res=300)
plot(terciles_reclassified_all_biodiv, col = c("#C3B3D8" ,"#735F9B", "#240D5E"))
dev.off()

################################################################################

#Save
terra::writeRaster(terciles_reclassified_all_summed, filename = "tercile_rasters/terciles_reclassified_all_summed_02FEV25.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_cargo_summed, filename = "tercile_rasters/terciles_reclassified_cargo_summed_02FEV25.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_tankers_summed, filename = "tercile_rasters/terciles_reclassified_tankers_summed_02FEV25.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_fishing_summed, filename = "tercile_rasters/terciles_reclassified_fishing_summed_02FEV25.tif", overwrite = TRUE)
#
terra::writeRaster(terciles_reclassified_cetaceans, filename = "tercile_rasters/terciles_reclassified_cetaceans_02FEV25.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_testudines, filename = "tercile_rasters/terciles_reclassified_testudines_02FEV25.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_pinnipeds, filename = "tercile_rasters/terciles_reclassified_pinnipeds_02FEV25.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_seabirds, filename = "tercile_rasters/terciles_reclassified_seabirds_02FEV25.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_all_biodiv, filename = "tercile_rasters/terciles_reclassified_all_biodiv_20JAN25.tif", overwrite = TRUE)

#Load
terciles_reclassified_all_summed <- terra::rast("tercile_rasters/terciles_reclassified_all_summed_02FEV25.tif")
terciles_reclassified_cargo_summed <- terra::rast("tercile_rasters/terciles_reclassified_cargo_summed_02FEV25.tif")
terciles_reclassified_tankers_summed <- terra::rast("tercile_rasters/terciles_reclassified_tankers_summed_02FEV25.tif")
terciles_reclassified_fishing_summed <- terra::rast("tercile_rasters/terciles_reclassified_fishing_summed_02FEV25.tif")
#
terciles_reclassified_cetaceans <- terra::rast("tercile_rasters/terciles_reclassified_cetaceans_02FEV25.tif")
terciles_reclassified_testudines <- terra::rast("tercile_rasters/terciles_reclassified_testudines_02FEV25.tif")
terciles_reclassified_pinnipeds <- terra::rast("tercile_rasters/terciles_reclassified_pinnipeds_02FEV25.tif")
terciles_reclassified_seabirds <- terra::rast("tercile_rasters/terciles_reclassified_seabirds_02FEV25.tif")
terciles_reclassified_all_biodiv <- terra::rast("tercile_rasters/terciles_reclassified_all_biodiv_20JAN25.tif")
