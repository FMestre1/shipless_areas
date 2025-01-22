#caixa <- terra::vect("shape/caixa3.shp")
#plot(all_2011_01)
#plot(caixa, add=TRUE)

#all_2011_01_cut <- terra::crop(all_2011_01, caixa)
#all_2011_02_cut <- terra::crop(all_2011_02, caixa)

#all_2011_01_cut[is.na(all_2011_01_cut)] <- 0
#all_2011_02_cut[is.na(all_2011_02_cut)] <- 0

#plot(all_2011_01_cut)
#plot(all_2011_02_cut)

#plot(all_2011_01_cut + all_2011_02_cut)

#plot(all_2011_01_cut)
#plot(all_2011_02_cut)
#summed <- sum(all_2011_01_cut, all_2011_02_cut, na.rm = TRUE)
#plot(summed)



################################################################################
#       % Of each ship density tercile density inside and outside MPA
################################################################################

#18-11-2024

#Load libraries
library(terra)
library(ggplot2)

#Inside MPA
inside_MPA <- as.vector(terra::values(terra::rast("D:/shipless_areas_paper/density_within_MPA.tif")))
inside_MPA <- inside_MPA[!is.na(inside_MPA)]
inside_MPA_counts <- as.data.frame(table(inside_MPA))

#Outside MPA
outside_MPA <- as.vector(terra::values(terra::rast("D:/shipless_areas_paper/density_outside_MPA.tif")))
outside_MPA <- outside_MPA[!is.na(outside_MPA)]
outside_MPA_counts <- as.data.frame(table(outside_MPA))


inside_MPA_counts_2 <- data.frame(inside_MPA_counts, (inside_MPA_counts$Freq * 100)/sum(inside_MPA_counts$Freq), "inside")
names(inside_MPA_counts_2)[4] <- "MPA"
names(inside_MPA_counts_2)[3] <- "percentage"
names(inside_MPA_counts_2)[1] <- "ship_density"
#
outside_MPA_counts_2 <- data.frame(outside_MPA_counts, (outside_MPA_counts$Freq * 100)/sum(outside_MPA_counts$Freq), "outside")
names(outside_MPA_counts_2)[4] <- "MPA"
names(outside_MPA_counts_2)[3] <- "percentage"
names(outside_MPA_counts_2)[1] <- "ship_density"

#data frame to plot
percentage_in_out_MPA <- rbind(inside_MPA_counts_2, outside_MPA_counts_2)
percentage_in_out_MPA$percentage <- round(percentage_in_out_MPA$percentage, 2)

#Bar Plot - fig 7
ggplot(percentage_in_out_MPA, aes(fill=MPA, y=percentage, x=ship_density)) + 
  geom_bar(position="dodge", stat="identity") +
  labs(x = "Ship Density", y = "Percentage", fill = "MPA") +
  geom_text(aes(label = paste0(percentage, "%")), position = position_dodge(width = 1), vjust = -0.5) +
  scale_x_discrete(labels = c("Low (first tercile)", "Medium (second tercile)", "High (third tercile)")) +
  scale_fill_manual(values = c("inside" = "darkolivegreen4", "outside" = "darkorange3"))



#######

#Beanplot with actual density
library(beanplot)

#Inside MPA
inside_MPA_values <- as.vector(terra::values(terra::rast("D:/shipless_areas_paper/density_within_MPA_VALUES.tif")))
inside_MPA_values <- inside_MPA_values[!is.na(inside_MPA_values)]
#Outside MPA
outside_MPA_values <- as.vector(terra::values(terra::rast("D:/shipless_areas_paper/density_outside_MPA_VALUES.tif")))
outside_MPA_values <- outside_MPA_values[!is.na(outside_MPA_values)]

df_in <- data.frame(inside_MPA_values, rep("in", length(inside_MPA_values)))
df_out <- data.frame(outside_MPA_values, rep("out", length(outside_MPA_values)))

names(df_in) <- c("density","mpa")
names(df_out) <- c("density","mpa")

df_in_out_mpa <- rbind(df_in, df_out)
str(df_in_out_mpa)

df_in_out_mpa$mpa <- as.factor(df_in_out_mpa$mpa)


?beanplot::beanplot()

beanplot(density ~ mpa, data = df_in_out_mpa, col = "lightgray", border = "grey", cutmin = 0)

################3

#Violin plot
ggplot(df_in_out_mpa, aes(x=mpa, y=density)) + 
  geom_violin()


################################################################################


library(terra)
library(gdistance)

large_ports <- terra::vect("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/world_port_index/large_ports.shp")

continents <- terra::vect("C:/Users/mestr/Documents/shape/ne_110m_admin_0_countries.shp")
plot(continents)
plot(large_ports, add=TRUE)

hotspots <- terra::rast("all_hotspots_RASTER.tif")
plot(hotspots)

#Load rasters
pinnipeds <- terra::rast("~/0. Artigos/shipless_areas/gis/tercile/terciles_reclassified_pinnipeds.tif")
cetaceans <- terra::rast("~/0. Artigos/shipless_areas/gis/tercile/terciles_reclassified_cetaceans.tif")
seabirds <- terra::rast("terciles_reclassified_seabirds.tif")
turtles <- terra::rast("~/0. Artigos/shipless_areas/gis/tercile/terciles_reclassified_testudines.tif")

