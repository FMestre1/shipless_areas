################################################################################
#                       Ship density vs other variables
################################################################################

#FMestre
#15-07-2024

#Load package
library(terra)

################################################################################
#                                 Load data
################################################################################

################################## SHIP DENSITY ################################

terciles_reclassified_all_summed <- terra::rast("tercile_rasters/terciles_reclassified_all_summed_02DEZ24.tif")
#terra::plot(all_summed)
#terra::writeRaster(all_summed, "all_summed.tif")

################################## CONTINENTS ##################################

continent <- terra::vect("C:\\Users\\mestr\\Documents\\0. Artigos\\shipless_areas\\gis\\continents_close_seas.shp")
#terra::plot(continent)

################################## FAO REGIONS #################################

fao <- terra::vect("D:\\shipless_areas_paper\\datasets\\FAO\\World_Fao_Areas.shp")
#terra::plot(fao, add=TRUE)

######################### MARINE PROTECTED AREAS (MPA) #########################

#Upload shapefile
mpa <- terra::vect("D:\\shipless_areas_paper\\datasets\\MPA\\mpa_assis.shp")
#terra::plot(mpa)
View(as.data.frame(mpa))

####################### EXCLUSIVE ECONOMIC ZONES (EEZ) #########################

#Upload shapefile
eez <- terra::vect("D:\\shipless_areas_paper\\datasets\\eez\\eez_v12_aggregated.shp")
#aggregating by country (SOVEREIGN1)
#terra::plot(eez)

################################ SPECIES RICHNESS ##############################

terciles_reclassified_testudines <- terra::rast("tercile_rasters/terciles_reclassified_testudines_02DEZ24.tif")
terciles_reclassified_pinnipeds <- terra::rast("tercile_rasters/terciles_reclassified_pinnipeds_02DEZ24.tif")
terciles_reclassified_seabirds <- terra::rast("tercile_rasters/terciles_reclassified_seabirds_02DEZ24.tif")
terciles_reclassified_cetaceans <- terra::rast("tercile_rasters/terciles_reclassified_cetaceans_02DEZ24.tif")
terciles_reclassified_all_biodiv <- terra::rast("tercile_rasters/terciles_reclassified_all_biodiv_20JAN25.tif")

################################################################################
#                                      MPA
################################################################################

#Mean
mpa_zonal <- terra::zonal(all_summed, mpa, fun=mean, as.polygons=TRUE, na.rm=TRUE) 
mpa_zonal_sd <- terra::zonal(all_summed, mpa, fun=sd, as.polygons=TRUE, na.rm=TRUE) 
mpa_zonal_df_mean <- as.data.frame(mpa_zonal)
mpa_zonal_df_sd <- as.data.frame(mpa_zonal_sd)
mpa_zonal_df <- cbind(mpa_zonal_df_mean, mpa_zonal_df_sd$grid_float_All_2011_01_converted)
names(mpa_zonal_df)[10:11] <- c("mean", "sd")
#Save & Load
#save(mpa_zonal_df, file = "mpa_zonal_df.RData")
#load("mpa_zonal_df.RData")
#terra::writeVector(mpa_zonal, "mpa_zonal.shp", overwrite=TRUE)
#terra::plot(mpa_zonal, "grid_float_All_2011_01_converted", palette_yr, type = "continuous")
#View(marine_realms_df)

#Max
mpa_zonal_max <- terra::zonal(all_summed, mpa, fun=max, as.polygons=TRUE, na.rm=TRUE) 
mpa_zonal_max_df <- as.data.frame(mpa_zonal_max)

names(mpa_zonal_max_df)[10] <- "max"
#Save & Load
#save(mpa_zonal_max_df, file = "mpa_zonal_max_df.RData")
#load("mpa_zonal_max_df.RData")
#terra::writeVector(mpa_zonal_max, "mpa_zonal_max.shp", overwrite=TRUE)
#terra::plot(mpa_zonal_max, "grid_float_All_2011_01_converted", palette_yr, type = "continuous")
#View(mpa_zonal_max_df)
#Boxplot
mpa_zonal_max_df_2 <- mpa_zonal_max_df[order(mpa_zonal_max_df$max, decreasing = TRUE),]

#Max - Top 10
mpa_zonal_max_df_2_top10 <- mpa_zonal_max_df[order(mpa_zonal_max_df$max, decreasing = TRUE),]
head(mpa_zonal_max_df_2_top10)
mpa_zonal_max_df_2_top10 <- mpa_zonal_max_df_2_top10[1:10,]

################################################################################
#                                  FAO REGIONS
################################################################################

#Mean
fao_zonal <- terra::zonal(all_summed, fao, fun=mean, as.polygons=TRUE, na.rm=TRUE) 
fao_zonal_sd <- terra::zonal(all_summed, fao, fun=sd, as.polygons=TRUE, na.rm=TRUE) 
fao_zonal_df_mean <- as.data.frame(fao_zonal)
fao_zonal_df_sd <- as.data.frame(fao_zonal_sd)
fao_zonal_df <- cbind(fao_zonal_df_mean, fao_zonal_df_sd$grid_float_All_2011_01_converted)
names(fao_zonal_df)[2:3] <- c("mean", "sd")
#Save & Load
#save(fao_zonal_df, file = "fao_zonal_df.RData")
#load("fao_zonal_df.RData")

################################################################################
#                                      EEZ
################################################################################

