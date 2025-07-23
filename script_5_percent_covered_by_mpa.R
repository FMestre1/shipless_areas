################################################################################
#                    Plot ship density by area - MAPS
################################################################################

#FMestre
#22-10-2024

#Load packages
library(terra)
library(dplyr)

#Clear environment
rm(list = ls())

#Define the working directory
setwd("~/github/shipless_areas")

#Load density rasters (terciles)
terciles_reclassified_all_summed <- terra::rast("tercile_rasters/terciles_reclassified_all_summed_02FEV25.tif")
terciles_reclassified_all_summed[is.na(terciles_reclassified_all_summed)] <- 0

#Vectors of the areas
mpa <- terra::vect("shapes/mpa_simplified.shp")
ebsa <- terra::vect("shapes/Ecologically_or_Biologically_Significant_Marine_Areas_(EBSAs).shp")
marine_realms <- terra::vect("shapes/marineRealms.shp")
eez <- terra::vect("shapes/eez_v12.shp")
meow <- terra::vect("shapes/meow_ecos.shp")

#Coastline
coastline <- terra::vect("shapes/coastline.shp")

# Zonal statistics
counted_values_MBR <- terra::zonal(terciles_reclassified_all_summed, 
                                   marine_realms, fun = "mean",
                                   as.raster = TRUE)

counted_values_MPA <- terra::zonal(terciles_reclassified_all_summed, 
                                   mpa, fun = "mean",
                                   as.raster = TRUE)

counted_values_EBSA <- terra::zonal(terciles_reclassified_all_summed, 
                                    ebsa, fun = "mean",
                                    as.raster = TRUE)

counted_values_EEZ <- terra::zonal(terciles_reclassified_all_summed, 
                                   eez, fun = "mean",
                                   as.raster = TRUE)

