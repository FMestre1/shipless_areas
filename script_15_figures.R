################################################################################
#                                   Figures            
################################################################################

#FAscensão
#13-05-2025

library(ggplot2)
library(terra)
library(exactextractr)
library(ggrepel)
library(gridExtra)
library(dplyr)
library(tidyterra)

################################################################################
# Figure 1
################################################################################

#rm(list=ls())

################################################################################
# Figure 2
################################################################################

rm(list=ls())

coastline <- terra::vect("shapes/continents_close_seas.shp")

biodiv_terciles <- terra::rast("tercile_rasters/terciles_reclassified_all_biodiv_20JAN25.tif")
ships_terciles <- terra::rast("tercile_rasters/terciles_reclassified_all_summed_02FEV25.tif")
bivariate_total <- terra::rast("final_bivariate/bivariate_global_20250129.tif")
areas_pma_ppa <- terra::rast("PMA_PPA_shipless_areas/priority_global_20250129.tif")

#Project
target_crs <- "+proj=robin +over"
#
coast_proj <- terra::project(coastline, target_crs)
#
biodiv_terciles_proj <- project(biodiv_terciles, target_crs, method = "near")
ships_terciles_proj <- project(ships_terciles, target_crs, method = "near")
bivariate_total_proj <- project(bivariate_total, target_crs, method = "near")
areas_pma_ppa_proj <- project(areas_pma_ppa, target_crs, method = "near")


#BIODIVERSITY --------------

# Convert raster to categorical
biodiv_terciles_proj <- terra::as.factor(biodiv_terciles_proj)

# Optional: set factor labels
levels(biodiv_terciles_proj) <- data.frame(
  ID = c(1, 2, 3),
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
    fill = "darkgrey", 
    color = "darkgrey", 
    linewidth = 0.8
  ) +
  labs(title = "Species Richness") +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5)  # This centers the title
  )

#SHIPS --------------

# Convert raster to categorical
ships_terciles_proj <- terra::as.factor(ships_terciles_proj)

# Optional: set factor labels
levels(ships_terciles_proj) <- data.frame(
  ID = c(1, 2, 3),
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
    fill = "darkgrey", 
    color = "darkgrey", 
    linewidth = 0.8
  ) +
  labs(title = "Ship Density") +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5)  # This centers the title
  )
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
    fill = "darkgrey", 
    color = "darkgrey", 
    linewidth = 0.8
  ) +
  labs(title = "Priority Areas") +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5)  # This centers the title
  )

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
    fill = "darkgrey", 
    color = "darkgrey", 
    linewidth = 0.8
  ) +
  labs(title = "Species Richness vs Ship Density") +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(hjust = 0.5)  # This centers the title
  )

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
