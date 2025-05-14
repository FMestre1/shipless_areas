################################################################################
#                                Manage Folders
################################################################################

#FMestre
#16-07-2024

#The WD to be used
setwd("/home/fredmestre/shipless_areas2")
list.files("/home/fredmestre/shipless_areas2")
ls()

#The External Drive
setwd("/media/fredmestre/FMestre/shipless_areas")
ls()

#List files in the disk's folder
list.files("/media/fredmestre/FMestre/shipless_areas")

#Check free space in my external drive
system("df -h /media/fredmestre/FMestre/shipless_areas")

#Check WD
getwd()

################################################################################
#                                 DOWNLOAD DATA
################################################################################

#FMestre
#27-06-2024

#Clear environment
rm(list = ls()) 

#Load packages
library(terra)
library(stringr)

#Define the working directory
setwd("~/github/shipless_areas")

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

######### DOWNLOAD ##########

for(i in 1:length(all_vessels)){
  
  http_all <- all_vessels[i]
  
  #Get filename
  file_name_parts_all <- stringr::str_split(http_all, "/")
  file_name_parts_all <- file_name_parts_all[[length(file_name_parts_all)]]
  filename_all <- file_name_parts_all[length(file_name_parts_all)]
  
  download.file(url = http_all, destfile = paste0("all/", filename_all, sep = ""))
  
}


################################################################################
#                          DOWNLOAD DATA USING TERMINAL
################################################################################

#FMestre
#28-06-2024

### Create directories ###
mkdir all
mkdir tankers
mkdir cargo
mkdir fishing

### ALL ###

cd all
mkdir 2011
mkdir 2012
mkdir 2013
mkdir 2014
mkdir 2015
mkdir 2016
mkdir 2017
mkdir 2018
mkdir 2019
mkdir 2020
mkdir 2021
mkdir 2022
mkdir 2023

wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2023_01-2023_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2022_01-2022_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2021_01-2021_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2020_01-2020_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2019_01-2019_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2018_01-2018_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2017_01-2017_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2016_01-2016_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2015_01-2015_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2014_01-2014_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2013_01-2013_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2012_01-2012_12_All_All_tiff.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/All_All/GMTDS_2011_01-2011_12_All_All_tiff.zip

unzip GMTDS_2023_01-2023_12_All_All_tiff.zip -d 2023/
  unzip GMTDS_2022_01-2022_12_All_All_tiff.zip -d 2022/
  unzip GMTDS_2021_01-2021_12_All_All_tiff.zip -d 2021/
  unzip GMTDS_2020_01-2020_12_All_All_tiff.zip -d 2020/
  unzip GMTDS_2019_01-2019_12_All_All_tiff.zip -d 2019/
  unzip GMTDS_2018_01-2018_12_All_All_tiff.zip -d 2018/
  unzip GMTDS_2017_01-2017_12_All_All_tiff.zip -d 2017/
  unzip GMTDS_2016_01-2016_12_All_All_tiff.zip -d 2016/
  unzip GMTDS_2015_01-2015_12_All_All_tiff.zip -d 2015/
  unzip GMTDS_2014_01-2014_12_All_All_tiff.zip -d 2014/
  unzip GMTDS_2013_01-2013_12_All_All_tiff.zip -d 2013/
  unzip GMTDS_2012_01-2012_12_All_All_tiff.zip -d 2012/
  unzip GMTDS_2011_01-2011_12_All_All_tiff.zip -d 2011/
  
  rm GMTDS_2023_01-2023_12_All_All_tiff.zip
rm GMTDS_2022_01-2022_12_All_All_tiff.zip
rm GMTDS_2021_01-2021_12_All_All_tiff.zip
rm GMTDS_2020_01-2020_12_All_All_tiff.zip
rm GMTDS_2019_01-2019_12_All_All_tiff.zip
rm GMTDS_2018_01-2018_12_All_All_tiff.zip
rm GMTDS_2017_01-2017_12_All_All_tiff.zip
rm GMTDS_2016_01-2016_12_All_All_tiff.zip
rm GMTDS_2015_01-2015_12_All_All_tiff.zip
rm GMTDS_2014_01-2014_12_All_All_tiff.zip
rm GMTDS_2013_01-2013_12_All_All_tiff.zip
rm GMTDS_2012_01-2012_12_All_All_tiff.zip
rm GMTDS_2011_01-2011_12_All_All_tiff.zip

