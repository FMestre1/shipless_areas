################################################################################
#                       Bivariate Choropleth Maps
################################################################################

#FMestre
#18-09-2024

#https://timogrossenbacher.ch/bivariate-maps-with-ggplot2-and-sf/
#https://cran.r-project.org/web/packages/biscale/vignettes/biscale.html

#WD
setwd("/home/fredmestre/shipless_areas2")

#Load library
library(biscale)
library(terra)

#### 1. Load ship density maps
all_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_all/all_summed.tif")
cargo_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_cargo/cargo_summed.tif")
tankers_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_tankers/tankers_summed.tif")
fishing_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_fishing/fishing_summed.tif")
#
all_summed <- terra::rast("E:/shipless_areas/all_summed.tif")
cargo_summed <- terra::rast("E:/shipless_areas/cargo_summed.tif")
tankers_summed <- terra::rast("E:/shipless_areas/tankers_summed.tif")
fishing_summed <- terra::rast("E:/shipless_areas/fishing_summed.tif")
#
#plot(all_summed)
#plot(cargo_summed)
#plot(tankers_summed)
#plot(fishing_summed)

#### 2. Load species richness maps
cetaceans_sr_raster <- terra::rast("cetaceans_sr_raster.tif")
testudines_sr_raster <- terra::rast("testudines_sr_raster.tif")
pinnipeds_sr_raster <- terra::rast("pinnipeds_sr_raster.tif")
#
#plot(cetaceans_sr_raster)
#plot(testudines_sr_raster)
#plot(pinnipeds_sr_raster)

#### 3. Same resolution and extent

# 3.1. Check CRS of both rasters
terra::crs(all_summed)
terra::crs(cargo_summed)
terra::crs(tankers_summed)
terra::crs(fishing_summed)
#
terra::crs(cetaceans_sr_raster)
terra::crs(testudines_sr_raster)
terra::crs(pinnipeds_sr_raster)

# 3.2. Align rastes

#Check extent and resolution

terra::ext(all_summed)
#terra::ext(cargo_summed)
#terra::ext(tankers_summed)
#terra::ext(fishing_summed)
#
terra::res(all_summed)
#terra::res(cargo_summed)
#terra::res(tankers_summed)
#terra::res(fishing_summed)
#
terra::ext(cetaceans_sr_raster)
#terra::ext(testudines_sr_raster)
#terra::ext(pinnipeds_sr_raster)
#
terra::res(cetaceans_sr_raster)
#terra::res(testudines_sr_raster)
#terra::res(pinnipeds_sr_raster)

#
# Resample to match the resolution of raster1
all_summed_resampled <- resample(all_summed, cetaceans_sr_raster)
cargo_summed_resampled <- resample(cargo_summed, cetaceans_sr_raster)
tankers_summed_resampled <- resample(tankers_summed, cetaceans_sr_raster)
fishing_summed_resampled <- resample(fishing_summed, cetaceans_sr_raster)
#Save
terra::writeRaster(all_summed_resampled, filename = "all_summed_resampled.tif")
terra::writeRaster(cargo_summed_resampled, filename = "cargo_summed_resampled.tif")
terra::writeRaster(tankers_summed_resampled, filename = "tankers_summed_resampled.tif")
terra::writeRaster(fishing_summed_resampled, filename = "fishing_summed_resampled.tif")
#Load
all_summed_resampled <- terra::rast("all_summed_resampled.tif")
cargo_summed_resampled <- terra::rast("cargo_summed_resampled.tif")
tankers_summed_resampled <- terra::rast("tankers_summed_resampled.tif")
fishing_summed_resampled <- terra::rast("fishing_summed_resampled.tif")


#terra::res(all_summed_resampled)
#terra::res(cargo_summed_resampled)
#terra::res(tankers_summed_resampled)
#terra::res(fishing_summed_resampled)


terra::global(all_summed_resampled, fun=quantile, na.rm = TRUE)
?terra::quantile