#Define NA as zero
pinnipeds[is.na(pinnipeds[])] <- 0 
cetaceans[is.na(cetaceans[])] <- 0 
seabirds[is.na(seabirds[])] <- 0 
turtles[is.na(turtles[])] <- 0 
#Extent and resolution in the seabirds maps
terra::ext(seabirds) <- terra::ext(turtles)
seabirds <- resample(seabirds, turtles)

#Sum biodiversity maps 
biodiversity <- pinnipeds + cetaceans + seabirds + turtles
plot(biodiversity)

#Save
terra::writeRaster(biodiversity, "sum_tercile_biodiversity.tif", overwrite=TRUE)


tr.cost1 <- gdistance::transition(raster::raster(biodiversity), transitionFunction=mean, directions=8) 
tr.cost1


terra::coor

sites.sp <- SpatialPoints(terra::crds(large_ports))

Neighbours <- spdep::tri2nb(sites.sp@coords)


plot(Neighbours, sites.sp@coords, col="darkgrey", add=TRUE)
for(i in 1:length(Neighbours))
{
  for(j in Neighbours[[i]][Neighbours[[i]] > i])
  {
    AtoB <- gdistance::shortestPath(tr.cost1, origin=sites.sp[i,], 
                                    goal=sites.sp[j,], output="SpatialLines")
    lines(AtoB, col="red", lwd=1.5)
  }
}


plot(AtoB, sites.sp@coords, col="darkgrey", add=TRUE)

################################################################################
################################################################################

#Load rasters
sum_all_2011 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2011.tif")
sum_all_2012 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2012.tif")
sum_all_2013 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2013.tif")
sum_all_2014 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2014.tif")
sum_all_2015 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2015.tif")
sum_all_2016 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2016.tif")
sum_all_2017 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2017.tif")
sum_all_2018 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2018.tif")
sum_all_2019 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2019.tif")
sum_all_2020 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2020.tif")
sum_all_2021 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2021.tif")
sum_all_2022 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2022.tif")
sum_all_2023 <- terra::rast("D:/shipless_areas/sum_all/sum_all_2023.tif")

#Cargo
sum_cargo_2011 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2011.tif")
sum_cargo_2012 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2012.tif")
sum_cargo_2013 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2013.tif")
sum_cargo_2014 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2014.tif")
sum_cargo_2015 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2015.tif")
sum_cargo_2016 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2016.tif")
sum_cargo_2017 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2017.tif")
sum_cargo_2018 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2018.tif")
sum_cargo_2019 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2019.tif")
sum_cargo_2020 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2020.tif")
sum_cargo_2021 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2021.tif")
sum_cargo_2022 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2022.tif")
sum_cargo_2023 <- terra::rast("D:/shipless_areas/sum_cargo/sum_cargo_2023.tif")

#Tankers
sum_tankers_2011 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2011.tif")
sum_tankers_2012 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2012.tif")
sum_tankers_2013 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2013.tif")
sum_tankers_2014 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2014.tif")
sum_tankers_2015 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2015.tif")
sum_tankers_2016 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2016.tif")
sum_tankers_2017 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2017.tif")
sum_tankers_2018 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2018.tif")
sum_tankers_2019 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2019.tif")
sum_tankers_2020 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2020.tif")
sum_tankers_2021 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2021.tif")
sum_tankers_2022 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2022.tif")
sum_tankers_2023 <- terra::rast("D:/shipless_areas/sum_tankers/sum_tankers_2023.tif")

#Line plot
years_names <- c(2011, 2012, 2013, 2014, 2015, 2016, 2017,
                 2018, 2019, 2020, 2021, 2022, 2023)

mean_density <- c(as.numeric(global(sum_all_2011, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2012, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2013, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2014, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2015, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2016, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2017, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2018, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2019, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2020, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2021, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2022, "mean", na.rm=TRUE)),
                  as.numeric(global(sum_all_2023, "mean", na.rm=TRUE))
)

sd_shipping <- c(as.numeric(global(sum_all_2011, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2012, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2013, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2014, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2015, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2016, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2017, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2018, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2019, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2020, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2021, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2022, "sd", na.rm=TRUE)),
                 as.numeric(global(sum_all_2023, "sd", na.rm=TRUE))
)

shipping_stats <- data.frame(years_names, mean_density, sd_shipping)
colnames(shipping_stats) <- c("year", "mean", "sd")

plot(shipping_stats$year, shipping_stats$mean, type="l")

##

mean_cargo_density <- c(as.numeric(global(sum_cargo_2011, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2012, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2013, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2014, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2015, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2016, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2017, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2018, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2019, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2020, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2021, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2022, "mean", na.rm=TRUE)),
                        as.numeric(global(sum_cargo_2023, "mean", na.rm=TRUE))
)

sd_cargo_shipping <- c(as.numeric(global(sum_cargo_2011, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2012, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2013, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2014, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2015, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2016, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2017, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2018, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2019, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2020, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2021, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2022, "sd", na.rm=TRUE)),
                       as.numeric(global(sum_cargo_2023, "sd", na.rm=TRUE))
)

