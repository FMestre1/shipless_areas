################################################################################
#                       Bivariate Choropleth Maps
################################################################################

#FMestre
#18-09-2024

#https://timogrossenbacher.ch/bivariate-maps-with-ggplot2-and-sf/
#https://cran.r-project.org/web/packages/biscale/vignettes/biscale.html

library(biscale)
library(terra)

#### 1. Load ship density maps
all_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_all/all_summed.tif")
cargo_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_cargo/cargo_summed.tif")
tankers_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_tankers/tankers_summed.tif")
fishing_summed <- terra::rast("/media/jorgeassis/FMestre/shipless_areas/sum_fishing/fishing_summed.tif")
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
#plot(cetaceans_sr_raster)
#plot(testudines_sr_raster)
#plot(pinnipeds_sr_raster)


#### 3. Same resolution and extent

# 3.1. Check CRS of both rasters
terra::crs(all_summed)
terra::crs(cargo_summed)
terra::crs(tankers_summed)
terra::crs(fishing_summed)
#
terra::crs(cetaceans_sr_raster)
terra::crs(testudines_sr_raster)
terra::crs(pinnipeds_sr_raster)


# 3.2. Align rastes
raster2_aligned <- resample(raster2, raster1, method = "bilinear")  # You can use "bilinear" or "near"



# create classes
?bi_class
data <- biscale::bi_class(stl_race_income, x = pctWhite, y = medInc, style = "quantile", dim = 3)

# create map
map <- ggplot() +
  geom_sf(data = data, mapping = aes(fill = bi_class), color = "white", size = 0.1, show.legend = FALSE) +
  bi_scale_fill(pal = "GrPink", dim = 3) +
  labs(
    title = "Race and Income in St. Louis, MO",
    subtitle = "Gray Pink (GrPink) Palette"
  ) +
  bi_theme()