counted_values_MEOW <- terra::zonal(terciles_reclassified_all_summed, 
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

################################################################################
#         Plotting the percentage of shipless areas covered by MPA            
################################################################################

#FMestre
#02-02-2025

#Define the working directory
setwd("~/github/shipless_areas")

#Load library
library(terra)

#Clear environment
rm(list = ls())

#Load rasters
priority_global <- terra::rast("outputs_fernando_ships_13_maio_25/priority_global_20250129.tif")
shipless_areas <- terra::rast("PMA_PPA_shipless_areas/shipless_global_20250129_RECLASS_FM.tif")
#plot(priority_global)
#plot(shipless_Areas)

#Load MPA
mpa <- terra::vect("D:/shipless_areas_paper/datasets/MPA/mpa_simplified_assis_CORRECTED_2.shp")
continents <- terra::vect("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/continents_close_seas.shp")
#plot(continents, add=TRUE)

#1. SHIPLESS AREAS #####################

#Zonal statistics
shipless_in_mpa <- terra::mask(shipless_areas, mpa)

# Calculate total shipless area (sum of non-NA values)
total_shipless_area <- sum(terra::values(shipless_areas, na.rm = TRUE))

# Calculate shipless area within MPAs
mpa_shipless_area <- sum(terra::values(shipless_in_mpa, na.rm = TRUE))

# Compute percentage
percentage_covered <- (mpa_shipless_area / total_shipless_area) * 100

#2. PPA (1) #####################
#select the PPA from priority_global, the value 1 in the raster
ppa <- priority_global == 1  # This creates a boolean (TRUE/FALSE) raster
ppa[ppa == 0] <- NA   # Set all FALSE values (not 1) to NA
ppa <- ppa*priority_global
#plot(ppa)

#Zonal statistics
ppa_in_mpa <- terra::mask(ppa, mpa)

# Calculate total ppa area (sum of non-NA values)
total_ppa_area <- sum(terra::values(ppa, na.rm = TRUE))

# Calculate ppa area within MPAs
mpa_ppa_area <- sum(terra::values(ppa_in_mpa, na.rm = TRUE))

# Compute percentage
percentage_covered2 <- (mpa_ppa_area / total_ppa_area) * 100

#3. PMA (2) #####################

#select the pma from priority_global, the value 1 in the raster
pma <- priority_global == 2  # This creates a boolean (TRUE/FALSE) raster
pma[pma == 0] <- NA   # Set all FALSE values (not 1) to NA
pma <- pma*priority_global
pma[pma == 2] <- 1
#plot(pma)

#Zonal statistics
pma_in_mpa <- terra::mask(pma, mpa)

# Calculate total pma area (sum of non-NA values)
total_pma_area <- sum(terra::values(pma, na.rm = TRUE))

# Calculate pma area within MPAs
mpa_pma_area <- sum(terra::values(pma_in_mpa, na.rm = TRUE))

# Compute percentage
percentage_covered3 <- (mpa_pma_area / total_pma_area) * 100

## -----------------------------------------------------------------------------

################################################################################
#  Plotting the percentage of shipless areas covered by MPA with no-take zones            
################################################################################


#FMestre
#30-04-2025

#Define the working directory
setwd("~/github/shipless_areas")

#Load library
library(terra)

#Clear environment
rm(list = ls())

#Load rasters
priority_global <- terra::rast("C:\\Users\\mestr\\Documents\\0. Artigos\\4. SUBMETIDOS\\shipless_areas\\gis\\last_files_fernando\\priority_global_20250129.tif")
shipless_areas <- terra::rast("C:\\Users\\mestr\\Documents\\0. Artigos\\4. SUBMETIDOS\\shipless_areas\\gis\\last_files_fernando\\shipless_global_20250129_RECLASS_FM.tif")
#plot(priority_global)
#plot(shipless_areas)

#Load MPA
mpa <- terra::vect("D:\\shipless_areas_paper\\datasets\\MPA\\mpa_simplified_assis_CORRECTED_2.shp")
continents <- terra::vect("C:\\Users\\mestr\\Documents\\0. Artigos\\4. SUBMETIDOS\\shipless_areas\\gis\\continents_close_seas.shp")
#plot(continents, add=TRUE)
#head(mpa)
#unique(mpa$noTake)

#Create new column with no take zones being 1 and all the rest being 0
mpa$noTake_01 <- 0
rows_to_update <- mpa$noTake %in% c("Part", "All")
mpa$noTake_01[rows_to_update] <- 1
#
mpa_noTake <- mpa[mpa$noTake_01 == 1, ]
#plot(mpa_noTake, add=TRUE)


#1. SHIPLESS AREAS #####################

#Zonal statistics
shipless_in_mpa_notake <- terra::mask(shipless_areas, mpa_noTake)

# Calculate total shipless area (sum of non-NA values)
total_shipless_area <- sum(terra::values(shipless_areas, na.rm = TRUE))

# Calculate shipless area within MPAs
mpa_shipless_area_notake <- sum(terra::values(shipless_in_mpa_notake, na.rm = TRUE))

# Compute percentage
percentage_covered_notake <- (mpa_shipless_area_notake / total_shipless_area) * 100
round(percentage_covered_notake, 2)

#2. PPA (1) #####################
#select the PPA from priority_global, the value 1 in the raster
ppa <- priority_global == 1  # This creates a boolean (TRUE/FALSE) raster
ppa[ppa == 0] <- NA   # Set all FALSE values (not 1) to NA
ppa <- ppa*priority_global
#plot(ppa)

#Zonal statistics
ppa_in_mpa_notake <- terra::mask(ppa, mpa_noTake)

# Calculate total ppa area (sum of non-NA values)
total_ppa_area <- sum(terra::values(ppa, na.rm = TRUE))

# Calculate ppa area within MPAs
mpa_ppa_area_notake <- sum(terra::values(ppa_in_mpa_notake, na.rm = TRUE))

# Compute percentage
percentage_covered2_notake <- (mpa_ppa_area_notake / total_ppa_area) * 100
round(percentage_covered2_notake, 2)

#3. PMA (2) #####################

#select the pma from priority_global, the value 1 in the raster
pma <- priority_global == 2  # This creates a boolean (TRUE/FALSE) raster
pma[pma == 0] <- NA   # Set all FALSE values (not 1) to NA
pma <- pma*priority_global
pma[pma == 2] <- 1
#plot(pma)

#Zonal statistics
pma_in_mpa_notake <- terra::mask(pma, mpa_noTake)

# Calculate total pma area (sum of non-NA values)
total_pma_area <- sum(terra::values(pma, na.rm = TRUE))

# Calculate pma area within MPAs
mpa_pma_area_notake <- sum(terra::values(pma_in_mpa_notake, na.rm = TRUE))

# Compute percentage
percentage_covered3 <- (mpa_pma_area_notake / total_pma_area) * 100
round(percentage_covered3, 2)



################################################################################
#    GETTING RANGE PROPORTION IN THE EACH TERCILE OF SHIP DENSITY (not used)
################################################################################

#FMestre
#21-01-2025

#Define the working directory
setwd("~/github/shipless_areas")

#Load library
library(terra)
library(sf)
library(ggplot2)
library(gridExtra)
library(ggpubr)

#Clear environment
rm(list = ls())

#1. Get the range data from...
#D:\shipless_areas_paper\datasets\Data_assis_21jan2025\Range maps

#1.1. List all rasters in the folder
range_rasters_paths <- list.files("D:/shipless_areas_paper/datasets/Data_assis_21jan2025/Range maps", pattern = ".tif$", full.names = TRUE)
range_rasters <- list.files("D:/shipless_areas_paper/datasets/Data_assis_21jan2025/Range maps", pattern = ".tif$", full.names = FALSE)

#remove .tif extension from the names
range_rasters <- gsub(".tif", "", range_rasters)
#replace space with underscore
range_rasters <- gsub(" ", "_", range_rasters)

#2. Get the ship density tercile map
terciles_reclassified_all_summed <- terra::rast("tercile_rasters/terciles_reclassified_all_summed_02FEV25.tif")

#2.1. Resample the ship density map to match the range map resolution (or get it from other source)
terciles_reclassified_all_summed_resampled <- resample(terciles_reclassified_all_summed, terra::rast(range_rasters_paths[[1]]), method="mode")
#table(as.vector(terra::values(terciles_reclassified_all_summed_resampled)))

#terra::plot(terciles_reclassified_all_summed_resampled)

#3. Get the proportion of the 3rd tercile
#3.1. Loop through all range maps to get their proportion
#output table - data frame with a column for species names and three columns for the proportion of each tercile
overlap_values_df <- data.frame()

for(i in 1:length(range_rasters)){
  
  range_map1 <- terra::rast(range_rasters_paths[[i]])
  #plot(terciles_reclassified_all_summed_resampled)
  #plot(range_map1, add = TRUE)
  #plot(range_map1)
  overlap_values1 <- terra::values(range_map1 * terciles_reclassified_all_summed_resampled)
  overlap_values1_df <- as.data.frame(table(overlap_values1))
  overlap_values1_df <- overlap_values1_df[overlap_values1_df$overlap_values1 != 0,]
  #convert the values to a percentage
  overlap_values1_df$percentage <- overlap_values1_df$Freq / sum(overlap_values1_df$Freq) * 100
  #if zero rows add NA row
  if(nrow(overlap_values1_df) == 0){
    overlap_values1_df <- data.frame(overlap_values1 = NA, Freq = NA, percentage = NA)
  }
  #add species name
  overlap_values1_df$species <- range_rasters[i]
  #remove Freq
  overlap_values1_df <- overlap_values1_df[,c("species", "overlap_values1", "percentage")]
  #rbind the data frames
  overlap_values_df <- rbind(overlap_values_df, overlap_values1_df)
  message(paste(i, "- Done with ", range_rasters[i]))
  
}    

#4. Retrieve information about which group each species belongs to
#4.1. Load the data table
species_data <- read.csv("D:\\shipless_areas_paper\\datasets\\Data_assis_21jan2025\\species_considered1.csv", sep=";")
#Replace space with underscore
species_data$Scientific.name <- gsub(" ", "_", species_data$Scientific.name)
#head(species_data)

#4.2. Add information on the taxonomic group to overlap_values_df
for(i in 1:nrow(overlap_values_df)){
  species_name <- overlap_values_df$species[i]
  taxonomic_group <- species_data$Group[species_data$Scientific.name == species_name]
  overlap_values_df$taxonomic_group[i] <- taxonomic_group
}

#4.3.save the data frame
write.csv(overlap_values_df, "overlap_values_df_21jan2025.csv", row.names = FALSE)
overlap_values_df <- read.csv("overlap_values_df_21jan2025.csv")
#see table
View(overlap_values_df)

#5. Create a boxplot for each tercile and each group
#5.1. Separate the df by group
turtles_tercile_percentage <- overlap_values_df[overlap_values_df$taxonomic_group == "seaturtles",]
seabirds_tercile_percentage <- overlap_values_df[overlap_values_df$taxonomic_group == "seabirds",]
pinnipeds_tercile_percentage <- overlap_values_df[overlap_values_df$taxonomic_group == "pinnipeds",]
cetaceans_tercile_percentage <- overlap_values_df[overlap_values_df$taxonomic_group == "cetaceans",]

#remove rows with NA values
turtles_tercile_percentage <- turtles_tercile_percentage[complete.cases(turtles_tercile_percentage),]
seabirds_tercile_percentage <- seabirds_tercile_percentage[complete.cases(seabirds_tercile_percentage),]
pinnipeds_tercile_percentage <- pinnipeds_tercile_percentage[complete.cases(pinnipeds_tercile_percentage),]
cetaceans_tercile_percentage <- cetaceans_tercile_percentage[complete.cases(cetaceans_tercile_percentage),]

#5.2. Draw the boxplot by group using ggplot2
library(ggplot2)
library(gridExtra)
install.packages("ggpubr")
library(ggpubr)

# Define a color palette
my_palette <- c("#556B2F", "#B8860B", "#CD0000")

# 5.2.1. Seaturtles
box_seaturtles <- ggplot(turtles_tercile_percentage, aes(x = percentage, y = as.factor(overlap_values1), fill = as.factor(overlap_values1))) + 
  geom_boxplot(width = 0.6) +
  labs(title = "Seaturtles", y = "Ship density", x = "Percentage") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_fill_manual(values = my_palette) +
  xlim(0, 100)

# 5.2.2. Seabirds
box_seabirds <- ggplot(seabirds_tercile_percentage, aes(x = percentage, y = as.factor(overlap_values1), fill = as.factor(overlap_values1))) + 
  geom_boxplot(width = 0.6) +
  labs(title = "Seabirds", y = "Ship density", x = "Percentage") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_fill_manual(values = my_palette) +
  xlim(0, 100)

# 5.2.3. Pinnipeds
box_pinnipeds <- ggplot(pinnipeds_tercile_percentage, aes(x = percentage, y = as.factor(overlap_values1), fill = as.factor(overlap_values1))) + 
  geom_boxplot(width = 0.6) +
  labs(title = "Pinnipeds", y = "Ship density", x = "Percentage") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_fill_manual(values = my_palette) +
  xlim(0, 100)


# 5.2.4. Cetaceans
box_cetaceans <- ggplot(cetaceans_tercile_percentage, aes(x = percentage, y = as.factor(overlap_values1), fill = as.factor(overlap_values1))) + 
  geom_boxplot(width = 0.6) +
  labs(title = "Cetaceans", y = "Ship density", x = "Percentage") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_fill_manual(values = my_palette) +
  xlim(0, 100)

# Combine four boxplots in one figure
#grid.arrange(box_seaturtles, box_seabirds, box_pinnipeds, box_cetaceans, ncol = 2)
ggarrange(box_seaturtles, box_seabirds, box_pinnipeds, box_cetaceans, ncol=2, nrow=2, common.legend = TRUE, legend="bottom")

# Define a color palette
my_palette <- c("#556B2F", "#B8860B", "#CD0000")

# 5.2.1. Seaturtles
box_seaturtles <- ggplot(turtles_tercile_percentage, aes(x = percentage, y = as.factor(overlap_values1), fill = as.factor(overlap_values1))) + 
  geom_boxplot(width = 0.6) +
  labs(title = "Seaturtles", y = "Ship density") + 
  theme_minimal() +
  scale_fill_manual(values = my_palette, 
                    labels = c("Low", "Intermediate", "High"), 
                    name = "") + 
  theme(legend.position = "none") 

# 5.2.2. Seabirds
box_seabirds <- ggplot(seabirds_tercile_percentage, aes(x = percentage, y = as.factor(overlap_values1), fill = as.factor(overlap_values1))) + 
  geom_boxplot(width = 0.6) +
  labs(title = "Seabirds", y = "Ship density") + 
  theme_minimal() +
  scale_fill_manual(values = my_palette, 
                    labels = c("Low", "Intermediate", "High"), 
                    name = "") + 
  theme(legend.position = "none") 

# 5.2.3. Pinnipeds
box_pinnipeds <- ggplot(pinnipeds_tercile_percentage, aes(x = percentage, y = as.factor(overlap_values1), fill = as.factor(overlap_values1))) + 
  geom_boxplot(width = 0.6) +
  labs(title = "Pinnipeds", y = "Ship density") + 
  theme_minimal() +
  scale_fill_manual(values = my_palette, 
                    labels = c("Low", "Intermediate", "High"), 
                    name = "") + 
  theme(legend.position = "none") 

# 5.2.4. Cetaceans
box_cetaceans <- ggplot(cetaceans_tercile_percentage, aes(x = percentage, y = as.factor(overlap_values1), fill = as.factor(overlap_values1))) + 
  geom_boxplot(width = 0.6) +
  labs(title = "Cetaceans", y = "Ship density") + 
  theme_minimal() +
  scale_fill_manual(values = my_palette, 
                    labels = c("Low", "Intermediate", "High"), 
                    name = "") + 
  theme(legend.position = "none") 

# Combine four boxplots in one figure
ggarrange(box_seaturtles, box_seabirds, box_pinnipeds, box_cetaceans, ncol=2, nrow=2, common.legend = TRUE, legend="bottom")