cargo_stats <- data.frame(years_names, mean_cargo_density, sd_cargo_shipping)
colnames(cargo_stats) <- c("year", "mean", "sd")

plot(cargo_stats$year, cargo_stats$mean, type="l")

##

################################################################################

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

#############################

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

################################################################################

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

#Mean - Top 10
mpa_zonal_df_2_top10 <- mpa_zonal_df[order(mpa_zonal_df$mean, decreasing = TRUE),]
head(mpa_zonal_df_2_top10)
mpa_zonal_df_2_top10 <- mpa_zonal_df_2_top10[1:10,]
#
png(file="mpa_vs_shipping_top10.png",width=5000, height=2500, res=300)
par(mar=c(5,20,5,5))
barplot(mpa_zonal_df_2_top10$mean,
        names.arg = paste0(mpa_zonal_df_2_top10$Name, " (", mpa_zonal_df_2_top10$cntryCd, ")"),
        #data=marine_realms_df_2, 
        main="Shipping Density vs MPA (top 10)",
        xlab=NA, 
        ylab=NA, 
        las = 2,
        horiz = TRUE,
        xlim= c(0,1000000)
)
dev.off()

################################################################################

png(file="mpa_max_vs_shipping.png",width=8000, height=8000, res=300)
par(mar=c(5,20,5,5))
barplot(mpa_zonal_max_df_2$max,
        names.arg = mpa_zonal_max_df_2$Name,
        #data=marine_realms_df_2, 
        main="Maximum Shipping Density vs MPA",
        xlab=NA, 
        ylab=NA,
        las = 2,
        horiz = TRUE,
        xlim= c(0,10000000)
)
dev.off()

################################################################################

#
png(file="mpa_vs_max_shipping_top10.png",width=5000, height=2500, res=300)
par(mar=c(5,20,5,5))
barplot(mpa_zonal_max_df_2_top10$max,
        names.arg = paste0(mpa_zonal_max_df_2_top10$Name, " (", mpa_zonal_max_df_2_top10$cntryCd, ")"),
        #data=marine_realms_df_2, 
        main="Shipping Density vs MPA (top 10)",
        xlab=NA, 
        ylab=NA, 
        las = 2,
        horiz = TRUE,
        xlim= c(0,10000000)
)
dev.off()

################################################################################

#Boxplot
ebsa_zonal_df_2 <- ebsa_zonal_df[order(ebsa_zonal_df$mean,decreasing = TRUE),]
png(file="ebsa_vs_shipping.png",width=4000, height=8000, res=300)
par(mar=c(5,20,5,5))
barplot(ebsa_zonal_df_2$mean,
        names.arg = ebsa_zonal_df_2$NAME,
        main="Shipping Density vs EBSA",
        xlab=NA, 
        ylab=NA, 
        las = 2,
        horiz = TRUE#,
        #xlim= c(0,1000000)
)
dev.off()

#Mean - Top 10
ebsa_zonal_df_2_top10 <- ebsa_zonal_df[order(ebsa_zonal_df$mean, decreasing = TRUE),]
head(ebsa_zonal_df_2_top10)
ebsa_zonal_df_2_top10 <- ebsa_zonal_df_2_top10[1:10,]
#
png(file="ebsa_vs_shipping_top10.png",width=5000, height=2500, res=300)
par(mar=c(5,20,5,5))
barplot(ebsa_zonal_df_2_top10$mean,
        names.arg = ebsa_zonal_df_2_top10$NAME,
        main="Shipping Density vs EBSA (top 10)",
        xlab=NA, 
        ylab=NA, 
        las = 2,
        horiz = TRUE#,
        #xlim= c(0,1000000)
)
dev.off()


#Max
ebsa_zonal_max <- terra::zonal(all_summed, ebsa, fun=max, as.polygons=TRUE, na.rm=TRUE) 
ebsa_zonal_max_df <- as.data.frame(ebsa_zonal_max)
names(ebsa_zonal_max_df)[9] <- "max"
#Save & Load
#save(ebsa_zonal_max_df, file = "ebsa_zonal_max_df.RData")
#load("ebsa_zonal_max_df.RData")
#terra::writeVector(ebsa_zonal_max, "ebsa_zonal_max.shp", overwrite=TRUE)
#terra::plot(ebsa_zonal_max, "grid_float_All_2011_01_converted", palette_yr, type = "continuous")
#View(ebsa_zonal_max_df)
#Boxplot
ebsa_zonal_max_df_2 <- ebsa_zonal_max_df[order(ebsa_zonal_max_df$max, decreasing = TRUE),]
png(file="ebsa_max_vs_shipping.png",width=8000, height=8000, res=300)
par(mar=c(5,20,5,5))
barplot(ebsa_zonal_max_df_2$max,
        names.arg = ebsa_zonal_max_df_2$NAME,
        main="Maximum Shipping Density vs EBSA",
        xlab=NA, 
        ylab=NA,
        las = 2,
        horiz = TRUE#,
        #xlim= c(0,10000000)
)
dev.off()

