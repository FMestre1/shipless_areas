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

