################################################################################
#                   GETTING SPECIES RANGES MAP FROM BIRDLIFE
################################################################################

#FMestre
#18-01-2025

#Load library
library(terra)
library(sf)

#load geodatabaase
birdlife_ranges <- sf::st_read("D:\\Birdlife_range_maps\\BOTW.gdb")
#birdlife_ranges

#Get a particular layer
birdlife_ranges <- sf::st_read("D:\\Birdlife_range_maps\\BOTW.gdb", layer = "All_Species")
species <- birdlife_ranges$sci_name
species <- unique(species)
length(species)

#Getting seabird species
species_20240402_33828 <- read.csv("species_20240402_33828.csv")
seabird_species <- species_20240402_33828$Scientific.name
seabird_species <- unique(seabird_species)

for(i in 1:length(seabird_species)){
  species1 <- seabird_species[i]
  #select those with species1
  range_species1 <- birdlife_ranges[which(birdlife_ranges$sci_name == species1),]
  species1_replace <- gsub(" ", "_", species1)
  st_write(range_species1, paste0("birdlife_ranges\\", species1_replace, ".shp"), , overwrite=TRUE) 
  #Convert sf to terra
  #range_species2 <- terra::vect(range_species1)
  #species1_replace <- gsub(" ", "_", species1)
  #terra::writeVector(range_species2, paste0("birdlife_ranges\\", species1_replace, ".shp"), overwrite=TRUE)
  message(paste0("Species ", i, " - ", species1, " has been saved!"))
}


