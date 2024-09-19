################################################################################
#                             Summarizing figures
################################################################################

#FMestre
#08-07-2024

#Load package
library(terra)

#List files
#list.files("/media/jorgeassis/FMestre/shipless_areas")

#setwd("/home/fredmestre/shipless_areas")
#setwd("/media/jorgeassis/FMestre/shipless_areas")

################################################################################
#                                Per ship type
################################################################################

#Load maps per ship type
all_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/all_summed.tif")
cargo_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_cargo/cargo_summed.tif")
tankers_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_tankers/tankers_summed.tif")
fishing_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_fishing/fishing_summed.tif")
#Plot
terra::plot(all_summed)
terra::plot(cargo_summed)
terra::plot(tankers_summed)
terra::plot(fishing_summed)
#Vector
as.vector(all_summed)
as.vector(cargo_summed)
as.vector(tankers_summed)
as.vector(fishing_summed)
#Histogram
terra::hist(all_summed)
terra::hist(cargo_summed)
terra::hist(tankers_summed)
terra::hist(fishing_summed)
#Summary
terra::summary(all_summed)
terra::summary(cargo_summed)
terra::summary(tankers_summed)
terra::summary(fishing_summed)
#Plot
fun_color_range <- colorRampPalette(c("#FFF8DC", "#EE7600", "#CD6600", "#8B4500", "black"))
my_colours <- fun_color_range(100)
options(terra.pal=my_colours)
#
#Plot, defining the last class as +100 (as it is in the website)
all_summed_2 <- all_summed
all_summed_2[all_summed_2>=100] <- 100
terra::plot(all_summed_2, range=c(0,100), main = "All ships (Hrs/km2)")
#
cargo_summed_2 <- cargo_summed
cargo_summed_2[cargo_summed>=100] <- 100
terra::plot(cargo_summed_2, range=c(0,100), main = "Cargo ships (Hrs/km2)")
#
tankers_summed_2 <- tankers_summed
tankers_summed_2[tankers_summed>=100] <- 100
terra::plot(tankers_summed_2, range=c(0,100), main = "Tankers (Hrs/km2)")
#
fishing_summed_2 <- fishing_summed
fishing_summed_2[fishing_summed>=100] <- 100
terra::plot(fishing_summed_2, range=c(0,100), main = "Fishing ships (Hrs/km2)")


################################################################################
#                                Per month
################################################################################

fun_color_range <- colorRampPalette(c("#FFF8DC", "#EE7600", "#CD6600", "#8B4500", "black"))
my_colours <- fun_color_range(100)
options(terra.pal=my_colours)

#loading all monthly maps
all_january <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_january.tif")
all_february <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_february.tif")
all_march <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_march.tif")
all_april <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_april.tif")
all_may <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_may.tif")
all_june <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_june.tif")
all_july <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_july.tif")
all_august <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_august.tif")
all_september <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_september.tif")
all_october <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_october.tif")
all_november <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_november.tif")
all_december <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/all_december.tif")

