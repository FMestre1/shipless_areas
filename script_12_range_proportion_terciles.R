################################################################################
#         GETTING RANGE PROPORTION IN THE EACH TERCILE OF SHIP DENSITY
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