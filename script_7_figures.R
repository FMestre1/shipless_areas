################################################################################
#                                   Figures            
################################################################################

#load packages
library(ggplot2)
library(terra)
library(exactextractr)
library(ggrepel)
library(gridExtra)
library(dplyr)
library(tidyterra)
library(ggrepel)
library(ggprism)

################################################################################
#                     Convert bivariate maps to raster files
################################################################################

#FMestre
#25-10-2024

#Clear environment
rm(list = ls())

#Define the working directory
setwd("~/github/shipless_areas")

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
#                                 Overall Map
################################################################################

#library(terra)

#all_ships_vs_cetaceans_RASTER <- terra::rast("final_bivariate/all_ships_vs_cetaceans_BIVARIATE_02FEV25.tif")
#all_ships_vs_turtles_RASTER <- terra::rast("final_bivariate/all_ships_vs_turtles_BIVARIATE_02FEV25.tif")
#all_ships_vs_pinnipeds_RASTER <- terra::rast("final_bivariate/all_ships_vs_pinnipeds_BIVARIATE_02FEV25.tif")
#all_ships_vs_seabirds_RASTER <- terra::rast("final_bivariate/all_ships_vs_seabirds_BIVARIATE_02FEV25.tif")

#Define NA as zero
##all_ships_vs_cetaceans_RASTER[is.na(all_ships_vs_cetaceans_RASTER[])] <- 0 
##all_ships_vs_turtles_RASTER[is.na(all_ships_vs_turtles_RASTER[])] <- 0 
##all_ships_vs_pinnipeds_RASTER[is.na(all_ships_vs_pinnipeds_RASTER[])] <- 0 
##all_ships_vs_seabirds_RASTER[is.na(all_ships_vs_seabirds_RASTER[])] <- 0 

#plot(all_ships_vs_cetaceans_RASTER)
#plot(all_ships_vs_turtles_RASTER)
#plot(all_ships_vs_pinnipeds_RASTER)
#plot(all_ships_vs_seabirds_RASTER)

#all_hotspots <- all_ships_vs_cetaceans_RASTER +
#                all_ships_vs_turtles_RASTER +
#                all_ships_vs_pinnipeds_RASTER +
#                all_ships_vs_seabirds_RASTER

#plot(all_hotspots)
#terra::writeRaster(all_hotspots, filename = "all_hotspots_RASTER_02FEV25.tif")

#Make plot
#world <- rnaturalearth::ne_coastline(scale = "medium", returnclass = "sf")
#world <- terra::vect(world)

#plot(all_hotspots)
#plot(world, add=TRUE)

#tiff("all_hotspots.tif", width=5000, height=2900, res=300)
#plot(all_hotspots, col = c("#E1BFAC" ,"#A6626D", "#6B062F"))
#dev.off()


################################################################################
#                             MAP OF OVERALL RISKS
################################################################################

#FMestre
#29-11-2024

#Load package
library(terra)

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
#                         FOUR AXIS PLOT (not used)
################################################################################

#FMestre
#29-11-2024

#Load package
library(terra)
library(exactextractr)
library(ggplot2)

#Create table with percentage of area occupied by high ship density and 
#percentage of area with high biodiversity value

#Load species richness maps
cetaceans_sr_raster <- terra::rast("final_rasters/cetaceans_sr_raster_NA.tif")
testudines_sr_raster <- terra::rast("final_rasters/testudines_sr_raster_NA.tif")
pinnipeds_sr_raster <- terra::rast("final_rasters/pinnipeds_sr_raster_NA.tif")
seabirds_sr_raster_resampled_cropped_ext <- terra::rast("final_rasters/seabirds_sr_raster_resampled_cropped_ext_NA.tif")

#Convert NA to 0
#cetaceans_sr_raster[is.na(cetaceans_sr_raster[])] <- 0 
#testudines_sr_raster[is.na(testudines_sr_raster[])] <- 0 
#pinnipeds_sr_raster[is.na(pinnipeds_sr_raster[])] <- 0 
#seabirds_sr_raster_resampled_cropped_ext[is.na(seabirds_sr_raster_resampled_cropped_ext[])] <- 0 
biodiv <- cetaceans_sr_raster + testudines_sr_raster + pinnipeds_sr_raster + seabirds_sr_raster_resampled_cropped_ext

all_summed_resampled_NA <- terra::rast("final_rasters/all_summed_resampled_no_2011_NA.tif")

#Reclassify biodiversity and ships with quartiles
#Isolate >75%

