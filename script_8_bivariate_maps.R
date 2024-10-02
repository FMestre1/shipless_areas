################################################################################
#                       Bivariate Choropleth Maps
################################################################################

#FMestre
#30-09-2024

#Load packages
library(data.table)
library(terra)
library(classInt)
library(patchwork)
library(ggplot2)
library(cowplot)
library(rnaturalearth)
library(rnaturalearthdata)


#### 1. Load ship density maps

all_summed_resampled <- terra::rast("all_summed_resampled.tif")
cargo_summed_resampled <- terra::rast("cargo_summed_resampled.tif")
tankers_summed_resampled <- terra::rast("tankers_summed_resampled.tif")
fishing_summed_resampled <- terra::rast("fishing_summed_resampled.tif")

# CCMAR computer
all_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_all/all_summed.tif")
cargo_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_cargo/cargo_summed.tif")
tankers_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_tankers/tankers_summed.tif")
fishing_summed <- terra::rast("/media/fredmestre/FMestre/shipless_areas/sum_fishing/fishing_summed.tif")

# My disk
all_summed <- terra::rast("E:/shipless_areas/all_summed.tif")
cargo_summed <- terra::rast("E:/shipless_areas/cargo_summed.tif")
tankers_summed <- terra::rast("E:/shipless_areas/tankers_summed.tif")
fishing_summed <- terra::rast("E:/shipless_areas/fishing_summed.tif")
#
#plot(all_summed)
#plot(cargo_summed)
#plot(tankers_summed)
#plot(fishing_summed)

#### 2. Load species richness maps
cetaceans_sr_raster <- terra::rast("cetaceans_sr_raster.tif")
testudines_sr_raster <- terra::rast("testudines_sr_raster.tif")
pinnipeds_sr_raster <- terra::rast("pinnipeds_sr_raster.tif")
#

#Required functions

#adapted from:
#https://gist.github.com/scbrown86/2779137a9378df7b60afd23e0c45c188#file-bivarrasterplot-r

colmat <- function(nbreaks = 3, breakstyle = "quantile",
                   upperleft = "#0096EB", upperright = "#820050", 
                   bottomleft = "#BEBEBE", bottomright = "#FFE60F",
                   xlab = "x label", ylab = "y label", plotLeg = TRUE,
                   saveLeg = FALSE) {
  # Load required libraries
  library(terra)
  require(ggplot2)
  require(classInt)
  require(data.table)
  
  if (breakstyle == "sd") {
    warning("SD breaks style cannot be used.\nWill not always return the correct number of breaks.\nSee classInt::classIntervals() for details.\nResetting to quantile",
            call. = FALSE, immediate. = FALSE)
    breakstyle <- "quantile"
  }
  
  my.data <- seq(0, 1, .01)
  my.class <- classInt::classIntervals(my.data, n = nbreaks, style = breakstyle)
  my.pal.1 <- classInt::findColours(my.class, c(upperleft, bottomleft))
  my.pal.2 <- classInt::findColours(my.class, c(upperright, bottomright))
  
  col.matrix <- matrix(nrow = 101, ncol = 101, NA)
  
  for (i in 1:101) {
    my.col <- c(paste(my.pal.1[i]), paste(my.pal.2[i]))
    col.matrix[102 - i, ] <- classInt::findColours(my.class, my.col)
  }
  
  # Convert the matrix into a data.table for plotting
  col.matrix.dt <- as.data.table(as.data.frame(col.matrix))
  col.matrix.dt[, Y := .I]  # Create a Y column as row number
  
  # Melt the data.table to long format
  col.matrix.dt <- melt(col.matrix.dt, id.vars = "Y", variable.name = "X", value.name = "HEXCode")
  
  # Convert X to integer by removing the "V" from the column names
  col.matrix.dt[, X := as.integer(sub("V", "", X))]
  
  # Remove duplicates and reverse the Y column
  col.matrix.dt <- col.matrix.dt[!duplicated(HEXCode)]
  col.matrix.dt[, Y := rev(Y)]
  
  # Adjust X and Y for plotting
  col.matrix.dt[, `:=`(Y = rep(1:nbreaks, each = nbreaks), X = rep(1:nbreaks, times = nbreaks))]
  col.matrix.dt[, UID := .I]  # Create a UID column
  
  # Plot the legend if needed
  if (plotLeg) {
    p <- ggplot(col.matrix.dt, aes(X, Y, fill = HEXCode)) +
      geom_tile() +
      scale_fill_identity() +
      coord_equal(expand = FALSE) +
      theme_void() +
      theme(aspect.ratio = 1,
            axis.title = element_text(size = 12, colour = "black", hjust = 0.5, vjust = 1),
            axis.title.y = element_text(angle = 90, hjust = 0.5)) +
      xlab(bquote(.(xlab) ~  symbol("\256"))) +
      ylab(bquote(.(ylab) ~  symbol("\256")))
    
    print(p)
    assign("BivLegend", p, envir = .GlobalEnv)
  }
  
  # Save the legend if required
  if (saveLeg) {
    ggsave(filename = "bivLegend.pdf", plot = p, device = "pdf",
           path = "./", width = 4, height = 4, units = "in", dpi = 300)
  }
  
  seqs <- seq(0, 100, length.out = nbreaks + 1)
  seqs[1] <- 1
  col.matrix <- col.matrix[seqs, seqs]
  
  attr(col.matrix, "breakstyle") <- breakstyle
  attr(col.matrix, "nbreaks") <- nbreaks
  
  return(col.matrix)
}


