################################################################################
#                       Bivariate Choropleth Maps
################################################################################

#FMestre
#18-09-2024

#https://timogrossenbacher.ch/bivariate-maps-with-ggplot2-and-sf/
#https://cran.r-project.org/web/packages/biscale/vignettes/biscale.html

#install.packages("biscale", dependencies = TRUE)
library("biscale")

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