#Max - Top 10
ebsa_zonal_max_df_2_top10 <- ebsa_zonal_max_df[order(ebsa_zonal_max_df$max, decreasing = TRUE),]
head(ebsa_zonal_max_df_2_top10)
ebsa_zonal_max_df_2_top10 <- ebsa_zonal_max_df_2_top10[1:10,]
#
png(file="ebsa_vs_max_shipping_top10.png",width=5000, height=2500, res=300)
par(mar=c(5,20,5,5))
barplot(ebsa_zonal_max_df_2_top10$max,
        names.arg = ebsa_zonal_max_df_2_top10$NAME,
        main="Shipping Density vs EBSA (top 10)",
        xlab=NA, 
        ylab=NA, 
        las = 2,
        horiz = TRUE#,
        #xlim= c(0,10000000)
)
dev.off()

################################################################################


################################################################################
#                              Non-MPA vs MPA
################################################################################

#Upload shapefiles
mpa_corrected <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/shapes/mpa_assis.shp")
non_mpa <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/shapes/diferenca_rectangulo_mpa.shp")
all_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/all_summed.tif")

#terra::plot(mpa_corrected)
#terra::plot(non_mpa)

#mpa_corrected_zonal <- terra::zonal(all_summed, mpa_corrected, fun=mean, as.polygons=TRUE, na.rm=TRUE) 
#non_mpa_zonal <- terra::zonal(all_summed, non_mpa, fun=mean, as.polygons=TRUE, na.rm=TRUE) 
#
mpa_corrected_extract <- terra::extract(all_summed, mpa_corrected) 
mpa_corrected_extract_values <- mpa_corrected_extract$grid_float_All_2011_01_converted
mpa_corrected_extract_values_noNA <- mpa_corrected_extract_values[!is.na(mpa_corrected_extract_values)]
#save(mpa_corrected_extract_values_noNA, file = "mpa_corrected_extract_values_noNA.RData")
#load("mpa_corrected_extract_values_noNA.RData")
#
non_mpa_extract <- terra::extract(all_summed, non_mpa) 
non_mpa_extract_values <- non_mpa_extract$grid_float_All_2011_01_converted
non_mpa_extract_values_noNA <- non_mpa_extract_values[!is.na(non_mpa_extract_values)]
#save(non_mpa_extract_values_noNA, file = "non_mpa_extract_values_noNA.RData")
#load("non_mpa_extract_values_noNA.RData")
#
mpa_df <- data.frame(mpa_corrected_extract_values_noNA, rep("mpa", length(mpa_corrected_extract_values_noNA)))
names(mpa_df) <- c("ship_density", "inside_outside_mpa")
non_mpa_df <- data.frame(non_mpa_extract_values_noNA, rep("non-mpa", length(non_mpa_extract_values_noNA)))
names(non_mpa_df) <- c("ship_density", "inside_outside_mpa")
mpa_final_df <- rbind(mpa_df, non_mpa_df)
mpa_final_df$inside_outside_mpa <- as.factor(mpa_final_df$inside_outside_mpa) 
#save(mpa_final_df, file = "mpa_final_df.RData")
#load("mpa_final_df.RData")

#Create the boxplot
mpa_final_df_log_transf <- mpa_final_df
mpa_final_df_log_transf$ship_density <- log(mpa_final_df_log_transf$ship_density)+1
#load("/media/jorgeassis/FMestre/shipless_areas/mpa_final_df.RData")
png(file="mpa_non_mpa_boxplot_LOG.png", width=1500, height=4000, res=300)
boxplot(mpa_final_df_log_transf$inside_outside_mpa, mpa_final_df_log_transf$ship_density)
dev.off()

#Violin plot
# install.packages("vioplot")
#png(file="mpa_non_mpa_plot.png",width=1500, height=2500, res=300)
#vioplot(inside_outside_mpa ~ ship_density, 
#        data = mpa_final_df,
#        col = c("#556B2F", "#8B1A1A")
#) 
#dev.off()


#Beanplot
#mpa_df <- mpa_final_df[mpa_final_df$inside_outside_ebsa == "mpa", ]
#non_mpa_df <- mpa_final_df[mpa_final_df$inside_outside_ebsa == "non-mpa", ]

mpa_final_df_sampled <- mpa_final_df[sample(nrow(mpa_final_df), 5000), ]
#table(mpa_final_df_sampled$inside_outside_mpa)

png(file="mpa_non_mpa_beanplot.png",width=1500, height=1500, res=300)
#beanplot::beanplot(sample(mpa_df$ship_density, 5000), sample(non_mpa_df$ship_density,5000))
beanplot::beanplot(mpa_final_df_sampled$ship_density ~ mpa_final_df_sampled$inside_outside_mpa)
dev.off()

################################################################################
#                              Non-EBSA vs EBSA
################################################################################

# ECOLOGICALLY OR BIOLOGICALLY SIGNIFICANT MARINE AREAS (EBSA)

#Upload shapefiles
ebsa <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/shapes/Ecologically_or_Biologically_Significant_Marine_Areas_(EBSAs).shp")
non_ebsa <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/shapes/non_ebsa.shp")
all_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/all_summed.tif")

#terra::plot(ebsa)
#terra::plot(non_ebsa)