bivariate.map <- function(rasterx, rastery, colourmatrix = col.matrix,
                          export.colour.matrix = TRUE,
                          outname = paste0("colMatrix_rasValues", names(rasterx))) {
  # Load required libraries
  require(terra)
  require(classInt)
  
  # Export colour matrix to a data.frame in the global environment if specified
  quanx <- values(rasterx)
  tempx <- data.frame(quanx = quanx, quantile = rep(NA, length(quanx)))
  brks <- with(tempx, classIntervals(quanx,
                                     n = attr(colourmatrix, "nbreaks"),
                                     style = attr(colourmatrix, "breakstyle"))$brks)
  
  # Add small noise to breaks
  brks[-1] <- brks[-1] + seq_along(brks[-1]) * .Machine$double.eps
  r1 <- within(tempx, quantile <- cut(quanx,
                                      breaks = brks,
                                      labels = 2:length(brks),
                                      include.lowest = TRUE))
  quantr <- data.frame(r1[, 2])
  
  quany <- values(rastery)
  tempy <- data.frame(quany = quany, quantile = rep(NA, length(quany)))
  brksy <- with(tempy, classIntervals(quany,
                                      n = attr(colourmatrix, "nbreaks"),
                                      style = attr(colourmatrix, "breakstyle"))$brks)
  
  brksy[-1] <- brksy[-1] + seq_along(brksy[-1]) * .Machine$double.eps
  r2 <- within(tempy, quantile <- cut(quany,
                                      breaks = brksy,
                                      labels = 2:length(brksy),
                                      include.lowest = TRUE))
  quantr2 <- data.frame(r2[, 2])
  
  as.numeric.factor <- function(x) {
    as.numeric(levels(x))[x]
  }
  
  col.matrix2 <- colourmatrix
  cn <- unique(colourmatrix)
  
  for (i in 1:length(col.matrix2)) {
    ifelse(is.na(col.matrix2[i]),
           col.matrix2[i] <- 1, 
           col.matrix2[i] <- which(col.matrix2[i] == cn)[1]
    )
  }
  
  # Export the colour matrix to data.frame in the global environment
  if (export.colour.matrix) {
    exportCols <- as.data.frame(cbind(
      as.vector(col.matrix2), 
      as.vector(colourmatrix), 
      t(col2rgb(as.vector(colourmatrix)))
    ))
    colnames(exportCols)[1:2] <- c("rasValue", "HEX")
    
    # Export to the global environment
    assign(
      x = outname,
      value = exportCols,
      pos = .GlobalEnv
    )
  }
  
  cols <- numeric(length(quantr[, 1]))
  
  for (i in 1:length(quantr[, 1])) {
    a <- as.numeric.factor(quantr[i, 1])
    b <- as.numeric.factor(quantr2[i, 1])
    cols[i] <- as.numeric(col.matrix2[b, a])
  }
  
  # Create a new raster from the modified values
  r <- rasterx
  values(r) <- cols  # Assign new values to raster
  
  return(r)
}

