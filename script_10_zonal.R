################################################################################
#                    Plot ship density by area - MAPS
################################################################################

#FMestre
#22-10-2024

#Load packages
library(terra)
library(dplyr)

#Load density rasters (terciles)
terciles_reclassified_all_summed_2 <- terra::rast("terciles_reclassified_all_summed.tif")
terciles_reclassified_all_summed_2[is.na(terciles_reclassified_all_summed_2)] <- 0

# Vectors of the areas
mpa <- terra::vect("shapes/mpa_simplified.shp")
ebsa <- terra::vect("shapes/Ecologically_or_Biologically_Significant_Marine_Areas_(EBSAs).shp")
marine_realms <- terra::vect("shapes/marineRealms.shp")
eez <- terra::vect("shapes/eez_v12.shp")
meow <- terra::vect("shapes/meow_ecos.shp")

#Coastline
coastline <- terra::vect("shapes/coastline.shp")

# Aonal statistics
counted_values_MBR <- terra::zonal(terciles_reclassified_all_summed_2, 
                                   marine_realms, fun = "mean",
                                   as.raster = TRUE)

counted_values_MPA <- terra::zonal(terciles_reclassified_all_summed_2, 
                                   mpa, fun = "mean",
                                   as.raster = TRUE)

counted_values_EBSA <- terra::zonal(terciles_reclassified_all_summed_2, 
                                    ebsa, fun = "mean",
                                   as.raster = TRUE)

counted_values_EEZ <- terra::zonal(terciles_reclassified_all_summed_2, 
                                    eez, fun = "mean",
                                    as.raster = TRUE)

counted_values_MEOW <- terra::zonal(terciles_reclassified_all_summed_2, 
                                    meow, fun = "mean",
                                   as.raster = TRUE)


terra::writeRaster(counted_values_MBR, "counted_values_MBR.tif")
terra::writeRaster(counted_values_MPA, "counted_values_MPA.tif")
terra::writeRaster(counted_values_EBSA, "counted_values_EBSA.tif")
terra::writeRaster(counted_values_EEZ, "counted_values_EEZ.tif")
terra::writeRaster(counted_values_MBR, "counted_values_MBR.tif")
terra::writeRaster(counted_values_MEOW, "counted_values_MEOW.tif")



library(terra)

# Define a custom palette from green to red
green_to_red_palette <- colorRampPalette(c("navajowhite", "#CD8500", "#CD0000"))

# Plot using the custom palette

png("map_mbr.png", width = 2000, height = 1000)
terra::plot(counted_values_MBR, col = green_to_red_palette(100))
terra::plot(coastline, add = TRUE)
dev.off()

png("map_mpa.png", width = 2000, height = 1000)
terra::plot(counted_values_MPA, col = green_to_red_palette(100))
terra::plot(coastline, add = TRUE)
dev.off()

png("map_ebsa.png", width = 2000, height = 1000)
terra::plot(counted_values_EBSA, col = green_to_red_palette(100))
terra::plot(coastline, add = TRUE)
dev.off()

png("map_eez.png", width = 2000, height = 1000)
terra::plot(counted_values_EEZ, col = green_to_red_palette(100))
terra::plot(coastline, add = TRUE)
dev.off()

png("map_meow.png", width = 2000, height = 1000)
terra::plot(counted_values_MEOW, col = green_to_red_palette(100))
terra::plot(coastline, add = TRUE)
dev.off()


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

#Plot - fig 7
ggplot(percentage_in_out_MPA, aes(fill=MPA, y=percentage, x=ship_density)) + 
  geom_bar(position="dodge", stat="identity") +
  labs(x = "Ship Density", y = "Percentage", fill = "MPA") +
  geom_text(aes(label = paste0(percentage, "%")), position = position_dodge(width = 1), vjust = -0.5) +
  scale_x_discrete(labels = c("Low (first tercile)", "Medium (second tercile)", "High (third tercile)")) +
  scale_fill_manual(values = c("inside" = "blue", "outside" = "red"))






