################################################################################
#                     Annual temporal trend of shipless areas
################################################################################

#FMestre
#06-01-2025

#Load package
library(terra)

#Define the working directory
setwd("~/github/shipless_areas")

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

#Convert NA to 0
sum_all_2011_resampled[is.na(sum_all_2011_resampled[])] <- 0 
sum_all_2012_resampled[is.na(sum_all_2012_resampled[])] <- 0 
sum_all_2013_resampled[is.na(sum_all_2013_resampled[])] <- 0 
sum_all_2014_resampled[is.na(sum_all_2014_resampled[])] <- 0 
sum_all_2015_resampled[is.na(sum_all_2015_resampled[])] <- 0 
sum_all_2016_resampled[is.na(sum_all_2016_resampled[])] <- 0 
sum_all_2017_resampled[is.na(sum_all_2017_resampled[])] <- 0 
sum_all_2018_resampled[is.na(sum_all_2018_resampled[])] <- 0 
sum_all_2019_resampled[is.na(sum_all_2019_resampled[])] <- 0 
sum_all_2020_resampled[is.na(sum_all_2020_resampled[])] <- 0 
sum_all_2021_resampled[is.na(sum_all_2021_resampled[])] <- 0 
sum_all_2022_resampled[is.na(sum_all_2022_resampled[])] <- 0 
sum_all_2023_resampled[is.na(sum_all_2023_resampled[])] <- 0 

#Convert under vector to NA
continents <- terra::vect("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/continents_close_seas.shp")

# Create a mask using the vector
sum_all_2011_resampled_mask <- terra::mask(sum_all_2011_resampled, continents)
#plot(sum_all_2011_resampled_mask)

# Convert all values to NA outside the mask
sum_all_2011_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2012_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2013_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2014_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2015_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2016_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2017_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2018_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2019_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2020_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2021_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2022_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA
sum_all_2023_resampled[!is.na(sum_all_2011_resampled_mask)] <- NA

#log transform
sum_all_2011_resampled_log <- log(sum_all_2011_resampled+1)
sum_all_2012_resampled_log <- log(sum_all_2012_resampled+1)
sum_all_2013_resampled_log <- log(sum_all_2013_resampled+1)
sum_all_2014_resampled_log <- log(sum_all_2014_resampled+1)
sum_all_2015_resampled_log <- log(sum_all_2015_resampled+1)
sum_all_2016_resampled_log <- log(sum_all_2016_resampled+1)
sum_all_2017_resampled_log <- log(sum_all_2017_resampled+1)
sum_all_2018_resampled_log <- log(sum_all_2018_resampled+1)
sum_all_2019_resampled_log <- log(sum_all_2019_resampled+1)
sum_all_2020_resampled_log <- log(sum_all_2020_resampled+1)
sum_all_2021_resampled_log <- log(sum_all_2021_resampled+1)
sum_all_2022_resampled_log <- log(sum_all_2022_resampled+1)
sum_all_2023_resampled_log <- log(sum_all_2023_resampled+1)

