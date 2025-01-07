################################################################################
#                     Annual temporal trend of shipless areas
################################################################################

#FMestre
#06-01-2025

#Load package
library(terra)

#For resample
cetaceans_sr_raster <- terra::rast("cetaceans_sr_raster.tif")

#Load rasters
sum_all_2011 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2011.tif")
sum_all_2012 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2012.tif")
sum_all_2013 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2013.tif")
sum_all_2014 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2014.tif")
sum_all_2015 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2015.tif")
sum_all_2016 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2016.tif")
sum_all_2017 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2017.tif")
sum_all_2018 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2018.tif")
sum_all_2019 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2019.tif")
sum_all_2020 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2020.tif")
sum_all_2021 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2021.tif")
sum_all_2022 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2022.tif")
sum_all_2023 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2023.tif")

#Resample
sum_all_2011_resampled <- resample(sum_all_2011, cetaceans_sr_raster)
sum_all_2012_resampled <- resample(sum_all_2012, cetaceans_sr_raster)
sum_all_2013_resampled <- resample(sum_all_2013, cetaceans_sr_raster)
sum_all_2014_resampled <- resample(sum_all_2014, cetaceans_sr_raster)
sum_all_2015_resampled <- resample(sum_all_2015, cetaceans_sr_raster)
sum_all_2016_resampled <- resample(sum_all_2016, cetaceans_sr_raster)
sum_all_2017_resampled <- resample(sum_all_2017, cetaceans_sr_raster)
sum_all_2018_resampled <- resample(sum_all_2018, cetaceans_sr_raster)
sum_all_2019_resampled <- resample(sum_all_2019, cetaceans_sr_raster)
sum_all_2020_resampled <- resample(sum_all_2020, cetaceans_sr_raster)
sum_all_2021_resampled <- resample(sum_all_2021, cetaceans_sr_raster)
sum_all_2022_resampled <- resample(sum_all_2022, cetaceans_sr_raster)
sum_all_2023_resampled <- resample(sum_all_2023, cetaceans_sr_raster)


