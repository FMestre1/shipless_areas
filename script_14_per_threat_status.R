################################################################################
#         Plotting the percentage of shipless areas covered by MPA            
################################################################################

#FMestre
#30-04-2025

#Define the working directory
setwd("~/github/shipless_areas")

#Load library
library(terra)

#Clear environment
rm(list = ls())

#Upload areas
priority_global <- terra::rast("C:\\Users\\mestr\\Documents\\0. Artigos\\4. SUBMETIDOS\\shipless_areas\\gis\\last_files_fernando\\priority_global_20250129.tif")
shipless_areas <- terra::rast("C:\\Users\\mestr\\Documents\\0. Artigos\\4. SUBMETIDOS\\shipless_areas\\gis\\last_files_fernando\\shipless_global_20250129_RECLASS_FM.tif")
#
ppa <- priority_global == 1  # This creates a boolean (TRUE/FALSE) raster
ppa[ppa == 0] <- NA   # Set all FALSE values (not 1) to NA
ppa <- ppa*priority_global
#
pma <- priority_global == 2  # This creates a boolean (TRUE/FALSE) raster
pma[pma == 0] <- NA   # Set all FALSE values (not 1) to NA
pma <- pma*priority_global
pma[pma == 2] <- 1

#plot(ppa)
#plot(pma)

species_ranges <- list.files("Range_maps", pattern = ".tif$", full.names = FALSE)

ranges_raster_list <- list()

for(i in 1:length(species_ranges)){
  
#remove the ".tif" portion
species_names <- gsub(".tif", "", species_ranges)
#add underscore in spaces
species_names <- gsub(" ", "_", species_names)

assign(paste0(species_names[i], "_range_raster"), terra::rast(paste0("Range_maps/", species_ranges[i])))

ranges_raster_list[[i]] <- get(paste0(species_names[i], "_range_raster"))

message(paste0("Concluded uploading the species range of ", species_names[i]))

}

#plot(ranges_raster_list[[1]])
#plot(ranges_raster_list[[2]])
#plot(ranges_raster_list[[3]])

names(ranges_raster_list) <- species_names

#In ranges_raster_list convert all 0 to NA
#for(i in 1:length(ranges_raster_list)) ranges_raster_list[[i]][ranges_raster_list[[i]] == 0] <- NA

################################################################################
#                              Overlap with PPA
################################################################################

#ranges_raster_list[[1]]
#ppa

ppa2 <- terra::resample(ppa, ranges_raster_list[[1]])
ppa2[is.na(ppa2)] <- 0

ppa_overlap_vector <- c()

for(i in 1:length(ranges_raster_list)){

ras1 <- ranges_raster_list[[i]]
ras1[ras1 == 1] <- 10
#
overlap1 <- sum(ppa2, ras1)
#
#plot(overlap1)
#
range_area_overlap <- length(as.vector(overlap1[overlap1 == 11]))
range_area <- length(c(as.vector(overlap1[overlap1 == 11]), as.vector(overlap1[overlap1 == 10])))
#
percent_overlap <- round(range_area_overlap/range_area * 100, 2)

ppa_overlap_vector <- c(pp_overlap_vector, percent_overlap)

message(i)

}

#Build data frame
ppa_data_frame <- data.frame(names(ranges_raster_list), ppa_overlap_vector)
ppa_data_frame$names.ranges_raster_list. <- gsub("_", " ", ppa_data_frame$names.ranges_raster_list.)
names(ppa_data_frame) <- c("species", "pma_overlap_percent")

#Save
write.csv(ppa_data_frame, "ppa_overlap_species.csv", row.names = FALSE)

################################################################################
#                              Overlap with PMA
################################################################################

#ranges_raster_list[[1]]
#pma

pma2 <- terra::resample(pma, ranges_raster_list[[1]])
pma2[is.na(pma2)] <- 0

pma_overlap_vector <- c()

for(i in 1:length(ranges_raster_list)){
  
  ras1 <- ranges_raster_list[[i]]
  ras1[ras1 == 1] <- 10
  #
  overlap1 <- sum(pma2, ras1)
  #
  #plot(overlap1)
  #
  range_area_overlap <- length(as.vector(overlap1[overlap1 == 11]))
  range_area <- length(c(as.vector(overlap1[overlap1 == 11]), as.vector(overlap1[overlap1 == 10])))
  #
  percent_overlap <- round(range_area_overlap/range_area * 100, 2)
  
  pma_overlap_vector <- c(pma_overlap_vector, percent_overlap)
  
  message(i)
  
}

#Build data frame
pma_data_frame <- data.frame(names(ranges_raster_list), pma_overlap_vector)
pma_data_frame$names.ranges_raster_list. <- gsub("_", " ", pma_data_frame$names.ranges_raster_list.)
names(pma_data_frame) <- c("species", "pma_overlap_percent")

#Save
write.csv(pma_data_frame, "pma_overlap_species.csv", row.names = FALSE)

################################################################################
#            Percentage of overlap with PMA and PPA by threat status
################################################################################

#Clear environment
rm(list = ls())

library(readxl)

cetaceans <- read_excel("C:\\Users\\mestr\\Documents\\0. Artigos\\4. SUBMETIDOS\\shipless_areas\\Supplementary information tables.xlsx", sheet = "S1.1. cetaceans")
#head(cetaceans)
sea_turtles <- read_excel("C:\\Users\\mestr\\Documents\\0. Artigos\\4. SUBMETIDOS\\shipless_areas\\Supplementary information tables.xlsx", sheet = "S1.2. sea turtles")
#head(sea_turtles)
pinnipeds <- read_excel("C:\\Users\\mestr\\Documents\\0. Artigos\\4. SUBMETIDOS\\shipless_areas\\Supplementary information tables.xlsx", sheet = "S1.3. pinnipeds")
#head(pinnipeds)
seabirds <- read_excel("C:\\Users\\mestr\\Documents\\0. Artigos\\4. SUBMETIDOS\\shipless_areas\\Supplementary information tables.xlsx", sheet = "S1.4. seabirds")
#head(seabirds)

all_species <- rbind(cetaceans, sea_turtles, pinnipeds, seabirds)

#Save
write.csv(all_species, "all_species.csv", row.names = FALSE)

#upload pma_data_frame
pma_data_frame <- read.csv("pma_overlap_species.csv")

#Upload ppa_data_frame
ppa_data_frame <- read.csv("ppa_overlap_species.csv")

#merge all_species and pma_data_frame by the value of a column
all_species_pma <- merge(all_species, pma_data_frame, by.x = "Scientific name", by.y = "species", all.x = TRUE)
all_species_ppa <- merge(all_species, ppa_data_frame, by.x = "Scientific name", by.y = "species", all.x = TRUE)

#convert IUCN status column to factor
all_species_pma$`IUCN status` <- as.factor(all_species_pma$`IUCN status`)
all_species_ppa$`IUCN status` <- as.factor(all_species_ppa$`IUCN status`)

#average the pma_overlap_percent by IUCN status
pma_overlap_by_status <- aggregate(all_species_pma$pma_overlap_percent, by = list(all_species_pma$`IUCN status`), FUN = mean)
ppa_overlap_by_status <- aggregate(all_species_ppa$pma_overlap_percent, by = list(all_species_ppa$`IUCN status`), FUN = mean)

pma_overlap_by_status$x <- round(pma_overlap_by_status$x, 2)
ppa_overlap_by_status$x <- round(ppa_overlap_by_status$x, 2)
