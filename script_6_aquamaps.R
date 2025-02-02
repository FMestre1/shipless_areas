################################################################################
#                            GETTING AQUAMAPS DATA
################################################################################

#FMestre
#24-09-2024

# Load necessary libraries
library(terra)

#Clear environment
rm(list = ls())

#Define the working directory
setwd("~/github/shipless_areas")

# Step 1: Read the CSV file
global_2020_sr <- read.csv('aquamaps/Global_2020_MarineSpeciesRichness_AquaMaps.csv')
cetacean_sr <- read.csv('aquamaps/cetacean.csv', skip = 4)
odobenidae_sr <- read.csv('aquamaps/odobenidae.csv', skip = 4)
otariidae_sr <- read.csv('aquamaps/otariidae.csv', skip = 4)
phocidae_sr <- read.csv('aquamaps/phocidae.csv', skip = 4)
testudines_sr <- read.csv('aquamaps/testudines.csv', skip = 4)
#
#head(global_2020_sr)
#head(cetacean_sr)
#head(odobenidae_sr)
#head(otariidae_sr)
#head(phocidae_sr)
#head(testudines_sr)

# Create an empty raster with the extent of the vector and set the desired resolution
r <- rast(ext(global_2020_sr_2), resolution = 0.5)

#### ALL SPECIES ####

# Step 1: Create a SpatialPointsDataFrame (or SpatVector in terra)
global_2020_sr_2 <- terra::vect(global_2020_sr, geom = c("Longitude", "Latitude"), crs = "EPSG:4326")

# Step 2: Rasterize the vector data using a specific field
global_2020_sr_raster <- rasterize(global_2020_sr_2, r, field = "Species.Count", fun = mean)
#plot(global_2020_sr_raster)

writeRaster(global_2020_sr_raster, "all_species_richness_raster.tif", overwrite = TRUE)

#### CETACEANS ####

# Step 1: Create a SpatialPointsDataFrame (or SpatVector in terra)
cetaceans_sr <- terra::vect(cetacean_sr, geom = c("Center.Longitude", "Center.Latitude"), crs = "EPSG:4326")

# Step 2: Rasterize the vector data using a specific field
cetaceans_sr_raster <- rasterize(cetaceans_sr, r, field = "Species.Count", fun = mean)
#plot(cetaceans_sr_raster)

writeRaster(cetaceans_sr_raster, "cetaceans_sr_raster.tif", overwrite = TRUE)

#### TESTUDINES ####

# Step 1: Create a SpatialPointsDataFrame (or SpatVector in terra)
testudines_sr <- terra::vect(testudines_sr, geom = c("Center.Longitude", "Center.Latitude"), crs = "EPSG:4326")

# Step 2: Rasterize the vector data using a specific field
testudines_sr_raster <- rasterize(testudines_sr, r, field = "Species.Count", fun = mean)
#plot(testudines_sr_raster)

writeRaster(testudines_sr_raster, "testudines_sr_raster.tif", overwrite = TRUE)

#### PINNIPEDS ####

# Step 1: Create a SpatialPointsDataFrame (or SpatVector in terra)
odobenidae_sr <- terra::vect(odobenidae_sr, geom = c("Center.Longitude", "Center.Latitude"), crs = "EPSG:4326")
otariidae_sr <- terra::vect(otariidae_sr, geom = c("Center.Longitude", "Center.Latitude"), crs = "EPSG:4326")
phocidae_sr <- terra::vect(phocidae_sr, geom = c("Center.Longitude", "Center.Latitude"), crs = "EPSG:4326")

# Step 2: Rasterize the vector data using a specific field
odobenidae_sr_raster <- rasterize(odobenidae_sr, r, field = "Species.Count", fun = mean)
otariidae_sr_raster <- rasterize(otariidae_sr, r, field = "Species.Count", fun = mean)
phocidae_sr_raster <- rasterize(phocidae_sr, r, field = "Species.Count", fun = mean)

# Convert NA to 0 for each raster using ifel
odobenidae_sr_raster[is.na(odobenidae_sr_raster)] <- 0
otariidae_sr_raster[is.na(otariidae_sr_raster)] <- 0
phocidae_sr_raster[is.na(phocidae_sr_raster)] <- 0
#plot(odobenidae_sr_raster)
#plot(otariidae_sr_raster)
#plot(phocidae_sr_raster)

pinnipeds_sr_raster <- odobenidae_sr_raster + otariidae_sr_raster + phocidae_sr_raster

pinnipeds_sr_raster[pinnipeds_sr_raster==0] <- NA
#plot(pinnipeds_sr_raster)

writeRaster(pinnipeds_sr_raster, "pinnipeds_sr_raster.tif", overwrite = TRUE)