#ebsa_zonal <- terra::zonal(all_summed, ebsa, fun=mean, as.polygons=TRUE, na.rm=TRUE) 
#non_ebsa_zonal <- terra::zonal(all_summed, non_ebsa, fun=mean, as.polygons=TRUE, na.rm=TRUE) 
#
ebsa_extract <- terra::extract(all_summed, ebsa)
ebsa_extract_values <- ebsa_extract$grid_float_All_2011_01_converted
ebsa_extract_values_noNA <- ebsa_extract_values[!is.na(ebsa_extract_values)]
#save(ebsa_extract_values_noNA, file = "ebsa_extract_values_noNA.RData")
#load("ebsa_extract_values_noNA.RData")
#
non_ebsa_extract <- terra::extract(all_summed, non_ebsa) 
non_ebsa_extract_values <- non_ebsa_extract$grid_float_All_2011_01_converted
non_ebsa_extract_values_noNA <- non_ebsa_extract_values[!is.na(non_ebsa_extract_values)]
#save(non_ebsa_extract_values_noNA, file = "non_ebsa_extract_values_noNA.RData")
#load("non_ebsa_extract_values_noNA.RData")
#
ebsa_df <- data.frame(ebsa_extract_values_noNA, rep("ebsa", length(ebsa_extract_values_noNA)))
names(ebsa_df) <- c("ship_density", "inside_outside_ebsa")
non_ebsa_df <- data.frame(non_ebsa_extract_values_noNA, rep("non-ebsa", length(non_ebsa_extract_values_noNA)))
names(non_ebsa_df) <- c("ship_density", "inside_outside_ebsa")
ebsa_final_df <- rbind(ebsa_df, non_ebsa_df)
ebsa_final_df$inside_outside_ebsa <- as.factor(ebsa_final_df$inside_outside_ebsa) 
#save(ebsa_final_df, file = "ebsa_final_df.RData")
#load("ebsa_final_df.RData")

#Create the boxplot
ebsa_final_df_log_transf <- ebsa_final_df
ebsa_final_df_log_transf$ship_density <- log(ebsa_final_df_log_transf$ship_density)+1
#load("/media/jorgeassis/FMestre/shipless_areas/ebsa_final_df.RData")
png(file="ebsa_non_ebsa_boxplot_LOG.png",width=1500, height=4000, res=300)
boxplot(ebsa_final_df_log_transf$inside_outside_ebsa, ebsa_final_df_log_transf$ship_density)
dev.off()

#Violin plot
#png(file="ebsa_non_ebsa_violin_plot.png",width=1500, height=2500, res=300)
#vioplot(inside_outside_ebsa ~ ship_density, 
#        data = ebsa_final_df,
#        col = c("#556B2F", "#8B1A1A")
#        ) 
#dev.off()

#Beanplot
#ebsa_df <- ebsa_final_df[ebsa_final_df$inside_outside_ebsa == "ebsa", ]
#non_ebsa_df <- ebsa_final_df[ebsa_final_df$inside_outside_ebsa == "non-ebsa", ]

ebsa_final_df_sampled <- ebsa_final_df[sample(nrow(ebsa_final_df), 5000), ]
#table(ebsa_final_df_sampled$inside_outside_ebsa)

png(file="ebsa_non_ebsa_beanplot_v3.png",width=1500, height=1500, res=300)
#beanplot::beanplot(sample(ebsa_df$ship_density, 5000), sample(non_ebsa_df$ship_density,5000))
beanplot::beanplot(ebsa_final_df_log_transf$ship_density ~ ebsa_final_df_log_transf$inside_outside_ebsa)
dev.off()

################################################################################

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


#################################################################################

################################################################################
#                            Marine Realms
################################################################################

# Create a color palette with interpolation
palette_yr <- colorRampPalette(c("#ffff00", "#ff0000"))
palette_yr <- palette_yr(10)

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

#################################################################################


################################################################################
#                                       EBSA
################################################################################

#Upload shapefiles
ebsa <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/shapes/Ecologically_or_Biologically_Significant_Marine_Areas_(EBSAs).shp")
non_ebsa <- terra::vect("/media/jorgeassis/FMestre/shipless_areas/shapes/non_ebsa.shp")
all_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/all_summed.tif")

#terra::plot(ebsa)
#terra::plot(non_ebsa)

#Mean
ebsa_zonal <- terra::zonal(all_summed, ebsa, fun=mean, as.polygons=TRUE, na.rm=TRUE) 
ebsa_zonal_sd <- terra::zonal(all_summed, ebsa, fun=sd, as.polygons=TRUE, na.rm=TRUE) 
ebsa_zonal_df_mean <- as.data.frame(ebsa_zonal)
ebsa_zonal_df_sd <- as.data.frame(ebsa_zonal_sd)
ebsa_zonal_df <- cbind(ebsa_zonal_df_mean, ebsa_zonal_df_sd$grid_float_All_2011_01_converted)
names(ebsa_zonal_df)[9:10] <- c("mean", "sd")
head(ebsa_zonal_df)
#Save & Load
#save(ebsa_zonal_df, file = "ebsa_zonal_df.RData")
#load("ebsa_zonal_df.RData")
#terra::writeVector(ebsa_zonal, "ebsa_zonal.shp", overwrite=TRUE)
#terra::plot(ebsa_zonal, "grid_float_All_2011_01_converted", palette_yr, type = "continuous")
#View(ebsa_zonal_df)