#Plot
months_stack <- c(all_january, all_february, all_march, all_april, all_may, all_june, all_july, all_august, all_september, all_october, all_november, all_december)
#
mean_sd_months_stack <- terra::global(months_stack, c("mean", "sd"), na.rm=TRUE)
mean_sd_months_stack <- data.frame(1:12, c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"), mean_sd_months_stack)
names(mean_sd_months_stack)[1:2] <- c("months_numbers", "months")
rownames(mean_sd_months_stack) <- 1:nrow(mean_sd_months_stack)
save(mean_sd_months_stack, file = "mean_sd_months_stack.RData")

plot(mean_sd_months_stack$months_numbers , mean_sd_months_stack$mean, type = "l", xaxt="n", main = "Monthly averaged", xlab = "month", ylab = "Ship density (hours/cell)")
axis(1, at = 1:12, labels = mean_sd_months_stack$months) 

#### January ####
all_january_2 <- all_january
all_january_2[all_january_2>=100] <- 100
terra::plot(all_january_2, range=c(0,100), main = "January (all ships, Hrs/km2)")

#### February ####
all_february_2 <- all_february
all_february_2[all_february_2>=100] <- 100
terra::plot(all_february_2, range=c(0,100), main = "February (all ships, Hrs/km2)")

#### March ####
all_march_2 <- all_march
all_march_2[all_march_2>=100] <- 100
terra::plot(all_march_2, range=c(0,100), main = "March (all ships, Hrs/km2)")

#### April ####
all_april_2 <- all_april
all_april_2[all_april_2>=100] <- 100
terra::plot(all_april_2, range=c(0,100), main = "April (all ships, Hrs/km2)")

#### May ####
all_may_2 <- all_may
all_may_2[all_may_2>=100] <- 100
terra::plot(all_may_2, range=c(0,100), main = "May (all ships, Hrs/km2)")

#### June ####
all_june_2 <- all_june
all_june_2[all_june_2>=100] <- 100
terra::plot(all_june_2, range=c(0,100), main = "June (all ships, Hrs/km2)")

#### July ####
all_july_2 <- all_july
all_july_2[all_july_2>=100] <- 100
terra::plot(all_july_2, range=c(0,100), main = "july (all ships, Hrs/km2)")

#### August ####
all_august_2 <- all_august
all_august_2[all_august_2>=100] <- 100
terra::plot(all_august_2, range=c(0,100), main = "august (all ships, Hrs/km2)")

#### September ####
all_september_2 <- all_september
all_september_2[all_september_2>=100] <- 100
terra::plot(all_september_2, range=c(0,100), main = "september (all ships, Hrs/km2)")

#### October ####
all_october_2 <- all_october
all_october_2[all_october_2>=100] <- 100
terra::plot(all_october_2, range=c(0,100), main = "october (all ships, Hrs/km2)")

#### November ####
all_november_2 <- all_november
all_november_2[all_november_2>=100] <- 100
terra::plot(all_november_2, range=c(0,100), main = "november (all ships, Hrs/km2)")

#### December ####
all_december_2 <- all_december
all_december_2[all_december_2>=100] <- 100
terra::plot(all_december_2, range=c(0,100), main = "december (all ships, Hrs/km2)")

################################################################################
#                                Per year
################################################################################


fun_color_range <- colorRampPalette(c("#FFF8DC", "#EE7600", "#CD6600", "#8B4500", "black"))
my_colours <- fun_color_range(100)
options(terra.pal=my_colours)


#Loading all yearly maps
sum_all_2011 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2011.tif")
sum_all_2012 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2012.tif")
sum_all_2013 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2013.tif")
sum_all_2014 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2014.tif")
sum_all_2015 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2015.tif")
sum_all_2016 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2016.tif")
sum_all_2017 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2017.tif")
sum_all_2018 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2018.tif")
sum_all_2019 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2019.tif")
sum_all_2020 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2020.tif")
sum_all_2021 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2021.tif")
sum_all_2022 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2022.tif")
sum_all_2023 <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/sum_all_2023.tif")
all_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/all_summed.tif")

#### 2011 ####
sum_all_2011_2 <- sum_all_2011
sum_all_2011_2[sum_all_2011_2>=100] <- 100
terra::plot(sum_all_2011_2, range=c(0,100), main = "Year 2011 (all ships, Hrs/km2)")

#### 2012 ####
sum_all_2012_2 <- sum_all_2012
sum_all_2012_2[sum_all_2012_2>=100] <- 100
terra::plot(sum_all_2012_2, range=c(0,100), main = "Year 2012 (all ships, Hrs/km2)")

#### 2013 ####
sum_all_2013_2 <- sum_all_2013
sum_all_2013_2[sum_all_2013_2>=100] <- 100
terra::plot(sum_all_2013_2, range=c(0,100), main = "Year 2013 (all ships, Hrs/km2)")

#### 2014 ####
sum_all_2014_2 <- sum_all_2014
sum_all_2014_2[sum_all_2014_2>=100] <- 100
terra::plot(sum_all_2014_2, range=c(0,100), main = "Year 2014 (all ships, Hrs/km2)")

#### 2015 ####
sum_all_2015_2 <- sum_all_2015
sum_all_2015_2[sum_all_2015_2>=100] <- 100
terra::plot(sum_all_2015_2, range=c(0,100), main = "Year 2015 (all ships, Hrs/km2)")

#### 2016 ####
sum_all_2016_2 <- sum_all_2016
sum_all_2016_2[sum_all_2016_2>=100] <- 100
terra::plot(sum_all_2016_2, range=c(0,100), main = "Year 2016 (all ships, Hrs/km2)")

#### 2017 ####
sum_all_2017_2 <- sum_all_2017
sum_all_2017_2[sum_all_2017_2>=100] <- 100
terra::plot(sum_all_2017_2, range=c(0,100), main = "Year 2017 (all ships, Hrs/km2)")

#### 2018 ####
sum_all_2018_2 <- sum_all_2018
sum_all_2018_2[sum_all_2018_2>=100] <- 100
terra::plot(sum_all_2018_2, range=c(0,100), main = "Year 2018 (all ships, Hrs/km2)")

#### 2019 ####
sum_all_2019_2 <- sum_all_2019
sum_all_2019_2[sum_all_2019_2>=100] <- 100
terra::plot(sum_all_2019_2, range=c(0,100), main = "Year 2019 (all ships, Hrs/km2)")

#### 2020 ####
sum_all_2020_2 <- sum_all_2020
sum_all_2020_2[sum_all_2020_2>=100] <- 100
terra::plot(sum_all_2020_2, range=c(0,100), main = "Year 2020 (all ships, Hrs/km2)")

#### 2021 ####
sum_all_2021_2 <- sum_all_2021
sum_all_2021_2[sum_all_2021_2>=100] <- 100
terra::plot(sum_all_2021_2, range=c(0,100), main = "Year 2021 (all ships, Hrs/km2)")

#### 2022 ####
sum_all_2022_2 <- sum_all_2022
sum_all_2022_2[sum_all_2022_2>=100] <- 100
terra::plot(sum_all_2022_2, range=c(0,100), main = "Year 2022 (all ships, Hrs/km2)")

#### 2023 ####
sum_all_2023_2 <- sum_all_2023
sum_all_2023_2[sum_all_2023_2>=100] <- 100
terra::plot(sum_all_2023_2, range=c(0,100), main = "Year 2023 (all ships, Hrs/km2)")

### ALL ###
all_summed_2 <- all_summed
all_summed_2[all_summed_2>=100] <- 100
terra::plot(all_summed_2, range=c(0,100), main = "All shipping activity (Hrs/km2)")

