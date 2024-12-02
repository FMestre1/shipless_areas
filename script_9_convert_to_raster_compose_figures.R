################################################################################
#                     Convert these maps to raster files
################################################################################

#FMestre
#25-10-2024

#Load package
library(terra)

################################################################################
#                                   Ceteceans
################################################################################

########## 1. All ships ##########

#Get a raster to be the template
all_summed_resampled <- terra::rast("all_summed_resampled.tif")

#Convert
all_ships_vs_cetaceans_df <- as.data.frame(all_ships_vs_cetaceans)
all_ships_vs_cetaceans_df_vect <- terra::vect(all_ships_vs_cetaceans_df, geom = c("x", "y"))
all_ships_vs_cetaceans_RASTER <- terra::rasterize(all_ships_vs_cetaceans_df_vect, 
                                           all_summed_resampled, 
                                           field = "BivValue", 
                                           fun = "mean")

#Save
terra::writeRaster(all_ships_vs_cetaceans_RASTER, filename = "final_bivariate/all_ships_vs_cetaceans_BIVARIATE_02DEZ.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_cetaceans_df <- as.data.frame(cargo_vs_cetaceans)
cargo_vs_cetaceans_vect <- terra::vect(cargo_vs_cetaceans_df, geom = c("x", "y"))
cargo_vs_cetaceans_RASTER <- terra::rasterize(cargo_vs_cetaceans_vect, 
                                             all_summed_resampled, 
                                             field = "BivValue", 
                                             fun = "mean")
#Save
terra::writeRaster(cargo_vs_cetaceans_RASTER, filename = "final_bivariate/cargo_vs_cetaceans_BIVARIATE_02DEZ.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_cetaceans_df <- as.data.frame(fishing_ships_vs_cetaceans)
fishing_vs_cetaceans_vect <- terra::vect(fishing_vs_cetaceans_df, geom = c("x", "y"))
fishing_vs_cetaceans_RASTER <- terra::rasterize(fishing_vs_cetaceans_vect, 
                                              all_summed_resampled, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(fishing_vs_cetaceans_RASTER, filename = "final_bivariate/fishing_vs_cetaceans_BIVARIATE_02DEZ.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_cetaceans_df <- as.data.frame(tankers_vs_cetaceans)
tankers_vs_cetaceans_vect <- terra::vect(tankers_vs_cetaceans_df, geom = c("x", "y"))
tankers_vs_cetaceans_RASTER <- terra::rasterize(tankers_vs_cetaceans_vect, 
                                                all_summed_resampled, 
                                                field = "BivValue", 
                                                fun = "mean")
#Save
terra::writeRaster(tankers_vs_cetaceans_RASTER, filename = "final_bivariate/tankers_vs_cetaceans_BIVARIATE_02DEZ.tif")

################################################################################
#                                   Sea Turtles
################################################################################

########## 1. All ships ##########

#Convert
all_ships_vs_turtles_df <- as.data.frame(all_ships_vs_turtles)
all_ships_vs_turtles_df_vect <- terra::vect(all_ships_vs_turtles_df, geom = c("x", "y"))
all_ships_vs_turtles_RASTER <- terra::rasterize(all_ships_vs_turtles_df_vect, 
                                                all_summed_resampled, 
                                                field = "BivValue", 
                                                fun = "mean")

#Save
terra::writeRaster(all_ships_vs_turtles_RASTER, filename = "final_bivariate/all_ships_vs_turtles_BIVARIATE_02DEZ.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_turtles_df <- as.data.frame(cargo_vs_turtles)
cargo_vs_turtles_vect <- terra::vect(cargo_vs_turtles_df, geom = c("x", "y"))
cargo_vs_turtles_RASTER <- terra::rasterize(cargo_vs_turtles_vect, 
                                            all_summed_resampled, 
                                            field = "BivValue", 
                                            fun = "mean")
#Save
terra::writeRaster(cargo_vs_turtles_RASTER, filename = "final_bivariate/cargo_vs_turtles_BIVARIATE_02DEZ.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_turtles_df <- as.data.frame(fishing_vs_turtles)
fishing_vs_turtles_vect <- terra::vect(fishing_vs_turtles_df, geom = c("x", "y"))
fishing_vs_turtles_RASTER <- terra::rasterize(fishing_vs_turtles_vect, 
                                              all_summed_resampled, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(fishing_vs_turtles_RASTER, filename = "final_bivariate/fishing_vs_turtles_BIVARIATE_02DEZ.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_turtles_df <- as.data.frame(tankers_vs_turtles)
tankers_vs_turtles_vect <- terra::vect(tankers_vs_turtles_df, geom = c("x", "y"))
tankers_vs_turtles_RASTER <- terra::rasterize(tankers_vs_turtles_vect, 
                                              all_summed_resampled, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(tankers_vs_turtles_RASTER, filename = "final_bivariate/tankers_vs_turtles_BIVARIATE_02DEZ.tif")

################################################################################
#                                   Pinnipeds
################################################################################

########## 1. All ships ##########

#Convert
all_ships_vs_pinnipeds_df <- as.data.frame(all_ships_vs_pinnipeds)
all_ships_vs_pinnipeds_df_vect <- terra::vect(all_ships_vs_pinnipeds_df, geom = c("x", "y"))
all_ships_vs_pinnipeds_RASTER <- terra::rasterize(all_ships_vs_pinnipeds_df_vect, 
                                                  all_summed_resampled, 
                                                  field = "BivValue", 
                                                  fun = "mean")

#Save
terra::writeRaster(all_ships_vs_pinnipeds_RASTER, filename = "final_bivariate/all_ships_vs_pinnipeds_BIVARIATE_02DEZ.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_pinnipeds_df <- as.data.frame(cargo_vs_pinnipeds)
cargo_vs_pinnipeds_vect <- terra::vect(cargo_vs_pinnipeds_df, geom = c("x", "y"))
cargo_vs_pinnipeds_RASTER <- terra::rasterize(cargo_vs_pinnipeds_vect, 
                                              all_summed_resampled, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(cargo_vs_pinnipeds_RASTER, filename = "final_bivariate/cargo_vs_pinnipeds_BIVARIATE_02DEZ.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_pinnipeds_df <- as.data.frame(fishing_vs_pinnipeds)
fishing_vs_pinnipeds_vect <- terra::vect(fishing_vs_pinnipeds_df, geom = c("x", "y"))
fishing_vs_pinnipeds_RASTER <- terra::rasterize(fishing_vs_pinnipeds_vect, 
                                                all_summed_resampled, 
                                                field = "BivValue", 
                                                fun = "mean")
#Save
terra::writeRaster(fishing_vs_pinnipeds_RASTER, filename = "final_bivariate/fishing_vs_pinnipeds_BIVARIATE_02DEZ.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_pinnipeds_df <- as.data.frame(tankers_vs_pinnipeds)
tankers_vs_pinnipeds_vect <- terra::vect(tankers_vs_pinnipeds_df, geom = c("x", "y"))
tankers_vs_pinnipeds_RASTER <- terra::rasterize(tankers_vs_pinnipeds_vect, 
                                                all_summed_resampled, 
                                                field = "BivValue", 
                                                fun = "mean")
#Save
terra::writeRaster(tankers_vs_pinnipeds_RASTER, filename = "final_bivariate/tankers_vs_pinnipeds_BIVARIATE_02DEZ.tif")

################################################################################
#                                   Sea Birds
################################################################################

########## 1. All ships ##########

#Convert
all_ships_vs_seabirds_df <- as.data.frame(all_ships_vs_seabirds)
all_ships_vs_seabirds_df_vect <- terra::vect(all_ships_vs_seabirds_df, geom = c("x", "y"))
all_ships_vs_seabirds_RASTER <- terra::rasterize(all_ships_vs_seabirds_df_vect, 
                                                 all_summed_resampled, 
                                                 field = "BivValue", 
                                                 fun = "mean")

#Save
terra::writeRaster(all_ships_vs_seabirds_RASTER, filename = "final_bivariate/all_ships_vs_seabirds_BIVARIATE_02DEZ.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_seabirds_df <- as.data.frame(cargo_vs_seabirds)
cargo_vs_seabirds_vect <- terra::vect(cargo_vs_seabirds_df, geom = c("x", "y"))
cargo_vs_seabirds_RASTER <- terra::rasterize(cargo_vs_seabirds_vect, 
                                             all_summed_resampled, 
                                             field = "BivValue", 
                                             fun = "mean")
#Save
terra::writeRaster(cargo_vs_seabirds_RASTER, filename = "final_bivariate/cargo_vs_seabirds_BIVARIATE_02DEZ.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_seabirds_df <- as.data.frame(fishing_vs_seabirds)
fishing_vs_seabirds_vect <- terra::vect(fishing_vs_seabirds_df, geom = c("x", "y"))
fishing_vs_seabirds_RASTER <- terra::rasterize(fishing_vs_seabirds_vect, 
                                               all_summed_resampled, 
                                               field = "BivValue", 
                                               fun = "mean")
#Save
terra::writeRaster(fishing_vs_seabirds_RASTER, filename = "final_bivariate/fishing_vs_seabirds_BIVARIATE_02DEZ.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_seabirds_df <- as.data.frame(tankers_vs_seabirds)
tankers_vs_seabirds_vect <- terra::vect(tankers_vs_seabirds_df, geom = c("x", "y"))
tankers_vs_seabirds_RASTER <- terra::rasterize(tankers_vs_seabirds_vect, 
                                               all_summed_resampled, 
                                               field = "BivValue", 
                                               fun = "mean")
#Save
terra::writeRaster(tankers_vs_seabirds_RASTER, filename = "final_bivariate/tankers_vs_seabirds_BIVARIATE_02DEZ.tif")

################################################################################
#                                 Overall Map
################################################################################


#library(terra)

#all_ships_vs_cetaceans_RASTER <- terra::rast("final_bivariate/all_ships_vs_cetaceans_BIVARIATE_02DEZ.tif")
#all_ships_vs_turtles_RASTER <- terra::rast("final_bivariate/all_ships_vs_turtles_BIVARIATE_02DEZ.tif")
#all_ships_vs_pinnipeds_RASTER <- terra::rast("final_bivariate/all_ships_vs_pinnipeds_BIVARIATE_02DEZ.tif")
#all_ships_vs_seabirds_RASTER <- terra::rast("final_bivariate/all_ships_vs_seabirds_BIVARIATE_02DEZ.tif")

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
#terra::writeRaster(all_hotspots, filename = "all_hotspots_RASTER_02DEZ.tif")

#Make plot
#world <- rnaturalearth::ne_coastline(scale = "medium", returnclass = "sf")
#world <- terra::vect(world)

#plot(all_hotspots)
#plot(world, add=TRUE)

#tiff("all_hotspots.tif", width=5000, height=2900, res=300)
#plot(all_hotspots, col = c("#E1BFAC" ,"#A6626D", "#6B062F"))
#dev.off()


################################################################################
#                          MAP OF OVERALL RISKS
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
all_summed_resampled <- terra::rast("final_rasters/all_summed_resampled_NA.tif")
all_summed_resampled_log <- log10(all_summed_resampled+1) #Log transform

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
all_summed__standardized <- (all_summed_resampled_log - terra::minmax(all_summed_resampled_log)[1]) / (terra::minmax(all_summed_resampled_log)[2] - terra::minmax(all_summed_resampled_log)[1])

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
terra::writeRaster(overall_conflict_standardized, "overall_conflict_standardized2_02DEZ.tif", overwrite=TRUE)
#overall_conflict_standardized  <- terra::rast("overall_conflict_standardized2_02DEZ.tif")

################################################################################
#                                 FOUR AXIS PLOT
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

all_summed_resampled <- terra::rast("final_rasters/all_summed_resampled_NA.tif")

#Reclassify biodiversity and ships with quartiles
#Isolate >75%

quartiles_ships <- quantile(values(all_summed_resampled), probs = c(1/4, 2/4,3/4), na.rm = TRUE)
quartiles_biodiversity <- quantile(values(biodiv), probs = c(1/4, 2/4,3/4), na.rm = TRUE)

class_matrix_all_ships <- matrix(c(0, quartiles_ships[1], 1,  # First quartile
                                   quartiles_ships[1], quartiles_ships[2], 2,  # Second quartile
                                   quartiles_ships[2], quartiles_ships[3], 3,  # Third quartile
                                   quartiles_ships[3], as.numeric(global(all_summed_resampled, fun=max, na.rm=TRUE)), 4),  # Fourth quartile
                                   ncol = 3, byrow = TRUE)


class_matrix_bidiversity <- matrix(c(-1, quartiles_biodiversity[1], 1,  # First quartile
                                     quartiles_biodiversity[1], quartiles_biodiversity[2], 2,  # Second quartile
                                     quartiles_biodiversity[2], quartiles_biodiversity[3], 3,  # Third quartile
                                     quartiles_biodiversity[3], as.numeric(global(biodiv, fun=max, na.rm=TRUE)), 4),  # Fourth quartile
                                     ncol = 3, byrow = TRUE)


quartiles_reclassified_ships <- terra::classify(all_summed_resampled, class_matrix_all_ships)
quartiles_reclassified_biodiversity <- terra::classify(biodiv, class_matrix_bidiversity)

terra::writeRaster(quartiles_reclassified_ships, "quartiles_reclassified_ships_02DEZ.tif")
terra::writeRaster(quartiles_reclassified_biodiversity, "quartiles_reclassified_biodiversity_02DEZ.tif")

#Extract per EEZ
eez <- terra::vect("eez.shp")
eez_grouped <- aggregate(eez, by = "SOVEREIGN1")
eez_grouped_sf <- sf::st_as_sf(eez_grouped)

fraction_ships <- exactextractr::exact_extract(quartiles_reclassified_ships, eez_grouped_sf, "frac", progress = TRUE)
fraction_biodiv <- exactextractr::exact_extract(quartiles_reclassified_biodiversity, eez_grouped_sf, "frac", progress = TRUE)

names(fraction_ships) <- paste0("ships_", names(fraction_ships))
names(fraction_biodiv) <- paste0("biodiv_", names(fraction_biodiv))

data_for_plot <- data.frame(eez_grouped_df[,1], fraction_biodiv, fraction_ships)
eez_grouped_df <- data.frame(eez_grouped)
data_for_plot <- data.frame(eez_grouped_df[,1],data_for_plot[,-1]*100)
names(data_for_plot)[1] <- "country"

View(data_for_plot)


#Removing "Azerbaijan", "Kazakhstan", "Turkmenistan"
data_for_plot <- data_for_plot[-c(7, 72, 146),]

#Save
write.csv(data_for_plot, "data_for_plot_02DEZ.csv")
#data_for_plot <- read.csv("data_for_plot_02DEZ.csv")

#Plot
png(file="four_axis_plot2.png", width=800, height=800)
ggplot(data_for_plot, aes(x = ships_frac_4, y = biodiv_frac_4, label = X)) +
  geom_point(size = 3, color = "darkblue") +
  geom_hline(yintercept = 50, linetype = "dashed") +
  geom_vline(xintercept = 50, linetype = "dashed") +
  labs(x = "Ship Density", y = "Biodiversity") +
  geom_text(hjust = 1.5, vjust = 0, size = 3) +  # Add labels
  theme_minimal()
dev.off()

################################################################################

library(ggrepel)

png(file="four_axis_plot3.png", width=800, height=800)
ggplot(data_for_plot, aes(x = ships_frac_4, y = biodiv_frac_4, label = X)) +
  geom_point(size = 3, color = "darkblue") +
  geom_hline(yintercept = 50, linetype = "dashed") +
  geom_vline(xintercept = 50, linetype = "dashed") +
  labs(x = "Ship Density", y = "Biodiversity") +
  geom_text_repel(hjust = 1.5, vjust = 0, size = 3, max.overlaps = Inf) +  # Add labels using ggrepel
  theme_minimal()
dev.off()
