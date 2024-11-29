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
terra::writeRaster(all_ships_vs_cetaceans_RASTER, filename = "all_ships_vs_cetaceans_BIVARIATE.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_cetaceans_df <- as.data.frame(cargo_vs_cetaceans)
cargo_vs_cetaceans_vect <- terra::vect(cargo_vs_cetaceans_df, geom = c("x", "y"))
cargo_vs_cetaceans_RASTER <- terra::rasterize(cargo_vs_cetaceans_vect, 
                                             all_summed_resampled, 
                                             field = "BivValue", 
                                             fun = "mean")
#Save
terra::writeRaster(cargo_vs_cetaceans_RASTER, filename = "cargo_vs_cetaceans_BIVARIATE.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_cetaceans_df <- as.data.frame(fishing_ships_vs_cetaceans)
fishing_vs_cetaceans_vect <- terra::vect(fishing_vs_cetaceans_df, geom = c("x", "y"))
fishing_vs_cetaceans_RASTER <- terra::rasterize(fishing_vs_cetaceans_vect, 
                                              all_summed_resampled, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(fishing_vs_cetaceans_RASTER, filename = "fishing_vs_cetaceans_BIVARIATE.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_cetaceans_df <- as.data.frame(tankers_vs_cetaceans)
tankers_vs_cetaceans_vect <- terra::vect(tankers_vs_cetaceans_df, geom = c("x", "y"))
tankers_vs_cetaceans_RASTER <- terra::rasterize(tankers_vs_cetaceans_vect, 
                                                all_summed_resampled, 
                                                field = "BivValue", 
                                                fun = "mean")
#Save
terra::writeRaster(tankers_vs_cetaceans_RASTER, filename = "tankers_vs_cetaceans_BIVARIATE.tif")

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
terra::writeRaster(all_ships_vs_turtles_RASTER, filename = "all_ships_vs_turtles_BIVARIATE.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_turtles_df <- as.data.frame(cargo_vs_turtles)
cargo_vs_turtles_vect <- terra::vect(cargo_vs_turtles_df, geom = c("x", "y"))
cargo_vs_turtles_RASTER <- terra::rasterize(cargo_vs_turtles_vect, 
                                            all_summed_resampled, 
                                            field = "BivValue", 
                                            fun = "mean")
#Save
terra::writeRaster(cargo_vs_turtles_RASTER, filename = "cargo_vs_turtles_BIVARIATE.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_turtles_df <- as.data.frame(fishing_vs_turtles)
fishing_vs_turtles_vect <- terra::vect(fishing_vs_turtles_df, geom = c("x", "y"))
fishing_vs_turtles_RASTER <- terra::rasterize(fishing_vs_turtles_vect, 
                                              all_summed_resampled, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(fishing_vs_turtles_RASTER, filename = "fishing_vs_turtles_BIVARIATE.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_turtles_df <- as.data.frame(tankers_vs_turtles)
tankers_vs_turtles_vect <- terra::vect(tankers_vs_turtles_df, geom = c("x", "y"))
tankers_vs_turtles_RASTER <- terra::rasterize(tankers_vs_turtles_vect, 
                                              all_summed_resampled, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(tankers_vs_turtles_RASTER, filename = "tankers_vs_turtles_BIVARIATE.tif")

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
terra::writeRaster(all_ships_vs_pinnipeds_RASTER, filename = "all_ships_vs_pinnipeds_BIVARIATE.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_pinnipeds_df <- as.data.frame(cargo_vs_pinnipeds)
cargo_vs_pinnipeds_vect <- terra::vect(cargo_vs_pinnipeds_df, geom = c("x", "y"))
cargo_vs_pinnipeds_RASTER <- terra::rasterize(cargo_vs_pinnipeds_vect, 
                                              all_summed_resampled, 
                                              field = "BivValue", 
                                              fun = "mean")
#Save
terra::writeRaster(cargo_vs_pinnipeds_RASTER, filename = "cargo_vs_pinnipeds_BIVARIATE.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_pinnipeds_df <- as.data.frame(fishing_vs_pinnipeds)
fishing_vs_pinnipeds_vect <- terra::vect(fishing_vs_pinnipeds_df, geom = c("x", "y"))
fishing_vs_pinnipeds_RASTER <- terra::rasterize(fishing_vs_pinnipeds_vect, 
                                                all_summed_resampled, 
                                                field = "BivValue", 
                                                fun = "mean")
#Save
terra::writeRaster(fishing_vs_pinnipeds_RASTER, filename = "fishing_vs_pinnipeds_BIVARIATE.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_pinnipeds_df <- as.data.frame(tankers_vs_pinnipeds)
tankers_vs_pinnipeds_vect <- terra::vect(tankers_vs_pinnipeds_df, geom = c("x", "y"))
tankers_vs_pinnipeds_RASTER <- terra::rasterize(tankers_vs_pinnipeds_vect, 
                                                all_summed_resampled, 
                                                field = "BivValue", 
                                                fun = "mean")
#Save
terra::writeRaster(tankers_vs_pinnipeds_RASTER, filename = "tankers_vs_pinnipeds_BIVARIATE.tif")

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
terra::writeRaster(all_ships_vs_seabirds_RASTER, filename = "all_ships_vs_seabirds_BIVARIATE.tif")


########## 2. Cargo ships ##########

#Convert
cargo_vs_seabirds_df <- as.data.frame(cargo_vs_seabirds)
cargo_vs_seabirds_vect <- terra::vect(cargo_vs_seabirds_df, geom = c("x", "y"))
cargo_vs_seabirds_RASTER <- terra::rasterize(cargo_vs_seabirds_vect, 
                                             all_summed_resampled, 
                                             field = "BivValue", 
                                             fun = "mean")
#Save
terra::writeRaster(cargo_vs_seabirds_RASTER, filename = "cargo_vs_seabirds_BIVARIATE.tif")

########## 3. Fishing ships ##########

#Convert
fishing_vs_seabirds_df <- as.data.frame(fishing_vs_seabirds)
fishing_vs_seabirds_vect <- terra::vect(fishing_vs_seabirds_df, geom = c("x", "y"))
fishing_vs_seabirds_RASTER <- terra::rasterize(fishing_vs_seabirds_vect, 
                                               all_summed_resampled, 
                                               field = "BivValue", 
                                               fun = "mean")
#Save
terra::writeRaster(fishing_vs_seabirds_RASTER, filename = "fishing_vs_seabirds_BIVARIATE.tif")

########## 4. Tankers ##########

#Convert
tankers_vs_seabirds_df <- as.data.frame(tankers_vs_seabirds)
tankers_vs_seabirds_vect <- terra::vect(tankers_vs_seabirds_df, geom = c("x", "y"))
tankers_vs_seabirds_RASTER <- terra::rasterize(tankers_vs_seabirds_vect, 
                                               all_summed_resampled, 
                                               field = "BivValue", 
                                               fun = "mean")
#Save
terra::writeRaster(tankers_vs_seabirds_RASTER, filename = "tankers_vs_seabirds_BIVARIATE.tif")

################################################################################
#                                 Overall Map
################################################################################


library(terra)

all_ships_vs_cetaceans_RASTER <- terra::rast("all_ships_vs_cetaceans_BIVARIATE.tif")
all_ships_vs_turtles_RASTER <- terra::rast("all_ships_vs_turtles_BIVARIATE.tif")
all_ships_vs_pinnipeds_RASTER <- terra::rast("all_ships_vs_pinnipeds_BIVARIATE.tif")
all_ships_vs_seabirds_RASTER <- terra::rast("all_ships_vs_seabirds_BIVARIATE.tif")

#Define NA as zero
all_ships_vs_cetaceans_RASTER[is.na(all_ships_vs_cetaceans_RASTER[])] <- 0 
all_ships_vs_turtles_RASTER[is.na(all_ships_vs_turtles_RASTER[])] <- 0 
all_ships_vs_pinnipeds_RASTER[is.na(all_ships_vs_pinnipeds_RASTER[])] <- 0 
all_ships_vs_seabirds_RASTER[is.na(all_ships_vs_seabirds_RASTER[])] <- 0 

plot(all_ships_vs_cetaceans_RASTER)
plot(all_ships_vs_turtles_RASTER)
plot(all_ships_vs_pinnipeds_RASTER)
plot(all_ships_vs_seabirds_RASTER)

all_hotspots <- all_ships_vs_cetaceans_RASTER +
                all_ships_vs_turtles_RASTER +
                all_ships_vs_pinnipeds_RASTER +
                all_ships_vs_seabirds_RASTER

plot(all_hotspots)
terra::writeRaster(all_hotspots, filename = "all_hotspots_RASTER.tif")

#Make plot
world <- rnaturalearth::ne_coastline(scale = "medium", returnclass = "sf")
world <- terra::vect(world)

plot(all_hotspots)
plot(world, add=TRUE)



tiff("all_hotspots.tif", width=5000, height=2900, res=300)
plot(all_hotspots, col = c("#E1BFAC" ,"#A6626D", "#6B062F"))
dev.off()


################################################################################
#                          MAP OF OVERALL RISKS
################################################################################

#FMestre
#29-11-2024

#Load package
library(terra)

#Load species richness maps
cetaceans_sr_raster <- terra::rast("cetaceans_sr_raster.tif")
testudines_sr_raster <- terra::rast("testudines_sr_raster.tif")
pinnipeds_sr_raster <- terra::rast("pinnipeds_sr_raster.tif")
seabirds_sr_raster_resampled_cropped_ext <- terra::rast("seabirds_sr_raster_resampled_cropped_ext.tif")
all_summed_resampled <- terra::rast("all_summed_resampled.tif")
all_summed_resampled_log <- log10(all_summed_resampled) #Log transform

#Convert NA to 0
cetaceans_sr_raster[is.na(cetaceans_sr_raster[])] <- 0 
testudines_sr_raster[is.na(testudines_sr_raster[])] <- 0 
pinnipeds_sr_raster[is.na(pinnipeds_sr_raster[])] <- 0 
seabirds_sr_raster_resampled_cropped_ext[is.na(seabirds_sr_raster_resampled_cropped_ext[])] <- 0 

#Rescale all maps (0-1)
cetaceans_sr_raster_standardized <- cetaceans_sr_raster/43
testudines_sr_raster_standardized <- testudines_sr_raster/6
pinnipeds_sr_raster_standardized <- pinnipeds_sr_raster/10
seabirds_sr_raster_resampled_cropped_ext_standardized <- seabirds_sr_raster_resampled_cropped_ext/69
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

#Save it...
terra::writeRaster(overall_conflict_standardized, "overall_conflict_standardized.tif")
