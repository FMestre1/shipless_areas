################################################################################
#                               Summarize maps
################################################################################

#FMestre
#15-04-2024

#This script is just to evaluate the tendencies per vessel type across the years

#Clear environment
rm(list = ls()) 

#Load package
library(terra)
#library(ggplot2)

#Define the working directory
setwd("~/github/shipless_areas")

# Create folder for temp files

#In terminal
#mkdir temp

terraOptions(tempdir = "E:/shipless_areas/temp")

#Check tem files
tmpFiles()

# PLOT PER YEAR
# 2011 data were not used

### ALL ###
sum_all_2012 <- sum(all_2012_01, all_2012_02, all_2012_03, all_2012_04, all_2012_05, all_2012_06, all_2012_07, all_2012_08, all_2012_09, all_2012_10, all_2012_11, all_2012_12, na.rm = TRUE)
sum_all_2013 <- sum(all_2013_01, all_2013_02, all_2013_03, all_2013_04, all_2013_05, all_2013_06, all_2013_07, all_2013_08, all_2013_09, all_2013_10, all_2013_11, all_2013_12, na.rm = TRUE)
sum_all_2014 <- sum(all_2014_01, all_2014_02, all_2014_03, all_2014_04, all_2014_05, all_2014_06, all_2014_07, all_2014_08, all_2014_09, all_2014_10, all_2014_11, all_2014_12, na.rm = TRUE)
sum_all_2015 <- sum(all_2015_01, all_2015_02, all_2015_03, all_2015_04, all_2015_05, all_2015_06, all_2015_07, all_2015_08, all_2015_09, all_2015_10, all_2015_11, all_2015_12, na.rm = TRUE)
sum_all_2016 <- sum(all_2016_01, all_2016_02, all_2016_03, all_2016_04, all_2016_05, all_2016_06, all_2016_07, all_2016_08, all_2016_09, all_2016_10, all_2016_11, all_2016_12, na.rm = TRUE)
sum_all_2017 <- sum(all_2017_01, all_2017_02, all_2017_03, all_2017_04, all_2017_05, all_2017_06, all_2017_07, all_2017_08, all_2017_09, all_2017_10, all_2017_11, all_2017_12, na.rm = TRUE)
sum_all_2018 <- sum(all_2018_01, all_2018_02, all_2018_03, all_2018_04, all_2018_05, all_2018_06, all_2018_07, all_2018_08, all_2018_09, all_2018_10, all_2018_11, all_2018_12, na.rm = TRUE)
sum_all_2019 <- sum(all_2019_01, all_2019_02, all_2019_03, all_2019_04, all_2019_05, all_2019_06, all_2019_07, all_2019_08, all_2019_09, all_2019_10, all_2019_11, all_2019_12, na.rm = TRUE)
sum_all_2020 <- sum(all_2020_01, all_2020_02, all_2020_03, all_2020_04, all_2020_05, all_2020_06, all_2020_07, all_2020_08, all_2020_09, all_2020_10, all_2020_11, all_2020_12, na.rm = TRUE)
sum_all_2021 <- sum(all_2021_01, all_2021_02, all_2021_03, all_2021_04, all_2021_05, all_2021_06, all_2021_07, all_2021_08, all_2021_09, all_2021_10, all_2021_11, all_2021_12, na.rm = TRUE)
sum_all_2022 <- sum(all_2022_01, all_2022_02, all_2022_03, all_2022_04, all_2022_05, all_2022_06, all_2022_07, all_2022_08, all_2022_09, all_2022_10, all_2022_11, all_2022_12, na.rm = TRUE)
sum_all_2023 <- sum(all_2023_01, all_2023_02, all_2023_03, all_2023_04, all_2023_05, all_2023_06, all_2023_07, all_2023_08, all_2023_09, all_2023_10, all_2023_11, all_2023_12, na.rm = TRUE)
all_summed_no_2011 <- sum(sum_all_2012, sum_all_2013, sum_all_2014, sum_all_2015, sum_all_2016, sum_all_2017, sum_all_2018, sum_all_2019, sum_all_2020, sum_all_2021, sum_all_2022, sum_all_2023, na.rm = TRUE)
last_three_years_21_22_23 <- sum(sum_all_2021, sum_all_2022, sum_all_2023)
#plot(all_summed_no_2011)
#plot(last_three_years_21_22_23)

