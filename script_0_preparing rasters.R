################################################################################
#                                 Preparing maps
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

# CCMAR computer
all_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_all/all_summed.tif")
cargo_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_cargo/cargo_summed.tif")
tankers_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_tankers/tankers_summed.tif")
fishing_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_fishing/fishing_summed.tif")

# My disk
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
seabirds_sr_raster <- terra::rast("seabirds_data/n_species_all_ranges.tif")

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
# Resample to match the resolution and extent
all_summed_resampled <- resample(all_summed, cetaceans_sr_raster)
cargo_summed_resampled <- resample(cargo_summed, cetaceans_sr_raster)
tankers_summed_resampled <- resample(tankers_summed, cetaceans_sr_raster)
fishing_summed_resampled <- resample(fishing_summed, cetaceans_sr_raster)
#
seabirds_sr_raster_resampled <- resample(seabirds_sr_raster, cetaceans_sr_raster)
#plot(seabirds_sr_raster_resampled)
continents <- terra::vect("shapes/coastline.shp")
#plot(continents, add=TRUE)

# Crop the raster using the vector leaving out the continents 
extent_vector <- as.polygons(ext(continents))
#plot(extent_vector)
oceans <- erase(extent_vector, continents)
crs(oceans) <- crs(continents)
#plot(oceans, add=TRUE)
seabirds_sr_raster_resampled_cropped <- crop(seabirds_sr_raster_resampled, oceans, mask=TRUE)
#plot(seabirds_sr_raster_resampled_cropped)

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

################################################################################
#                        Set continents to NA, else to 0
################################################################################

#FMestre
#02-12-2024


#### 1. Load ships density maps
#Using raster (to keep compatibility with the functions)
all_summed_resampled <- terra::rast("all_summed_resampled.tif")
cargo_summed_resampled <- terra::rast("cargo_summed_resampled.tif")
tankers_summed_resampled <- terra::rast("tankers_summed_resampled.tif")
fishing_summed_resampled <- terra::rast("fishing_summed_resampled.tif")
#
cetaceans_sr_raster <- terra::rast("cetaceans_sr_raster.tif")
testudines_sr_raster <- terra::rast("testudines_sr_raster.tif")
pinnipeds_sr_raster <- terra::rast("pinnipeds_sr_raster.tif")
seabirds_sr_raster_resampled_cropped_ext <- terra::rast("seabirds_sr_raster_resampled_cropped_ext.tif")

#COnver to NA to 0
all_summed_resampled[is.na(all_summed_resampled[])] <- 0 
cargo_summed_resampled[is.na(cargo_summed_resampled[])] <- 0 
tankers_summed_resampled[is.na(tankers_summed_resampled[])] <- 0 
fishing_summed_resampled[is.na(fishing_summed_resampled[])] <- 0 

cetaceans_sr_raster[is.na(cetaceans_sr_raster[])] <- 0 
testudines_sr_raster[is.na(testudines_sr_raster)] <- 0 
pinnipeds_sr_raster[is.na(pinnipeds_sr_raster[])] <- 0
seabirds_sr_raster_resampled_cropped_ext[is.na(seabirds_sr_raster_resampled_cropped_ext[])] <- 0

#Convert under vector to NA
continents <- terra::vect("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/continents_close_seas.shp")
plot(continents)

# Create a mask using the vector
all_summed_resampled_mask <- terra::mask(all_summed_resampled, continents)
cargo_summed_resampled_mask <- terra::mask(cargo_summed_resampled, continents)
tankers_summed_resampled_mask <- terra::mask(tankers_summed_resampled, continents)
fishing_summed_resampled_mask <- terra::mask(fishing_summed_resampled, continents)

cetaceans_sr_mask <- terra::mask(cetaceans_sr_raster, continents)
testudines_sr_raster_mask <- terra::mask(testudines_sr_raster, continents)
pinnipeds_sr_raster_mask <- terra::mask(pinnipeds_sr_raster, continents)
seabirds_sr_raster_resampled_cropped_ext_mask <- terra::mask(seabirds_sr_raster_resampled_cropped_ext, continents)

# Convert all values to NA outside the mask
all_summed_resampled[!is.na(all_summed_resampled_mask)] <- NA
cargo_summed_resampled[!is.na(cargo_summed_resampled_mask)] <- NA
tankers_summed_resampled[!is.na(tankers_summed_resampled_mask)] <- NA
fishing_summed_resampled[!is.na(fishing_summed_resampled_mask)] <- NA

cetaceans_sr_raster[!is.na(cetaceans_sr_mask)] <- NA
testudines_sr_raster[!is.na(testudines_sr_raster_mask)] <- NA
pinnipeds_sr_raster[!is.na(pinnipeds_sr_raster_mask)] <- NA
seabirds_sr_raster_resampled_cropped_ext[!is.na(seabirds_sr_raster_resampled_cropped_ext_mask)] <- NA

### SAVE
terra::writeRaster(all_summed_resampled,"final_rasters/all_summed_resampled_NA.tif")
terra::writeRaster(cargo_summed_resampled,"final_rasters/cargo_summed_resampled_NA.tif")
terra::writeRaster(tankers_summed_resampled,"final_rasters/tankers_summed_resampled_NA.tif")
terra::writeRaster(fishing_summed_resampled,"final_rasters/fishing_summed_resampled_NA.tif")

terra::writeRaster(cetaceans_sr_raster,"final_rasters/cetaceans_sr_raster_NA.tif")
terra::writeRaster(testudines_sr_raster,"final_rasters/testudines_sr_raster_NA.tif")
terra::writeRaster(pinnipeds_sr_raster,"final_rasters/pinnipeds_sr_raster_NA.tif")
terra::writeRaster(seabirds_sr_raster_resampled_cropped_ext,"final_rasters/seabirds_sr_raster_resampled_cropped_ext_NA.tif")