#Load world vector data
world <- ne_coastline(scale = "medium", returnclass = "sf")


################################################################################
################################################################################
# Cetaceans

# Create the colour matrix
col.matrix <- colmat(nbreaks = 3, breakstyle = "quantile",
                        xlab = "Ship density", ylab = "Cetacean richness", 
                        bottomright = "#4885C1", upperright = "#3F2949",
                        bottomleft = "#CABED0", upperleft = "#AE3A4E",
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
final_plot_cet_ships

################################################################################
################################################################################
# Sea Turtles

# Create the colour matrix
col.matrix2 <- colmat(nbreaks = 3, breakstyle = "quantile",
                     xlab = "Ship density", ylab = "Sea turtle richness", 
                     bottomright = "#4885C1", upperright = "#3F2949",
                     bottomleft = "#CABED0", upperleft = "#AE3A4E",
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
final_plot_turtles_ships


################################################################################
################################################################################
# Pinnipeds

# Create the colour matrix
col.matrix3 <- colmat(nbreaks = 3, breakstyle = "quantile",
                      xlab = "Ship density", ylab = "Pinniped richness", 
                      bottomright = "#4885C1", upperright = "#3F2949",
                      bottomleft = "#CABED0", upperleft = "#AE3A4E",
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
final_plot_pinniped_ships

################################################################################
################################################################################
# Cetaceans vs tankers

# Create the colour matrix
col.matrix4 <- colmat(nbreaks = 3, breakstyle = "quantile",
                     xlab = "Tanker density", ylab = "Cetacean richness", 
                     bottomright = "#4885C1", upperright = "#3F2949",
                     bottomleft = "#CABED0", upperleft = "#AE3A4E",
                     saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
tankers_vs_cetaceans <- bivariate.map(rasterx = tankers_summed_resampled, rastery = cetaceans_sr_raster,
                                        export.colour.matrix = FALSE,
                                        colourmatrix = col.matrix4)

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
final_plot_cet_ships_tank

################################################################################
################################################################################
# Cetaceans vs cargo ships

# Create the colour matrix
col.matrix5 <- colmat(nbreaks = 3, breakstyle = "quantile",
                      xlab = "Cargo ship density", ylab = "Cetacean richness", 
                      bottomright = "#4885C1", upperright = "#3F2949",
                      bottomleft = "#CABED0", upperleft = "#AE3A4E",
                      saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
cargo_vs_cetaceans <- bivariate.map(rasterx = cargo_summed_resampled, rastery = cetaceans_sr_raster,
                                              export.colour.matrix = FALSE,
                                              colourmatrix = col.matrix5)

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
  scale_fill_gradientn(colours = col.matrix5, na.value = "transparent") + 
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
final_plot_cet_ships_cargo

################################################################################
################################################################################
# Cetaceans vs fishing ships

# Create the colour matrix
col.matrix6 <- colmat(nbreaks = 3, breakstyle = "quantile",
                      xlab = "Fishing ship density", ylab = "Cetacean richness", 
                      bottomright = "#4885C1", upperright = "#3F2949",
                      bottomleft = "#CABED0", upperleft = "#AE3A4E",
                      saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
fishing_ships_vs_cetaceans <- bivariate.map(rasterx = fishing_summed_resampled, rastery = cetaceans_sr_raster,
                                            export.colour.matrix = FALSE,
                                            colourmatrix = col.matrix6)

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
  scale_fill_gradientn(colours = col.matrix6, na.value = "transparent") + 
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
final_plot_cet_ships_fisihing

################################################################################
################################################################################
# Turtles vs tankers

# Create the colour matrix
col.matrix7 <- colmat(nbreaks = 3, breakstyle = "quantile",
                      xlab = "Tanker density", ylab = "Sea turtles richness", 
                      bottomright = "#4885C1", upperright = "#3F2949",
                      bottomleft = "#CABED0", upperleft = "#AE3A4E",
                      saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
tankers_vs_turtles <- bivariate.map(rasterx = tankers_summed_resampled, rastery = testudines_sr_raster,
                                    export.colour.matrix = FALSE,
                                    colourmatrix = col.matrix7)

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
  scale_fill_gradientn(colours = col.matrix7, na.value = "transparent") + 
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
final_plot_turtles_ships_tank

################################################################################
################################################################################
# Turtles vs cargo ships

# Create the colour matrix
col.matrix8 <- colmat(nbreaks = 3, breakstyle = "quantile",
                      xlab = "Cargo ships density", ylab = "Sea turtles richness", 
                      bottomright = "#4885C1", upperright = "#3F2949",
                      bottomleft = "#CABED0", upperleft = "#AE3A4E",
                      saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
cargo_vs_turtles <- bivariate.map(rasterx = cargo_summed_resampled, rastery = testudines_sr_raster,
                                  export.colour.matrix = FALSE,
                                  colourmatrix = col.matrix8)

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
  scale_fill_gradientn(colours = col.matrix8, na.value = "transparent") + 
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
  ggtitle("Cargo ship density vs Sea turtle Richness") + 
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
final_plot_turtles_ships_cargo

################################################################################
################################################################################
# Turtles vs fishing ships

# Create the colour matrix
col.matrix9 <- colmat(nbreaks = 3, breakstyle = "quantile",
                      xlab = "Fishing ships density", ylab = "Sea turtles richness", 
                      bottomright = "#4885C1", upperright = "#3F2949",
                      bottomleft = "#CABED0", upperleft = "#AE3A4E",
                      saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
fishing_vs_turtles <- bivariate.map(rasterx = fishing_summed_resampled, rastery = testudines_sr_raster,
                                    export.colour.matrix = FALSE,
                                    colourmatrix = col.matrix9)

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
  scale_fill_gradientn(colours = col.matrix9, na.value = "transparent") + 
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
  ggtitle("Fishing ship density vs Sea turtle Richness") + 
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
final_plot_turtles_ships_fishing

################################################################################
################################################################################
# Pinnipeds vs tankers

# Create the colour matrix
col.matrix10 <- colmat(nbreaks = 3, breakstyle = "quantile",
                       xlab = "Tanker density", ylab = "Pinnipeds richness", 
                       bottomright = "#4885C1", upperright = "#3F2949",
                       bottomleft = "#CABED0", upperleft = "#AE3A4E",
                       saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
tankers_vs_pinnipeds <- bivariate.map(rasterx = tankers_summed_resampled, rastery = pinnipeds_sr_raster,
                                      export.colour.matrix = FALSE,
                                      colourmatrix = col.matrix10)

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
  scale_fill_gradientn(colours = col.matrix10, na.value = "transparent") + 
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
final_plot_pinnipeds_ships_tank

################################################################################
################################################################################
# Pinnipeds vs cargo ships

# Create the colour matrix
col.matrix11 <- colmat(nbreaks = 3, breakstyle = "quantile",
                       xlab = "Cargo ships density", ylab = "Pinnipeds richness", 
                       bottomright = "#4885C1", upperright = "#3F2949",
                       bottomleft = "#CABED0", upperleft = "#AE3A4E",
                       saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
cargo_vs_pinnipeds <- bivariate.map(rasterx = cargo_summed_resampled, rastery = pinnipeds_sr_raster,
                                    export.colour.matrix = FALSE,
                                    colourmatrix = col.matrix11)

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
  scale_fill_gradientn(colours = col.matrix11, na.value = "transparent") + 
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
  ggtitle("Cargo ship density vs Pinniped Richness") + 
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
final_plot_pinnipeds_ships_cargo

################################################################################
################################################################################
# Pinnipeds vs fishing ships

# Create the colour matrix
col.matrix12 <- colmat(nbreaks = 3, breakstyle = "quantile",
                       xlab = "Fishing ships density", ylab = "Pinnipeds richness", 
                       bottomright = "#4885C1", upperright = "#3F2949",
                       bottomleft = "#CABED0", upperleft = "#AE3A4E",
                       saveLeg = FALSE, plotLeg = TRUE)

# create the bivariate raster
fishing_vs_pinnipeds <- bivariate.map(rasterx = fishing_summed_resampled, rastery = pinnipeds_sr_raster,
                                      export.colour.matrix = FALSE,
                                      colourmatrix = col.matrix12)

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
  scale_fill_gradientn(colours = col.matrix12, na.value = "transparent") + 
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
  ggtitle("Fishing ship density vs Pinniped Richness") + 
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
final_plot_pinnipeds_ships_fishing

################################################################################
################################################################################



