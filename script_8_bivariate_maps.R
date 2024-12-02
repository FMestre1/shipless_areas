################################################################################
#                       Bivariate Choropleth Maps
################################################################################

#FMestre
#30-09-2024

#Load packages
library(data.table)
library(classInt)
library(patchwork)
library(ggplot2)
library(cowplot)
library(rnaturalearth)
library(rnaturalearthdata)

#### 1. Load raster data
#Have to be loaded as rasters of the raster package
all_summed_resampled <- raster::raster("final_rasters/all_summed_resampled_NA.tif")
cargo_summed_resampled <- raster::raster("final_rasters/cargo_summed_resampled_NA.tif")
tankers_summed_resampled <- raster::raster("final_rasters/tankers_summed_resampled_NA.tif")
fishing_summed_resampled <- raster::raster("final_rasters/fishing_summed_resampled_NA.tif")

cetaceans_sr_raster <- raster::raster("final_rasters/cetaceans_sr_raster_NA.tif")
testudines_sr_raster <- raster::raster("final_rasters/testudines_sr_raster_NA.tif")
pinnipeds_sr_raster <- raster::raster("final_rasters/pinnipeds_sr_raster_NA.tif")
seabirds_sr_raster_resampled_cropped_ext <- raster::raster("final_rasters/seabirds_sr_raster_resampled_cropped_ext_NA.tif")


#### 2. Load world vector data
world <- rnaturalearth::ne_coastline(scale = "medium", returnclass = "sf")

#### 3. Get the functions
source("functions1.R")

################################################################################
# Cetaceans
################################################################################