quartiles_ships <- quantile(values(all_summed_resampled_NA), probs = c(1/4, 2/4,3/4), na.rm = TRUE)
quartiles_biodiversity <- quantile(values(biodiv), probs = c(1/4, 2/4,3/4), na.rm = TRUE)

class_matrix_all_ships <- matrix(c(0, quartiles_ships[1], 1,  # First quartile
                                   quartiles_ships[1], quartiles_ships[2], 2,  # Second quartile
                                   quartiles_ships[2], quartiles_ships[3], 3,  # Third quartile
                                   quartiles_ships[3], as.numeric(global(all_summed_resampled_NA, fun=max, na.rm=TRUE)), 4),  # Fourth quartile
                                 ncol = 3, byrow = TRUE)


class_matrix_bidiversity <- matrix(c(-1, quartiles_biodiversity[1], 1,  # First quartile
                                     quartiles_biodiversity[1], quartiles_biodiversity[2], 2,  # Second quartile
                                     quartiles_biodiversity[2], quartiles_biodiversity[3], 3,  # Third quartile
                                     quartiles_biodiversity[3], as.numeric(global(biodiv, fun=max, na.rm=TRUE)), 4),  # Fourth quartile
                                   ncol = 3, byrow = TRUE)


quartiles_reclassified_ships <- terra::classify(all_summed_resampled_NA, class_matrix_all_ships)
quartiles_reclassified_biodiversity <- terra::classify(biodiv, class_matrix_bidiversity)

terra::writeRaster(quartiles_reclassified_ships, "quartiles_reclassified_ships_02FEV25.tif")
terra::writeRaster(quartiles_reclassified_biodiversity, "quartiles_reclassified_biodiversity_02FEV25.tif")

#Extract per EEZ
eez <- terra::vect("eez.shp")
eez_grouped <- aggregate(eez, by = "SOVEREIGN1")
eez_grouped_sf <- sf::st_as_sf(eez_grouped)

fraction_ships <- exactextractr::exact_extract(quartiles_reclassified_ships, eez_grouped_sf, "frac", progress = TRUE)
fraction_biodiv <- exactextractr::exact_extract(quartiles_reclassified_biodiversity, eez_grouped_sf, "frac", progress = TRUE)

names(fraction_ships) <- paste0("ships_", names(fraction_ships))
names(fraction_biodiv) <- paste0("biodiv_", names(fraction_biodiv))

eez_grouped_df <- data.frame(eez_grouped)
data_for_plot <- data.frame(eez_grouped_df[,c(1,30)], fraction_biodiv, fraction_ships)
data_for_plot2 <- data.frame(data_for_plot[,1:2],data_for_plot[,-c(1,2)]*100)
names(data_for_plot2)[1] <- "country"
names(data_for_plot2)[2] <- "iso_code"
#View(data_for_plot2)

#Removing "Azerbaijan", "Kazakhstan", "Turkmenistan"
data_for_plot3 <- data_for_plot2[-c(7, 72, 146),]
View(data_for_plot3)

#Save
write.csv(data_for_plot3, "data_for_plot_04DEZ.csv")
#data_for_plot3 <- read.csv("data_for_plot_04DEZ.csv")

#Save plot
png(file="four_axis_plot4.png", width=1000, height=1000)
ggplot(data_for_plot3, aes(x = ships_frac_4, y = biodiv_frac_4, label = iso_code)) +
  xlim(0, 125) +
  #geom_text(size = 3, color = "darkblue") +
  geom_text_repel(size = 3, max.overlaps = Inf) +  # Use geom_text_repel for readable text
  #geom_text_repel(size = 3, max.overlaps = Inf) +
  geom_hline(yintercept = 50, linetype = "dashed") +
  geom_vline(xintercept = 50, linetype = "dashed") +
  labs(x = "Ship Density", y = "Biodiversity") +
  theme_minimal()
dev.off()



## SECOND VERSION -------------------------------------------------------------------------------------------------------------------------------------------

#FAscensão & FMestre
#13-05-2025

################################################################################
# Figure 1
################################################################################

rm(list=ls())

coastline <- terra::vect("shapes/continents_close_seas.shp")

bb <- sf::st_union(sf::st_make_grid(sf::st_bbox(c(xmin = -180, xmax = 180, ymax = 90, ymin = -90), crs = sf::st_crs(4326)), n = 100))

