################################################################################
#                             Ship density by area
################################################################################

#FMestre
#15-10-2024

#Load packages
library(terra)
library(dplyr)

#Continents
#continent <- terra::vect("/media/fredmestre/FMestre/shipless_areas/shapes/ne_110m_admin_0_countries.shp")

#Load density rasters (terciles)
terciles_reclassified_all_summed <- terra::rast("terciles_reclassified_all_summed.tif")
terciles_reclassified_cargo_summed <- terra::rast("terciles_reclassified_cargo_summed.tif")
terciles_reclassified_tankers_summed <- terra::rast("terciles_reclassified_tankers_summed.tif")
terciles_reclassified_fishing_summed <- terra::rast("terciles_reclassified_fishing_summed.tif")

################################################################################
#                       Marine Protected Area (MPA)
################################################################################

#UNEP-WCMC and IUCN (2024), Protected Planet: The World Database on Protected Areas (WDPA) [Online], October 2024, Cambridge, UK: UNEP-WCMC and IUCN. Available at: www.protectedplanet.net.

mpa <- terra::vect("shapes/mpa_assis.shp")
plot(mpa)
crs(mpa)

# Extract raster values for each polygon
extracted_values_mpa <- extract(terciles_reclassified_all_summed, 
                                mpa)

mpa_df <- as.data.frame(mpa)
mpa_df <- data.frame(1:nrow(mpa_df), mpa_df)
colnames(mpa_df)[1] <- "ID_2"
#head(mpa_df)

# merge two data frames by ID
extracted_values_mpa_2 <- merge(extracted_values_mpa, mpa_df, by.x = "ID", by.y = "ID_2")
#head(extracted_values_mpa_2)

# Summarizing the frequency of each class per polygon
summary_table_mpa <- table(extracted_values_mpa_2[,2:3])
summary_table_mpa <- as.data.frame(summary_table_mpa)
#View(summary_table_mpa)

#Convert to percentages
# Group by `realm_name` and calculate the total frequency for each realm
summary_table_mpa_df_grouped <- summary_table_mpa %>%
  group_by(Name) %>%
  mutate(total_freq = sum(Freq))

# Calculate the percentage of each level within each realm
summary_table_mpa_df_grouped <- summary_table_mpa_df_grouped %>%
  mutate(percentage = (Freq / total_freq) * 100)

# Print the results
summary_table_mpa_df_grouped <- as.data.frame(summary_table_mpa_df_grouped)
#View(summary_table_mpa_df_grouped)

## Reorder the data frame, putting those with more "High density" on top 
# Assuming your data frame is called `df`
# Step 1: Filter the rows where grid_float_All_2011_01_converted == "3"
high_density_df_mpa <- summary_table_mpa_df_grouped %>%
  filter(grid_float_All_2011_01_converted == "3") %>%
  arrange(percentage)  # Step 2: Arrange by descending percentage for "3" category

# Step 3: Reorder the original data frame based on the order of realm_name in the high density subset
summary_table_mpa_df_grouped_ordered <- summary_table_mpa_df_grouped %>%
  mutate(Name = factor(Name, levels = high_density_df_mpa$Name)) %>%
  arrange(Name, grid_float_All_2011_01_converted)

# View the result
View(summary_table_mpa_df_grouped_ordered)[1:60,]

# Stacked bar plot with ggplot2
ggplot(summary_table_mpa_df_grouped_ordered, aes(x = as.factor(Name), y = percentage, fill = as.factor(grid_float_All_2011_01_converted))) +
  geom_bar(stat = "identity", position = position_stack(reverse = TRUE)) +
  labs(x = "Marine Protected Areas", y = "Percentage of total area", fill = "Ship density") +
  theme_minimal() +
  coord_flip() +
  # Manually specify colors and rename the classes in the legend
  scale_fill_manual(
    values = c("1" = "#CDC673", "2" = "#EE4000", "3" = "#8B0000"),  # Colors
    labels = c("Low Density", "Medium Density", "High Density")      # Custom labels
  ) +
  # Adjust theme to give more space to the left labels (realm_name)
  theme(
    plot.margin = unit(c(1, 1, 1, 2.5), "cm"),   # Increase left margin (last value) for more space
    axis.text.y = element_text(size = 8, hjust = 1),  # Increase label size and align them correctly
    axis.title.y = element_text(size = 14, margin = margin(r = 50))  # Increase space between y-axis title and labels
  )


################################################################################
#         Ecologically or Biologically Significant Areas (EBSA)
################################################################################

ebsa <- terra::vect("shapes/Ecologically_or_Biologically_Significant_Marine_Areas_(EBSAs).shp")
plot(ebsa)
crs(ebsa)

