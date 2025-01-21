################################################################################
#                       Ship density vs other variables
################################################################################

#FMestre
#21-01-2025

#Load package
library(terra)

################################################################################
#                                 Load data
################################################################################

################################## SHIP DENSITY ################################

terciles_reclassified_all_summed <- terra::rast("tercile_rasters/terciles_reclassified_all_summed_02DEZ24.tif")
#terra::plot(all_summed)

################################## CONTINENTS ##################################

continent <- terra::vect("C:\\Users\\mestr\\Documents\\0. Artigos\\shipless_areas\\gis\\continents_close_seas.shp")
#terra::plot(continent)

################################## FAO REGIONS #################################

fao <- terra::vect("D:\\shipless_areas_paper\\datasets\\FAO\\World_Fao_Areas.shp")
#terra::plot(fao, add=TRUE)

####################### EXCLUSIVE ECONOMIC ZONES (EEZ) #########################

#Upload shapefile
eez <- terra::vect("D:\\shipless_areas_paper\\datasets\\eez\\eez_v12_aggregated.shp")
eez_s <- terra::simplifyGeom(eez, tolerance=0.01)
#terra::plot(eez_s)

######################### MARINE PROTECTED AREAS (MPA) #########################

#Upload shapefile
mpa <- terra::vect("D:\\shipless_areas_paper\\datasets\\MPA\\mpa_assis.shp")
mpa_s <- terra::simplifyGeom(mpa, tolerance=0.01)
#nrow(mpa_s)
#length(unique(mpa_s$Name))
#terra::plot(mpa_s)
#which polygons of mpa_s overlaps which polygons of eez_s?
mpa_eez_intersect <- terra::intersect(mpa_s, eez_s)
#(...)

################################ SPECIES RICHNESS ##############################

terciles_reclassified_testudines <- terra::rast("tercile_rasters/terciles_reclassified_testudines_02DEZ24.tif")
terciles_reclassified_pinnipeds <- terra::rast("tercile_rasters/terciles_reclassified_pinnipeds_02DEZ24.tif")
terciles_reclassified_seabirds <- terra::rast("tercile_rasters/terciles_reclassified_seabirds_02DEZ24.tif")
terciles_reclassified_cetaceans <- terra::rast("tercile_rasters/terciles_reclassified_cetaceans_02DEZ24.tif")
terciles_reclassified_all_biodiv <- terra::rast("tercile_rasters/terciles_reclassified_all_biodiv_20JAN25.tif")

################################################################################
#                                      MPA
################################################################################


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