cd ..

### CARGO SHIPS ###

cd cargo
mkdir 2011
mkdir 2012
mkdir 2013
mkdir 2014
mkdir 2015
mkdir 2016
mkdir 2017
mkdir 2018
mkdir 2019
mkdir 2020
mkdir 2021
mkdir 2022
mkdir 2023

wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2023_01-2023_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2022_01-2022_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2021_01-2021_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2020_01-2020_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2019_01-2019_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2018_01-2018_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2017_01-2017_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2016_01-2016_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2015_01-2015_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2014_01-2014_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2013_01-2013_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2012_01-2012_12_ShipTypeAgg_Cargo+Ships.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/CargoShips/GMTDS_2011_01-2011_12_ShipTypeAgg_Cargo+Ships.zip

unzip GMTDS_2023_01-2023_12_ShipTypeAgg_Cargo+Ships.zip -d 2023/
  unzip GMTDS_2022_01-2022_12_ShipTypeAgg_Cargo+Ships.zip -d 2022/
  unzip GMTDS_2021_01-2021_12_ShipTypeAgg_Cargo+Ships.zip -d 2021/
  unzip GMTDS_2020_01-2020_12_ShipTypeAgg_Cargo+Ships.zip -d 2020/
  unzip GMTDS_2019_01-2019_12_ShipTypeAgg_Cargo+Ships.zip -d 2019/
  unzip GMTDS_2018_01-2018_12_ShipTypeAgg_Cargo+Ships.zip -d 2018/
  unzip GMTDS_2017_01-2017_12_ShipTypeAgg_Cargo+Ships.zip -d 2017/
  unzip GMTDS_2016_01-2016_12_ShipTypeAgg_Cargo+Ships.zip -d 2016/
  unzip GMTDS_2015_01-2015_12_ShipTypeAgg_Cargo+Ships.zip -d 2015/
  unzip GMTDS_2014_01-2014_12_ShipTypeAgg_Cargo+Ships.zip -d 2014/
  unzip GMTDS_2013_01-2013_12_ShipTypeAgg_Cargo+Ships.zip -d 2013/
  unzip GMTDS_2012_01-2012_12_ShipTypeAgg_Cargo+Ships.zip -d 2012/
  unzip GMTDS_2011_01-2011_12_ShipTypeAgg_Cargo+Ships.zip -d 2011/
  
  rm GMTDS_2023_01-2023_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2022_01-2022_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2021_01-2021_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2020_01-2020_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2019_01-2019_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2018_01-2018_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2017_01-2017_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2016_01-2016_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2015_01-2015_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2014_01-2014_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2013_01-2013_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2012_01-2012_12_ShipTypeAgg_Cargo+Ships.zip
rm GMTDS_2011_01-2011_12_ShipTypeAgg_Cargo+Ships.zip

cd ..

### TANKERS ###

cd tankers
mkdir 2011
mkdir 2012
mkdir 2013
mkdir 2014
mkdir 2015
mkdir 2016
mkdir 2017
mkdir 2018
mkdir 2019
mkdir 2020
mkdir 2021
mkdir 2022
mkdir 2023

wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2023_01-2023_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2022_01-2022_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2021_01-2021_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2020_01-2020_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2019_01-2019_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2018_01-2018_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2017_01-2017_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2016_01-2016_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2015_01-2015_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2014_01-2014_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2013_01-2013_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2012_01-2012_12_ShipTypeAgg_Tankers.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Tankers/GMTDS_2011_01-2011_12_ShipTypeAgg_Tankers.zip