shipless_areas <- terra::rast("~/0. Artigos/4. SUBMETIDOS/shipless_areas/gis/last_files_fernando/shipless_global_20250129_RECLASS_FM.tif")
mpa <- terra::vect("C:/Users/mestr/Documents/github/shipless_areas/shapes/mpa.shp")
eez <- terra::vect("C:/Users/mestr/Documents/github/shipless_areas/shapes/eez_aggregated.shp")
open_sea <- terra::vect("C:/Users/mestr/Documents/github/shipless_areas/shapes/goas_fm.shp")

#Project
target_crs <- "+proj=robin +over"
#
shipless_areas_proj <- project(shipless_areas, target_crs, method = "near")
#
coast_proj <- terra::project(coastline, target_crs)
mpa_proj <- terra::project(mpa, target_crs)
eez_proj <- terra::project(eez, target_crs)
open_sea_proj <- terra::project(open_sea, target_crs)
#
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
    linetype = "dotted"
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

fig1

#Save
ggsave("fig1.svg", fig1, width = 12, height = 10, dpi = 300)

################################################################################
# Figure 2
################################################################################

rm(list=ls())

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

rm(list=ls())

# MPA ------------------------------------------------

MPA_larger <- st_read("shapes/MPA_Fer_larger.shp")
gc()

bivmap <- rast("bivariate_global_20241203.tif")
bivmap.bin <- rast("priority_global_20241203.tif")


MPA_info <- exact_extract(bivmap.bin, 
                          MPA_larger, 
                          coverage_area = TRUE,
                          function(df) {df %>%
                              mutate(frac_total = coverage_area / sum(coverage_area)) %>%
                              group_by(WDPAID, value) %>%
                              summarize(#total_area = sum(coverage_area)/10000,
                                freq = sum(frac_total))}, 
                          summarize_df = TRUE, 
                          include_cols = 'WDPAID', 
                          progress = FALSE)

(MPA_info2 <- MPA_info %>%
    dplyr::rename(Priority_area = value) %>%
    mutate(Priority_area = recode(Priority_area, 
                                  "1" = "PPA", 
                                  "2" = "PMA"))) 

(MPA_info2b <- MPA_info2 %>% 
    drop_na() %>%
    distinct(WDPAID, Priority_area, .keep_all = TRUE) %>%
    arrange(WDPAID) %>%
    group_by(WDPAID, Priority_area) %>%
    summarise(freq = sum(freq)) %>% 
    arrange(WDPAID) %>%
    spread(key=Priority_area, value=freq, fill = 0))


MPA_larger2 <- MPA_larger %>%
  st_drop_geometry() %>%
  dplyr::select(WDPAID, NAME, AreaFer_ha,IUCN_CAT) %>%
  distinct() %>%  
  left_join(MPA_info2b) %>%
  mutate(IUCN_CAT = recode(IUCN_CAT, 
                           "Not Assigned" = "Other", 
                           "Not Applicable" = "Other", 
                           "Not Reported" = "Other", 
                           "III" = "Other",  
                           "IV" = "Other", 
                           "V" = "Other", 
                           "VI" = "Other"))

highlights <- MPA_larger2 %>%
    as_tibble() %>%
    filter((AreaFer_ha > 5e7 & PMA>.5) | (AreaFer_ha > 10e7 & PPA > 0.5)) %>%
    arrange(PMA) %>%
    mutate(label=letters[1:nrow(.)])


# EEZ ------------------------------------------------

eez <- st_read("shapes/eez_zonal.shp")
eez <- eez %>% st_make_valid()

EEZ_info <- exact_extract(bivmap.bin, 
                          eez, 
                          coverage_area = TRUE,
                          function(df) {df %>%
                              mutate(frac_total = coverage_area / sum(coverage_area)) %>%
                              group_by(MRGID, value) %>%
                              summarize(#total_area = sum(coverage_area)/10000,
                                freq = sum(frac_total))}, 
                          summarize_df = TRUE, 
                          include_cols = c('MRGID', "AREA_KM2"), 
                          progress = FALSE)

# 1 --> PPA
# 2 --> PMA

(EEZ_info2 <- EEZ_info %>%
    dplyr::rename(Priority_area = value) %>%
    mutate(Priority_area = recode(Priority_area, 
                                  "1" = "PPA", 
                                  "2" = "PMA"))) 

(EEZ_info2b <- EEZ_info2 %>% 
    drop_na() %>%
    distinct(MRGID, Priority_area, .keep_all = TRUE) %>%
    group_by(MRGID, Priority_area) %>%
    summarise(freq = sum(freq)) %>% 
    spread(key=Priority_area, value=freq, fill = 0))