################################## MARINE REALMS ###############################

#Upload shapefile
marine_realms <- terra::vect("D:\\shipless_areas_paper\\datasets\\Marine biogeographic realms and species endemicity\\marineRealms\\marineRealms.shp")
#terra::plot(marine_realms)

######### ECOLOGICALLY OR BIOLOGICALLY SIGNIFICANT MARINE AREAS (EBSA) #########

#Upload shapefile
ebsa <- terra::vect("D:\\shipless_areas_paper\\datasets\\Ecologically_or_Biologically_Significant_Marine_Areas\\Ecologically_or_Biologically_Significant_Marine_Areas_(EBSAs).shp")
#terra::plot(ebsa)

################################################################################


mpa_zonal <- terra::zonal(terciles_reclassified_all_summed, mpa[1:3,], fun=count, as.polygons=TRUE, na.rm=TRUE) 
#mpa_zonal_sd <- terra::zonal(all_summed, mpa, fun=sd, as.polygons=TRUE, na.rm=TRUE) 
#mpa_zonal_df_mean <- as.data.frame(mpa_zonal)
#mpa_zonal_df_sd <- as.data.frame(mpa_zonal_sd)
#mpa_zonal_df <- cbind(mpa_zonal_df_mean, mpa_zonal_df_sd$grid_float_All_2011_01_converted)
#names(mpa_zonal_df)[10:11] <- c("mean", "sd")
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

############################# OCEAN BASINS REGIONS ##############################

ocean_basins <- terra::vect("D:\\shipless_areas_paper\\datasets\\OceanicBasins\\Intersect_EEZ_IHO_v5_20241010.shp")
#terra::plot(ocean_basins)

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

#(...)

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

#(...)

################################################################################
#                       Ship density vs other variables
################################################################################

#VBastazini
#01-08-2024

#Load package
library(MASS)

#################################### NOT USED ##################################

#Load
load("/media/jorgeassis/FMestre/shipless_areas/mpa_corrected_extract_values_noNA.RData")
load("/media/jorgeassis/FMestre/shipless_areas/ebsa_extract_values_noNA.RData")
load("/media/jorgeassis/FMestre/shipless_areas/non_ebsa_extract_values_noNA.RData")
load("/media/jorgeassis/FMestre/shipless_areas/non_mpa_extract_values_noNA.RData")

mpa <- mpa_corrected_extract_values_noNA
nmpa <- non_mpa_extract_values_noNA
ebsa <- ebsa_extract_values_noNA
nebsa <- non_ebsa_extract_values_noNA

summary(mpa)
summary(nmpa)
summary(ebsa)
summary(nebsa)

rm(mpa_corrected_extract_values_noNA, non_mpa_extract_values_noNA,
   ebsa_extract_values_noNA, non_ebsa_extract_values_noNA)

################################################################################
#                               MPA - NON-MPA
################################################################################

y <- c(mpa,nmpa)
level_1 <- rep(1, length(mpa))
level_2 <- rep(2, length(nmpa))

# Combine  vectors
combined_vector <- c(level_1, level_2)

# Convert factor
factor_vector <- factor(combined_vector, levels = c(1, 2))
mean_mpa <- tapply(y,factor_vector,mean);mean_mpa

# Variance
variance <- tapply(y,factor_vector,var);variance

# number of observations in each group (np)
# total number of observations (n) 
# number of levels of the factor “group” (levels):
np <- tapply(y,factor_vector,length)
n <- sum(np)
levels1 <- length(np)
# variance calculation (Se2) 
# diagonal matrix (Vμ), 
s2hat <- sum((np-1)*variance)/(n-levels1)
Vmu <- diag(1/np)

#To simulate the posterior distribution,
#we define the quantity od desired samples
m = 5000

# amostra da precisão
tau <- rgamma(m,(n-levels1)/2,s2hat*(n-levels1)/2)

# amostra do desvio padrão (σ)
sigma <- sqrt(1/tau)
med.post <- numeric()

# calculo da média posterior
for(i in 1:m) med.post <- rbind(med.post,mvrnorm(1,as.numeric(mean_mpa),Vmu/tau[i]))
#Um exemplo de sumário estatístico para a amostra da posterior do desvio padrão (σ) seria:
c(quantile(sigma,prob=c(0.025,0.5,0.975)),media=mean(sigma),dp=sd(sigma))
#intervalo de credibilidade (ICr95%) compreende então valores entre 1.46 e 3.18. 
#Sumários estatísticos para os efeitos dos quatro níveis do fator “sitio”
for(i in 1:ncol(med.post)) {print(c(quantile(med.post[,i],prob=c(0.025,0.5,0.975)),  media=mean(med.post[,i]),dp=sd(med.post[,i]))) }
# Distribuição posterior.

#Plot
plot(density(med.post[,1]),xlab="Protected areas",ylab= "Density", main="", xlim=c(40,180), ylim=c(0,1))
lines(density(med.post[,2]),lwd=3,col="red")
#A probabilidade de que μ2 seja maior que μ1 equivale a:
sum(med.post[,1]>med.post[,2])/m
legend("topright",pch=15,c("MPA","Non MPA"),col=c("black","red"))