# Extract raster values for each polygon
extracted_values_ebsa <- extract(terciles_reclassified_all_summed, 
                                ebsa)

ebsa_df <- as.data.frame(ebsa)
ebsa_df <- data.frame(1:nrow(ebsa), ebsa)
colnames(ebsa_df)[1] <- "ID_2"
#head(ebsa_df)

# merge two data frames by ID
extracted_values_ebsa_2 <- merge(extracted_values_ebsa, ebsa_df, by.x = "ID", by.y = "ID_2")
#head(extracted_values_ebsa_2)

# Summarizing the frequency of each class per polygon
summary_table_ebsa <- table(extracted_values_ebsa_2[,c(2,6)])
summary_table_ebsa <- as.data.frame(summary_table_ebsa)
#View(summary_table_ebsa)

#Convert to percentages
# Group by `realm_name` and calculate the total frequency for each realm
summary_table_ebsa_df_grouped <- summary_table_ebsa %>%
  group_by(NAME) %>%
  mutate(total_freq = sum(Freq))

# Calculate the percentage of each level within each realm
summary_table_ebsa_df_grouped <- summary_table_ebsa_df_grouped %>%
  mutate(percentage = (Freq / total_freq) * 100)

# Print the results
summary_table_ebsa_df_grouped <- as.data.frame(summary_table_ebsa_df_grouped)
#View(summary_table_ebsa_df_grouped)

## Reorder the data frame, putting those with more "High density" on top 
# Assuming your data frame is called `df`
# Step 1: Filter the rows where grid_float_All_2011_01_converted == "3"
high_density_df_ebsa <- summary_table_ebsa_df_grouped %>%
  filter(grid_float_All_2011_01_converted == "3") %>%
  arrange(percentage)  # Step 2: Arrange by descending percentage for "3" category

# Step 3: Reorder the original data frame based on the order of realm_name in the high density subset
summary_table_ebsa_df_grouped_ordered <- summary_table_ebsa_df_grouped %>%
  mutate(NAME = factor(NAME, levels = high_density_df_ebsa$NAME)) %>%
  arrange(NAME, grid_float_All_2011_01_converted)

# View the result
View(summary_table_ebsa_df_grouped_ordered)[1:60,]

# Stacked bar plot with ggplot2
ggplot(summary_table_ebsa_df_grouped_ordered, aes(x = as.factor(NAME), y = percentage, fill = as.factor(grid_float_All_2011_01_converted))) +
  geom_bar(stat = "identity", position = position_stack(reverse = TRUE)) +
  labs(x = "Ecologically or Biologically Significant Areas", y = "Percentage of total area", fill = "Ship density") +
  theme_minimal() +
  coord_flip() +
  # Manually specify colors and rename the classes in the legend
  scale_fill_manual(
    values = c("1" = "#CDC673", "2" = "#EE4000", "3" = "#8B0000"),  # Colors
    labels = c("Low Density", "Medium Density", "High Density")      # Custom labels
  ) +
  # Adjust theme to give more space to the left labels (realm_name)
  theme(
    plot.margin = unit(c(1, 1, 1, 2.5), "cm"),   # Increase left margin (last value) for more space
    axis.text.y = element_text(size = 8, hjust = 1),  # Increase label size and align them correctly
    axis.title.y = element_text(size = 14, margin = margin(r = 50))  # Increase space between y-axis title and labels
  )

################################################################################
#                       Mapped Biogeographic Realms (MBR)
################################################################################

marine_realms <- terra::vect("shapes/marineRealms.shp")
plot(marine_realms)
crs(marine_realms)

## boxplot with 2 layers
#View(as.data.frame(marine_realms))
#marine_realms_R <- rasterize(marine_realms, terciles_reclassified_all_summed, "realm_name")
#boxplot_MBR <- boxplot(terciles_reclassified_all_summed, marine_realms_R)

# Extract raster values for each polygon
extracted_values_MBR <- extract(terciles_reclassified_all_summed, 
                                marine_realms)
# merge two data frames by ID
extracted_values_MBR_2 <- merge(extracted_values_MBR, as.data.frame(marine_realms), by.x = "ID", by.y = "Realm")

# Summarizing the frequency of each class per polygon
summary_table_MBR <- table(extracted_values_MBR_2[,2:3])
summary_table_MBR <- as.data.frame(summary_table_MBR)

View(summary_table_MBR)

#Convert to percentages

# Group by `realm_name` and calculate the total frequency for each realm
summary_table_MBR_df_grouped <- summary_table_MBR %>%
  group_by(realm_name) %>%
  mutate(total_freq = sum(Freq))

# Calculate the percentage of each level within each realm
summary_table_MBR_df_grouped <- summary_table_MBR_df_grouped %>%
  mutate(percentage = (Freq / total_freq) * 100)