(EEZ2 <- eez %>%
    st_drop_geometry() %>%
    dplyr::select(GEONAME, SOVEREIGN1 ,MRGID, AREA_KM2) %>%
    mutate(AreaFer_ha = as.numeric(AREA_KM2*100)) %>%
    distinct() %>%  
    left_join(EEZ_info2b)%>%
    drop_na() %>%
    as_tibble()) 

range(EEZ2$AreaFer_ha)

highlights2 <- EEZ2 %>%
    as_tibble() %>%
    filter((AreaFer_ha > 1e8 & PMA>.8) | (AreaFer_ha > 1e8 & PPA > 0.43)) %>%
    arrange(PMA) %>%
    mutate(label=letters[(nrow(highlights)+1):(nrow(highlights)+nrow(.))])


# OS -------------------------------------------------

os <- st_read("shapes/Intersect_EEZ_IHO_v5_20241010_Fer.shp")

os <- os %>%
  st_make_valid() 

OS_info <- exact_extract(bivmap.bin, 
                         os, 
                         coverage_area = TRUE,
                         function(df) {df %>%
                             mutate(frac_total = coverage_area / sum(coverage_area)) %>%
                             group_by(MRGID,MarRegion, AREA_KM2, value) %>%
                             summarize(#total_area = sum(coverage_area)/10000,
                               freq = sum(frac_total))}, 
                         summarize_df = TRUE, 
                         include_cols = c('MRGID', "MarRegion", "AREA_KM2"), 
                         progress = FALSE)

# 1 --> PPA
# 2 --> PMA


(OS_info2 <- OS_info %>%
    dplyr::rename(Priority_area = value) %>%
    mutate(Priority_area = recode(Priority_area, 
                                  "1" = "PPA", 
                                  "2" = "PMA"))) 

(OS_info2b <- OS_info2 %>% 
    drop_na() %>%
    distinct(MRGID, Priority_area, .keep_all = TRUE) %>%
    group_by(MRGID, Priority_area) %>%
    summarise(freq = sum(freq)) %>% 
    spread(key=Priority_area, value=freq, fill = 0))



(OS_info2 <- OS_info %>%
    st_drop_geometry() %>%
    dplyr::select(MRGID, AREA_KM2) %>%
    mutate(AreaFer_ha = as.numeric(AREA_KM2*100)) %>%
    distinct() %>%  
    left_join(OS_info2b)%>%
    drop_na() %>%
    as_tibble()) 

OS_info2$label <- gsub("High Seas of the ", "", OS_info2$MarRegion)
OS_info2$label <- gsub(" Ocean", "", OS_info2$label)


# Plots -------------------------------------------------

MPA_larger2 <- read.csv("MPA_larger_shipless.csv")
EEZ2 <- read.csv("EEZ_shipless.csv")
OS_info2 <- read.csv("OS_shipless.csv")

mpa <- ggplot(MPA_larger2, aes(PMA*100, PPA*100)) +
   # geom_point(aes(size=AreaFer_ha, col=IUCN_CAT), alpha=.5) +
   geom_jitter(aes(size=AreaFer_ha), col="darkgreen", alpha=.5) +
   # scale_color_brewer("IUCN cat", palette = "Set1") +
   geom_label_repel(data = highlights, aes(label=label),
                     box.padding = .8, max.overlaps = Inf) +
   scale_x_continuous(breaks = c(25, 50, 75)) +
   scale_y_continuous(breaks = c(25, 50, 75)) +
   # labs(x="Area priority for mitigation (%)", y="Area priority\nfor preservation (%)",
   #      title = "A) MPAs") +
   labs(x=" ", y="Priority Preservation Areas (%)",
        title = "A) MPAs") +
   theme_minimal() +
   theme(legend.position = "none",
         text=element_text(size=14)) +
   guides(size="none")

###

EEZ <- ggplot(EEZ2, aes(PMA*100, PPA*100)) +
   geom_jitter(aes(size=AreaFer_ha), col="#FF9326", alpha=.5) +
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

ggsave("fig3.pdf", grid.arrange(mpa, EEZ, OS, nrow=1), width = 18, height = 8, dpi = 300)

#ggsave(plot=grid.arrange(mpa, EEZ, OS, nrow=1), "MPA_EEZ_HS_20250513.tiff",
#       device=grDevices::tiff,
#       width = 18, height = 8, units= "cm", dpi = 300)

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
continents <- terra::vect("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/continents_close_seas.shp")

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