#Save
terra::writeRaster(sum_all_2012, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2012.tif")
terra::writeRaster(sum_all_2013, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2013.tif")
terra::writeRaster(sum_all_2014, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2014.tif")
terra::writeRaster(sum_all_2015, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2015.tif")
terra::writeRaster(sum_all_2016, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2016.tif")
terra::writeRaster(sum_all_2017, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2017.tif")
terra::writeRaster(sum_all_2018, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2018.tif")
terra::writeRaster(sum_all_2019, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2019.tif")
terra::writeRaster(sum_all_2020, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2020.tif")
terra::writeRaster(sum_all_2021, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2021.tif")
terra::writeRaster(sum_all_2022, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2022.tif")
terra::writeRaster(sum_all_2023, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2023.tif")
terra::writeRaster(all_summed_no_2011, filename="E:/shipless_areas/sum_all_no_2011/all_summed_no_2011.tif")
terra::writeRaster(last_three_years_21_22_23, filename="E:/shipless_areas/sum_all_no_2011/last_three_years_21_22_23.tif")

#Load
sum_all_2012 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2012.tif")
sum_all_2013 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2013.tif")
sum_all_2014 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2014.tif")
sum_all_2015 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2015.tif")
sum_all_2016 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2016.tif")
sum_all_2017 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2017.tif")
sum_all_2018 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2018.tif")
sum_all_2019 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2019.tif")
sum_all_2020 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2020.tif")
sum_all_2021 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2021.tif")
sum_all_2022 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2022.tif")
sum_all_2023 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2023.tif")
all_summed_no_2011 <- terra::rast("E:/shipless_areas/sum_all_no_2011/all_summed_no_2011.tif")
last_three_years_21_22_23 <- terra::rast("E:/shipless_areas/sum_all_no_2011/last_three_years_21_22_23.tif")

# Mean and SD
all_summed_stack <- c(sum_all_2012, sum_all_2013, sum_all_2014, sum_all_2015, sum_all_2016, sum_all_2017, sum_all_2018, sum_all_2019, sum_all_2020, sum_all_2021, sum_all_2022, sum_all_2023)
rm(sum_all_2012, sum_all_2013, sum_all_2014, sum_all_2015, sum_all_2016, sum_all_2017, sum_all_2018, sum_all_2019, sum_all_2020, sum_all_2021, sum_all_2022, sum_all_2023)
#
mean_sd_all_summed_stack <- terra::global(all_summed_stack, c("mean", "sd"), na.rm=TRUE)
mean_sd_all_summed_stack <- data.frame(2012:2023, mean_sd_all_summed_stack)
names(mean_sd_all_summed_stack)[1] <- "years"
rownames(mean_sd_all_summed_stack) <- 1:nrow(mean_sd_all_summed_stack)
save(mean_sd_all_summed_stack, file = "mean_sd_all_summed_stack.RData")
plot(mean_sd_all_summed_stack$years, mean_sd_all_summed_stack$mean, type = "l", main = "All ships", xlab = "year", ylab = "Ship density (hours/cell)")
rm(list = ls())

### CARGO ###
sum_cargo_2012 <- sum(cargo_2012_01, cargo_2012_02, cargo_2012_03, cargo_2012_04, cargo_2012_05, cargo_2012_06, cargo_2012_07, cargo_2012_08, cargo_2012_09, cargo_2012_10, cargo_2012_11, cargo_2012_12, na.rm = TRUE)
sum_cargo_2013 <- sum(cargo_2013_01, cargo_2013_02, cargo_2013_03, cargo_2013_04, cargo_2013_05, cargo_2013_06, cargo_2013_07, cargo_2013_08, cargo_2013_09, cargo_2013_10, cargo_2013_11, cargo_2013_12, na.rm = TRUE)
sum_cargo_2014 <- sum(cargo_2014_01, cargo_2014_02, cargo_2014_03, cargo_2014_04, cargo_2014_05, cargo_2014_06, cargo_2014_07, cargo_2014_08, cargo_2014_09, cargo_2014_10, cargo_2014_11, cargo_2014_12, na.rm = TRUE)
sum_cargo_2015 <- sum(cargo_2015_01, cargo_2015_02, cargo_2015_03, cargo_2015_04, cargo_2015_05, cargo_2015_06, cargo_2015_07, cargo_2015_08, cargo_2015_09, cargo_2015_10, cargo_2015_11, cargo_2015_12, na.rm = TRUE)
sum_cargo_2016 <- sum(cargo_2016_01, cargo_2016_02, cargo_2016_03, cargo_2016_04, cargo_2016_05, cargo_2016_06, cargo_2016_07, cargo_2016_08, cargo_2016_09, cargo_2016_10, cargo_2016_11, cargo_2016_12, na.rm = TRUE)
sum_cargo_2017 <- sum(cargo_2017_01, cargo_2017_02, cargo_2017_03, cargo_2017_04, cargo_2017_05, cargo_2017_06, cargo_2017_07, cargo_2017_08, cargo_2017_09, cargo_2017_10, cargo_2017_11, cargo_2017_12, na.rm = TRUE)
sum_cargo_2018 <- sum(cargo_2018_01, cargo_2018_02, cargo_2018_03, cargo_2018_04, cargo_2018_05, cargo_2018_06, cargo_2018_07, cargo_2018_08, cargo_2018_09, cargo_2018_10, cargo_2018_11, cargo_2018_12, na.rm = TRUE)
sum_cargo_2019 <- sum(cargo_2019_01, cargo_2019_02, cargo_2019_03, cargo_2019_04, cargo_2019_05, cargo_2019_06, cargo_2019_07, cargo_2019_08, cargo_2019_09, cargo_2019_10, cargo_2019_11, cargo_2019_12, na.rm = TRUE)
sum_cargo_2020 <- sum(cargo_2020_01, cargo_2020_02, cargo_2020_03, cargo_2020_04, cargo_2020_05, cargo_2020_06, cargo_2020_07, cargo_2020_08, cargo_2020_09, cargo_2020_10, cargo_2020_11, cargo_2020_12, na.rm = TRUE)
sum_cargo_2021 <- sum(cargo_2021_01, cargo_2021_02, cargo_2021_03, cargo_2021_04, cargo_2021_05, cargo_2021_06, cargo_2021_07, cargo_2021_08, cargo_2021_09, cargo_2021_10, cargo_2021_11, cargo_2021_12, na.rm = TRUE)
sum_cargo_2022 <- sum(cargo_2022_01, cargo_2022_02, cargo_2022_03, cargo_2022_04, cargo_2022_05, cargo_2022_06, cargo_2022_07, cargo_2022_08, cargo_2022_09, cargo_2022_10, cargo_2022_11, cargo_2022_12, na.rm = TRUE)
sum_cargo_2023 <- sum(cargo_2023_01, cargo_2023_02, cargo_2023_03, cargo_2023_04, cargo_2023_05, cargo_2023_06, cargo_2023_07, cargo_2023_08, cargo_2023_09, cargo_2023_10, cargo_2023_11, cargo_2023_12, na.rm = TRUE)
cargo_summed <- sum(sum_cargo_2012, sum_cargo_2013, sum_cargo_2014, sum_cargo_2015, sum_cargo_2016, sum_cargo_2017, sum_cargo_2018, sum_cargo_2019, sum_cargo_2020, sum_cargo_2021, sum_cargo_2022, sum_cargo_2023, na.rm = TRUE)
#plot(cargo_summed)

#Save
terra::writeRaster(sum_cargo_2012, filename="E:/shipless_areas/sum_cargo/sum_cargo_2012.tif")
terra::writeRaster(sum_cargo_2013, filename="E:/shipless_areas/sum_cargo/sum_cargo_2013.tif")
terra::writeRaster(sum_cargo_2014, filename="E:/shipless_areas/sum_cargo/sum_cargo_2014.tif")
terra::writeRaster(sum_cargo_2015, filename="E:/shipless_areas/sum_cargo/sum_cargo_2015.tif")
terra::writeRaster(sum_cargo_2016, filename="E:/shipless_areas/sum_cargo/sum_cargo_2016.tif")
terra::writeRaster(sum_cargo_2017, filename="E:/shipless_areas/sum_cargo/sum_cargo_2017.tif")
terra::writeRaster(sum_cargo_2018, filename="E:/shipless_areas/sum_cargo/sum_cargo_2018.tif")
terra::writeRaster(sum_cargo_2019, filename="E:/shipless_areas/sum_cargo/sum_cargo_2019.tif")
terra::writeRaster(sum_cargo_2020, filename="E:/shipless_areas/sum_cargo/sum_cargo_2020.tif")
terra::writeRaster(sum_cargo_2021, filename="E:/shipless_areas/sum_cargo/sum_cargo_2021.tif")
terra::writeRaster(sum_cargo_2022, filename="E:/shipless_areas/sum_cargo/sum_cargo_2022.tif")
terra::writeRaster(sum_cargo_2023, filename="E:/shipless_areas/sum_cargo/sum_cargo_2023.tif")
terra::writeRaster(cargo_summed, filename="E:/shipless_areas/sum_cargo/cargo_summed.tif")

#Load
sum_cargo_2012 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2012.tif")
sum_cargo_2013 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2013.tif")
sum_cargo_2014 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2014.tif")
sum_cargo_2015 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2015.tif")
sum_cargo_2016 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2016.tif")
sum_cargo_2017 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2017.tif")
sum_cargo_2018 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2018.tif")
sum_cargo_2019 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2019.tif")
sum_cargo_2020 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2020.tif")
sum_cargo_2021 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2021.tif")
sum_cargo_2022 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2022.tif")
sum_cargo_2023 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2023.tif")
cargo_summed <- terra::rast("E:/shipless_areas/sum_cargo/cargo_summed.tif")

# Mean and SD
cargo_summed_stack <- c(sum_cargo_2012, sum_cargo_2013, sum_cargo_2014, sum_cargo_2015, sum_cargo_2016, sum_cargo_2017, sum_cargo_2018, sum_cargo_2019, sum_cargo_2020, sum_cargo_2021, sum_cargo_2022, sum_cargo_2023)
rm(sum_cargo_2012, sum_cargo_2013, sum_cargo_2014, sum_cargo_2015, sum_cargo_2016, sum_cargo_2017, sum_cargo_2018, sum_cargo_2019, sum_cargo_2020, sum_cargo_2021, sum_cargo_2022, sum_cargo_2023)
#
#
mean_sd_cargo_summed_stack <- terra::global(cargo_summed_stack, c("mean", "sd"), na.rm=TRUE)
mean_sd_cargo_summed_stack <- data.frame(2011:2023, mean_sd_cargo_summed_stack)
names(mean_sd_cargo_summed_stack)[1] <- "years"
rownames(mean_sd_cargo_summed_stack) <- 1:nrow(mean_sd_cargo_summed_stack)
save(mean_sd_cargo_summed_stack, file = "mean_sd_cargo_summed_stack.RData")
plot(mean_sd_cargo_summed_stack$years, mean_sd_cargo_summed_stack$mean, type = "l", , main = "Cargo ships", xlab = "year", ylab = "Ship density (hours/cell)")
rm(list = ls())

### TANKERS ###
sum_tankers_2012 <- sum(tankers_2012_01, tankers_2012_02, tankers_2012_03, tankers_2012_04, tankers_2012_05, tankers_2012_06, tankers_2012_07, tankers_2012_08, tankers_2012_09, tankers_2012_10, tankers_2012_11, tankers_2012_12, na.rm = TRUE)
sum_tankers_2013 <- sum(tankers_2013_01, tankers_2013_02, tankers_2013_03, tankers_2013_04, tankers_2013_05, tankers_2013_06, tankers_2013_07, tankers_2013_08, tankers_2013_09, tankers_2013_10, tankers_2013_11, tankers_2013_12, na.rm = TRUE)
sum_tankers_2014 <- sum(tankers_2014_01, tankers_2014_02, tankers_2014_03, tankers_2014_04, tankers_2014_05, tankers_2014_06, tankers_2014_07, tankers_2014_08, tankers_2014_09, tankers_2014_10, tankers_2014_11, tankers_2014_12, na.rm = TRUE)
sum_tankers_2015 <- sum(tankers_2015_01, tankers_2015_02, tankers_2015_03, tankers_2015_04, tankers_2015_05, tankers_2015_06, tankers_2015_07, tankers_2015_08, tankers_2015_09, tankers_2015_10, tankers_2015_11, tankers_2015_12, na.rm = TRUE)
sum_tankers_2016 <- sum(tankers_2016_01, tankers_2016_02, tankers_2016_03, tankers_2016_04, tankers_2016_05, tankers_2016_06, tankers_2016_07, tankers_2016_08, tankers_2016_09, tankers_2016_10, tankers_2016_11, tankers_2016_12, na.rm = TRUE)
sum_tankers_2017 <- sum(tankers_2017_01, tankers_2017_02, tankers_2017_03, tankers_2017_04, tankers_2017_05, tankers_2017_06, tankers_2017_07, tankers_2017_08, tankers_2017_09, tankers_2017_10, tankers_2017_11, tankers_2017_12, na.rm = TRUE)
sum_tankers_2018 <- sum(tankers_2018_01, tankers_2018_02, tankers_2018_03, tankers_2018_04, tankers_2018_05, tankers_2018_06, tankers_2018_07, tankers_2018_08, tankers_2018_09, tankers_2018_10, tankers_2018_11, tankers_2018_12, na.rm = TRUE)
sum_tankers_2019 <- sum(tankers_2019_01, tankers_2019_02, tankers_2019_03, tankers_2019_04, tankers_2019_05, tankers_2019_06, tankers_2019_07, tankers_2019_08, tankers_2019_09, tankers_2019_10, tankers_2019_11, tankers_2019_12, na.rm = TRUE)
sum_tankers_2020 <- sum(tankers_2020_01, tankers_2020_02, tankers_2020_03, tankers_2020_04, tankers_2020_05, tankers_2020_06, tankers_2020_07, tankers_2020_08, tankers_2020_09, tankers_2020_10, tankers_2020_11, tankers_2020_12, na.rm = TRUE)
sum_tankers_2021 <- sum(tankers_2021_01, tankers_2021_02, tankers_2021_03, tankers_2021_04, tankers_2021_05, tankers_2021_06, tankers_2021_07, tankers_2021_08, tankers_2021_09, tankers_2021_10, tankers_2021_11, tankers_2021_12, na.rm = TRUE)
sum_tankers_2022 <- sum(tankers_2022_01, tankers_2022_02, tankers_2022_03, tankers_2022_04, tankers_2022_05, tankers_2022_06, tankers_2022_07, tankers_2022_08, tankers_2022_09, tankers_2022_10, tankers_2022_11, tankers_2022_12, na.rm = TRUE)
sum_tankers_2023 <- sum(tankers_2023_01, tankers_2023_02, tankers_2023_03, tankers_2023_04, tankers_2023_05, tankers_2023_06, tankers_2023_07, tankers_2023_08, tankers_2023_09, tankers_2023_10, tankers_2023_11, tankers_2023_12, na.rm = TRUE)
tankers_summed <- sum(sum_tankers_2012, sum_tankers_2013, sum_tankers_2014, sum_tankers_2015, sum_tankers_2016, sum_tankers_2017, sum_tankers_2018, sum_tankers_2019, sum_tankers_2020, sum_tankers_2021, sum_tankers_2022, sum_tankers_2023, na.rm = TRUE)
#plot(tankers_summed)

#Save
terra::writeRaster(sum_tankers_2012, filename="E:/shipless_areas/sum_tankers/sum_tankers_2012.tif")
terra::writeRaster(sum_tankers_2013, filename="E:/shipless_areas/sum_tankers/sum_tankers_2013.tif")
terra::writeRaster(sum_tankers_2014, filename="E:/shipless_areas/sum_tankers/sum_tankers_2014.tif")
terra::writeRaster(sum_tankers_2015, filename="E:/shipless_areas/sum_tankers/sum_tankers_2015.tif")
terra::writeRaster(sum_tankers_2016, filename="E:/shipless_areas/sum_tankers/sum_tankers_2016.tif")
terra::writeRaster(sum_tankers_2017, filename="E:/shipless_areas/sum_tankers/sum_tankers_2017.tif")
terra::writeRaster(sum_tankers_2018, filename="E:/shipless_areas/sum_tankers/sum_tankers_2018.tif")
terra::writeRaster(sum_tankers_2019, filename="E:/shipless_areas/sum_tankers/sum_tankers_2019.tif")
terra::writeRaster(sum_tankers_2020, filename="E:/shipless_areas/sum_tankers/sum_tankers_2020.tif")
terra::writeRaster(sum_tankers_2021, filename="E:/shipless_areas/sum_tankers/sum_tankers_2021.tif")
terra::writeRaster(sum_tankers_2022, filename="E:/shipless_areas/sum_tankers/sum_tankers_2022.tif")
terra::writeRaster(sum_tankers_2023, filename="E:/shipless_areas/sum_tankers/sum_tankers_2023.tif")
terra::writeRaster(tankers_summed, filename="E:/shipless_areas/sum_tankers/tankers_summed.tif")

#Load
sum_tankers_2012 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2012.tif")
sum_tankers_2013 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2013.tif")
sum_tankers_2014 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2014.tif")
sum_tankers_2015 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2015.tif")
sum_tankers_2016 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2016.tif")
sum_tankers_2017 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2017.tif")
sum_tankers_2018 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2018.tif")
sum_tankers_2019 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2019.tif")
sum_tankers_2020 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2020.tif")
sum_tankers_2021 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2021.tif")
sum_tankers_2022 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2022.tif")
sum_tankers_2023 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2023.tif")
tankers_summed <- terra::rast("E:/shipless_areas/sum_tankers/tankers_summed.tif")

# Mean and SD
tankers_summed_stack <- c(sum_tankers_2012, sum_tankers_2013, sum_tankers_2014, sum_tankers_2015, sum_tankers_2016, sum_tankers_2017, sum_tankers_2018, sum_tankers_2019, sum_tankers_2020, sum_tankers_2021, sum_tankers_2022, sum_tankers_2023)
rm(sum_tankers_2012, sum_tankers_2013, sum_tankers_2014, sum_tankers_2015, sum_tankers_2016, sum_tankers_2017, sum_tankers_2018, sum_tankers_2019, sum_tankers_2020, sum_tankers_2021, sum_tankers_2022, sum_tankers_2023)
##
mean_sd_tankers_summed_stack <- terra::global(tankers_summed_stack, c("mean", "sd"), na.rm=TRUE)
mean_sd_tankers_summed_stack <- data.frame(2011:2023, mean_sd_tankers_summed_stack)
names(mean_sd_tankers_summed_stack)[1] <- "years"
rownames(mean_sd_tankers_summed_stack) <- 1:nrow(mean_sd_tankers_summed_stack)
save(mean_sd_tankers_summed_stack, file = "mean_sd_tankers_summed_stack.RData")
plot(mean_sd_tankers_summed_stack$years, mean_sd_tankers_summed_stack$mean, type = "l", main = "Tankers", xlab = "year", ylab = "Ship density (hours/cell)")
rm(list = ls())

### FISHING ###
sum_fishing_2012 <- sum(fishing_2012_01, fishing_2012_02, fishing_2012_03, fishing_2012_04, fishing_2012_05, fishing_2012_06, fishing_2012_07, fishing_2012_08, fishing_2012_09, fishing_2012_10, fishing_2012_11, fishing_2012_12, na.rm = TRUE)
sum_fishing_2013 <- sum(fishing_2013_01, fishing_2013_02, fishing_2013_03, fishing_2013_04, fishing_2013_05, fishing_2013_06, fishing_2013_07, fishing_2013_08, fishing_2013_09, fishing_2013_10, fishing_2013_11, fishing_2013_12, na.rm = TRUE)
sum_fishing_2014 <- sum(fishing_2014_01, fishing_2014_02, fishing_2014_03, fishing_2014_04, fishing_2014_05, fishing_2014_06, fishing_2014_07, fishing_2014_08, fishing_2014_09, fishing_2014_10, fishing_2014_11, fishing_2014_12, na.rm = TRUE)
sum_fishing_2015 <- sum(fishing_2015_01, fishing_2015_02, fishing_2015_03, fishing_2015_04, fishing_2015_05, fishing_2015_06, fishing_2015_07, fishing_2015_08, fishing_2015_09, fishing_2015_10, fishing_2015_11, fishing_2015_12, na.rm = TRUE)
sum_fishing_2016 <- sum(fishing_2016_01, fishing_2016_02, fishing_2016_03, fishing_2016_04, fishing_2016_05, fishing_2016_06, fishing_2016_07, fishing_2016_08, fishing_2016_09, fishing_2016_10, fishing_2016_11, fishing_2016_12, na.rm = TRUE)
sum_fishing_2017 <- sum(fishing_2017_01, fishing_2017_02, fishing_2017_03, fishing_2017_04, fishing_2017_05, fishing_2017_06, fishing_2017_07, fishing_2017_08, fishing_2017_09, fishing_2017_10, fishing_2017_11, fishing_2017_12, na.rm = TRUE)
sum_fishing_2018 <- sum(fishing_2018_01, fishing_2018_02, fishing_2018_03, fishing_2018_04, fishing_2018_05, fishing_2018_06, fishing_2018_07, fishing_2018_08, fishing_2018_09, fishing_2018_10, fishing_2018_11, fishing_2018_12, na.rm = TRUE)
sum_fishing_2019 <- sum(fishing_2019_01, fishing_2019_02, fishing_2019_03, fishing_2019_04, fishing_2019_05, fishing_2019_06, fishing_2019_07, fishing_2019_08, fishing_2019_09, fishing_2019_10, fishing_2019_11, fishing_2019_12, na.rm = TRUE)
sum_fishing_2020 <- sum(fishing_2020_01, fishing_2020_02, fishing_2020_03, fishing_2020_04, fishing_2020_05, fishing_2020_06, fishing_2020_07, fishing_2020_08, fishing_2020_09, fishing_2020_10, fishing_2020_11, fishing_2020_12, na.rm = TRUE)
sum_fishing_2021 <- sum(fishing_2021_01, fishing_2021_02, fishing_2021_03, fishing_2021_04, fishing_2021_05, fishing_2021_06, fishing_2021_07, fishing_2021_08, fishing_2021_09, fishing_2021_10, fishing_2021_11, fishing_2021_12, na.rm = TRUE)
sum_fishing_2022 <- sum(fishing_2022_01, fishing_2022_02, fishing_2022_03, fishing_2022_04, fishing_2022_05, fishing_2022_06, fishing_2022_07, fishing_2022_08, fishing_2022_09, fishing_2022_10, fishing_2022_11, fishing_2022_12, na.rm = TRUE)
sum_fishing_2023 <- sum(fishing_2023_01, fishing_2023_02, fishing_2023_03, fishing_2023_04, fishing_2023_05, fishing_2023_06, fishing_2023_07, fishing_2023_08, fishing_2023_09, fishing_2023_10, fishing_2023_11, fishing_2023_12, na.rm = TRUE)
fishing_summed <- sum( sum_fishing_2012, sum_fishing_2013, sum_fishing_2014, sum_fishing_2015, sum_fishing_2016, sum_fishing_2017, sum_fishing_2018, sum_fishing_2019, sum_fishing_2020, sum_fishing_2021, sum_fishing_2022, sum_fishing_2023, na.rm = TRUE)
#plot(fishing_summed)

#Save
terra::writeRaster(sum_fishing_2012, filename="E:/shipless_areas/sum_fishing/sum_fishing_2012.tif")
terra::writeRaster(sum_fishing_2013, filename="E:/shipless_areas/sum_fishing/sum_fishing_2013.tif")
terra::writeRaster(sum_fishing_2014, filename="E:/shipless_areas/sum_fishing/sum_fishing_2014.tif")
terra::writeRaster(sum_fishing_2015, filename="E:/shipless_areas/sum_fishing/sum_fishing_2015.tif")
terra::writeRaster(sum_fishing_2016, filename="E:/shipless_areas/sum_fishing/sum_fishing_2016.tif")
terra::writeRaster(sum_fishing_2017, filename="E:/shipless_areas/sum_fishing/sum_fishing_2017.tif")
terra::writeRaster(sum_fishing_2018, filename="E:/shipless_areas/sum_fishing/sum_fishing_2018.tif")
terra::writeRaster(sum_fishing_2019, filename="E:/shipless_areas/sum_fishing/sum_fishing_2019.tif")
terra::writeRaster(sum_fishing_2020, filename="E:/shipless_areas/sum_fishing/sum_fishing_2020.tif")
terra::writeRaster(sum_fishing_2021, filename="E:/shipless_areas/sum_fishing/sum_fishing_2021.tif")
terra::writeRaster(sum_fishing_2022, filename="E:/shipless_areas/sum_fishing/sum_fishing_2022.tif")
terra::writeRaster(sum_fishing_2023, filename="E:/shipless_areas/sum_fishing/sum_fishing_2023.tif")
terra::writeRaster(fishing_summed, filename="E:/shipless_areas/sum_fishing/fishing_summed.tif")

#Load
sum_fishing_2012 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2012.tif")
sum_fishing_2013 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2013.tif")
sum_fishing_2014 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2014.tif")
sum_fishing_2015 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2015.tif")
sum_fishing_2016 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2016.tif")
sum_fishing_2017 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2017.tif")
sum_fishing_2018 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2018.tif")
sum_fishing_2019 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2019.tif")
sum_fishing_2020 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2020.tif")
sum_fishing_2021 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2021.tif")
sum_fishing_2022 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2022.tif")
sum_fishing_2023 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2023.tif")
fishing_summed <- terra::rast("E:/shipless_areas/sum_fishing/fishing_summed.tif")

# Mean and SD
fishing_summed_stack <- c(sum_fishing_2012, sum_fishing_2013, sum_fishing_2014, sum_fishing_2015, sum_fishing_2016, sum_fishing_2017, sum_fishing_2018, sum_fishing_2019, sum_fishing_2020, sum_fishing_2021, sum_fishing_2022, sum_fishing_2023)
rm(sum_fishing_2012, sum_fishing_2013, sum_fishing_2014, sum_fishing_2015, sum_fishing_2016, sum_fishing_2017, sum_fishing_2018, sum_fishing_2019, sum_fishing_2020, sum_fishing_2021, sum_fishing_2022, sum_fishing_2023)
#
mean_sd_fishing_summed_stack <- terra::global(fishing_summed_stack, c("mean", "sd"), na.rm=TRUE)
mean_sd_fishing_summed_stack <- data.frame(2011:2023, mean_sd_fishing_summed_stack)
names(mean_sd_fishing_summed_stack)[1] <- "years"
rownames(mean_sd_fishing_summed_stack) <- 1:nrow(mean_sd_fishing_summed_stack)
save(mean_sd_fishing_summed_stack, file = "mean_sd_fishing_summed_stack.RData")
plot(mean_sd_fishing_summed_stack$years, mean_sd_fishing_summed_stack$mean, type = "l", main = "Fishing ships", xlab = "year", ylab = "Ship density (hours/cell)")
rm(list = ls())

save(mean_sd_all_summed_stack, file = "mean_sd_all_summed_stack_v2.RData")
save(mean_sd_cargo_summed_stack, file = "mean_sd_cargo_summed_stack_v2.RData")
save(mean_sd_tankers_summed_stack, file = "mean_sd_tankers_summed_stack_v2.RData")
save(mean_sd_fishing_summed_stack, file = "mean_sd_fishing_summed_stack_v2.RData")

########################################################################################
#                     Month-based summary - (not really used!)
########################################################################################


### JANUARY ###
all_january <- sum(all_2011_01, all_2012_01, all_2013_01, all_2014_01, all_2015_01, all_2016_01, all_2017_01, all_2018_01, all_2019_01, all_2020_01, all_2021_01, all_2022_01, all_2023_01, na.rm = TRUE)
cargo_january <- sum(cargo_2011_01, cargo_2012_01, cargo_2013_01, cargo_2014_01, cargo_2015_01, cargo_2016_01, cargo_2017_01, cargo_2018_01, cargo_2019_01, cargo_2020_01, cargo_2021_01, cargo_2022_01, cargo_2023_01, na.rm = TRUE)
tankers_january <- sum(tankers_2011_01, tankers_2012_01, tankers_2013_01, tankers_2014_01, tankers_2015_01, tankers_2016_01, tankers_2017_01, tankers_2018_01, tankers_2019_01, tankers_2020_01, tankers_2021_01, tankers_2022_01, tankers_2023_01, na.rm = TRUE)
fishing_january <- sum(fishing_2011_01, fishing_2012_01, fishing_2013_01, fishing_2014_01, fishing_2015_01, fishing_2016_01, fishing_2017_01, fishing_2018_01, fishing_2019_01, fishing_2020_01, fishing_2021_01, fishing_2022_01, fishing_2023_01, na.rm = TRUE)
#Save
terra::writeRaster(all_january, filename="E:/shipless_areas/all_january.tif")
terra::writeRaster(cargo_january, filename="E:/shipless_areas/cargo_january.tif")
terra::writeRaster(tankers_january, filename="E:/shipless_areas/tankers_january.tif")
terra::writeRaster(fishing_january, filename="E:/shipless_areas/fishing_january.tif")

### FEBRUARY ###
all_february <- sum(all_2011_02, all_2012_02, all_2013_02, all_2014_02, all_2015_02, all_2016_02, all_2017_02, all_2018_02, all_2019_02, all_2020_02, all_2021_02, all_2022_02, all_2023_02, na.rm = TRUE)
cargo_february <- sum(cargo_2011_02, cargo_2012_02, cargo_2013_02, cargo_2014_02, cargo_2015_02, cargo_2016_02, cargo_2017_02, cargo_2018_02, cargo_2019_02, cargo_2020_02, cargo_2021_02, cargo_2022_02, cargo_2023_02, na.rm = TRUE)
tankers_february <- sum(tankers_2011_02, tankers_2012_02, tankers_2013_02, tankers_2014_02, tankers_2015_02, tankers_2016_02, tankers_2017_02, tankers_2018_02, tankers_2019_02, tankers_2020_02, tankers_2021_02, tankers_2022_02, tankers_2023_02, na.rm = TRUE)
fishing_february <- sum(fishing_2011_02, fishing_2012_02, fishing_2013_02, fishing_2014_02, fishing_2015_02, fishing_2016_02, fishing_2017_02, fishing_2018_02, fishing_2019_02, fishing_2020_02, fishing_2021_02, fishing_2022_02, fishing_2023_02, na.rm = TRUE)
#Save
terra::writeRaster(all_february, filename="E:/shipless_areas/all_february.tif")
terra::writeRaster(cargo_february, filename="E:/shipless_areas/cargo_february.tif")
terra::writeRaster(tankers_february, filename="E:/shipless_areas/tankers_february.tif")
terra::writeRaster(fishing_february, filename="E:/shipless_areas/fishing_february.tif")

### MARCH ###
all_march <- sum(all_2011_03, all_2012_03, all_2013_03, all_2014_03, all_2015_03, all_2016_03, all_2017_03, all_2018_03, all_2019_03, all_2020_03, all_2021_03, all_2022_03, all_2023_03, na.rm = TRUE)
cargo_march <- sum(cargo_2011_03, cargo_2012_03, cargo_2013_03, cargo_2014_03, cargo_2015_03, cargo_2016_03, cargo_2017_03, cargo_2018_03, cargo_2019_03, cargo_2020_03, cargo_2021_03, cargo_2022_03, cargo_2023_03, na.rm = TRUE)
tankers_march <- sum(tankers_2011_03, tankers_2012_03, tankers_2013_03, tankers_2014_03, tankers_2015_03, tankers_2016_03, tankers_2017_03, tankers_2018_03, tankers_2019_03, tankers_2020_03, tankers_2021_03, tankers_2022_03, tankers_2023_03, na.rm = TRUE)
fishing_march <- sum(fishing_2011_03, fishing_2012_03, fishing_2013_03, fishing_2014_03, fishing_2015_03, fishing_2016_03, fishing_2017_03, fishing_2018_03, fishing_2019_03, fishing_2020_03, fishing_2021_03, fishing_2022_03, fishing_2023_03, na.rm = TRUE)
#Save
terra::writeRaster(all_march, filename="E:/shipless_areas/all_march.tif")
terra::writeRaster(cargo_march, filename="E:/shipless_areas/cargo_march.tif")
terra::writeRaster(tankers_march, filename="E:/shipless_areas/tankers_march.tif")
terra::writeRaster(fishing_march, filename="E:/shipless_areas/fishing_march.tif")

### APRIL ###
all_april <- sum(all_2011_04, all_2012_04, all_2013_04, all_2014_04, all_2015_04, all_2016_04, all_2017_04, all_2018_04, all_2019_04, all_2020_04, all_2021_04, all_2022_04, all_2023_04, na.rm = TRUE)
cargo_april <- sum(cargo_2011_04, cargo_2012_04, cargo_2013_04, cargo_2014_04, cargo_2015_04, cargo_2016_04, cargo_2017_04, cargo_2018_04, cargo_2019_04, cargo_2020_04, cargo_2021_04, cargo_2022_04, cargo_2023_04, na.rm = TRUE)
tankers_april <- sum(tankers_2011_04, tankers_2012_04, tankers_2013_04, tankers_2014_04, tankers_2015_04, tankers_2016_04, tankers_2017_04, tankers_2018_04, tankers_2019_04, tankers_2020_04, tankers_2021_04, tankers_2022_04, tankers_2023_04, na.rm = TRUE)
fishing_april <- sum(fishing_2011_04, fishing_2012_04, fishing_2013_04, fishing_2014_04, fishing_2015_04, fishing_2016_04, fishing_2017_04, fishing_2018_04, fishing_2019_04, fishing_2020_04, fishing_2021_04, fishing_2022_04, fishing_2023_04, na.rm = TRUE)
#Save
terra::writeRaster(all_april, filename="E:/shipless_areas/all_april.tif")
terra::writeRaster(cargo_april, filename="E:/shipless_areas/cargo_april.tif")
terra::writeRaster(tankers_april, filename="E:/shipless_areas/tankers_april.tif")
terra::writeRaster(fishing_april, filename="E:/shipless_areas/fishing_april.tif")

### MAY ###
all_may <- sum(all_2011_05, all_2012_05, all_2013_05, all_2014_05, all_2015_05, all_2016_05, all_2017_05, all_2018_05, all_2019_05, all_2020_05, all_2021_05, all_2022_05, all_2023_05, na.rm = TRUE)
cargo_may <- sum(cargo_2011_05, cargo_2012_05, cargo_2013_05, cargo_2014_05, cargo_2015_05, cargo_2016_05, cargo_2017_05, cargo_2018_05, cargo_2019_05, cargo_2020_05, cargo_2021_05, cargo_2022_05, cargo_2023_05, na.rm = TRUE)
tankers_may <- sum(tankers_2011_05, tankers_2012_05, tankers_2013_05, tankers_2014_05, tankers_2015_05, tankers_2016_05, tankers_2017_05, tankers_2018_05, tankers_2019_05, tankers_2020_05, tankers_2021_05, tankers_2022_05, tankers_2023_05, na.rm = TRUE)
fishing_may <- sum(fishing_2011_05, fishing_2012_05, fishing_2013_05, fishing_2014_05, fishing_2015_05, fishing_2016_05, fishing_2017_05, fishing_2018_05, fishing_2019_05, fishing_2020_05, fishing_2021_05, fishing_2022_05, fishing_2023_05, na.rm = TRUE)
#Save
terra::writeRaster(all_may, filename="E:/shipless_areas/all_may.tif")
terra::writeRaster(cargo_may, filename="E:/shipless_areas/cargo_may.tif")
terra::writeRaster(tankers_may, filename="E:/shipless_areas/tankers_may.tif")
terra::writeRaster(fishing_may, filename="E:/shipless_areas/fishing_may.tif")

### JUNE ###
all_june <- sum(all_2011_06, all_2012_06, all_2013_06, all_2014_06, all_2015_06, all_2016_06, all_2017_06, all_2018_06, all_2019_06, all_2020_06, all_2021_06, all_2022_06, all_2023_06, na.rm = TRUE)
cargo_june <- sum(cargo_2011_06, cargo_2012_06, cargo_2013_06, cargo_2014_06, cargo_2015_06, cargo_2016_06, cargo_2017_06, cargo_2018_06, cargo_2019_06, cargo_2020_06, cargo_2021_06, cargo_2022_06, cargo_2023_06, na.rm = TRUE)
tankers_june <- sum(tankers_2011_06, tankers_2012_06, tankers_2013_06, tankers_2014_06, tankers_2015_06, tankers_2016_06, tankers_2017_06, tankers_2018_06, tankers_2019_06, tankers_2020_06, tankers_2021_06, tankers_2022_06, tankers_2023_06, na.rm = TRUE)
fishing_june <- sum(fishing_2011_06, fishing_2012_06, fishing_2013_06, fishing_2014_06, fishing_2015_06, fishing_2016_06, fishing_2017_06, fishing_2018_06, fishing_2019_06, fishing_2020_06, fishing_2021_06, fishing_2022_06, fishing_2023_06, na.rm = TRUE)
#Save
terra::writeRaster(all_june, filename="E:/shipless_areas/all_june.tif")
terra::writeRaster(cargo_june, filename="E:/shipless_areas/cargo_june.tif")
terra::writeRaster(tankers_june, filename="E:/shipless_areas/tankers_june.tif")
terra::writeRaster(fishing_june, filename="E:/shipless_areas/fishing_june.tif")

### JULY ###
all_july <- sum(all_2011_07, all_2012_07, all_2013_07, all_2014_07, all_2015_07, all_2016_07, all_2017_07, all_2018_07, all_2019_07, all_2020_07, all_2021_07, all_2022_07, all_2023_07, na.rm = TRUE)
cargo_july <- sum(cargo_2011_07, cargo_2012_07, cargo_2013_07, cargo_2014_07, cargo_2015_07, cargo_2016_07, cargo_2017_07, cargo_2018_07, cargo_2019_07, cargo_2020_07, cargo_2021_07, cargo_2022_07, cargo_2023_07, na.rm = TRUE)
tankers_july <- sum(tankers_2011_07, tankers_2012_07, tankers_2013_07, tankers_2014_07, tankers_2015_07, tankers_2016_07, tankers_2017_07, tankers_2018_07, tankers_2019_07, tankers_2020_07, tankers_2021_07, tankers_2022_07, tankers_2023_07, na.rm = TRUE)
fishing_july <- sum(fishing_2011_07, fishing_2012_07, fishing_2013_07, fishing_2014_07, fishing_2015_07, fishing_2016_07, fishing_2017_07, fishing_2018_07, fishing_2019_07, fishing_2020_07, fishing_2021_07, fishing_2022_07, fishing_2023_07, na.rm = TRUE)
#Save
terra::writeRaster(all_july, filename="E:/shipless_areas/all_july.tif")
terra::writeRaster(cargo_july, filename="E:/shipless_areas/cargo_july.tif")
terra::writeRaster(tankers_july, filename="E:/shipless_areas/tankers_july.tif")
terra::writeRaster(fishing_july, filename="E:/shipless_areas/fishing_july.tif")

### AUGUST ###
all_august <- sum(all_2011_08, all_2012_08, all_2013_08, all_2014_08, all_2015_08, all_2016_08, all_2017_08, all_2018_08, all_2019_08, all_2020_08, all_2021_08, all_2022_08, all_2023_08, na.rm = TRUE)
cargo_august <- sum(cargo_2011_08, cargo_2012_08, cargo_2013_08, cargo_2014_08, cargo_2015_08, cargo_2016_08, cargo_2017_08, cargo_2018_08, cargo_2019_08, cargo_2020_08, cargo_2021_08, cargo_2022_08, cargo_2023_08, na.rm = TRUE)
tankers_august <- sum(tankers_2011_08, tankers_2012_08, tankers_2013_08, tankers_2014_08, tankers_2015_08, tankers_2016_08, tankers_2017_08, tankers_2018_08, tankers_2019_08, tankers_2020_08, tankers_2021_08, tankers_2022_08, tankers_2023_08, na.rm = TRUE)
fishing_august <- sum(fishing_2011_08, fishing_2012_08, fishing_2013_08, fishing_2014_08, fishing_2015_08, fishing_2016_08, fishing_2017_08, fishing_2018_08, fishing_2019_08, fishing_2020_08, fishing_2021_08, fishing_2022_08, fishing_2023_08, na.rm = TRUE)
#Save
terra::writeRaster(all_august, filename="E:/shipless_areas/all_august.tif")
terra::writeRaster(cargo_august, filename="E:/shipless_areas/cargo_august.tif")
terra::writeRaster(tankers_august, filename="E:/shipless_areas/tankers_august.tif")
terra::writeRaster(fishing_august, filename="E:/shipless_areas/fishing_august.tif")

### SEPTEMBER ###
all_september <- sum(all_2011_09, all_2012_09, all_2013_09, all_2014_09, all_2015_09, all_2016_09, all_2017_09, all_2018_09, all_2019_09, all_2020_09, all_2021_09, all_2022_09, all_2023_09, na.rm = TRUE)
cargo_september <- sum(cargo_2011_09, cargo_2012_09, cargo_2013_09, cargo_2014_09, cargo_2015_09, cargo_2016_09, cargo_2017_09, cargo_2018_09, cargo_2019_09, cargo_2020_09, cargo_2021_09, cargo_2022_09, cargo_2023_09, na.rm = TRUE)
tankers_september <- sum(tankers_2011_09, tankers_2012_09, tankers_2013_09, tankers_2014_09, tankers_2015_09, tankers_2016_09, tankers_2017_09, tankers_2018_09, tankers_2019_09, tankers_2020_09, tankers_2021_09, tankers_2022_09, tankers_2023_09, na.rm = TRUE)
fishing_september <- sum(fishing_2011_09, fishing_2012_09, fishing_2013_09, fishing_2014_09, fishing_2015_09, fishing_2016_09, fishing_2017_09, fishing_2018_09, fishing_2019_09, fishing_2020_09, fishing_2021_09, fishing_2022_09, fishing_2023_09, na.rm = TRUE)
#Save
terra::writeRaster(all_september, filename="E:/shipless_areas/all_september.tif")
terra::writeRaster(cargo_september, filename="E:/shipless_areas/cargo_september.tif")
terra::writeRaster(tankers_september, filename="E:/shipless_areas/tankers_september.tif")
terra::writeRaster(fishing_september, filename="E:/shipless_areas/fishing_september.tif")

### OCTOBER ###
all_october <- sum(all_2011_10, all_2012_10, all_2013_10, all_2014_10, all_2015_10, all_2016_10, all_2017_10, all_2018_10, all_2019_10, all_2020_10, all_2021_10, all_2022_10, all_2023_10, na.rm = TRUE)
cargo_october <- sum(cargo_2011_10, cargo_2012_10, cargo_2013_10, cargo_2014_10, cargo_2015_10, cargo_2016_10, cargo_2017_10, cargo_2018_10, cargo_2019_10, cargo_2020_10, cargo_2021_10, cargo_2022_10, cargo_2023_10, na.rm = TRUE)
tankers_october <- sum(tankers_2011_10, tankers_2012_10, tankers_2013_10, tankers_2014_10, tankers_2015_10, tankers_2016_10, tankers_2017_10, tankers_2018_10, tankers_2019_10, tankers_2020_10, tankers_2021_10, tankers_2022_10, tankers_2023_10, na.rm = TRUE)
fishing_october <- sum(fishing_2011_10, fishing_2012_10, fishing_2013_10, fishing_2014_10, fishing_2015_10, fishing_2016_10, fishing_2017_10, fishing_2018_10, fishing_2019_10, fishing_2020_10, fishing_2021_10, fishing_2022_10, fishing_2023_10, na.rm = TRUE)
#Save
terra::writeRaster(all_october, filename="E:/shipless_areas/all_october.tif")
terra::writeRaster(cargo_october, filename="E:/shipless_areas/cargo_october.tif")
terra::writeRaster(tankers_october, filename="E:/shipless_areas/tankers_october.tif")
terra::writeRaster(fishing_october, filename="E:/shipless_areas/fishing_october.tif")

### NOVEMBER ###
all_november <- sum(all_2011_11, all_2012_11, all_2013_11, all_2014_11, all_2015_11, all_2016_11, all_2017_11, all_2018_11, all_2019_11, all_2020_11, all_2021_11, all_2022_11, all_2023_11, na.rm = TRUE)
cargo_november <- sum(cargo_2011_11, cargo_2012_11, cargo_2013_11, cargo_2014_11, cargo_2015_11, cargo_2016_11, cargo_2017_11, cargo_2018_11, cargo_2019_11, cargo_2020_11, cargo_2021_11, cargo_2022_11, cargo_2023_11, na.rm = TRUE)
tankers_november <- sum(tankers_2011_11, tankers_2012_11, tankers_2013_11, tankers_2014_11, tankers_2015_11, tankers_2016_11, tankers_2017_11, tankers_2018_11, tankers_2019_11, tankers_2020_11, tankers_2021_11, tankers_2022_11, tankers_2023_11, na.rm = TRUE)
fishing_november <- sum(fishing_2011_11, fishing_2012_11, fishing_2013_11, fishing_2014_11, fishing_2015_11, fishing_2016_11, fishing_2017_11, fishing_2018_11, fishing_2019_11, fishing_2020_11, fishing_2021_11, fishing_2022_11, fishing_2023_11, na.rm = TRUE)
#Save
terra::writeRaster(all_november, filename="E:/shipless_areas/all_november.tif")
terra::writeRaster(cargo_november, filename="E:/shipless_areas/cargo_november.tif")
terra::writeRaster(tankers_november, filename="E:/shipless_areas/tankers_november.tif")
terra::writeRaster(fishing_november, filename="E:/shipless_areas/fishing_november.tif")

### DECEMBER ###
all_december <- sum(all_2011_12, all_2012_12, all_2013_12, all_2014_12, all_2015_12, all_2016_12, all_2017_12, all_2018_12, all_2019_12, all_2020_12, all_2021_12, all_2022_12, all_2023_12, na.rm = TRUE)
cargo_december <- sum(cargo_2011_12, cargo_2012_12, cargo_2013_12, cargo_2014_12, cargo_2015_12, cargo_2016_12, cargo_2017_12, cargo_2018_12, cargo_2019_12, cargo_2020_12, cargo_2021_12, cargo_2022_12, cargo_2023_12, na.rm = TRUE)
tankers_december <- sum(tankers_2011_12, tankers_2012_12, tankers_2013_12, tankers_2014_12, tankers_2015_12, tankers_2016_12, tankers_2017_12, tankers_2018_12, tankers_2019_12, tankers_2020_12, tankers_2021_12, tankers_2022_12, tankers_2023_12, na.rm = TRUE)
fishing_december <- sum(fishing_2011_12, fishing_2012_12, fishing_2013_12, fishing_2014_12, fishing_2015_12, fishing_2016_12, fishing_2017_12, fishing_2018_12, fishing_2019_12, fishing_2020_12, fishing_2021_12, fishing_2022_12, fishing_2023_12, na.rm = TRUE)
#Save
terra::writeRaster(all_december, filename="E:/shipless_areas/all_december.tif")
terra::writeRaster(cargo_december, filename="E:/shipless_areas/cargo_december.tif")
terra::writeRaster(tankers_december, filename="E:/shipless_areas/tankers_december.tif")
terra::writeRaster(fishing_december, filename="E:/shipless_areas/fishing_december.tif")



