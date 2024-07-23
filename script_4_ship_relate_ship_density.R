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

all_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/all_summed.tif")
#terra::plot(all_summed)
#terra::writeRaster(all_summed, "all_summed.tif")

################################## CONTINENTS ##################################

continent <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/shapes/ne_110m_admin_0_countries.shp")
#terra::plot(continent)

#terra::plot(all_summed)
#terra::plot(continent, add=TRUE)

################################## MARINE REALMS ###############################

#Upload shapefile
marine_realms <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/shapes/marineRealms.shp")
#terra::plot(marine_realms)

#terra::plot(all_summed)
#terra::plot(marine_realms, add=TRUE)

######################### MARINE PROTECTED AREAS (MPA) #########################

#Upload shapefile
mpa <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/shapes/mpa_assis.shp")
#terra::plot(mpa)

#terra::plot(all_summed)
#terra::plot(mpa, add=TRUE)

######### ECOLOGICALLY OR BIOLOGICALLY SIGNIFICANT MARINE AREAS (EBSA) #########

#Upload shapefile
ebsa <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/shapes/Ecologically_or_Biologically_Significant_Marine_Areas_(EBSAs).shp")
#terra::plot(ebsa)

#terra::plot(all_summed)
#terra::plot(ebsa, add=TRUE)

############################## BIODIVERSITY RANKING ############################

#Upload raster
#biodiv_rank <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/rasters/biodiversity_ranking.tif")
#biodiv_rank_projected <- terra::project(biodiv_rank, all_summed)
#terra::writeRaster(biodiv_rank_projected, "/media/jorgeassis/FMestre/shipless_areas/rasters/biodiv_rank_projected.tif")
biodiv_rank_projected <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/rasters/biodiv_rank_projected.tif")

biodiv_rank_projected_vector <- as.vector(biodiv_rank_projected)
all_summed_vector <- as.vector(all_summed)
biodiv_rank_VS_shipping_density <- data.frame(biodiv_rank_projected_vector, all_summed_vector)
#head(biodiv_rank_VS_shipping_density)
biodiv_rank_VS_shipping_density_complete <- biodiv_rank_VS_shipping_density[complete.cases(biodiv_rank_VS_shipping_density),]
#head(biodiv_rank_VS_shipping_density_complete)
names(biodiv_rank_VS_shipping_density_complete) <- c("biodiversity_ranking", "shiping_density")
#Save
#save(biodiv_rank_VS_shipping_density_complete, file = "biodiv_rank_VS_shipping_density_complete.Rdata")
#load("biodiv_rank_VS_shipping_density_complete.Rdata")

#Select (randomly) a percentage of the total rows in the df to plot
#nrow(biodiv_rank_VS_shipping_density_complete)/100

biodiv_rank_VS_shipping_density_complete_sampled <- biodiv_rank_VS_shipping_density_complete[sample(1:nrow(biodiv_rank_VS_shipping_density_complete),50000, replace=FALSE),]
plot(biodiv_rank_VS_shipping_density_complete_sampled$biodiversity_ranking, biodiv_rank_VS_shipping_density_complete_sampled$shiping_density)

################################ SPECIES RICHNESS ##############################

species_rich_all <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/datasets/WCMC-019-PatternsBiodiversity2010-AcrossTaxa.shp")
#terra::plot(species_rich_all, "AllTaxa")
species_indiv_rich <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/datasets/WCMC-019-PatternsBiodiversity2010-IndivTaxa.shp")

#Mean - all species
richness_zonal <- terra::zonal(all_summed, species_rich_all, fun=mean, as.polygons=TRUE, na.rm=TRUE)
richness_zonal_df <- as.data.frame(richness_zonal)
names(richness_zonal_df)[8] <- "ship_density"
head(richness_zonal_df)
#save(richness_zonal_df, file = "richness_zonal_df.RData")
#load("richness_zonal_df.RData")
#Plot
#terra::plot(richness_zonal, "grid_float_All_2011_01_converted")
plot(richness_zonal_df$ship_density, richness_zonal_df$AllTaxa, xlab = "Mean Ship Density", ylab = "Species Richnness")

#Max - all species
richness_zonal_max <- terra::zonal(all_summed, species_rich_all, fun=max, as.polygons=TRUE, na.rm=TRUE)
richness_zonal_max_df <- as.data.frame(richness_zonal_max)
names(richness_zonal_max_df)[8] <- "ship_density"
head(richness_zonal_max_df)
#save(richness_zonal_max_df, file = "richness_zonal_max_df.RData")
#load("richness_zonal_max_df.RData")
#plot
plot(richness_zonal_max_df$ship_density, richness_zonal_max_df$AllTaxa, xlab = "Maximum Ship Density", ylab = "Species Richnness")

#Mean - all taxa individually
richness_indiv_taxa_zonal <- terra::zonal(all_summed, species_indiv_rich, fun=mean, as.polygons=TRUE, na.rm=TRUE) 
richness_indiv_taxa_zonal_df <- as.data.frame(richness_indiv_taxa_zonal)
names(richness_indiv_taxa_zonal_df)[17] <- "ship_density"
head(richness_indiv_taxa_zonal_df)
#save(richness_indiv_taxa_zonal_df, file = "richness_indiv_taxa_zonal_df.RData")
#load("richness_indiv_taxa_zonal_df.RData")
#Plot
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$Cetacean, xlab = "Mean Ship Density", ylab = "Cetacean Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$Pinniped, xlab = "Mean Ship Density", ylab = "Pinniped Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$Mangrove, xlab = "Mean Ship Density", ylab = "Mangrove Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$Seagrass, xlab = "Mean Ship Density", ylab = "Seagrass Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$Squid, xlab = "Mean Ship Density", ylab = "Squid Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$CoasFishCK, xlab = "Mean Ship Density", ylab = "Coastal Fish Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$NonOcShark, xlab = "Mean Ship Density", ylab = "Non-Oceanic Shark Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$NonSqCeph, xlab = "Mean Ship Density", ylab = "Non-Squid Cephalopods Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$TunaBllfsh, xlab = "Mean Ship Density", ylab = "Tuna & Billfish Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$OceanShark, xlab = "Mean Ship Density", ylab = "Oceanic Shark Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$Euphausiid, xlab = "Mean Ship Density", ylab = "Euphausiid Species Richnness")
plot(richness_indiv_taxa_zonal_df$ship_density, richness_indiv_taxa_zonal_df$ForamCK, xlab = "Mean Ship Density", ylab = "Foraminifera Species Richnness")

