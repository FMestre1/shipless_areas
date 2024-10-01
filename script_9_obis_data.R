################################################################################
#                         Getting data from OBIS
################################################################################

#FMestre
#26-09-2024

setwd("/home/fredmestre/shipless_areas2")

#load packages
library(robis)
#https://cran.r-project.org/web/packages/robis/robis.pdf
#https://obis.org/2016/11/22/sorbycollection/
#https://www.marinespecies.org/index.php

?robis::dataset

#robis::dataset(scientificname = NULL, taxonid = NULL, datasetid = NULL,
#        nodeid = NULL, instituteid = NULL, areaid = NULL, startdate = NULL,
#        enddate = NULL, startdepth = NULL, enddepth = NULL, geometry = NULL,
#        redlist = NULL, hab = NULL, wrims = NULL, hasextensions = NULL,
#        exclude = NULL, verbose = FALSE)

# 1. SEA TURTLES ###############################################################

#Leatherback turtle - Dermochelys coriacea
#Loggerhead turtle - Caretta caretta
#Kemp’s ridley turtle - Lepidochelys kempii
#Green sea turtle - Chelonia mydas
#Olive ridley turtle - Lepidochelys olivacea
#Hawksbill turtle - Eretmochelys imbricata
#Flatback turtle - Natator depressus

caretta_obis <- robis::dataset(scientificname = "Caretta caretta")
#View(caretta_obis)

dermochelys_obis <- robis::dataset(scientificname = "Dermochelys coriacea")
#View(dermochelys_obis)

lepidochelys_obis <- robis::dataset(scientificname = "Lepidochelys kempii")
#View(lepidochelys_obis)

chelonia_obis <- robis::dataset(scientificname = "Chelonia mydas")
#View(chelonia_obis)

lepidochelys_ol_obis <- robis::dataset(scientificname = "Lepidochelys olivacea")
#View(lepidochelys_ol_obis)

eretmochelys_obis <- robis::dataset(scientificname = "Eretmochelys imbricata")
#eretmochelys_obis <- robis::dataset(taxonid = "137207")
#View(eretmochelys_obis)

natator_obis <- robis::dataset(scientificname = "Natator depressus")
#View(natator_obis)

sea_turtles_obis <- rbind(caretta_obis, dermochelys_obis, lepidochelys_obis, chelonia_obis, lepidochelys_ol_obis, eretmochelys_obis, natator_obis)
#View(sea_turtles_obis)

# 2. PINNIPEDS #################################################################

pinniped_obis <- robis::dataset(taxonid = "148736")
#View(pinniped_obis)


# 3. CETACEANS #################################################################

cetacea_obis <- robis::dataset(taxonid = "2688")
#View(cetacea_obis)


# Download all occurrence records for the taxon Cetacea (taxon ID 2688) ########

cetacea_records <- occurrence(taxonid = "2688")