################################################################################
#                              EBSA - NON-EBSA
################################################################################

y2 <- c(ebsa,nebsa)
level_1_2 <- rep(1, length(ebsa))
level_2_2 <- rep(2, length(nebsa))

# Combine  vectors
combined_vector2 <- c(level_1_2, level_2_2)

# Convert factor
factor_vector2 <- factor(combined_vector2, levels = c(1, 2))
mean_ebsa <- tapply(y2,factor_vector2, mean);mean_ebsa

# Variance
variance2 <- tapply(y2,factor_vector2,var);variance2

# number of observations in each group (np)
# total number of observations (n) 
# number of levels of the factor “group” (levels):
np2 <- tapply(y2,factor_vector2,length)
n2 <- sum(np2)
levels2 <- length(np2)
# variance calculation (Se2) 
# diagonal matrix (Vμ), 
s2hat2 <- sum((np2-1)*variance2)/(n2-levels2)
Vmu2 <- diag(1/np2)

#To simulate the posterior distribution,
#we define the quantity od desired samples
m = 5000

# amostra da precisão
tau2 <- rgamma(m,(n2-levels2)/s2hat2*(n2-levels2)/2)

# amostra do desvio padrão (σ)
sigma2 <- sqrt(1/tau2)
med.post2 <- numeric()

# calculo da média posterior
for(i in 1:m) med.post2 <- rbind(med.post2, mvrnorm(1,as.numeric(mean_ebsa),Vmu2/tau2[i]))
#Um exemplo de sumário estatístico para a amostra da posterior do desvio padrão (σ) seria:
c(quantile(sigma2,prob=c(0.025,0.5,0.975)),media=mean(sigma2),dp=sd(sigma2))
#intervalo de credibilidade (ICr95%) compreende então valores entre 1.46 e 3.18. 
#Sumários estatísticos para os efeitos dos quatro níveis do fator “sitio”
for(i in 1:ncol(med.post2)) {print(c(quantile(med.post2[,i],prob=c(0.025,0.5,0.975)),  media=mean(med.post2[,i]),dp=sd(med.post2[,i]))) }
# Distribuição posterior.

#Plot
plot(density(med.post2[,1]),xlab="EBSA",ylab= "Density", main="", xlim=c(0,180), ylim=c(0,1))
lines(density(med.post2[,2]),lwd=3, col="red")
#A probabilidade de que μ2 seja maior que μ1 equivale a:
sum(med.post2[,1]>med.post2[,2])/m
legend("topright",pch=15,c("EBSA","Non EBSA"),col=c("black","red"))


################################################################################
#                             Ship density by area
################################################################################

#FMestre
#15-10-2024

#Load packages
library(terra)
library(dplyr)

#Load density rasters (terciles)
terciles_reclassified_all_summed <- terra::rast("terciles_reclassified_all_summed.tif")
terciles_reclassified_cargo_summed <- terra::rast("terciles_reclassified_cargo_summed.tif")
terciles_reclassified_tankers_summed <- terra::rast("terciles_reclassified_tankers_summed.tif")
terciles_reclassified_fishing_summed <- terra::rast("terciles_reclassified_fishing_summed.tif")

################################################################################
#                       Marine Protected Area (MPA)
################################################################################

#UNEP-WCMC and IUCN (2024), Protected Planet: The World Database on Protected Areas (WDPA)
#[Online], October 2024, Cambridge, UK: UNEP-WCMC and IUCN. Available at: www.protectedplanet.net.

#mpa <- terra::vect("shapes/mpa_simplified.shp")
mpa <- terra::vect("shapes/MPA_merged_from_WDPA.shp")
#plot(mpa)
#crs(mpa)

# Extract raster values for each polygon
extracted_values_mpa <- extract(terciles_reclassified_all_summed, 
                                mpa)

mpa_df <- as.data.frame(mpa)
mpa_df <- data.frame(1:nrow(mpa_df), mpa_df)
colnames(mpa_df)[1] <- "ID"
#head(mpa_df)

# merge two data frames by ID
extracted_values_mpa_2 <- merge(extracted_values_mpa, mpa_df, by.x = "ID", by.y = "ID")
#head(extracted_values_mpa_2)
names(extracted_values_mpa_2)

# Summarizing the frequency of each class per polygon
summary_table_mpa <- table(extracted_values_mpa_2[,c(2,6)])
summary_table_mpa <- as.data.frame(summary_table_mpa)
#View(summary_table_mpa)

#Convert to percentages
# Group by `Name` and calculate the total frequency for each MPA
summary_table_mpa_df_grouped <- summary_table_mpa %>%
  group_by(NAME) %>%
  mutate(total_freq = sum(Freq))

# Calculate the percentage of each level within each MPA
summary_table_mpa_df_grouped <- summary_table_mpa_df_grouped %>%
  mutate(percentage = (Freq / total_freq) * 100)
# View(summary_table_mpa_df_grouped)

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
  mutate(Name = factor(NAME, levels = high_density_df_mpa$Name)) %>%
  arrange(NAME, grid_float_All_2011_01_converted)
