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