#Quantiles
terciles_sum_all_2011_resampled <- quantile(values(sum_all_2011_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2012_resampled <- quantile(values(sum_all_2012_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2013_resampled <- quantile(values(sum_all_2013_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2014_resampled <- quantile(values(sum_all_2014_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2015_resampled <- quantile(values(sum_all_2015_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2016_resampled <- quantile(values(sum_all_2016_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2017_resampled <- quantile(values(sum_all_2017_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2018_resampled <- quantile(values(sum_all_2018_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2019_resampled <- quantile(values(sum_all_2019_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2020_resampled <- quantile(values(sum_all_2020_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2021_resampled <- quantile(values(sum_all_2021_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2022_resampled <- quantile(values(sum_all_2022_resampled), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2023_resampled <- quantile(values(sum_all_2023_resampled), probs = c(1/3, 2/3), na.rm = TRUE)

#Create reclassification matrix
class_matrix_sum_all_2011_resampled <- matrix(c(-1, terciles_sum_all_2011_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2011_resampled[1], terciles_sum_all_2011_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2011_resampled[2], as.numeric(global(sum_all_2011, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2012_resampled <- matrix(c(-1, terciles_sum_all_2012_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2012_resampled[1], terciles_sum_all_2012_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2012_resampled[2], as.numeric(global(sum_all_2012, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2013_resampled <- matrix(c(-1, terciles_sum_all_2013_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2013_resampled[1], terciles_sum_all_2013_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2013_resampled[2], as.numeric(global(sum_all_2013, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2014_resampled <- matrix(c(-1, terciles_sum_all_2014_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2014_resampled[1], terciles_sum_all_2014_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2014_resampled[2], as.numeric(global(sum_all_2014, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2015_resampled <- matrix(c(-1, terciles_sum_all_2015_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2015_resampled[1], terciles_sum_all_2015_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2015_resampled[2], as.numeric(global(sum_all_2015, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2016_resampled <- matrix(c(-1, terciles_sum_all_2016_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2016_resampled[1], terciles_sum_all_2016_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2016_resampled[2], as.numeric(global(sum_all_2016, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2017_resampled <- matrix(c(-1, terciles_sum_all_2017_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2017_resampled[1], terciles_sum_all_2017_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2017_resampled[2], as.numeric(global(sum_all_2017, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2018_resampled <- matrix(c(-1, terciles_sum_all_2018_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2018_resampled[1], terciles_sum_all_2018_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2018_resampled[2], as.numeric(global(sum_all_2018, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2019_resampled <- matrix(c(-1, terciles_sum_all_2019_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2019_resampled[1], terciles_sum_all_2019_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2019_resampled[2], as.numeric(global(sum_all_2019, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2020_resampled <- matrix(c(-1, terciles_sum_all_2020_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2020_resampled[1], terciles_sum_all_2020_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2020_resampled[2], as.numeric(global(sum_all_2020, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2021_resampled <- matrix(c(-1, terciles_sum_all_2021_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2021_resampled[1], terciles_sum_all_2021_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2021_resampled[2], as.numeric(global(sum_all_2021, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2022_resampled <- matrix(c(-1, terciles_sum_all_2022_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2022_resampled[1], terciles_sum_all_2022_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2022_resampled[2], as.numeric(global(sum_all_2022, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2023_resampled <- matrix(c(-1, terciles_sum_all_2023_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2023_resampled[1], terciles_sum_all_2023_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2023_resampled[2], as.numeric(global(sum_all_2023, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)


#Reclassify
terciles_reclassified_sum_all_2011_resampled <- terra::classify(sum_all_2011_resampled, class_matrix_sum_all_2011_resampled)
terciles_reclassified_sum_all_2012_resampled <- terra::classify(sum_all_2012_resampled, class_matrix_sum_all_2012_resampled)
terciles_reclassified_sum_all_2013_resampled <- terra::classify(sum_all_2013_resampled, class_matrix_sum_all_2013_resampled)
terciles_reclassified_sum_all_2014_resampled <- terra::classify(sum_all_2014_resampled, class_matrix_sum_all_2014_resampled)
terciles_reclassified_sum_all_2015_resampled <- terra::classify(sum_all_2015_resampled, class_matrix_sum_all_2015_resampled)
terciles_reclassified_sum_all_2016_resampled <- terra::classify(sum_all_2016_resampled, class_matrix_sum_all_2016_resampled)
terciles_reclassified_sum_all_2017_resampled <- terra::classify(sum_all_2017_resampled, class_matrix_sum_all_2017_resampled)
terciles_reclassified_sum_all_2018_resampled <- terra::classify(sum_all_2018_resampled, class_matrix_sum_all_2018_resampled)
terciles_reclassified_sum_all_2019_resampled <- terra::classify(sum_all_2019_resampled, class_matrix_sum_all_2019_resampled)
terciles_reclassified_sum_all_2020_resampled <- terra::classify(sum_all_2020_resampled, class_matrix_sum_all_2020_resampled)
terciles_reclassified_sum_all_2021_resampled <- terra::classify(sum_all_2021_resampled, class_matrix_sum_all_2021_resampled)
terciles_reclassified_sum_all_2022_resampled <- terra::classify(sum_all_2022_resampled, class_matrix_sum_all_2022_resampled)
terciles_reclassified_sum_all_2023_resampled <- terra::classify(sum_all_2023_resampled, class_matrix_sum_all_2023_resampled)


################
terciles_reclassified_sum_all_2011_resampled[is.na(terciles_reclassified_sum_all_2011_resampled[])] <- 0 

continents <- terra::vect("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/continents_close_seas.shp")

terciles_reclassified_sum_all_2011_resampled_mask <- terra::mask(terciles_reclassified_sum_all_2011_resampled, continents)

terciles_reclassified_sum_all_2011_resampled[!is.na(terciles_reclassified_sum_all_2011_resampled_mask)] <- NA
################

#write to disk
terra::writeRaster(terciles_reclassified_sum_all_2011_resampled, "year_terciles/terciles_reclassified_sum_all_2011_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2012_resampled, "year_terciles/terciles_reclassified_sum_all_2012_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2013_resampled, "year_terciles/terciles_reclassified_sum_all_2013_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2014_resampled, "year_terciles/terciles_reclassified_sum_all_2014_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2015_resampled, "year_terciles/terciles_reclassified_sum_all_2015_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2016_resampled, "year_terciles/terciles_reclassified_sum_all_2016_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2017_resampled, "year_terciles/terciles_reclassified_sum_all_2017_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2018_resampled, "year_terciles/terciles_reclassified_sum_all_2018_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2019_resampled, "year_terciles/terciles_reclassified_sum_all_2019_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2020_resampled, "year_terciles/terciles_reclassified_sum_all_2020_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2021_resampled, "year_terciles/terciles_reclassified_sum_all_2021_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2022_resampled, "year_terciles/terciles_reclassified_sum_all_2022_resampled.tif")
terra::writeRaster(terciles_reclassified_sum_all_2023_resampled, "year_terciles/terciles_reclassified_sum_all_2023_resampled.tif")

#Load if needed
#terciles_reclassified_sum_all_2011_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2011_resampled.tif")
#terciles_reclassified_sum_all_2012_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2012_resampled.tif")
#terciles_reclassified_sum_all_2013_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2013_resampled.tif")
#terciles_reclassified_sum_all_2014_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2014_resampled.tif")
#terciles_reclassified_sum_all_2015_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2015_resampled.tif")
#terciles_reclassified_sum_all_2016_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2016_resampled.tif")
#terciles_reclassified_sum_all_2017_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2017_resampled.tif")
#terciles_reclassified_sum_all_2018_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2018_resampled.tif")
#terciles_reclassified_sum_all_2019_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2019_resampled.tif")
#terciles_reclassified_sum_all_2020_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2020_resampled.tif")
#terciles_reclassified_sum_all_2021_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2021_resampled.tif")
#terciles_reclassified_sum_all_2022_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2022_resampled.tif")
#terciles_reclassified_sum_all_2023_resampled <- terra::rast("year_terciles/terciles_reclassified_sum_all_2023_resampled.tif")

#Plot it
plot(terciles_reclassified_sum_all_2011_resampled, col = c("#E1BFAC" ,"#A6626D", "#6B062F"))