# Calculate the tercile breakpoints
terciles_all_summed <- quantile(values(all_summed_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_cargo_summed <- quantile(values(cargo_summed_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_tankers_summed <- quantile(values(tankers_summed_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_fishing_summed <- quantile(values(fishing_summed_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
#
terciles_cetaceans_sr_raster <- quantile(values(cetaceans_sr_raster), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_testudines_sr_raster <- quantile(values(testudines_sr_raster), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_pinnipeds_sr_raster <- quantile(values(pinnipeds_sr_raster), probs = c(1/3, 2/3), na.rm = TRUE)


# Classify the raster into terciles
# Create a matrix for classification
class_matrix_all_summed <- matrix(c(0, terciles_all_summed[1], 1,  # First tercile
                                 terciles_all_summed[1], terciles_all_summed[2], 2,  # Second tercile
                                 terciles_all_summed[2], as.numeric(global(all_summed_resampled, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                 ncol = 3, byrow = TRUE)

class_matrix_cargo_summed <- matrix(c(0, terciles_cargo_summed[1], 1,  # First tercile
                                  terciles_cargo_summed[1], terciles_cargo_summed[2], 2,  # Second tercile
                                  terciles_cargo_summed[2], as.numeric(global(cargo_summed_resampled, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                  ncol = 3, byrow = TRUE)

class_matrix_tankers_summed <- matrix(c(0, terciles_tankers_summed[1], 1,  # First tercile
                                  terciles_tankers_summed[1], terciles_tankers_summed[2], 2,  # Second tercile
                                  terciles_tankers_summed[2], as.numeric(global(tankers_summed_resampled, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                   ncol = 3, byrow = TRUE)

class_matrix_fishing_summed <- matrix(c(0, terciles_fishing_summed[1], 1,  # First tercile
                                   terciles_fishing_summed[1], terciles_fishing_summed[2], 2,  # Second tercile
                                   terciles_fishing_summed[2], as.numeric(global(fishing_summed_resampled, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                   ncol = 3, byrow = TRUE)

class_matrix_cetaceans <- matrix(c(as.numeric(global(cetaceans_sr_raster, fun=min, na.rm=TRUE)), terciles_cetaceans_sr_raster[1], 1,  # First tercile
                                   terciles_cetaceans_sr_raster[1], terciles_cetaceans_sr_raster[2], 2,  # Second tercile
                                   terciles_cetaceans_sr_raster[2], as.numeric(global(cetaceans_sr_raster, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                    ncol = 3, byrow = TRUE)

class_matrix_testudines <- matrix(c(as.numeric(global(testudines_sr_raster, fun=min, na.rm=TRUE)), terciles_testudines_sr_raster[1], 1,  # First tercile
                                    terciles_testudines_sr_raster[1], terciles_testudines_sr_raster[2], 2,  # Second tercile
                                    terciles_testudines_sr_raster[2], as.numeric(global(testudines_sr_raster, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                    ncol = 3, byrow = TRUE)


class_matrix_pinnipeds <- matrix(c(as.numeric(global(pinnipeds_sr_raster, fun=min, na.rm=TRUE)), terciles_pinnipeds_sr_raster[1], 1,  # First tercile
                                  terciles_pinnipeds_sr_raster[1], terciles_pinnipeds_sr_raster[2], 2,  # Second tercile
                                  terciles_pinnipeds_sr_raster[2], as.numeric(global(pinnipeds_sr_raster, fun=max, na.rm=TRUE)), 3),  # Third tercile
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

# Plot the result
plot(terciles_reclassified_all_summed)
plot(terciles_reclassified_cargo_summed)
plot(terciles_reclassified_tankers_summed)
plot(terciles_reclassified_fishing_summed)
#
plot(terciles_reclassified_cetaceans)
plot(terciles_reclassified_testudines)
plot(terciles_reclassified_pinnipeds)

#Save
terra::writeRaster(terciles_reclassified_all_summed, filename = "terciles_reclassified_all_summed.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_cargo_summed, filename = "terciles_reclassified_cargo_summed.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_tankers_summed, filename = "terciles_reclassified_tankers_summed.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_fishing_summed, filename = "terciles_reclassified_fishing_summed.tif", overwrite = TRUE)
#
terra::writeRaster(terciles_reclassified_cetaceans, filename = "terciles_reclassified_cetaceans.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_testudines, filename = "terciles_reclassified_testudines.tif", overwrite = TRUE)
terra::writeRaster(terciles_reclassified_pinnipeds, filename = "terciles_reclassified_pinnipeds.tif", overwrite = TRUE)

#Load
terciles_reclassified_all_summed <- terra::rast("terciles_reclassified_all_summed.tif")
terciles_reclassified_cargo_summed <- terra::rast("terciles_reclassified_cargo_summed.tif")
terciles_reclassified_tankers_summed <- terra::rast("terciles_reclassified_tankers_summed.tif")
terciles_reclassified_fishing_summed <- terra::rast("terciles_reclassified_fishing_summed.tif")
#
terciles_reclassified_cetaceans <- terra::rast("terciles_reclassified_cetaceans.tif")
terciles_reclassified_testudines <- terra::rast("terciles_reclassified_testudines.tif")
terciles_reclassified_pinnipeds <- terra::rast("terciles_reclassified_pinnipeds.tif")

##############################

library(bivariatemaps)

colormatrix <- colmat(
  nquantiles = 3,
  upperleft = "blue",
  upperright = "red",
  bottomleft = "grey",
  bottomright = "yellow",
  xlab = "x label",
  ylab = "y label"
)

all_summed_vs_cetaceans <- bivariate.map(all_summed, cetaceans_sr_raster, colormatrix, nquantiles = 3)