unzip GMTDS_2023_01-2023_12_ShipTypeAgg_Tankers.zip -d 2023/
  unzip GMTDS_2022_01-2022_12_ShipTypeAgg_Tankers.zip -d 2022/
  unzip GMTDS_2021_01-2021_12_ShipTypeAgg_Tankers.zip -d 2021/
  unzip GMTDS_2020_01-2020_12_ShipTypeAgg_Tankers.zip -d 2020/
  unzip GMTDS_2019_01-2019_12_ShipTypeAgg_Tankers.zip -d 2019/
  unzip GMTDS_2018_01-2018_12_ShipTypeAgg_Tankers.zip -d 2018/
  unzip GMTDS_2017_01-2017_12_ShipTypeAgg_Tankers.zip -d 2017/
  unzip GMTDS_2016_01-2016_12_ShipTypeAgg_Tankers.zip -d 2016/
  unzip GMTDS_2015_01-2015_12_ShipTypeAgg_Tankers.zip -d 2015/
  unzip GMTDS_2014_01-2014_12_ShipTypeAgg_Tankers.zip -d 2014/
  unzip GMTDS_2013_01-2013_12_ShipTypeAgg_Tankers.zip -d 2013/
  unzip GMTDS_2012_01-2012_12_ShipTypeAgg_Tankers.zip -d 2012/
  unzip GMTDS_2011_01-2011_12_ShipTypeAgg_Tankers.zip -d 2011/
  
  rm GMTDS_2023_01-2023_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2022_01-2022_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2021_01-2021_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2020_01-2020_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2019_01-2019_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2018_01-2018_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2017_01-2017_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2016_01-2016_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2015_01-2015_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2014_01-2014_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2013_01-2013_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2012_01-2012_12_ShipTypeAgg_Tankers.zip
rm GMTDS_2011_01-2011_12_ShipTypeAgg_Tankers.zip

cd ..

### FISHING ###

cd fishing
mkdir 2011
mkdir 2012
mkdir 2013
mkdir 2014
mkdir 2015
mkdir 2016
mkdir 2017
mkdir 2018
mkdir 2019
mkdir 2020
mkdir 2021
mkdir 2022
mkdir 2023

wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2023_01-2023_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2022_01-2022_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2021_01-2021_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2020_01-2020_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2019_01-2019_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2018_01-2018_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2017_01-2017_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2016_01-2016_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2015_01-2015_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2014_01-2014_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2013_01-2013_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2012_01-2012_12_ShipTypeAgg_Fishing.zip
wget https://maplarge-public.s3.amazonaws.com/GMTDS/Standard_Extracts/ShipTypeAgg/Fishing/GMTDS_2011_01-2011_12_ShipTypeAgg_Fishing.zip

unzip GMTDS_2023_01-2023_12_ShipTypeAgg_Fishing.zip -d 2023/
  unzip GMTDS_2022_01-2022_12_ShipTypeAgg_Fishing.zip -d 2022/
  unzip GMTDS_2021_01-2021_12_ShipTypeAgg_Fishing.zip -d 2021/
  unzip GMTDS_2020_01-2020_12_ShipTypeAgg_Fishing.zip -d 2020/
  unzip GMTDS_2019_01-2019_12_ShipTypeAgg_Fishing.zip -d 2019/
  unzip GMTDS_2018_01-2018_12_ShipTypeAgg_Fishing.zip -d 2018/
  unzip GMTDS_2017_01-2017_12_ShipTypeAgg_Fishing.zip -d 2017/
  unzip GMTDS_2016_01-2016_12_ShipTypeAgg_Fishing.zip -d 2016/
  unzip GMTDS_2015_01-2015_12_ShipTypeAgg_Fishing.zip -d 2015/
  unzip GMTDS_2014_01-2014_12_ShipTypeAgg_Fishing.zip -d 2014/
  unzip GMTDS_2013_01-2013_12_ShipTypeAgg_Fishing.zip -d 2013/
  unzip GMTDS_2012_01-2012_12_ShipTypeAgg_Fishing.zip -d 2012/
  unzip GMTDS_2011_01-2011_12_ShipTypeAgg_Fishing.zip -d 2011/
  
  rm GMTDS_2023_01-2023_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2022_01-2022_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2021_01-2021_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2020_01-2020_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2019_01-2019_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2018_01-2018_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2017_01-2017_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2016_01-2016_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2015_01-2015_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2014_01-2014_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2013_01-2013_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2012_01-2012_12_ShipTypeAgg_Fishing.zip
rm GMTDS_2011_01-2011_12_ShipTypeAgg_Fishing.zip

cd ..

################################################################################
#                      Summarizing Monthy per Type
################################################################################

#Create folder structure

mkdir monthly_sum
#
mkdir monthly_sum/all
mkdir monthly_sum/cargo
mkdir monthly_sum/fishing
mkdir monthly_sum/tankers

