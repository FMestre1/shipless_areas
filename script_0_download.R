################################################################################
# DOWNLOAD DATA
################################################################################

#FMestre
#27-06-2024

library(terra)
library(stringr)

# All Vessels

all_vessels <- c(
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2023_01-2023_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2022_01-2022_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2021_01-2021_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2020_01-2020_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2019_01-2019_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2018_01-2018_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2017_01-2017_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2016_01-2016_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2015_01-2015_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2014_01-2014_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2013_01-2013_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2012_01-2012_12_All_All_tiff.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2011_01-2011_12_All_All_tiff.zip"
)
# Cargo Ships

cargo_ships <- c(
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2023_01-2023_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2022_01-2022_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2021_01-2021_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2020_01-2020_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2019_01-2019_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2018_01-2018_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2017_01-2017_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2016_01-2016_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2015_01-2015_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2014_01-2014_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2013_01-2013_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2012_01-2012_12_ShipTypeAgg_Cargo+Ships.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2011_01-2011_12_ShipTypeAgg_Cargo+Ships.zip"
)
# Tankers

tankers <- c(
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2023_01-2023_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2022_01-2022_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2021_01-2021_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2020_01-2020_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2019_01-2019_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2018_01-2018_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2017_01-2017_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2016_01-2016_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2015_01-2015_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2014_01-2014_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2013_01-2013_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2012_01-2012_12_ShipTypeAgg_Tankers.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2011_01-2011_12_ShipTypeAgg_Tankers.zip"
)
# Fishing:

fishing <- c(
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2023_01-2023_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2022_01-2022_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2021_01-2021_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2020_01-2020_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2019_01-2019_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2018_01-2018_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2017_01-2017_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2016_01-2016_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2015_01-2015_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2014_01-2014_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2013_01-2013_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2012_01-2012_12_ShipTypeAgg_Fishing.zip",
"https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2011_01-2011_12_ShipTypeAgg_Fishing.zip"
)

######### DOWNLOAD #########

for(i in 1:length(all_vessels)){
  
  http_all <- all_vessels[i]
  
  #Get filename
  file_name_parts_all <- stringr::str_split(http_all, "/")
  file_name_parts_all <- file_name_parts_all[[length(file_name_parts_all)]]
  filename_all <- file_name_parts_all[length(file_name_parts_all)]
  
  download.file(url = http_all, destfile = paste0("all/", filename_all, sep = ""))
  
}