# Print the results
summary_table_MBR_df_grouped <- as.data.frame(summary_table_MBR_df_grouped)
#View(summary_table_MBR_df_grouped)

## Reorder the data frame, putting those with more "High density" on top 
# Assuming your data frame is called `df`
# Step 1: Filter the rows where grid_float_All_2011_01_converted == "3"
high_density_df_MBR <- summary_table_MBR_df_grouped %>%
  filter(grid_float_All_2011_01_converted == "3") %>%
  arrange(percentage)  # Step 2: Arrange by descending percentage for "3" category

# Step 3: Reorder the original data frame based on the order of realm_name in the high density subset
summary_table_MBR_df_grouped_ordered <- summary_table_MBR_df_grouped %>%
  mutate(realm_name = factor(realm_name, levels = high_density_df_MBR$realm_name)) %>%
  arrange(realm_name, grid_float_All_2011_01_converted)

# View the result
#View(summary_table_MBR_df_grouped_ordered)

# Stacked bar plot with ggplot2
ggplot(summary_table_MBR_df_grouped_ordered, aes(x = as.factor(realm_name), y = percentage, fill = as.factor(grid_float_All_2011_01_converted))) +
  geom_bar(stat = "identity", position = position_stack(reverse = TRUE)) +
  labs(x = "Biogeographic Realms", y = "Percentage of total area", fill = "Ship density") +
  theme_minimal() +
  coord_flip() +
  # Manually specify colors and rename the classes in the legend
  scale_fill_manual(
    values = c("1" = "#CDC673", "2" = "#EE4000", "3" = "#8B0000"),  # Colors
    labels = c("Low Density", "Medium Density", "High Density")      # Custom labels
  ) +
  # Adjust theme to give more space to the left labels (realm_name)
  theme(
    plot.margin = unit(c(1, 1, 1, 2.5), "cm"),   # Increase left margin (last value) for more space
    axis.text.y = element_text(size = 8, hjust = 1),  # Increase label size and align them correctly
    axis.title.y = element_text(size = 14, margin = margin(r = 50))  # Increase space between y-axis title and labels
  )


################################################################################
#                       Exclusive Economic Zones (EEZ)
################################################################################

#Flanders Marine Institute (2023). Maritime Boundaries Geodatabase: 
#Maritime Boundaries and Exclusive Economic Zones (200NM), version 12. 
#Available online at https://www.marineregions.org/. 
#https://doi.org/10.14284/632

eez <- terra::vect("shapes/eez_v12.shp")
#eez_boundaries <- terra::vect("shapes/eez_boundaries_v12.shp")

View(as.data.frame(eez))
#View(as.data.frame(eez_boundaries))

plot(eez)
#plot(eez_boundaries)
crs(eez)

# Extract raster values for each polygon
extracted_values_eez <- extract(terciles_reclassified_all_summed, 
                                eez)

eez_df <- as.data.frame(eez)
eez_df <- data.frame(1:nrow(eez_df), eez_df)
colnames(eez_df)[1] <- "ID_2"
  
# merge two data frames by ID
extracted_values_eez_2 <- merge(extracted_values_eez, eez_df, by.x = "ID", by.y = "ID_2")


# Summarizing the frequency of each class per polygon
summary_table_eez <- table(extracted_values_eez_2[,c(2,10)])
summary_table_eez <- as.data.frame(summary_table_eez)

# Derive percentage
summary_table_eez_df_grouped <- summary_table_eez %>%
  group_by(SOVEREIGN1) %>%
  mutate(total_freq = sum(Freq))

# Calculate the percentage of each level within each realm
summary_table_eez_df_grouped <- summary_table_eez_df_grouped %>%
  mutate(percentage = (Freq / total_freq) * 100)

# Print the results
summary_table_eez_df_grouped <- as.data.frame(summary_table_eez_df_grouped)
#View(summary_table_MBR_df_grouped)

## Reorder the data frame, putting those with more "High density" on top 
# Assuming your data frame is called `df`
# Step 1: Filter the rows where grid_float_All_2011_01_converted == "3"
high_density_df_eez <- summary_table_eez_df_grouped %>%
  filter(grid_float_All_2011_01_converted == "3") %>%
  arrange(percentage)  # Step 2: Arrange by descending percentage for "3" category

# Step 3: Reorder the original data frame based on the order of realm_name in the high density subset
summary_table_eez_df_grouped_ordered <- summary_table_eez_df_grouped %>%
  mutate(SOVEREIGN1 = factor(SOVEREIGN1, levels = high_density_df_eez$SOVEREIGN1)) %>%
  arrange(SOVEREIGN1, grid_float_All_2011_01_converted)


# View the result
#View(summary_table_MBR_df_grouped_ordered)