# View(summary_table_mpa_df_grouped_ordered)
# names(summary_table_mpa_df_grouped_ordered)

# Stacked bar plot with ggplot2
#View(summary_table_mpa_df_grouped_ordered)

write.csv(summary_table_mpa_df_grouped_ordered, "summary_table_mpa_df_grouped_ordered.csv")

png("MPA_barplot.png", width = 4000, height = 10000)

ggplot(summary_table_mpa_df_grouped_ordered, aes(x = as.factor(Name), y = percentage, fill = as.factor(grid_float_All_2011_01_converted))) +
  geom_bar(stat = "identity", position = "stack") +
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

dev.off()

################################################################################
#         Ecologically or Biologically Significant Areas (EBSA)
################################################################################

ebsa <- terra::vect("shapes/Ecologically_or_Biologically_Significant_Marine_Areas_(EBSAs).shp")
#plot(ebsa)
#crs(ebsa)

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

# Step 1: Filter the rows where grid_float_All_2011_01_converted == "3" and arrange in descending order
high_density_df_ebsa <- summary_table_ebsa_df_grouped %>%
  filter(grid_float_All_2011_01_converted == "3") %>%
  arrange(desc(percentage))  # Arrange by descending percentage of class 3

# Step 2: Reorder the original data frame based on the ordered NAME from high_density_df_ebsa
summary_table_ebsa_df_grouped_ordered <- summary_table_ebsa_df_grouped %>%
  mutate(NAME = factor(NAME, levels = high_density_df_ebsa$NAME)) %>%
  arrange(NAME, grid_float_All_2011_01_converted)

#Clean EBSA name
ebsa_name <- summary_table_ebsa_df_grouped_ordered$NAME
ebsa_name <- gsub("\\?", "-", ebsa_name)  # Replace "?" with "-"
ebsa_name <- gsub("EBSA No\\. [0-9]+: ", "", ebsa_name)  # Remove "EBSA No. [number]: "
summary_table_ebsa_df_grouped_ordered$NAME <- ebsa_name
# View the result
# View(summary_table_ebsa_df_grouped_ordered)

write.csv(summary_table_ebsa_df_grouped_ordered, "summary_table_ebsa_df_grouped_ordered.csv")

# Stacked bar plot with ggplot2
png("EBSA_barplot.png", width = 3000, height = 5000)

#ggplot(summary_table_ebsa_df_grouped_ordered, aes(x = as.factor(NAME), y = percentage, fill = as.factor(grid_float_All_2011_01_converted))) +
ggplot(summary_table_ebsa_df_grouped_ordered, aes(x = NAME, y = percentage, fill = grid_float_All_2011_01_converted)) +
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
    plot.margin = unit(c(1, 1, 1, 2.5), "cm"),  # Increase left margin (last value) for more space
    axis.text.y = element_text(size = 16, hjust = 1),  # Increase y-axis label font size
    axis.text.x = element_text(size = 16),  # Increase x-axis label font size
    axis.title.y = element_text(size = 16, margin = margin(r = 50)),  # Increase y-axis title font size
    axis.title.x = element_text(size = 16),  # Increase x-axis title font size
    legend.title = element_text(size = 16),  # Increase legend title font size
    legend.text = element_text(size = 14)    # Increase legend text font size
  )

dev.off()

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

write.csv(summary_table_MBR_df_grouped_ordered, "summary_table_MBR_df_grouped_ordered.csv")

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

write.csv(summary_table_eez_df_grouped_ordered, "summary_table_eez_df_grouped_ordered.csv")

png(file="eez_plot.png", width = 2500, height = 10000)

ggplot(summary_table_eez_df_grouped_ordered, aes(x = as.factor(SOVEREIGN1), y = percentage, fill = as.factor(grid_float_All_2011_01_converted))) +
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
    plot.margin = unit(c(1, 1, 1, 2.5), "cm"),  # Increase left margin (last value) for more space
    axis.text.y = element_text(size = 16, hjust = 1),  # Increase y-axis label font size
    axis.text.x = element_text(size = 16),  # Increase x-axis label font size
    axis.title.y = element_text(size = 16, margin = margin(r = 50)),  # Increase y-axis title font size
    axis.title.x = element_text(size = 16),  # Increase x-axis title font size
    legend.title = element_text(size = 16),  # Increase legend title font size
    legend.text = element_text(size = 14)    # Increase legend text font size
  )

dev.off()

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

write.csv(summary_table_meow_df_grouped_ordered, "summary_table_meow_df_grouped_ordered.csv")

png(file="meow_plot.png", width = 2500, height = 5000)

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
    plot.margin = unit(c(1, 1, 1, 2.5), "cm"),  # Increase left margin (last value) for more space
    axis.text.y = element_text(size = 16, hjust = 1),  # Increase y-axis label font size
    axis.text.x = element_text(size = 16),  # Increase x-axis label font size
    axis.title.y = element_text(size = 16, margin = margin(r = 50)),  # Increase y-axis title font size
    axis.title.x = element_text(size = 16),  # Increase x-axis title font size
    legend.title = element_text(size = 16),  # Increase legend title font size
    legend.text = element_text(size = 14)    # Increase legend text font size
  )

dev.off()


################################################################################




