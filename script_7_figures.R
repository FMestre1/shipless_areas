################################################################################
#                                   Figures            
################################################################################

#FMestre
#25-10-2024

source("config.R")

################################################################################
#                                   Cetaceans
################################################################################

########## 1. All ships ##########

#Get a raster to be the template
all_summed_resampled_NA <- terra::rast("final_rasters/all_summed_resampled_no_2011_NA.tif")


#Convert
all_ships_vs_cetaceans_df <- as.data.frame(all_ships_vs_cetaceans)
all_ships_vs_cetaceans_df_vect <- terra::vect(all_ships_vs_cetaceans_df, geom = c("x", "y"))
all_ships_vs_cetaceans_RASTER <- terra::rasterize(all_ships_vs_cetaceans_df_vect, 
                                                  all_summed_resampled_NA, 
                                                  field = "BivValue", 
                                                  fun = "mean")

#Save
terra::writeRaster(all_ships_vs_cetaceans_RASTER, filename = "final_bivariate/all_ships_vs_cetaceans_BIVARIATE_02FEV25.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_cetaceans_df <- as.data.frame(cargo_vs_cetaceans)
cargo_vs_cetaceans_vect <- terra::vect(cargo_vs_cetaceans_df, geom = c("x", "y"))
cargo_vs_cetaceans_RASTER <- terra::rasterize(cargo_vs_cetaceans_vect, 
                                              all_summed_resampled_NA, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(cargo_vs_cetaceans_RASTER, filename = "final_bivariate/cargo_vs_cetaceans_BIVARIATE_02FEV25.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_cetaceans_df <- as.data.frame(fishing_ships_vs_cetaceans)
fishing_vs_cetaceans_vect <- terra::vect(fishing_vs_cetaceans_df, geom = c("x", "y"))
fishing_vs_cetaceans_RASTER <- terra::rasterize(fishing_vs_cetaceans_vect, 
                                                all_summed_resampled_NA, 
                                                field = "BivValue", 
                                                fun = "mean")
#Save
terra::writeRaster(fishing_vs_cetaceans_RASTER, filename = "final_bivariate/fishing_vs_cetaceans_BIVARIATE_02FEV25.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_cetaceans_df <- as.data.frame(tankers_vs_cetaceans)
tankers_vs_cetaceans_vect <- terra::vect(tankers_vs_cetaceans_df, geom = c("x", "y"))
tankers_vs_cetaceans_RASTER <- terra::rasterize(tankers_vs_cetaceans_vect, 
                                                all_summed_resampled_NA, 
                                                field = "BivValue", 
                                                fun = "mean")
#Save
terra::writeRaster(tankers_vs_cetaceans_RASTER, filename = "final_bivariate/tankers_vs_cetaceans_BIVARIATE_02FEV25.tif")

################################################################################
#                                  Sea Turtles
################################################################################

########## 1. All ships ##########

#Convert
all_ships_vs_turtles_df <- as.data.frame(all_ships_vs_turtles)
all_ships_vs_turtles_df_vect <- terra::vect(all_ships_vs_turtles_df, geom = c("x", "y"))
all_ships_vs_turtles_RASTER <- terra::rasterize(all_ships_vs_turtles_df_vect, 
                                                all_summed_resampled_NA, 
                                                field = "BivValue", 
                                                fun = "mean")

#Save
terra::writeRaster(all_ships_vs_turtles_RASTER, filename = "final_bivariate/all_ships_vs_turtles_BIVARIATE_02FEV25.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_turtles_df <- as.data.frame(cargo_vs_turtles)
cargo_vs_turtles_vect <- terra::vect(cargo_vs_turtles_df, geom = c("x", "y"))
cargo_vs_turtles_RASTER <- terra::rasterize(cargo_vs_turtles_vect, 
                                            all_summed_resampled_NA, 
                                            field = "BivValue", 
                                            fun = "mean")
#Save
terra::writeRaster(cargo_vs_turtles_RASTER, filename = "final_bivariate/cargo_vs_turtles_BIVARIATE_02FEV25.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_turtles_df <- as.data.frame(fishing_vs_turtles)
fishing_vs_turtles_vect <- terra::vect(fishing_vs_turtles_df, geom = c("x", "y"))
fishing_vs_turtles_RASTER <- terra::rasterize(fishing_vs_turtles_vect, 
                                              all_summed_resampled_NA, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(fishing_vs_turtles_RASTER, filename = "final_bivariate/fishing_vs_turtles_BIVARIATE_02FEV25.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_turtles_df <- as.data.frame(tankers_vs_turtles)
tankers_vs_turtles_vect <- terra::vect(tankers_vs_turtles_df, geom = c("x", "y"))
tankers_vs_turtles_RASTER <- terra::rasterize(tankers_vs_turtles_vect, 
                                              all_summed_resampled_NA, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(tankers_vs_turtles_RASTER, filename = "final_bivariate/tankers_vs_turtles_BIVARIATE_02FEV25.tif")

################################################################################
#                                   Pinnipeds
################################################################################

########## 1. All ships ##########

#Convert
all_ships_vs_pinnipeds_df <- as.data.frame(all_ships_vs_pinnipeds)
all_ships_vs_pinnipeds_df_vect <- terra::vect(all_ships_vs_pinnipeds_df, geom = c("x", "y"))
all_ships_vs_pinnipeds_RASTER <- terra::rasterize(all_ships_vs_pinnipeds_df_vect, 
                                                  all_summed_resampled_NA, 
                                                  field = "BivValue", 
                                                  fun = "mean")

#Save
terra::writeRaster(all_ships_vs_pinnipeds_RASTER, filename = "final_bivariate/all_ships_vs_pinnipeds_BIVARIATE_02FEV25.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_pinnipeds_df <- as.data.frame(cargo_vs_pinnipeds)
cargo_vs_pinnipeds_vect <- terra::vect(cargo_vs_pinnipeds_df, geom = c("x", "y"))
cargo_vs_pinnipeds_RASTER <- terra::rasterize(cargo_vs_pinnipeds_vect, 
                                              all_summed_resampled_NA, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(cargo_vs_pinnipeds_RASTER, filename = "final_bivariate/cargo_vs_pinnipeds_BIVARIATE_02FEV25.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_pinnipeds_df <- as.data.frame(fishing_vs_pinnipeds)
fishing_vs_pinnipeds_vect <- terra::vect(fishing_vs_pinnipeds_df, geom = c("x", "y"))
fishing_vs_pinnipeds_RASTER <- terra::rasterize(fishing_vs_pinnipeds_vect, 
                                                all_summed_resampled_NA, 
                                                field = "BivValue", 
                                                fun = "mean")
#Save
terra::writeRaster(fishing_vs_pinnipeds_RASTER, filename = "final_bivariate/fishing_vs_pinnipeds_BIVARIATE_02FEV25.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_pinnipeds_df <- as.data.frame(tankers_vs_pinnipeds)
tankers_vs_pinnipeds_vect <- terra::vect(tankers_vs_pinnipeds_df, geom = c("x", "y"))
tankers_vs_pinnipeds_RASTER <- terra::rasterize(tankers_vs_pinnipeds_vect, 
                                                all_summed_resampled_NA, 
                                                field = "BivValue", 
                                                fun = "mean")
#Save
terra::writeRaster(tankers_vs_pinnipeds_RASTER, filename = "final_bivariate/tankers_vs_pinnipeds_BIVARIATE_02FEV25.tif")

################################################################################
#                                   Sea Birds
################################################################################

########## 1. All ships ##########

#Convert
all_ships_vs_seabirds_df <- as.data.frame(all_ships_vs_seabirds)
all_ships_vs_seabirds_df_vect <- terra::vect(all_ships_vs_seabirds_df, geom = c("x", "y"))
all_ships_vs_seabirds_RASTER <- terra::rasterize(all_ships_vs_seabirds_df_vect, 
                                                 all_summed_resampled_NA, 
                                                 field = "BivValue", 
                                                 fun = "mean")

#Save
terra::writeRaster(all_ships_vs_seabirds_RASTER, filename = "final_bivariate/all_ships_vs_seabirds_BIVARIATE_02FEV25.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_seabirds_df <- as.data.frame(cargo_vs_seabirds)
cargo_vs_seabirds_vect <- terra::vect(cargo_vs_seabirds_df, geom = c("x", "y"))
cargo_vs_seabirds_RASTER <- terra::rasterize(cargo_vs_seabirds_vect, 
                                             all_summed_resampled_NA, 
                                             field = "BivValue", 
                                             fun = "mean")
#Save
terra::writeRaster(cargo_vs_seabirds_RASTER, filename = "final_bivariate/cargo_vs_seabirds_BIVARIATE_02FEV25.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_seabirds_df <- as.data.frame(fishing_vs_seabirds)
fishing_vs_seabirds_vect <- terra::vect(fishing_vs_seabirds_df, geom = c("x", "y"))
fishing_vs_seabirds_RASTER <- terra::rasterize(fishing_vs_seabirds_vect, 
                                               all_summed_resampled_NA, 
                                               field = "BivValue", 
                                               fun = "mean")
#Save
terra::writeRaster(fishing_vs_seabirds_RASTER, filename = "final_bivariate/fishing_vs_seabirds_BIVARIATE_02FEV25.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_seabirds_df <- as.data.frame(tankers_vs_seabirds)
tankers_vs_seabirds_vect <- terra::vect(tankers_vs_seabirds_df, geom = c("x", "y"))
tankers_vs_seabirds_RASTER <- terra::rasterize(tankers_vs_seabirds_vect, 
                                               all_summed_resampled_NA, 
                                               field = "BivValue", 
                                               fun = "mean")
#Save
terra::writeRaster(tankers_vs_seabirds_RASTER, filename = "final_bivariate/tankers_vs_seabirds_BIVARIATE_02FEV25.tif")

################################################################################
#                             MAP OF OVERALL RISKS
################################################################################

#FMestre
#29-11-2024

#Load species richness maps
cetaceans_sr_raster <- terra::rast("final_rasters/cetaceans_sr_raster_NA.tif")
testudines_sr_raster <- terra::rast("final_rasters/testudines_sr_raster_NA.tif")
pinnipeds_sr_raster <- terra::rast("final_rasters/pinnipeds_sr_raster_NA.tif")
seabirds_sr_raster_resampled_cropped_ext <- terra::rast("final_rasters/seabirds_sr_raster_resampled_cropped_ext_NA.tif")
all_summed_resampled_NA <- terra::rast("final_rasters/all_summed_resampled_no_2011_NA.tif")
all_summed_resampled_NA_log <- log10(all_summed_resampled_NA+1) #Log transform

#Convert NA to 0
#cetaceans_sr_raster[is.na(cetaceans_sr_raster[])] <- 0 
#testudines_sr_raster[is.na(testudines_sr_raster[])] <- 0 
#pinnipeds_sr_raster[is.na(pinnipeds_sr_raster[])] <- 0 
#seabirds_sr_raster_resampled_cropped_ext[is.na(seabirds_sr_raster_resampled_cropped_ext[])] <- 0 

#Rescale all maps (0-1)
cetaceans_sr_raster_standardized <- cetaceans_sr_raster/43
testudines_sr_raster_standardized <- testudines_sr_raster/6
pinnipeds_sr_raster_standardized <- pinnipeds_sr_raster/10
seabirds_sr_raster_resampled_cropped_ext_standardized <- seabirds_sr_raster_resampled_cropped_ext/68
all_summed__standardized <- (all_summed_resampled_NA_log - terra::minmax(all_summed_resampled_NA_log)[1]) / (terra::minmax(all_summed_resampled_NA_log)[2] - terra::minmax(all_summed_resampled_NA_log)[1])

#Combine biodiversity and ships
ships_cetaceans_sr_raster <- all_summed__standardized * cetaceans_sr_raster_standardized
ships_testudines_sr_raster <- all_summed__standardized * testudines_sr_raster_standardized
ships_pinnipeds_sr_raster <- all_summed__standardized * pinnipeds_sr_raster_standardized
ships_seabirds_sr_raster <- all_summed__standardized * seabirds_sr_raster_resampled_cropped_ext_standardized

#Overall
overall_conflict <- ships_cetaceans_sr_raster + 
  ships_testudines_sr_raster + 
  ships_pinnipeds_sr_raster + 
  ships_seabirds_sr_raster

overall_conflict_standardized <- overall_conflict/terra::minmax(overall_conflict)[2]
plot(overall_conflict_standardized)

#overall_conflict_standardized[is.na(overall_conflict_standardized[])] <- 0 

#Save it...
terra::writeRaster(overall_conflict_standardized, "overall_conflict_standardized2_02FEV25.tif", overwrite=TRUE)
#overall_conflict_standardized  <- terra::rast("overall_conflict_standardized2_02FEV25.tif")

################################################################################
# Figure 1
################################################################################

source("config.R")

coastline <- terra::vect("shapes/continents_close_seas.shp")
bb <- sf::st_union(sf::st_make_grid(sf::st_bbox(c(xmin = -180, xmax = 180, ymax = 90, ymin = -90), crs = sf::st_crs(4326)), n = 100))
shipless_areas <- terra::rast("~/0. Artigos/4. SUBMETIDOS/shipless_areas/gis/last_files_fernando/shipless_global_20250129_RECLASS_FM.tif")
mpa <- terra::vect("shapes/mpa_big_greater_100000.shp")
eez <- terra::vect("shapes/eez_v12_aggregated.shp")
open_sea <- terra::vect("C:/Users/mestr/Documents/0. Artigos/4. SUBMETIDOS/shipless_areas/gis/open_seas_lines/Equador_et_al_lines.shp")

#Project
target_crs <- "+proj=robin +over"
#
shipless_areas_proj <- project(shipless_areas, target_crs, method = "near")
coast_proj <- terra::project(coastline, target_crs)
mpa_proj <- terra::project(mpa, target_crs)
eez_proj <- terra::project(eez, target_crs)
open_sea_proj <- terra::project(open_sea, target_crs)
bb <- sf::st_transform(bb, target_crs)
#
graticule <- sf::st_graticule(lat = seq(-90, 90, by = 30),
                              lon = seq(-180, 180, by = 60)) |> 
sf::st_transform(crs = target_crs)

fig1 <- ggplot() +
  geom_sf(data = graticule, 
          color = "grey70") +
  geom_spatvector(
    data = open_sea_proj, 
    fill = NA, 
    color = "black", 
    linewidth = 0.3
  ) +
  geom_spatraster(data = shipless_areas_proj) +
  scale_fill_gradient(
    low = "transparent",
    high = "#00CDCD",
    na.value = "transparent",
    limits = c(1, 1),
    guide = "none"
  ) +
  geom_spatvector(
    data = mpa_proj,
    alpha = 0.7,
    fill = "lightgreen", 
    color = "lightgreen", 
    linewidth = 0.5
  ) +
  geom_spatvector(
    data = eez_proj, 
    fill = NA, 
    color = "black", 
    linewidth = 0.5,
    linetype = "dashed"
  ) +
  geom_spatvector(
    data = coast_proj, 
    fill = "lightgrey", 
    color = "black", 
    linewidth = 0.5
  ) +
  theme_void() +
  theme(panel.background = element_blank()) +
  geom_sf(data = bb, fill=NA, colour = "#B2B2B2" , linetype='solid', linewidth= 0.75)

#fig1

#Save
ggsave("NEW_fig1.pdf", fig1, width = 12, height = 6, dpi = 300)
ggsave("NEW_fig1.tiff", fig1, width = 12, height = 6, dpi = 300)

################################################################################
# Figure 2
################################################################################

source("config.R")

coastline <- terra::vect("shapes/continents_close_seas.shp")

biodiv_terciles <- terra::rast("rasters_15maio25/richness_class_20250203.tif")
ships_terciles <- terra::rast("rasters_15maio25/ship_class_20250203.tif")
bivariate_total <- terra::rast("final_bivariate/bivariate_global_20250129.tif")
areas_pma_ppa <- terra::rast("PMA_PPA_shipless_areas/priority_global_20250129.tif")

bb <- sf::st_union(sf::st_make_grid(sf::st_bbox(c(xmin = -180, xmax = 180, ymax = 90, ymin = -90), crs = sf::st_crs(4326)), n = 100))

#Project
target_crs <- "+proj=robin +over"
#
coast_proj <- terra::project(coastline, target_crs)
#
biodiv_terciles_proj <- project(biodiv_terciles, target_crs, method = "near")
ships_terciles_proj <- project(ships_terciles, target_crs, method = "near")
bivariate_total_proj <- project(bivariate_total, target_crs, method = "near")
areas_pma_ppa_proj <- project(areas_pma_ppa, target_crs, method = "near")
bb <- sf::st_transform(bb, target_crs)


#BIODIVERSITY --------------

# Convert raster to categorical
biodiv_terciles_proj <- terra::as.factor(biodiv_terciles_proj)

# Optional: set factor labels
levels(biodiv_terciles_proj) <- data.frame(
  ID = c(0, 1, 2),
  levels = c("Low", "Medium", "High")
)

# Define colors
biodiv_colors <- c(
  "Low" = "#f5f0f0",
  "Medium" = "#f3dc92",
  "High" = "#f3c935"
)

p1 <- ggplot() +
  geom_spatraster(data = biodiv_terciles_proj) +
  scale_fill_manual(
    values = biodiv_colors,
    na.value = "transparent",  # Keeps NA values transparent in the plot
    na.translate = FALSE,     # Removes NA from the legend
    name = NULL               # Removes legend title (optional)
  ) +
  geom_spatvector(
    data = coast_proj, 
    fill = "lightgrey", 
    color = "lightgrey", 
    linewidth = 0.8
  ) +
  labs(title = "Species Richness") +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5)  # This centers the title
  ) +
  geom_sf(data = bb, fill=NA, colour = "#B2B2B2" , linetype='solid', linewidth= 0.75)

#SHIPS --------------

# Convert raster to categorical
ships_terciles_proj <- terra::as.factor(ships_terciles_proj)

# Optional: set factor labels
levels(ships_terciles_proj) <- data.frame(
  ID = c(0, 1, 2),
  levels = c("Low", "Medium", "High")
)

# Define colors
# Define colors for each category
ships_colors <- c(
  "Low" = "#f5f0f0",
  "Medium" = "#8e8db2",
  "High" = "#282a74"
)

p2 <- ggplot() +
  geom_spatraster(data = ships_terciles_proj) +
  scale_fill_manual(
    values = ships_colors,
    na.value = "transparent",  # Keeps NA values transparent in the plot
    na.translate = FALSE,     # Removes NA from the legend
    name = NULL               # Removes legend title (optional)
  ) +
  geom_spatvector(
    data = coast_proj, 
    fill = "lightgrey", 
    color = "lightgrey", 
    linewidth = 0.8
  ) +
  labs(title = "Ship Density") +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5)  # This centers the title
  ) +
  geom_sf(data = bb, fill=NA, colour = "#B2B2B2" , linetype='solid', linewidth= 0.75)


#PPA/PMA --------------

# Convert raster to categorical
areas_pma_ppa_proj <- terra::as.factor(areas_pma_ppa_proj)

# Optional: set factor labels
levels(areas_pma_ppa_proj) <- data.frame(
  ID = c(1, 2),
  levels = c("PPA", "PMA")
)


# Define colors
# Define colors for each category
area_colors <- c(
  "PPA" = "#F3C935",
  "PMA" = "#A92C4E"
)

p3 <- ggplot() +
  geom_spatraster(data = areas_pma_ppa_proj) +
  scale_fill_manual(
    values = area_colors,
    na.value = "transparent",  # Keeps NA values transparent in the plot
    na.translate = FALSE,     # Removes NA from the legend
    name = NULL               # Removes legend title (optional)
  ) +
  geom_spatvector(
    data = coast_proj, 
    fill = "lightgrey", 
    color = "lightgrey", 
    linewidth = 0.8
  ) +
  labs(title = "Priority Areas") +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5)  # This centers the title
  ) +
  geom_sf(data = bb, fill=NA, colour = "#B2B2B2" , linetype='solid', linewidth= 0.75)


#BIVARIATE --------------

# Convert raster to categorical
bivariate_total_proj <- terra::as.factor(bivariate_total_proj)

# Define colors
bivariate_colors <- c(
  "1" = "#f5f0f0",
  "2" = "#f3dc92",
  "3" = "#F3C935",
  "7" = "#8e8db2",
  "8" = "#ad8379",
  "9" = "#ce7a41",
  "10" = "#282a74",
  "11" = "#682b61",
  "12" = "#a92c4e"
)

p4 <- ggplot() +
  geom_spatraster(data = bivariate_total_proj) +
  scale_fill_manual(
    values = bivariate_colors,
    na.value = "transparent",  # Keeps NA values transparent in the plot
    na.translate = FALSE,     # Removes NA from the legend
    name = NULL               # Removes legend title (optional)
  ) +
  geom_spatvector(
    data = coast_proj, 
    fill = "lightgrey", 
    color = "lightgrey", 
    linewidth = 0.8
  ) +
  labs(title = "Species Richness vs Ship Density") +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(hjust = 0.5)  # This centers the title
  ) +
  geom_sf(data = bb, fill=NA, colour = "#B2B2B2" , linetype='solid', linewidth= 0.75)


# Save as high-res PNG (or EPS)
ggsave("p1.pdf", p1, width = 12, height = 10, dpi = 300)
ggsave("p2.pdf", p2, width = 12, height = 10, dpi = 300)
ggsave("p3.pdf", p3, width = 12, height = 10, dpi = 300)
ggsave("p4.pdf", p4, width = 12, height = 10, dpi = 300)

################################################################################
# Figure 3
################################################################################

source("config.R")

# MPA --------------------------------------------------------------------------

#Load MPA vector
mpa <- terra::vect("shapes/WDPA_info.gpkg")
#mpa <- terra::aggregate(mpa, by="WDPA_ID")

#mpa_data_table <- data.frame(mpa)
#mpa_agg <- mpa
#mpa_agg$agg_value <- 1
#mpa_agg <- terra::aggregate(mpa_agg, by="agg_value")
#Save/Read
#writeVector(mpa_agg, "mpa_agg/MPA_aggregated.shp", overwrite =TRUE)
mpa_agg <- terra::vect("mpa_agg/MPA_aggregated.shp")

#Add area
mpa_area <- terra::expanse(mpa, "ha")
mpa$area_hectares <- mpa_area 
MPA_larger <- mpa[mpa$area_hectares > 100000,]
MPA_larger <- sf::st_as_sf(MPA_larger)

#Load rasters
bivmap.bin <- terra::rast("outputs_fernando_ships_13_maio_25\\bivariate_global_20250203.tif")
priority_global <- terra::rast("outputs_fernando_ships_13_maio_25\\priority_global_20250129.tif")
shipless_areas <- terra::rast("~/0. Artigos/4. SUBMETIDOS/shipless_areas/gis/last_files_fernando/shipless_global_20250129_RECLASS_FM.tif")

###---

MPA_shipless <- exact_extract(
  raster::raster(shipless_areas),
  MPA_larger,
  fun = function(df) {
    total_area <- sum(df$coverage_fraction, na.rm = TRUE)
    shipless_area <- sum(df$coverage_fraction[df$value == 1], na.rm = TRUE)
    fraction <- ifelse(total_area > 0, shipless_area / total_area, NA)
    data.frame(fraction_shipless = fraction)
  },
  include_cols = c("WDPA_ID", "WDPA_Name"),
  summarize_df = TRUE,
  progress = FALSE
)

MPA_larger_df <- data.frame(MPA_larger)
MPA_larger_df <- MPA_larger_df[,c("WDPA_ID", "WDPA_Name")]
MPA_shipless <- data.frame(MPA_larger_df, MPA_shipless)

write.csv(MPA_shipless, "MPA_shipless.csv")

###---

# Extract values and compute fractional coverage
MPA_info <- exact_extract(
  raster::raster(priority_global), 
  MPA_larger, 
  coverage_area = TRUE,
  fun = function(df) {
    df %>%
      mutate(frac_total = coverage_area / sum(coverage_area)) %>%
      group_by(WDPA_ID, value) %>%
      summarize(freq = sum(frac_total), .groups = "drop")
  }, 
  summarize_df = TRUE, 
  include_cols = "WDPA_ID", 
  progress = FALSE
)

# Recode value to descriptive labels
MPA_info2 <- MPA_info %>%
  rename(Priority_area = value) %>%
  mutate(Priority_area = recode(Priority_area, "1" = "PPA", "2" = "PMA"))

# Pivot to wide format: one column for each priority area
MPA_info2b <- MPA_info2 %>% 
  drop_na() %>%
  distinct(WDPA_ID, Priority_area, .keep_all = TRUE) %>%
  arrange(WDPA_ID) %>%
  group_by(WDPA_ID, Priority_area) %>%
  summarise(freq = sum(freq), .groups = "drop") %>% 
  pivot_wider(names_from = Priority_area, values_from = freq, values_fill = 0)

# Merge with original MPA attributes and replace NAs with 0
MPA_larger2 <- MPA_larger %>%
  st_drop_geometry() %>%
  select(WDPA_ID, WDPA_Name, area_hectares, WDPA_IUCN_cat) %>%
  distinct() %>%  
  left_join(MPA_info2b, by = "WDPA_ID") %>%
  mutate(
    PPA = replace_na(PPA, 0),
    PMA = replace_na(PMA, 0),
    PPA_percent = 100 * PPA,
    PMA_percent = 100 * PMA
  )
highlights <- MPA_larger2 %>%
  as_tibble() %>%
  filter(area_hectares > 40000000  & (PMA > 0.01 & PPA > 0.02) | (PMA > 0.3 & PPA > 0.3) | area_hectares > 9351271 & PMA > 0.8)  %>%
  arrange(PMA) %>%
  mutate(label=letters[1:nrow(.)])

# EEZ --------------------------------------------------------------------------

eez <- terra::vect("shapes/eez_aggregated.shp")
eez_area <- terra::expanse(eez, "ha")
eez$area_hectares <- eez_area 
eez <- sf::st_as_sf(eez)
eez <- eez %>% st_make_valid()

EEZ_info <- exact_extract(raster::raster(priority_global), 
                          eez, 
                          coverage_area = TRUE,
                          function(df) {df %>%
                              mutate(frac_total = coverage_area / sum(coverage_area)) %>%
                              group_by(MRGID, value) %>%
                              summarize(
                                freq = sum(frac_total))}, 
                          summarize_df = TRUE, 
                          include_cols = c('MRGID', "area_hectares"), 
                          progress = FALSE)

EEZ_info2 <- EEZ_info %>%
  dplyr::rename(Priority_area = value) %>%
  mutate(Priority_area = recode(Priority_area, 
                                "1" = "PPA", 
                                "2" = "PMA")) 

EEZ_info2b <- EEZ_info2 %>% 
  drop_na() %>%
  distinct(MRGID, Priority_area, .keep_all = TRUE) %>%
  group_by(MRGID, Priority_area) %>%
  summarise(freq = sum(freq)) %>% 
  spread(key=Priority_area, value=freq, fill = 0)

EEZ2 <- eez %>%
  st_drop_geometry() %>%
  dplyr::select(GEONAME, SOVEREIGN1 ,MRGID, area_hectares) %>%
  distinct() %>%  
  left_join(EEZ_info2b)%>%
  drop_na() %>%
  as_tibble()

#range(EEZ2$area_hectares)

highlights2 <- EEZ2 %>%
  as_tibble() %>%
  filter((PMA > 0.05 & PPA > 0.1)) %>%
  arrange(PMA) %>%
  mutate(label=letters[(nrow(highlights)+1):(nrow(highlights)+nrow(.))])

# OS ---------------------------------------------------------------------------

os <- terra::vect("shapes/Intersect_EEZ_IHO_v5_20241010_Fer.shp")
os_area <- terra::expanse(os, "ha")
os$area_hectares <- os_area 
os <- sf::st_as_sf(os)
os <- st_make_valid(os)

OS_info <- exact_extract(raster::raster(priority_global), 
                         os, 
                         coverage_area = TRUE,
                         function(df) {df %>%
                             mutate(frac_total = coverage_area / sum(coverage_area)) %>%
                             group_by(MRGID,MarRegion, area_hectares, value) %>%
                             summarize(
                               freq = sum(frac_total))}, 
                         summarize_df = TRUE, 
                         include_cols = c('MRGID', "MarRegion", "area_hectares"), 
                         progress = FALSE)

OS_info2 <- OS_info %>%
  dplyr::rename(Priority_area = value) %>%
  mutate(Priority_area = recode(Priority_area, 
                                "1" = "PPA", 
                                "2" = "PMA"))

OS_info2b <- OS_info2 %>% 
  drop_na() %>%
  distinct(MRGID, Priority_area, .keep_all = TRUE) %>%
  group_by(MRGID, Priority_area) %>%
  summarise(freq = sum(freq)) %>% 
  spread(key=Priority_area, value=freq, fill = 0)



OS_info2 <- OS_info %>%
  st_drop_geometry() %>%
  dplyr::select(MRGID, area_hectares) %>%
  distinct() %>%  
  left_join(OS_info2b)%>%
  drop_na() %>%
  as_tibble()

OS_info2$label <- gsub("High Seas of the ", "", OS_info2$MarRegion)
OS_info2$label <- gsub(" Ocean", "", OS_info2$label)

write.csv(MPA_larger2, "MPA_larger_areas.csv")
write.csv(EEZ2, "EEZ_areas.csv")
write.csv(OS_info2, "OS_areas.csv")


# Plots ------------------------------------------------------------------------

#MPA_larger2 <- read.csv("MPA_larger_areas.csv")
#EEZ2 <- read.csv("EEZ_areas.csv")
#OS_info2 <- read.csv("OS_areas.csv")

mpa <- ggplot(MPA_larger2, aes(PMA*100, PPA*100)) +
  geom_jitter(aes(size=area_hectares), col="darkgreen", alpha=.5) +
  geom_label_repel(data = highlights, aes(label=label),
                   box.padding = .8, max.overlaps = Inf) +
  scale_x_continuous(breaks = c(25, 50, 75)) +
  scale_y_continuous(breaks = c(25, 50, 75)) +
  labs(x=" ", y="Priority Preservation Areas (%)",
       title = "A) MPAs") +
  theme_minimal() +
  theme(legend.position = "none",
        text=element_text(size=14)) +
  guides(size="none")


###

EEZ <- ggplot(EEZ2, aes(PMA*100, PPA*100)) +
  geom_jitter(aes(size=area_hectares), col="#FF9326", alpha=.5) +
  labs(x="PMA (%)", y="PPA (%)") +
  scale_x_continuous(breaks = c(25, 50, 75)) +
  scale_y_continuous(breaks = c(25, 50, 75)) +
  labs(x="Priority Mitigation Areas (%)", y=" ", 
       title = "B) EEZ") +
  geom_label_repel(data = highlights2, aes(label=label),
                   box.padding = .8, max.overlaps = Inf) +
  theme_minimal() +
  theme(legend.position = "none",
        text=element_text(size=14)) +
  guides(size="none")

###

OS <- ggplot(OS_info2, aes(PMA*100, PPA*100, label=label)) +
  geom_point(size=3,col="blue", alpha=.5) +
  labs(x=" ", y=" ", 
       title = "C) High seas") +
  geom_label_repel(max.overlaps = Inf, box.padding = 2) +
  theme_minimal() +
  # xlim(-5,30) +
  # ylim(-5,30) +
  theme(legend.position = "none",
        text=element_text(size=14)) +
  guides(size="none")


# Join All -------------------------------------------------

grid.arrange(mpa, EEZ, OS, nrow=1)

ggsave("NEW_fig3.pdf", grid.arrange(mpa, EEZ, OS, nrow=1), width = 18, height = 6, dpi = 300)
ggsave("NEW_fig3.tiff", grid.arrange(mpa, EEZ, OS, nrow=1), width = 18, height = 6, dpi = 300)

save(mpa$data, EEZ$data, OS_$data, file = "figure3_plots.Rdata")

# Save
write.csv(MPA_larger2, "MPA_larger2.csv", row.names = F)
write.csv(EEZ2, "EEZ2.csv", row.names = F)
write.csv(OS_info2, "OS_info2.csv", row.names = F)

################################################################################
#               Annual temporal trend of shipless areas (Fig S1)
################################################################################

#FMestre
#06-01-2025

#Load package
library(terra)

#Clear environment
rm(list = ls())

#Define the working directory
setwd("~/github/shipless_areas")

#For resample
cetaceans_sr_raster <- terra::rast("cetaceans_sr_raster.tif")

#Load rasters
sum_all_2012 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2012.tif")
sum_all_2013 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2013.tif")
sum_all_2014 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2014.tif")
sum_all_2015 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2015.tif")
sum_all_2016 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2016.tif")
sum_all_2017 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2017.tif")
sum_all_2018 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2018.tif")
sum_all_2019 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2019.tif")
sum_all_2020 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2020.tif")
sum_all_2021 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2021.tif")
sum_all_2022 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2022.tif")
sum_all_2023 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2023.tif")

#Resample
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
continents <- terra::vect("shapes/continents_close_seas.shp")

# Create a mask using the vector
sum_all_2012_resampled_mask <- terra::mask(sum_all_2012_resampled, continents)
#plot(sum_all_2012_resampled_mask)

# Convert all values to NA outside the mask
sum_all_2012_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2013_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2014_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2015_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2016_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2017_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2018_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2019_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2020_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2021_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2022_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA
sum_all_2023_resampled[!is.na(sum_all_2012_resampled_mask)] <- NA

#log transform
#sum_all_2011_resampled_log <- log(sum_all_2011_resampled+1)
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
png("year_terciles/first_tercile_2011_2023_version2.png", width=5000, height=5000, units="px", pointsize=12)
par(mfrow=c(4,3), mar=c(2, 2, 4, 2)) # Adjust margins
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