#Max - all taxa individually
richness_indiv_taxa_zonal_max <- terra::zonal(all_summed, species_indiv_rich, fun=max, as.polygons=TRUE, na.rm=TRUE) 
richness_indiv_taxa_zonal_max_df <- as.data.frame(richness_indiv_taxa_zonal_max)
names(richness_indiv_taxa_zonal_max_df)[17] <- "ship_density"
head(richness_indiv_taxa_zonal_max_df)
#save(richness_indiv_taxa_zonal_max_df, file = "richness_indiv_taxa_zonal_max_df.RData")
#load("richness_indiv_taxa_zonal_max_df.RData")
#Plot
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$Cetacean, xlab = "Maximum Ship Density", ylab = "Cetacean Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$Pinniped, xlab = "Maximum Ship Density", ylab = "Pinniped Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$Mangrove, xlab = "Maximum Ship Density", ylab = "Mangrove Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$Seagrass, xlab = "Maximum Ship Density", ylab = "Seagrass Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$Squid, xlab = "Maximum Ship Density", ylab = "Squid Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$CoasFishCK, xlab = "Maximum Ship Density", ylab = "Coastal Fish Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$NonOcShark, xlab = "Maximum Ship Density", ylab = "Non-Oceanic Shark Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$NonSqCeph, xlab = "Maximum Ship Density", ylab = "Non-Squid Cephalopods Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$TunaBllfsh, xlab = "Maximum Ship Density", ylab = "Tuna & Billfish Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$OceanShark, xlab = "Maximum Ship Density", ylab = "Oceanic Shark Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$Euphausiid, xlab = "Maximum Ship Density", ylab = "Euphausiid Species Richnness")
plot(richness_indiv_taxa_zonal_max_df$ship_density, richness_indiv_taxa_zonal_max_df$ForamCK, xlab = "Maximum Ship Density", ylab = "Foraminifera Species Richnness")

################################################################################
#                            Create the plots
################################################################################

# Create a color palette with interpolation
#palette_yr <- colorRampPalette(c("#ffff00", "#ff0000"))
#palette_yr <- palette_yr(10)

#?terra::zonal
marine_realms_zonal <- terra::zonal(all_summed, marine_realms, fun=mean, as.polygons=TRUE, na.rm=TRUE) 
marine_realms_zonal_sd <- terra::zonal(all_summed, marine_realms, fun=sd, as.polygons=TRUE, na.rm=TRUE) 
marine_realms_df_mean <- as.data.frame(marine_realms_zonal)
marine_realms_df_sd <- as.data.frame(marine_realms_zonal_sd)
marine_realms_df <- cbind(marine_realms_df_mean, marine_realms_df_sd$grid_float_All_2011_01_converted)
names(marine_realms_df) <- c("realm", "realm_name", "mean", "sd")
marine_realms_df$realm_name[3] <- "Caribbean & Gulf of Mexico"
marine_realms_df$realm_name[4] <- "Offshore & NW North Atlantic"
marine_realms_df$realm_name[18] <- "Norwegian Sea (in part)"
marine_realms_df$realm_name[21] <- "Gulfs of Aqaba, Aden, Suez, Red Sea"
marine_realms_df$realm_name[28] <- "Indo-Pacific seas & Indian Ocean"
#Save & Load
#save(marine_realms_df, file = "marine_realms_df.RData")
#load("marine_realms_df.RData")
#terra::writeVector(marine_realms_zonal, "marine_realms_zonal.shp", overwrite=TRUE)
#terra::plot(marine_realms_zonal, "grid_float_All_2011_01_converted", palette_yr, type = "continuous")
#View(marine_realms_df)
#Boxplot
marine_realms_df_2 <- marine_realms_df[order(marine_realms_df$mean,decreasing = TRUE),]
png(file="marine_realms_vs_shipping.png",width=4000, height=2500, res=300)
par(mar=c(5,20,5,5))
barplot(marine_realms_df_2$mean,
        names.arg = marine_realms_df_2$realm_name,
        #data=marine_realms_df_2, 
        main="Shipping Density vs Marine Realms",
        xlab=NA, 
        ylab=NA, 
        las = 2,
        horiz = TRUE,
        xlim= c(0,2000)
        )
dev.off()

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
#Boxplot
mpa_zonal_df_2 <- mpa_zonal_df[order(mpa_zonal_df$mean,decreasing = TRUE),]
png(file="mpa_vs_shipping.png",width=4000, height=8000, res=300)
par(mar=c(5,20,5,5))
barplot(mpa_zonal_df_2$mean,
        names.arg = mpa_zonal_df_2$Name,
        #data=marine_realms_df_2, 
        main="Shipping Density vs MPA",
        xlab=NA, 
        ylab=NA, 
        las = 2,
        horiz = TRUE,
        xlim= c(0,1000000)
)
dev.off()