# Create the colour matrix
col.matrix <- colmat(nbreaks = 3, breakstyle = "quantile",
                     xlab = "Ship density", ylab = "Cetacean richness", 
                     bottomright = "#ffcc80", upperright = "#b30000",
                     bottomleft = "#c3b3d8", upperleft = "#240d5e",
                     saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
all_ships_vs_cetaceans <- bivariate.map(rasterx = all_summed_resampled, rastery = cetaceans_sr_raster,
                                        export.colour.matrix = FALSE,
                                        colourmatrix = col.matrix)

# Convert to dataframe for plotting with ggplot
all_ships_vs_cetaceans <- setDT(as.data.frame(all_ships_vs_cetaceans, xy = TRUE))
colnames(all_ships_vs_cetaceans)[3] <- "BivValue"
all_ships_vs_cetaceans_2 <- melt(all_ships_vs_cetaceans, id.vars = c("x", "y"),
                                 measure.vars = "BivValue",
                                 value.name = "bivVal",
                                 variable.name = "Variable")

# Create the map
map_all_ships_cetaceans <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = all_ships_vs_cetaceans_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_all_ships_cetaceans

# Add the title directly to the main plot so it scales with zoom
cetaceans_ships_main_plot_with_title <- map_all_ships_cetaceans + 
  ggtitle("Ship density vs Cetacean Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_cet_ships <- ggdraw() +
  draw_plot(cetaceans_ships_main_plot_with_title) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )


# Show the final plot with a fixed legend and a title that stays visible
tiff("all_ships_cetacean_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_cet_ships
dev.off()

################################################################################
################################################################################
# Cetaceans vs tankers

# create the bivariate raster
tankers_vs_cetaceans <- bivariate.map(rasterx = tankers_summed_resampled, rastery = cetaceans_sr_raster,
                                      export.colour.matrix = FALSE,
                                      colourmatrix = col.matrix)

# Convert to dataframe for plotting with ggplot
tankers_vs_cetaceans <- setDT(as.data.frame(tankers_vs_cetaceans, xy = TRUE))
colnames(tankers_vs_cetaceans)[3] <- "BivValue"
tankers_vs_cetaceans_2 <- melt(tankers_vs_cetaceans, id.vars = c("x", "y"),
                               measure.vars = "BivValue",
                               value.name = "bivVal",
                               variable.name = "Variable")

# Create the map
map_all_ships_cetaceans_tank <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = tankers_vs_cetaceans_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_all_ships_cetaceans_tank

# Add the title directly to the main plot so it scales with zoom
cetaceans_ships_main_plot_with_title_tank <- map_all_ships_cetaceans_tank + 
  ggtitle("Tanker density vs Cetacean Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_cet_ships_tank <- ggdraw() +
  draw_plot(cetaceans_ships_main_plot_with_title_tank) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("tankers_cetacean_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_cet_ships_tank
dev.off()

################################################################################
################################################################################
# Cetaceans vs cargo ships

# create the bivariate raster
cargo_vs_cetaceans <- bivariate.map(rasterx = cargo_summed_resampled, rastery = cetaceans_sr_raster,
                                    export.colour.matrix = FALSE,
                                    colourmatrix = col.matrix)

# Convert to dataframe for plotting with ggplot
cargo_vs_cetaceans <- setDT(as.data.frame(cargo_vs_cetaceans, xy = TRUE))
colnames(cargo_vs_cetaceans)[3] <- "BivValue"
cargo_vs_cetaceans_2 <- melt(cargo_vs_cetaceans, id.vars = c("x", "y"),
                             measure.vars = "BivValue",
                             value.name = "bivVal",
                             variable.name = "Variable")

# Create the map
map_all_ships_cetaceans_cargo <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = cargo_vs_cetaceans_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_all_ships_cetaceans_cargo

# Add the title directly to the main plot so it scales with zoom
cetaceans_ships_main_plot_with_title_cargo <- map_all_ships_cetaceans_cargo + 
  ggtitle("Cargo ships density vs Cetacean Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_cet_ships_cargo <- ggdraw() +
  draw_plot(cetaceans_ships_main_plot_with_title_cargo) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("cargo_cetacean_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_cet_ships_cargo
dev.off()

################################################################################
################################################################################
# Cetaceans vs fishing ships

# create the bivariate raster
fishing_ships_vs_cetaceans <- bivariate.map(rasterx = fishing_summed_resampled, rastery = cetaceans_sr_raster,
                                            export.colour.matrix = FALSE,
                                            colourmatrix = col.matrix)

# Convert to dataframe for plotting with ggplot
fishing_ships_vs_cetaceans <- setDT(as.data.frame(fishing_ships_vs_cetaceans, xy = TRUE))
colnames(fishing_ships_vs_cetaceans)[3] <- "BivValue"
fishing_ships_vs_cetaceans_2 <- melt(fishing_ships_vs_cetaceans, id.vars = c("x", "y"),
                                     measure.vars = "BivValue",
                                     value.name = "bivVal",
                                     variable.name = "Variable")

# Create the map
map_fishing_cetaceans <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = fishing_ships_vs_cetaceans_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_fishing_cetaceans

# Add the title directly to the main plot so it scales with zoom
cetaceans_ships_main_plot_with_title_fisihing <- map_fishing_cetaceans + 
  ggtitle("Fishing ships density vs Cetacean Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_cet_ships_fisihing <- ggdraw() +
  draw_plot(cetaceans_ships_main_plot_with_title_fisihing) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("fishing_cetacean_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_cet_ships_fisihing
dev.off()


################################################################################
# Sea Turtles
################################################################################

# Create the colour matrix
col.matrix2 <- colmat(nbreaks = 3, breakstyle = "quantile",
                      xlab = "Ship density", ylab = "Sea turtle richness", 
                      bottomright = "#ffcc80", upperright = "#b30000",
                      bottomleft = "#c3b3d8", upperleft = "#240d5e",
                      saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
all_ships_vs_turtles <- bivariate.map(rasterx = all_summed_resampled, rastery = testudines_sr_raster,
                                      export.colour.matrix = FALSE,
                                      colourmatrix = col.matrix2)

# Convert to dataframe for plotting with ggplot
all_ships_vs_turtles <- setDT(as.data.frame(all_ships_vs_turtles, xy = TRUE))
colnames(all_ships_vs_turtles)[3] <- "BivValue"
all_ships_vs_turtles_2 <- melt(all_ships_vs_turtles, id.vars = c("x", "y"),
                               measure.vars = "BivValue",
                               value.name = "bivVal",
                               variable.name = "Variable")

# Create the map
map_all_ships_turtles <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = all_ships_vs_turtles_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix2, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_all_ships_turtles

# Add the title directly to the main plot so it scales with zoom
turtles_ships_main_plot_with_title <- map_all_ships_turtles + 
  ggtitle("Ship density vs Sea Turtle Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_turtles_ships <- ggdraw() +
  draw_plot(turtles_ships_main_plot_with_title) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("all_ships_turtles_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_turtles_ships
dev.off()

################################################################################
################################################################################
# Turtles vs tankers

# create the bivariate raster
tankers_vs_turtles <- bivariate.map(rasterx = tankers_summed_resampled, rastery = testudines_sr_raster,
                                    export.colour.matrix = FALSE,
                                    colourmatrix = col.matrix2)

# Convert to dataframe for plotting with ggplot
tankers_vs_turtles <- setDT(as.data.frame(tankers_vs_turtles, xy = TRUE))
colnames(tankers_vs_turtles)[3] <- "BivValue"
tankers_vs_turtles_2 <- melt(tankers_vs_turtles, id.vars = c("x", "y"),
                             measure.vars = "BivValue",
                             value.name = "bivVal",
                             variable.name = "Variable")

# Create the map
map_all_ships_turtles_tank <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = tankers_vs_turtles_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix2, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_all_ships_turtles_tank

# Add the title directly to the main plot so it scales with zoom
turtles_ships_main_plot_with_title_tank <- map_all_ships_turtles_tank + 
  ggtitle("Tanker density vs Sea turtle Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_turtles_ships_tank <- ggdraw() +
  draw_plot(turtles_ships_main_plot_with_title_tank) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("tankers_turtles_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_turtles_ships_tank
dev.off()

################################################################################
################################################################################
# Turtles vs cargo ships

# create the bivariate raster
cargo_vs_turtles <- bivariate.map(rasterx = cargo_summed_resampled, rastery = testudines_sr_raster,
                                  export.colour.matrix = FALSE,
                                  colourmatrix = col.matrix2)

# Convert to dataframe for plotting with ggplot
cargo_vs_turtles <- setDT(as.data.frame(cargo_vs_turtles, xy = TRUE))
colnames(cargo_vs_turtles)[3] <- "BivValue"
cargo_vs_turtles_2 <- melt(cargo_vs_turtles, id.vars = c("x", "y"),
                           measure.vars = "BivValue",
                           value.name = "bivVal",
                           variable.name = "Variable")

# Create the map
map_cargo_turtles <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = cargo_vs_turtles_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix2, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_cargo_turtles

# Add the title directly to the main plot so it scales with zoom
turtles_ships_main_plot_with_title_cargo <- map_cargo_turtles + 
  ggtitle("Cargo ships density vs Sea turtle Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_turtles_ships_cargo <- ggdraw() +
  draw_plot(turtles_ships_main_plot_with_title_cargo) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("cargo_turtles_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_turtles_ships_cargo
dev.off()

################################################################################
################################################################################
# Turtles vs fishing ships

# create the bivariate raster
fishing_vs_turtles <- bivariate.map(rasterx = fishing_summed_resampled, rastery = testudines_sr_raster,
                                    export.colour.matrix = FALSE,
                                    colourmatrix = col.matrix2)

# Convert to dataframe for plotting with ggplot
fishing_vs_turtles <- setDT(as.data.frame(fishing_vs_turtles, xy = TRUE))
colnames(fishing_vs_turtles)[3] <- "BivValue"
fishing_vs_turtles_2 <- melt(fishing_vs_turtles, id.vars = c("x", "y"),
                             measure.vars = "BivValue",
                             value.name = "bivVal",
                             variable.name = "Variable")

# Create the map
map_fishing_turtles <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = fishing_vs_turtles_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix2, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_fishing_turtles

# Add the title directly to the main plot so it scales with zoom
turtles_ships_main_plot_with_title_fishing <- map_fishing_turtles + 
  ggtitle("Fishing ships density vs Sea turtle Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_turtles_ships_fishing <- ggdraw() +
  draw_plot(turtles_ships_main_plot_with_title_fishing) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("fishing_turtles_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_turtles_ships_fishing
dev.off()

################################################################################
# Pinnipeds
################################################################################

# Create the colour matrix
col.matrix3 <- colmat(nbreaks = 3, breakstyle = "quantile",
                      xlab = "Ship density", ylab = "Pinniped richness", 
                      bottomright = "#ffcc80", upperright = "#b30000",
                      bottomleft = "#c3b3d8", upperleft = "#240d5e",
                      saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
all_ships_vs_pinnipeds <- bivariate.map(rasterx = all_summed_resampled, rastery = pinnipeds_sr_raster,
                                        export.colour.matrix = FALSE,
                                        colourmatrix = col.matrix3)

# Convert to dataframe for plotting with ggplot
all_ships_vs_pinnipeds <- setDT(as.data.frame(all_ships_vs_pinnipeds, xy = TRUE))
colnames(all_ships_vs_pinnipeds)[3] <- "BivValue"
all_ships_vs_pinnipeds_2 <- melt(all_ships_vs_pinnipeds, id.vars = c("x", "y"),
                                 measure.vars = "BivValue",
                                 value.name = "bivVal",
                                 variable.name = "Variable")

# Create the map
map_all_ships_pinnipeds <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = all_ships_vs_pinnipeds_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix3, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_all_ships_pinnipeds

# Add the title directly to the main plot so it scales with zoom
pinniped_ships_main_plot_with_title <- map_all_ships_pinnipeds + 
  ggtitle("Ship density vs Sea Pinniped Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_pinniped_ships <- ggdraw() +
  draw_plot(pinniped_ships_main_plot_with_title) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("all_ships_pinnipeds_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_pinniped_ships
dev.off()

################################################################################
################################################################################
# Pinnipeds vs tankers

# create the bivariate raster
tankers_vs_pinnipeds <- bivariate.map(rasterx = tankers_summed_resampled, rastery = pinnipeds_sr_raster,
                                      export.colour.matrix = FALSE,
                                      colourmatrix = col.matrix3)

# Convert to dataframe for plotting with ggplot
tankers_vs_pinnipeds <- setDT(as.data.frame(tankers_vs_pinnipeds, xy = TRUE))
colnames(tankers_vs_pinnipeds)[3] <- "BivValue"
tankers_vs_pinnipeds_2 <- melt(tankers_vs_pinnipeds, id.vars = c("x", "y"),
                               measure.vars = "BivValue",
                               value.name = "bivVal",
                               variable.name = "Variable")

# Create the map
map_all_ships_pinnipeds_tank <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = tankers_vs_pinnipeds_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix3, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_all_ships_pinnipeds_tank

# Add the title directly to the main plot so it scales with zoom
pinnipeds_ships_main_plot_with_title_tank <- map_all_ships_pinnipeds_tank + 
  ggtitle("Tanker density vs Pinniped Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_pinnipeds_ships_tank <- ggdraw() +
  draw_plot(pinnipeds_ships_main_plot_with_title_tank) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("tankers_pinnipeds_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_pinnipeds_ships_tank
dev.off()

################################################################################
################################################################################
# Pinnipeds vs cargo ships

# create the bivariate raster
cargo_vs_pinnipeds <- bivariate.map(rasterx = cargo_summed_resampled, rastery = pinnipeds_sr_raster,
                                    export.colour.matrix = FALSE,
                                    colourmatrix = col.matrix3)

# Convert to dataframe for plotting with ggplot
cargo_vs_pinnipeds <- setDT(as.data.frame(cargo_vs_pinnipeds, xy = TRUE))
colnames(cargo_vs_pinnipeds)[3] <- "BivValue"
cargo_vs_pinnipeds_2 <- melt(cargo_vs_pinnipeds, id.vars = c("x", "y"),
                             measure.vars = "BivValue",
                             value.name = "bivVal",
                             variable.name = "Variable")

# Create the map
map_cargo_pinnipeds <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = cargo_vs_pinnipeds_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix3, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_cargo_pinnipeds

# Add the title directly to the main plot so it scales with zoom
pinnipeds_ships_main_plot_with_title_cargo <- map_cargo_pinnipeds + 
  ggtitle("Cargo ships density vs Pinniped Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_pinnipeds_ships_cargo <- ggdraw() +
  draw_plot(pinnipeds_ships_main_plot_with_title_cargo) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("cargo_pinnipeds_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_pinnipeds_ships_cargo
dev.off()

################################################################################
################################################################################
# Pinnipeds vs fishing ships

# create the bivariate raster
fishing_vs_pinnipeds <- bivariate.map(rasterx = fishing_summed_resampled, rastery = pinnipeds_sr_raster,
                                      export.colour.matrix = FALSE,
                                      colourmatrix = col.matrix3)

# Convert to dataframe for plotting with ggplot
fishing_vs_pinnipeds <- setDT(as.data.frame(fishing_vs_pinnipeds, xy = TRUE))
colnames(fishing_vs_pinnipeds)[3] <- "BivValue"
fishing_vs_pinnipeds_2 <- melt(fishing_vs_pinnipeds, id.vars = c("x", "y"),
                               measure.vars = "BivValue",
                               value.name = "bivVal",
                               variable.name = "Variable")

# Create the map
map_fishing_pinnipeds <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = fishing_vs_pinnipeds_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix3, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_fishing_pinnipeds

# Add the title directly to the main plot so it scales with zoom
pinnipeds_ships_main_plot_with_title_fishing <- map_fishing_pinnipeds + 
  ggtitle("Fishing ships density vs Pinniped Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_pinnipeds_ships_fishing <- ggdraw() +
  draw_plot(pinnipeds_ships_main_plot_with_title_fishing) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("fishing_pinnipeds_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_pinnipeds_ships_fishing
dev.off()


################################################################################
# Seabirds
################################################################################

# Create the colour matrix
col.matrix4 <- colmat(nbreaks = 3, breakstyle = "quantile",
                      xlab = "Ship density", ylab = "Seabird richness", 
                      bottomright = "#ffcc80", upperright = "#b30000",
                      bottomleft = "#c3b3d8", upperleft = "#240d5e",
                      saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster

#ext(seabirds_sr_raster_resampled_cropped) <- ext(pinnipeds_sr_raster)
#seabirds_sr_raster_resampled_cropped_ext <- extend(seabirds_sr_raster_resampled_cropped, ext(pinnipeds_sr_raster))
#terra::writeRaster(seabirds_sr_raster_resampled_cropped_ext, "seabirds_sr_raster_resampled_cropped_ext.tif")

all_ships_vs_seabirds <- bivariate.map(rasterx = all_summed_resampled, rastery = seabirds_sr_raster_resampled_cropped_ext,
                                       export.colour.matrix = FALSE,
                                       colourmatrix = col.matrix4)

# Convert to dataframe for plotting with ggplot
all_ships_vs_seabirds <- setDT(as.data.frame(all_ships_vs_seabirds, xy = TRUE))
colnames(all_ships_vs_seabirds)[3] <- "BivValue"
all_ships_vs_seabirds_2 <- melt(all_ships_vs_seabirds, id.vars = c("x", "y"),
                                measure.vars = "BivValue",
                                value.name = "bivVal",
                                variable.name = "Variable")

# Create the map
map_all_ships_seabirds <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = all_ships_vs_seabirds_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix4, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_all_ships_seabirds

# Add the title directly to the main plot so it scales with zoom
seabirds_ships_main_plot_with_title <- map_all_ships_seabirds + 
  ggtitle("Ship density vs Seabird Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_seabirds_ships <- ggdraw() +
  draw_plot(seabirds_ships_main_plot_with_title) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("all_ships_seabirds_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_seabirds_ships
dev.off()

################################################################################
################################################################################
# Seabirds vs tankers

# create the bivariate raster
tankers_vs_seabirds <- bivariate.map(rasterx = tankers_summed_resampled, rastery = seabirds_sr_raster_resampled_cropped_ext,
                                     export.colour.matrix = FALSE,
                                     colourmatrix = col.matrix4)

# Convert to dataframe for plotting with ggplot
tankers_vs_seabirds <- setDT(as.data.frame(tankers_vs_seabirds, xy = TRUE))
colnames(tankers_vs_seabirds)[3] <- "BivValue"
tankers_vs_seabirds_2 <- melt(tankers_vs_seabirds, id.vars = c("x", "y"),
                              measure.vars = "BivValue",
                              value.name = "bivVal",
                              variable.name = "Variable")

# Create the map
map_all_ships_seabirds_tank <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = tankers_vs_seabirds_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix4, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_all_ships_seabirds_tank

# Add the title directly to the main plot so it scales with zoom
seabirds_ships_main_plot_with_title_tank <- map_all_ships_seabirds_tank + 
  ggtitle("Tanker density vs Seabird Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_seabirds_ships_tank <- ggdraw() +
  draw_plot(seabirds_ships_main_plot_with_title_tank) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("tankers_seabirds_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_seabirds_ships_tank
dev.off()

################################################################################
################################################################################
# Seabirds vs cargo ships

# create the bivariate raster
cargo_vs_seabirds <- bivariate.map(rasterx = cargo_summed_resampled, rastery = seabirds_sr_raster_resampled_cropped_ext,
                                   export.colour.matrix = FALSE,
                                   colourmatrix = col.matrix4)

# Convert to dataframe for plotting with ggplot
cargo_vs_seabirds <- setDT(as.data.frame(cargo_vs_seabirds, xy = TRUE))
colnames(cargo_vs_seabirds)[3] <- "BivValue"
cargo_vs_seabirds_2 <- melt(cargo_vs_seabirds, id.vars = c("x", "y"),
                            measure.vars = "BivValue",
                            value.name = "bivVal",
                            variable.name = "Variable")

# Create the map
map_cargo_seabirds <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = cargo_vs_seabirds_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix4, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_cargo_seabirds

# Add the title directly to the main plot so it scales with zoom
seabirds_ships_main_plot_with_title_cargo <- map_cargo_seabirds + 
  ggtitle("Cargo ships density vs Seabird Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_seabirds_ships_cargo <- ggdraw() +
  draw_plot(seabirds_ships_main_plot_with_title_cargo) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("cargo_seabirds_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_seabirds_ships_cargo
dev.off()

################################################################################
################################################################################
# Seabirds vs fishing ships

# create the bivariate raster
fishing_vs_seabirds <- bivariate.map(rasterx = fishing_summed_resampled, rastery = seabirds_sr_raster_resampled_cropped_ext,
                                     export.colour.matrix = FALSE,
                                     colourmatrix = col.matrix4)

# Convert to dataframe for plotting with ggplot
fishing_vs_seabirds <- setDT(as.data.frame(fishing_vs_seabirds, xy = TRUE))
colnames(fishing_vs_seabirds)[3] <- "BivValue"
fishing_vs_seabirds_2 <- melt(fishing_vs_seabirds, id.vars = c("x", "y"),
                              measure.vars = "BivValue",
                              value.name = "bivVal",
                              variable.name = "Variable")

# Create the map
map_fishing_seabirds <- ggplot() +  # Start with an empty ggplot
  geom_raster(data = fishing_vs_seabirds_2, aes(x = x, y = y, fill = bivVal)) +
  scale_fill_gradientn(colours = col.matrix4, na.value = "transparent") + 
  # General theme adjustments
  theme_bw() +
  theme(text = element_text(size = 10, colour = "black")) +
  # Add world borders using geom_sf
  geom_sf(data = world, fill = NA, colour = "black", size = 0.4) +  # Outline continents only
  # Use coord_sf() to keep aspect ratio and avoid cropping the map
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE) +  # Set full limits for global view
  # Customize legend and background
  theme(legend.position = "none",
        plot.background = element_blank(),
        strip.text = element_text(size = 12, colour = "black"),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 12, colour = "black"),
        axis.title = element_text(size = 12, colour = "black")) +
  # Axis labels
  labs(x = "Longitude", y = "Latitude")

# Print the final map
map_fishing_seabirds

# Add the title directly to the main plot so it scales with zoom
seabirds_ships_main_plot_with_title_fishing <- map_fishing_seabirds + 
  ggtitle("Fishing ships density vs Seabird Richness") + 
  theme(
    plot.title = element_text(
      size = 16,       # Adjust title font size
      face = "bold",   # Bold title
      hjust = 0.5      # Center the title
    )
  )

# Now, use cowplot to draw the legend in a fixed position aligned with the x-axis
final_plot_seabirds_ships_fishing <- ggdraw() +
  draw_plot(seabirds_ships_main_plot_with_title_fishing) +  # Add the main plot with title
  draw_plot(
    BivLegend + theme(
      plot.background = element_rect(fill = "white", colour = NA),  # Background for the legend
      legend.title = element_text(size = 6),  # Adjust legend text size
      legend.text = element_text(size = 6)
    ), 
    x = 0.05,  # X position (left aligned)
    y = 0.15,  # Align the legend with the x-axis
    width = 0.25,  # Legend width
    height = 0.25  # Legend height
  )

# Show the final plot with a fixed legend and a title that stays visible
tiff("fishing_seabirds_02DEZ24.tif", width=5000, height=2900, res=300)
final_plot_seabirds_ships_fishing
dev.off()