#Quantiles
terciles_sum_all_2011_resampled <- quantile(values(sum_all_2011_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2012_resampled <- quantile(values(sum_all_2012_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2013_resampled <- quantile(values(sum_all_2013_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2014_resampled <- quantile(values(sum_all_2014_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2015_resampled <- quantile(values(sum_all_2015_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2016_resampled <- quantile(values(sum_all_2016_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2017_resampled <- quantile(values(sum_all_2017_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2018_resampled <- quantile(values(sum_all_2018_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2019_resampled <- quantile(values(sum_all_2019_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2020_resampled <- quantile(values(sum_all_2020_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2021_resampled <- quantile(values(sum_all_2021_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2022_resampled <- quantile(values(sum_all_2022_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)
terciles_sum_all_2023_resampled <- quantile(values(sum_all_2023_resampled_log), probs = c(1/3, 2/3), na.rm = TRUE)

#Create reclassification matrix
class_matrix_sum_all_2011_resampled <- matrix(c(-1, terciles_sum_all_2011_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2011_resampled[1], terciles_sum_all_2011_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2011_resampled[2], as.numeric(global(sum_all_2011_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2012_resampled <- matrix(c(-1, terciles_sum_all_2012_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2012_resampled[1], terciles_sum_all_2012_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2012_resampled[2], as.numeric(global(sum_all_2012_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2013_resampled <- matrix(c(-1, terciles_sum_all_2013_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2013_resampled[1], terciles_sum_all_2013_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2013_resampled[2], as.numeric(global(sum_all_2013_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2014_resampled <- matrix(c(-1, terciles_sum_all_2014_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2014_resampled[1], terciles_sum_all_2014_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2014_resampled[2], as.numeric(global(sum_all_2014_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2015_resampled <- matrix(c(-1, terciles_sum_all_2015_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2015_resampled[1], terciles_sum_all_2015_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2015_resampled[2], as.numeric(global(sum_all_2015_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2016_resampled <- matrix(c(-1, terciles_sum_all_2016_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2016_resampled[1], terciles_sum_all_2016_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2016_resampled[2], as.numeric(global(sum_all_2016_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2017_resampled <- matrix(c(-1, terciles_sum_all_2017_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2017_resampled[1], terciles_sum_all_2017_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2017_resampled[2], as.numeric(global(sum_all_2017_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2018_resampled <- matrix(c(-1, terciles_sum_all_2018_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2018_resampled[1], terciles_sum_all_2018_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2018_resampled[2], as.numeric(global(sum_all_2018_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2019_resampled <- matrix(c(-1, terciles_sum_all_2019_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2019_resampled[1], terciles_sum_all_2019_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2019_resampled[2], as.numeric(global(sum_all_2019_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2020_resampled <- matrix(c(-1, terciles_sum_all_2020_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2020_resampled[1], terciles_sum_all_2020_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2020_resampled[2], as.numeric(global(sum_all_2020_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2021_resampled <- matrix(c(-1, terciles_sum_all_2021_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2021_resampled[1], terciles_sum_all_2021_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2021_resampled[2], as.numeric(global(sum_all_2021_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2022_resampled <- matrix(c(-1, terciles_sum_all_2022_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2022_resampled[1], terciles_sum_all_2022_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2022_resampled[2], as.numeric(global(sum_all_2022_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)

class_matrix_sum_all_2023_resampled <- matrix(c(-1, terciles_sum_all_2023_resampled[1], 1,  # First tercile
                                                terciles_sum_all_2023_resampled[1], terciles_sum_all_2023_resampled[2], 2,  # Second tercile
                                                terciles_sum_all_2023_resampled[2], as.numeric(global(sum_all_2023_resampled_log, fun=max, na.rm=TRUE)), 3),  # Third tercile
                                                ncol = 3, byrow = TRUE)


#Reclassify
terciles_reclassified_sum_all_2011_resampled_log <- terra::classify(sum_all_2011_resampled_log, class_matrix_sum_all_2011_resampled)
terciles_reclassified_sum_all_2012_resampled_log <- terra::classify(sum_all_2012_resampled_log, class_matrix_sum_all_2012_resampled)
terciles_reclassified_sum_all_2013_resampled_log <- terra::classify(sum_all_2013_resampled_log, class_matrix_sum_all_2013_resampled)
terciles_reclassified_sum_all_2014_resampled_log <- terra::classify(sum_all_2014_resampled_log, class_matrix_sum_all_2014_resampled)
terciles_reclassified_sum_all_2015_resampled_log <- terra::classify(sum_all_2015_resampled_log, class_matrix_sum_all_2015_resampled)
terciles_reclassified_sum_all_2016_resampled_log <- terra::classify(sum_all_2016_resampled_log, class_matrix_sum_all_2016_resampled)
terciles_reclassified_sum_all_2017_resampled_log <- terra::classify(sum_all_2017_resampled_log, class_matrix_sum_all_2017_resampled)
terciles_reclassified_sum_all_2018_resampled_log <- terra::classify(sum_all_2018_resampled_log, class_matrix_sum_all_2018_resampled)
terciles_reclassified_sum_all_2019_resampled_log <- terra::classify(sum_all_2019_resampled_log, class_matrix_sum_all_2019_resampled)
terciles_reclassified_sum_all_2020_resampled_log <- terra::classify(sum_all_2020_resampled_log, class_matrix_sum_all_2020_resampled)
terciles_reclassified_sum_all_2021_resampled_log <- terra::classify(sum_all_2021_resampled_log, class_matrix_sum_all_2021_resampled)
terciles_reclassified_sum_all_2022_resampled_log <- terra::classify(sum_all_2022_resampled_log, class_matrix_sum_all_2022_resampled)
terciles_reclassified_sum_all_2023_resampled_log <- terra::classify(sum_all_2023_resampled_log, class_matrix_sum_all_2023_resampled)

# plot only the first tercile
first_tercile_2011 <- terciles_reclassified_sum_all_2011_resampled_log == 1
first_tercile_2012 <- terciles_reclassified_sum_all_2012_resampled_log == 1
first_tercile_2013 <- terciles_reclassified_sum_all_2013_resampled_log == 1
first_tercile_2014 <- terciles_reclassified_sum_all_2014_resampled_log == 1
first_tercile_2015 <- terciles_reclassified_sum_all_2015_resampled_log == 1
first_tercile_2016 <- terciles_reclassified_sum_all_2016_resampled_log == 1
first_tercile_2017 <- terciles_reclassified_sum_all_2017_resampled_log == 1
first_tercile_2018 <- terciles_reclassified_sum_all_2018_resampled_log == 1
first_tercile_2019 <- terciles_reclassified_sum_all_2019_resampled_log == 1
first_tercile_2020 <- terciles_reclassified_sum_all_2020_resampled_log == 1
first_tercile_2021 <- terciles_reclassified_sum_all_2021_resampled_log == 1
first_tercile_2022 <- terciles_reclassified_sum_all_2022_resampled_log == 1
first_tercile_2023 <- terciles_reclassified_sum_all_2023_resampled_log == 1
#
first_tercile_2011 <- first_tercile_2011 * terciles_reclassified_sum_all_2011_resampled_log 
first_tercile_2012 <- first_tercile_2012 * terciles_reclassified_sum_all_2012_resampled_log 
first_tercile_2013 <- first_tercile_2013 * terciles_reclassified_sum_all_2013_resampled_log 
first_tercile_2014 <- first_tercile_2014 * terciles_reclassified_sum_all_2014_resampled_log 
first_tercile_2015 <- first_tercile_2015 * terciles_reclassified_sum_all_2015_resampled_log 
first_tercile_2016 <- first_tercile_2016 * terciles_reclassified_sum_all_2016_resampled_log 
first_tercile_2017 <- first_tercile_2017 * terciles_reclassified_sum_all_2017_resampled_log 
first_tercile_2018 <- first_tercile_2018 * terciles_reclassified_sum_all_2018_resampled_log 
first_tercile_2019 <- first_tercile_2019 * terciles_reclassified_sum_all_2019_resampled_log 
first_tercile_2020 <- first_tercile_2020 * terciles_reclassified_sum_all_2020_resampled_log 
first_tercile_2021 <- first_tercile_2021 * terciles_reclassified_sum_all_2021_resampled_log 
first_tercile_2022 <- first_tercile_2022 * terciles_reclassified_sum_all_2022_resampled_log 
first_tercile_2023 <- first_tercile_2023 * terciles_reclassified_sum_all_2023_resampled_log 
#
first_tercile_2011[first_tercile_2011==0] <- NA
first_tercile_2012[first_tercile_2012==0] <- NA
first_tercile_2013[first_tercile_2013==0] <- NA
first_tercile_2014[first_tercile_2014==0] <- NA
first_tercile_2015[first_tercile_2015==0] <- NA
first_tercile_2016[first_tercile_2016==0] <- NA
first_tercile_2017[first_tercile_2017==0] <- NA
first_tercile_2018[first_tercile_2018==0] <- NA
first_tercile_2019[first_tercile_2019==0] <- NA
first_tercile_2020[first_tercile_2020==0] <- NA
first_tercile_2021[first_tercile_2021==0] <- NA
first_tercile_2022[first_tercile_2022==0] <- NA
first_tercile_2023[first_tercile_2023==0] <- NA

#Plot - generate a png file
png("year_terciles/first_tercile_2011_2023.png", width=5000, height=5000, units="px", pointsize=12)
par(mfrow=c(5,3), mar=c(2, 2, 4, 2)) # Adjust margins
plot(first_tercile_2011, main="2011", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2012, main="2012", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2013, main="2013", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2014, main="2014", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2015, main="2015", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2016, main="2016", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2017, main="2017", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2018, main="2018", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2019, main="2019", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2020, main="2020", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2021, main="2021", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2022, main="2022", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
plot(first_tercile_2023, main="2023", col = "lightskyblue4",cex.main = 10, legend = FALSE)
plot(continents, col = "gray31", border = NA, add=TRUE)
dev.off()

#write to disk
terra::writeRaster(terciles_reclassified_sum_all_2011_resampled_log, "year_terciles/terciles_reclassified_sum_all_2011_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2012_resampled_log, "year_terciles/terciles_reclassified_sum_all_2012_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2013_resampled_log, "year_terciles/terciles_reclassified_sum_all_2013_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2014_resampled_log, "year_terciles/terciles_reclassified_sum_all_2014_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2015_resampled_log, "year_terciles/terciles_reclassified_sum_all_2015_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2016_resampled_log, "year_terciles/terciles_reclassified_sum_all_2016_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2017_resampled_log, "year_terciles/terciles_reclassified_sum_all_2017_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2018_resampled_log, "year_terciles/terciles_reclassified_sum_all_2018_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2019_resampled_log, "year_terciles/terciles_reclassified_sum_all_2019_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2020_resampled_log, "year_terciles/terciles_reclassified_sum_all_2020_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2021_resampled_log, "year_terciles/terciles_reclassified_sum_all_2021_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2022_resampled_log, "year_terciles/terciles_reclassified_sum_all_2022_resampled_log.tif")
terra::writeRaster(terciles_reclassified_sum_all_2023_resampled_log, "year_terciles/terciles_reclassified_sum_all_2023_resampled_log.tif")


#(...)

#Load if needed
terciles_reclassified_sum_all_2011_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2011_resampled_log.tif")
terciles_reclassified_sum_all_2012_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2012_resampled_log.tif")
terciles_reclassified_sum_all_2013_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2013_resampled_log.tif")
terciles_reclassified_sum_all_2014_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2014_resampled_log.tif")
terciles_reclassified_sum_all_2015_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2015_resampled_log.tif")
terciles_reclassified_sum_all_2016_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2016_resampled_log.tif")
terciles_reclassified_sum_all_2017_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2017_resampled_log.tif")
terciles_reclassified_sum_all_2018_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2018_resampled_log.tif")
terciles_reclassified_sum_all_2019_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2019_resampled_log.tif")
terciles_reclassified_sum_all_2020_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2020_resampled_log.tif")
terciles_reclassified_sum_all_2021_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2021_resampled_log.tif")
terciles_reclassified_sum_all_2022_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2022_resampled_log.tif")
terciles_reclassified_sum_all_2023_resampled_log <- terra::rast("year_terciles/terciles_reclassified_sum_all_2023_resampled_log.tif")
