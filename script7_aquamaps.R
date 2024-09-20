library(devtools)
#devtools::install_github("raquamaps/aquamapsdata", dependencies = TRUE)
library(aquamapsdata)
#https://github.com/raquamaps/aquamapsdata

library(leaflet)
library(terra)    # For working with raster data
library(dplyr)    # For data manipulation if needed

# downloads about 2 GB of data, approx 10 GB when unpacked
?aquamapsdata::download_db
#download_db()
#default_db("sqlite")
#am_citation()

#... unpacking /tmp/am.db.bz2 to ~/.config/aquamaps/am.db

# include a citation in text format
am_citation()

#Connect to database
db <- aquamapsdata::con_am()

################################################################################

#devtools::install_github("raquamaps/raquamaps")  
library(raquamaps)

#See
#https://raquamaps.github.io/raquamaps-intro.html




