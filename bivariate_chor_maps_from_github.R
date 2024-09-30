

#Palettes
#https://cran.r-project.org/web/packages/biscale/vignettes/bivariate_palettes.html
# test1 <- biscale::bi_pal(pal = "Bluegill", dim = 3, flip_axes = TRUE)


#https://gist.github.com/scbrown86/2779137a9378df7b60afd23e0c45c188#file-bivarrasterplot-r


#Load packages
library(data.table)
library(terra)
library(classInt)
library(patchwork)


#Functions
colmat2 <- function(nbreaks = 3, breakstyle = "quantile",
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


bivariate.map2 <- function(rasterx, rastery, colourmatrix = col.matrix,
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


  
  # Define the number of breaks
  nBreaks <- 3
  
  
  # Create the colour matrix
  col.matrixQ <- colmat2(nbreaks = nBreaks, breakstyle = "quantile",
                        xlab = "Ship density", ylab = "Cetacean richness", 
                        bottomright = "#4885C1", upperright = "#3F2949",
                        bottomleft = "#CABED0", upperleft = "#AE3A4E",
                        saveLeg = FALSE, plotLeg = TRUE)
  
  # create the bivariate raster

 bivmapQ <- bivariate.map2(rasterx = terciles_reclassified_all_summed, rastery = terciles_reclassified_cetaceans,
#  bivmapQ <- bivariate.map2(rasterx = all_summed, rastery = cetaceans_sr_raster,
                           export.colour.matrix = FALSE,
                           colourmatrix = col.matrixQ)
  
  
    # Convert to dataframe for plotting with ggplot
  bivMapDFQ <- setDT(as.data.frame(bivmapQ, xy = TRUE))
  colnames(bivMapDFQ)[3] <- "BivValue"
  bivMapDFQ <- melt(bivMapDFQ, id.vars = c("x", "y"),
                    measure.vars = "BivValue",
                    value.name = "bivVal",
                    variable.name = "Variable")
  
  # Make the map using ggplot
  map_q <- ggplot(bivMapDFQ, aes(x = x, y = y)) +
    geom_raster(aes(fill = bivVal)) +
    scale_y_continuous(breaks = seq(-20, 60, by = 10), 
                       labels = paste0(seq(-20, 60, 10), "°")) +
    scale_x_continuous(breaks = seq(50, 175, 25), 
                       labels = paste0(seq(50, 175, 25), "°")) +
    scale_fill_gradientn(colours = col.matrixQ, na.value = "transparent") + 
    theme_bw() +
    theme(text = element_text(size = 10, colour = "black")) +
    borders(colour = "black", size = 0.5) +
    coord_quickmap(expand = FALSE, xlim = c(-180, 180), ylim = c(-90, 90)) +  # Adjusted limits for global view
    theme(legend.position = "none",
          plot.background = element_blank(),
          strip.text = element_text(size = 12, colour = "black"),
          axis.text.y = element_text(angle = 90, hjust = 0.5),
          axis.text = element_text(size = 12, colour = "black"),
          axis.title = element_text(size = 12, colour = "black")) +
    labs(x = "Longitude", y = "Latitude")
  
  map_q
  
  
  ########################################################################################################################### 
  
  # Using different breaks algorithm
  # Create the colour matrix
  col.matrixF <- colmat2(nbreaks = nBreaks, breakstyle = "fisher",
                        xlab = "Ship density", ylab = "Cetacean Richness", 
                        bottomright = "#F7900A", upperright = "#993A65",
                        bottomleft = "#44B360", upperleft = "#3A88B5",
                        saveLeg = FALSE, plotLeg = TRUE)
  
  # create the bivariate raster
  
  bivmapF <- bivariate.map2(rasterx = terciles_reclassified_all_summed, rastery = terciles_reclassified_cetaceans,
                            export.colour.matrix = FALSE,
                           colourmatrix = col.matrixF)
  
  bivMapDFF <- setDT(as.data.frame(bivmapF, xy = TRUE))
  
  colnames(bivMapDFF)[3] <- "BivValue"
  
  bivMapDFF <- melt(bivMapDFF, id.vars = c("x", "y"),
                    measure.vars = "BivValue",
                    value.name = "bivVal",
                    variable.name = "Variable")
  
  # Make the map using ggplot
  map_F <- ggplot(bivMapDFF, aes(x = x, y = y)) +
    geom_raster(aes(fill = bivVal)) +
    scale_y_continuous(breaks = seq(-20, 60, by = 10), 
                       labels = paste0(seq(-20, 60, 10), "°")) +
    scale_x_continuous(breaks = seq(50,175,25), 
                       labels = paste0(seq(50,175,25), "°")) +
    scale_fill_gradientn(colours = col.matrixF, na.value = "transparent") + 
    theme_bw() +
    theme(text = element_text(size = 10, colour = "black")) +
    borders(colour = "black", size = 0.5) +
    coord_quickmap(expand = FALSE, xlim = c(-180, 180), ylim = c(-90, 90)) +  # Adjusted limits for global view
    theme(legend.position = "none",
          plot.background = element_blank(),
          strip.text = element_text(size = 12, colour = "black"),
          axis.text.y = element_text(angle = 90, hjust = 0.5),
          axis.text = element_text(size = 12, colour = "black"),
          axis.title = element_text(size = 12, colour = "black")) +
    labs(x = "Longitude", y = "Latitude")
  
  fig <- {{map_q + ggtitle("Quantile breaks")} / {map_F + ggtitle("Fisher breaks")} } + 
    inset_element(BivLegend + theme(plot.background = element_rect(fill = "white",
                                                                   colour = NA)), 
                  left = 0.5, bottom = 0.5, right = 1.2, top = 0.90,
                  align_to = "full") +
    plot_annotation(caption = "Both plots are made on the same data, but have breaks defined differently")
  
  fig
 
  ###########################################################################################################################
  
   # Save
  ggplot2::ggsave(plot = fig,
         filename = "BivariatePlot_ggsave.pdf",
         device = "pdf", path = "./",
         width = 6, height = 7, units = "in",
         dpi = 320)