# Stacked bar plot with ggplot2 - just the top 20 EEZ
ggplot(summary_table_eez_df_grouped_ordered[1:60,], aes(x = as.factor(SOVEREIGN1), y = percentage, fill = as.factor(grid_float_All_2011_01_converted))) +
  geom_bar(stat = "identity", position = position_stack(reverse = TRUE)) +
  labs(x = "Economic Exclusive Zones", y = "Percentage of total area", fill = "Ship density") +
  theme_minimal() +
  coord_flip() +
  # Manually specify colors and rename the classes in the legend
  scale_fill_manual(
    values = c("1" = "#CDC673", "2" = "#EE4000", "3" = "#8B0000"),  # Colors
    labels = c("Low Density", "Medium Density", "High Density")      # Custom labels
  ) +
  # Adjust theme to give more space to the left labels (realm_name)
  theme(
    plot.margin = unit(c(1, 1, 1, 2.5), "cm"),   # Increase left margin (last value) for more space
    axis.text.y = element_text(size = 8, hjust = 1),  # Increase label size and align them correctly
    axis.title.y = element_text(size = 14, margin = margin(r = 50))  # Increase space between y-axis title and labels
  )


################################################################################
#                   Marine Ecoregions of the World (MEOW)
################################################################################

#https://www.worldwildlife.org/publications/marine-ecoregions-of-the-world-a-bioregionalization-of-coastal-and-shelf-areas

meow <- terra::vect("shapes/meow_ecos.shp")
plot(meow)
crs(meow)
View(as.data.frame(meow))


# Extract raster values for each polygon
extracted_values_meow <- extract(terciles_reclassified_all_summed, 
                                meow)

meow_df <- as.data.frame(meow)
meow_df <- data.frame(1:nrow(meow_df), meow_df)
colnames(meow_df)[1] <- "ID_2"

# merge two data frames by ID
extracted_values_meow_2 <- merge(extracted_values_meow, meow_df, by.x = "ID", by.y = "ID_2")

# Summarizing the frequency of each class per polygon
summary_table_meow <- table(extracted_values_meow_2[,c(2,4)])
summary_table_meow <- as.data.frame(summary_table_meow)

# Derive percentage
summary_table_meow_df_grouped <- summary_table_meow %>%
  group_by(ECOREGION) %>%
  mutate(total_freq = sum(Freq))

# Calculate the percentage
summary_table_meow_df_grouped <- summary_table_meow_df_grouped %>%
  mutate(percentage = (Freq / total_freq) * 100)

# Print the results
summary_table_meow_df_grouped <- as.data.frame(summary_table_meow_df_grouped)
#View(summary_table_meow_df_grouped)

## Reorder the data frame, putting those with more "High density" on top 
# Assuming your data frame is called `df`
# Step 1: Filter the rows where grid_float_All_2011_01_converted == "3"
high_density_df_meow <- summary_table_meow_df_grouped %>%
  filter(grid_float_All_2011_01_converted == "3") %>%
  arrange(percentage)  # Step 2: Arrange by descending percentage for "3" category

# Step 3: Reorder the original data frame based on the order of realm_name in the high density subset
summary_table_meow_df_grouped_ordered <- summary_table_meow_df_grouped %>%
  mutate(ECOREGION = factor(ECOREGION, levels = high_density_df_meow$ECOREGION)) %>%
  arrange(desc(ECOREGION), grid_float_All_2011_01_converted)

# View the result
#View(summary_table_meow_df_grouped_ordered)

# Stacked bar plot with ggplot2

png(file="meow_plot.png", width = 2000, height = 2000)

ggplot(summary_table_meow_df_grouped_ordered, aes(x = as.factor(ECOREGION), y = percentage, fill = as.factor(grid_float_All_2011_01_converted))) +
  geom_bar(stat = "identity", position = position_stack(reverse = TRUE)) +
  labs(x = "Marine Ecoregions of the World", y = "Percentage of total area", fill = "Ship density") +
  theme_minimal() +
  coord_flip() +
  # Manually specify colors and rename the classes in the legend
  scale_fill_manual(
    values = c("1" = "#CDC673", "2" = "#EE4000", "3" = "#8B0000"),  # Colors
    labels = c("Low Density", "Medium Density", "High Density")      # Custom labels
  ) +
  # Adjust theme to give more space to the left labels (realm_name)
  theme(
    plot.margin = unit(c(1, 1, 1, 2.5), "cm"),   # Increase left margin (last value) for more space
    axis.text.y = element_text(size = 8, hjust = 1),  # Increase label size and align them correctly
    axis.title.y = element_text(size = 14, margin = margin(r = 50))  # Increase space between y-axis title and labels
  )

dev.off()

