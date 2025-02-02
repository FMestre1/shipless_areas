################################################################################
#                               Loading rasters
################################################################################

#FMestre
#15-04-2024

#Clear environment
rm(list = ls()) 

#Load packages
library(terra)

#Define the working directory
setwd("~/github/shipless_areas")

#file.access(dir("."), mode = 4)

#Set new wd, should be this one
#list.files("/media/jorgeassis/FMestre/shipless_areas")

#Define temp directory
terraOptions(tempdir = "temp")

#Check temporary files
tmpFiles()

#Check free space in my external drive
#df -h /media/jorgeassis/FMestre

####### Before, rename the space in the name of the cargo ships files #######

# Set the working directory (modify as needed)
folder_rename <- c(
"/media/jorgeassis/FMestre/shipless_areas/cargo/2011/", 
"/media/jorgeassis/FMestre/shipless_areas/cargo/2012/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2013/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2014/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2015/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2016/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2017/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2018/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2019/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2020/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2021/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2022/",
"/media/jorgeassis/FMestre/shipless_areas/cargo/2023/"
)

#Renaming files in cargo (which had a space in the name)
for(p in 1:length(folder_rename)){
 
    path2 <- folder_rename[p]
    names_list <- list.files(path2)
   
    for(f in 1:length(names_list))
  
    {
    old_name <- paste0(path2, names_list[f])
    new_name <- gsub("\\s", "_", old_name)
    file.rename(old_name, new_name)
    message(paste("Renamed:", old_name, "to", new_name))
    }
  
}


##Changing file  permissions (if required)
  # Define the target directory
file_path <- c("/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2011/", 
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2012/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2013/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2014/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2015/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2016/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2017/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2018/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2019/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2020/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2021/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2022/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/all/2023/",
               
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2011/", 
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2012/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2013/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2014/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2015/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2016/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2017/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2018/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2019/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2020/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2021/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2022/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/cargo/2023/",
               
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2011/", 
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2012/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2013/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2014/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2015/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2016/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2017/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2018/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2019/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2020/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2021/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2022/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/fishing/2023/",
               
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2011/", 
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2012/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2013/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2014/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2015/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2016/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2017/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2018/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2019/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2020/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2021/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2022/",
               "/home/fredmestre/shipless_areas//media/jorgeassis/FMestre/shipless_areas/tankers/2023/"
)

for(j in 1:length(file_path)){

file_path1 <- file_path[j]

files_in <- list.files(file_path1)  

for(i in 1:length(files_in)) system(paste0("chmod u+r ", file_path1, files_in[i]))

}

###################################### ALL SHIPS ######################################

###### 2012 ######
all_2012_01 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_01_converted.tif")
all_2012_02 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_02_converted.tif")
all_2012_03 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_03_converted.tif")
all_2012_04 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_04_converted.tif")
all_2012_05 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_05_converted.tif")
all_2012_06 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_06_converted.tif")
all_2012_07 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_07_converted.tif")
all_2012_08 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_08_converted.tif")
all_2012_09 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_09_converted.tif")
all_2012_10 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_10_converted.tif")
all_2012_11 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_11_converted.tif")
all_2012_12 = terra::rast("E:/shipless_areas/all/2012/grid_float_All_2012_12_converted.tif")

###### 2013 ######
all_2013_01 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_01_converted.tif")
all_2013_02 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_02_converted.tif")
all_2013_03 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_03_converted.tif")
all_2013_04 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_04_converted.tif")
all_2013_05 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_05_converted.tif")
all_2013_06 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_06_converted.tif")
all_2013_07 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_07_converted.tif")
all_2013_08 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_08_converted.tif")
all_2013_09 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_09_converted.tif")
all_2013_10 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_10_converted.tif")
all_2013_11 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_11_converted.tif")
all_2013_12 = terra::rast("E:/shipless_areas/all/2013/grid_float_All_2013_12_converted.tif")


###### 2014 ######
all_2014_01 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_01_converted.tif")
all_2014_02 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_02_converted.tif")
all_2014_03 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_03_converted.tif")
all_2014_04 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_04_converted.tif")
all_2014_05 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_05_converted.tif")
all_2014_06 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_06_converted.tif")
all_2014_07 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_07_converted.tif")
all_2014_08 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_08_converted.tif")
all_2014_09 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_09_converted.tif")
all_2014_10 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_10_converted.tif")
all_2014_11 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_11_converted.tif")
all_2014_12 = terra::rast("E:/shipless_areas/all/2014/grid_float_All_2014_12_converted.tif")


###### 2015 ######
all_2015_01 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_01_converted.tif")
all_2015_02 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_02_converted.tif")
all_2015_03 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_03_converted.tif")
all_2015_04 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_04_converted.tif")
all_2015_05 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_05_converted.tif")
all_2015_06 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_06_converted.tif")
all_2015_07 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_07_converted.tif")
all_2015_08 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_08_converted.tif")
all_2015_09 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_09_converted.tif")
all_2015_10 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_10_converted.tif")
all_2015_11 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_11_converted.tif")
all_2015_12 = terra::rast("E:/shipless_areas/all/2015/grid_float_All_2015_12_converted.tif")


###### 2016 ######
all_2016_01 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_01_converted.tif")
all_2016_02 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_02_converted.tif")
all_2016_03 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_03_converted.tif")
all_2016_04 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_04_converted.tif")
all_2016_05 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_05_converted.tif")
all_2016_06 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_06_converted.tif")
all_2016_07 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_07_converted.tif")
all_2016_08 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_08_converted.tif")
all_2016_09 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_09_converted.tif")
all_2016_10 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_10_converted.tif")
all_2016_11 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_11_converted.tif")
all_2016_12 = terra::rast("E:/shipless_areas/all/2016/grid_float_All_2016_12_converted.tif")


###### 2017 ######
all_2017_01 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_01_converted.tif")
all_2017_02 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_02_converted.tif")
all_2017_03 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_03_converted.tif")
all_2017_04 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_04_converted.tif")
all_2017_05 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_05_converted.tif")
all_2017_06 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_06_converted.tif")
all_2017_07 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_07_converted.tif")
all_2017_08 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_08_converted.tif")
all_2017_09 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_09_converted.tif")
all_2017_10 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_10_converted.tif")
all_2017_11 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_11_converted.tif")
all_2017_12 = terra::rast("E:/shipless_areas/all/2017/grid_float_All_2017_12_converted.tif")


###### 2018 ######
all_2018_01 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_01_converted.tif")
all_2018_02 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_02_converted.tif")
all_2018_03 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_03_converted.tif")
all_2018_04 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_04_converted.tif")
all_2018_05 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_05_converted.tif")
all_2018_06 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_06_converted.tif")
all_2018_07 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_07_converted.tif")
all_2018_08 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_08_converted.tif")
all_2018_09 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_09_converted.tif")
all_2018_10 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_10_converted.tif")
all_2018_11 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_11_converted.tif")
all_2018_12 = terra::rast("E:/shipless_areas/all/2018/grid_float_All_2018_12_converted.tif")


###### 2019 ######
all_2019_01 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_01_converted.tif")
all_2019_02 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_02_converted.tif")
all_2019_03 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_03_converted.tif")
all_2019_04 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_04_converted.tif")
all_2019_05 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_05_converted.tif")
all_2019_06 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_06_converted.tif")
all_2019_07 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_07_converted.tif")
all_2019_08 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_08_converted.tif")
all_2019_09 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_09_converted.tif")
all_2019_10 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_10_converted.tif")
all_2019_11 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_11_converted.tif")
all_2019_12 = terra::rast("E:/shipless_areas/all/2019/grid_float_All_2019_12_converted.tif")


###### 2020 ######
all_2020_01 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_01_converted.tif")
all_2020_02 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_02_converted.tif")
all_2020_03 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_03_converted.tif")
all_2020_04 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_04_converted.tif")
all_2020_05 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_05_converted.tif")
all_2020_06 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_06_converted.tif")
all_2020_07 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_07_converted.tif")
all_2020_08 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_08_converted.tif")
all_2020_09 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_09_converted.tif")
all_2020_10 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_10_converted.tif")
all_2020_11 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_11_converted.tif")
all_2020_12 = terra::rast("E:/shipless_areas/all/2020/grid_float_All_2020_12_converted.tif")


###### 2021 ######
all_2021_01 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_01_converted.tif")
all_2021_02 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_02_converted.tif")
all_2021_03 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_03_converted.tif")
all_2021_04 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_04_converted.tif")
all_2021_05 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_05_converted.tif")
all_2021_06 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_06_converted.tif")
all_2021_07 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_07_converted.tif")
all_2021_08 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_08_converted.tif")
all_2021_09 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_09_converted.tif")
all_2021_10 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_10_converted.tif")
all_2021_11 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_11_converted.tif")
all_2021_12 = terra::rast("E:/shipless_areas/all/2021/grid_float_All_2021_12_converted.tif")


###### 2022 ######
all_2022_01 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_01_converted.tif")
all_2022_02 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_02_converted.tif")
all_2022_03 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_03_converted.tif")
all_2022_04 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_04_converted.tif")
all_2022_05 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_05_converted.tif")
all_2022_06 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_06_converted.tif")
all_2022_07 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_07_converted.tif")
all_2022_08 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_08_converted.tif")
all_2022_09 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_09_converted.tif")
all_2022_10 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_10_converted.tif")
all_2022_11 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_11_converted.tif")
all_2022_12 = terra::rast("E:/shipless_areas/all/2022/grid_float_All_2022_12_converted.tif")


###### 2023 ######
all_2023_01 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_01_converted.tif")
all_2023_02 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_02_converted.tif")
all_2023_03 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_03_converted.tif")
all_2023_04 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_04_converted.tif")
all_2023_05 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_05_converted.tif")
all_2023_06 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_06_converted.tif")
all_2023_07 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_07_converted.tif")
all_2023_08 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_08_converted.tif")
all_2023_09 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_09_converted.tif")
all_2023_10 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_10_converted.tif")
all_2023_11 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_11_converted.tif")
all_2023_12 = terra::rast("E:/shipless_areas/all/2023/grid_float_All_2023_12_converted.tif")


###################################### CARGO SHIPS ######################################

###### 2011 ######
cargo_2011_01 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_01_converted.tif")
cargo_2011_02 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_02_converted.tif")
cargo_2011_03 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_03_converted.tif")
cargo_2011_04 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_04_converted.tif")
cargo_2011_05 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_05_converted.tif")
cargo_2011_06 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_06_converted.tif")
cargo_2011_07 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_07_converted.tif")
cargo_2011_08 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_08_converted.tif")
cargo_2011_09 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_09_converted.tif")
cargo_2011_10 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_10_converted.tif")
cargo_2011_11 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_11_converted.tif")
cargo_2011_12 = terra::rast("E:/shipless_areas/cargo/2011/grid_float_Cargo_Ships_2011_12_converted.tif")


###### 2012 ######
cargo_2012_01 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_01_converted.tif")
cargo_2012_02 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_02_converted.tif")
cargo_2012_03 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_03_converted.tif")
cargo_2012_04 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_04_converted.tif")
cargo_2012_05 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_05_converted.tif")
cargo_2012_06 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_06_converted.tif")
cargo_2012_07 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_07_converted.tif")
cargo_2012_08 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_08_converted.tif")
cargo_2012_09 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_09_converted.tif")
cargo_2012_10 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_10_converted.tif")
cargo_2012_11 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_11_converted.tif")
cargo_2012_12 = terra::rast("E:/shipless_areas/cargo/2012/grid_float_Cargo_Ships_2012_12_converted.tif")


###### 2013 ######
cargo_2013_01 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_01_converted.tif")
cargo_2013_02 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_02_converted.tif")
cargo_2013_03 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_03_converted.tif")
cargo_2013_04 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_04_converted.tif")
cargo_2013_05 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_05_converted.tif")
cargo_2013_06 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_06_converted.tif")
cargo_2013_07 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_07_converted.tif")
cargo_2013_08 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_08_converted.tif")
cargo_2013_09 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_09_converted.tif")
cargo_2013_10 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_10_converted.tif")
cargo_2013_11 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_11_converted.tif")
cargo_2013_12 = terra::rast("E:/shipless_areas/cargo/2013/grid_float_Cargo_Ships_2013_12_converted.tif")


###### 2014 ######
cargo_2014_01 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_01_converted.tif")
cargo_2014_02 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_02_converted.tif")
cargo_2014_03 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_03_converted.tif")
cargo_2014_04 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_04_converted.tif")
cargo_2014_05 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_05_converted.tif")
cargo_2014_06 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_06_converted.tif")
cargo_2014_07 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_07_converted.tif")
cargo_2014_08 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_08_converted.tif")
cargo_2014_09 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_09_converted.tif")
cargo_2014_10 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_10_converted.tif")
cargo_2014_11 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_11_converted.tif")
cargo_2014_12 = terra::rast("E:/shipless_areas/cargo/2014/grid_float_Cargo_Ships_2014_12_converted.tif")


###### 2015 ######
cargo_2015_01 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_01_converted.tif")
cargo_2015_02 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_02_converted.tif")
cargo_2015_03 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_03_converted.tif")
cargo_2015_04 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_04_converted.tif")
cargo_2015_05 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_05_converted.tif")
cargo_2015_06 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_06_converted.tif")
cargo_2015_07 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_07_converted.tif")
cargo_2015_08 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_08_converted.tif")
cargo_2015_09 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_09_converted.tif")
cargo_2015_10 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_10_converted.tif")
cargo_2015_11 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_11_converted.tif")
cargo_2015_12 = terra::rast("E:/shipless_areas/cargo/2015/grid_float_Cargo_Ships_2015_12_converted.tif")


###### 2016 ######
cargo_2016_01 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_01_converted.tif")
cargo_2016_02 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_02_converted.tif")
cargo_2016_03 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_03_converted.tif")
cargo_2016_04 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_04_converted.tif")
cargo_2016_05 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_05_converted.tif")
cargo_2016_06 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_06_converted.tif")
cargo_2016_07 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_07_converted.tif")
cargo_2016_08 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_08_converted.tif")
cargo_2016_09 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_09_converted.tif")
cargo_2016_10 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_10_converted.tif")
cargo_2016_11 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_11_converted.tif")
cargo_2016_12 = terra::rast("E:/shipless_areas/cargo/2016/grid_float_Cargo_Ships_2016_12_converted.tif")


###### 2017 ######
cargo_2017_01 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_01_converted.tif")
cargo_2017_02 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_02_converted.tif")
cargo_2017_03 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_03_converted.tif")
cargo_2017_04 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_04_converted.tif")
cargo_2017_05 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_05_converted.tif")
cargo_2017_06 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_06_converted.tif")
cargo_2017_07 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_07_converted.tif")
cargo_2017_08 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_08_converted.tif")
cargo_2017_09 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_09_converted.tif")
cargo_2017_10 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_10_converted.tif")
cargo_2017_11 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_11_converted.tif")
cargo_2017_12 = terra::rast("E:/shipless_areas/cargo/2017/grid_float_Cargo_Ships_2017_12_converted.tif")


###### 2018 ######
cargo_2018_01 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_01_converted.tif")
cargo_2018_02 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_02_converted.tif")
cargo_2018_03 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_03_converted.tif")
cargo_2018_04 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_04_converted.tif")
cargo_2018_05 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_05_converted.tif")
cargo_2018_06 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_06_converted.tif")
cargo_2018_07 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_07_converted.tif")
cargo_2018_08 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_08_converted.tif")
cargo_2018_09 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_09_converted.tif")
cargo_2018_10 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_10_converted.tif")
cargo_2018_11 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_11_converted.tif")
cargo_2018_12 = terra::rast("E:/shipless_areas/cargo/2018/grid_float_Cargo_Ships_2018_12_converted.tif")


###### 2019 ######
cargo_2019_01 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_01_converted.tif")
cargo_2019_02 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_02_converted.tif")
cargo_2019_03 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_03_converted.tif")
cargo_2019_04 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_04_converted.tif")
cargo_2019_05 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_05_converted.tif")
cargo_2019_06 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_06_converted.tif")
cargo_2019_07 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_07_converted.tif")
cargo_2019_08 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_08_converted.tif")
cargo_2019_09 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_09_converted.tif")
cargo_2019_10 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_10_converted.tif")
cargo_2019_11 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_11_converted.tif")
cargo_2019_12 = terra::rast("E:/shipless_areas/cargo/2019/grid_float_Cargo_Ships_2019_12_converted.tif")


###### 2020 ######
cargo_2020_01 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_01_converted.tif")
cargo_2020_02 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_02_converted.tif")
cargo_2020_03 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_03_converted.tif")
cargo_2020_04 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_04_converted.tif")
cargo_2020_05 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_05_converted.tif")
cargo_2020_06 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_06_converted.tif")
cargo_2020_07 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_07_converted.tif")
cargo_2020_08 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_08_converted.tif")
cargo_2020_09 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_09_converted.tif")
cargo_2020_10 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_10_converted.tif")
cargo_2020_11 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_11_converted.tif")
cargo_2020_12 = terra::rast("E:/shipless_areas/cargo/2020/grid_float_Cargo_Ships_2020_12_converted.tif")


###### 2021 ######
cargo_2021_01 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_01_converted.tif")
cargo_2021_02 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_02_converted.tif")
cargo_2021_03 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_03_converted.tif")
cargo_2021_04 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_04_converted.tif")
cargo_2021_05 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_05_converted.tif")
cargo_2021_06 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_06_converted.tif")
cargo_2021_07 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_07_converted.tif")
cargo_2021_08 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_08_converted.tif")
cargo_2021_09 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_09_converted.tif")
cargo_2021_10 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_10_converted.tif")
cargo_2021_11 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_11_converted.tif")
cargo_2021_12 = terra::rast("E:/shipless_areas/cargo/2021/grid_float_Cargo_Ships_2021_12_converted.tif")


###### 2022 ######
cargo_2022_01 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_01_converted.tif")
cargo_2022_02 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_02_converted.tif")
cargo_2022_03 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_03_converted.tif")
cargo_2022_04 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_04_converted.tif")
cargo_2022_05 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_05_converted.tif")
cargo_2022_06 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_06_converted.tif")
cargo_2022_07 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_07_converted.tif")
cargo_2022_08 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_08_converted.tif")
cargo_2022_09 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_09_converted.tif")
cargo_2022_10 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_10_converted.tif")
cargo_2022_11 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_11_converted.tif")
cargo_2022_12 = terra::rast("E:/shipless_areas/cargo/2022/grid_float_Cargo_Ships_2022_12_converted.tif")


###### 2023 ######
cargo_2023_01 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_01_converted.tif")
cargo_2023_02 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_02_converted.tif")
cargo_2023_03 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_03_converted.tif")
cargo_2023_04 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_04_converted.tif")
cargo_2023_05 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_05_converted.tif")
cargo_2023_06 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_06_converted.tif")
cargo_2023_07 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_07_converted.tif")
cargo_2023_08 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_08_converted.tif")
cargo_2023_09 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_09_converted.tif")
cargo_2023_10 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_10_converted.tif")
cargo_2023_11 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_11_converted.tif")
cargo_2023_12 = terra::rast("E:/shipless_areas/cargo/2023/grid_float_Cargo_Ships_2023_12_converted.tif")


###################################### TANKER SHIPS ######################################

###### 2011 ######
tankers_2011_01 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_01_converted.tif")
tankers_2011_02 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_02_converted.tif")
tankers_2011_03 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_03_converted.tif")
tankers_2011_04 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_04_converted.tif")
tankers_2011_05 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_05_converted.tif")
tankers_2011_06 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_06_converted.tif")
tankers_2011_07 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_07_converted.tif")
tankers_2011_08 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_08_converted.tif")
tankers_2011_09 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_09_converted.tif")
tankers_2011_10 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_10_converted.tif")
tankers_2011_11 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_11_converted.tif")
tankers_2011_12 = terra::rast("E:/shipless_areas/tankers/2011/grid_float_Tankers_2011_12_converted.tif")


###### 2012 ######
tankers_2012_01 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_01_converted.tif")
tankers_2012_02 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_02_converted.tif")
tankers_2012_03 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_03_converted.tif")
tankers_2012_04 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_04_converted.tif")
tankers_2012_05 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_05_converted.tif")
tankers_2012_06 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_06_converted.tif")
tankers_2012_07 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_07_converted.tif")
tankers_2012_08 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_08_converted.tif")
tankers_2012_09 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_09_converted.tif")
tankers_2012_10 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_10_converted.tif")
tankers_2012_11 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_11_converted.tif")
tankers_2012_12 = terra::rast("E:/shipless_areas/tankers/2012/grid_float_Tankers_2012_12_converted.tif")


###### 2013 ######
tankers_2013_01 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_01_converted.tif")
tankers_2013_02 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_02_converted.tif")
tankers_2013_03 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_03_converted.tif")
tankers_2013_04 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_04_converted.tif")
tankers_2013_05 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_05_converted.tif")
tankers_2013_06 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_06_converted.tif")
tankers_2013_07 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_07_converted.tif")
tankers_2013_08 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_08_converted.tif")
tankers_2013_09 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_09_converted.tif")
tankers_2013_10 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_10_converted.tif")
tankers_2013_11 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_11_converted.tif")
tankers_2013_12 = terra::rast("E:/shipless_areas/tankers/2013/grid_float_Tankers_2013_12_converted.tif")


###### 2014 ######
tankers_2014_01 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_01_converted.tif")
tankers_2014_02 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_02_converted.tif")
tankers_2014_03 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_03_converted.tif")
tankers_2014_04 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_04_converted.tif")
tankers_2014_05 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_05_converted.tif")
tankers_2014_06 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_06_converted.tif")
tankers_2014_07 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_07_converted.tif")
tankers_2014_08 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_08_converted.tif")
tankers_2014_09 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_09_converted.tif")
tankers_2014_10 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_10_converted.tif")
tankers_2014_11 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_11_converted.tif")
tankers_2014_12 = terra::rast("E:/shipless_areas/tankers/2014/grid_float_Tankers_2014_12_converted.tif")


###### 2015 ######
tankers_2015_01 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_01_converted.tif")
tankers_2015_02 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_02_converted.tif")
tankers_2015_03 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_03_converted.tif")
tankers_2015_04 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_04_converted.tif")
tankers_2015_05 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_05_converted.tif")
tankers_2015_06 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_06_converted.tif")
tankers_2015_07 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_07_converted.tif")
tankers_2015_08 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_08_converted.tif")
tankers_2015_09 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_09_converted.tif")
tankers_2015_10 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_10_converted.tif")
tankers_2015_11 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_11_converted.tif")
tankers_2015_12 = terra::rast("E:/shipless_areas/tankers/2015/grid_float_Tankers_2015_12_converted.tif")


###### 2016 ######
tankers_2016_01 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_01_converted.tif")
tankers_2016_02 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_02_converted.tif")
tankers_2016_03 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_03_converted.tif")
tankers_2016_04 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_04_converted.tif")
tankers_2016_05 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_05_converted.tif")
tankers_2016_06 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_06_converted.tif")
tankers_2016_07 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_07_converted.tif")
tankers_2016_08 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_08_converted.tif")
tankers_2016_09 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_09_converted.tif")
tankers_2016_10 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_10_converted.tif")
tankers_2016_11 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_11_converted.tif")
tankers_2016_12 = terra::rast("E:/shipless_areas/tankers/2016/grid_float_Tankers_2016_12_converted.tif")


###### 2017 ######
tankers_2017_01 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_01_converted.tif")
tankers_2017_02 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_02_converted.tif")
tankers_2017_03 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_03_converted.tif")
tankers_2017_04 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_04_converted.tif")
tankers_2017_05 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_05_converted.tif")
tankers_2017_06 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_06_converted.tif")
tankers_2017_07 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_07_converted.tif")
tankers_2017_08 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_08_converted.tif")
tankers_2017_09 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_09_converted.tif")
tankers_2017_10 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_10_converted.tif")
tankers_2017_11 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_11_converted.tif")
tankers_2017_12 = terra::rast("E:/shipless_areas/tankers/2017/grid_float_Tankers_2017_12_converted.tif")


###### 2018 ######
tankers_2018_01 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_01_converted.tif")
tankers_2018_02 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_02_converted.tif")
tankers_2018_03 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_03_converted.tif")
tankers_2018_04 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_04_converted.tif")
tankers_2018_05 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_05_converted.tif")
tankers_2018_06 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_06_converted.tif")
tankers_2018_07 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_07_converted.tif")
tankers_2018_08 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_08_converted.tif")
tankers_2018_09 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_09_converted.tif")
tankers_2018_10 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_10_converted.tif")
tankers_2018_11 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_11_converted.tif")
tankers_2018_12 = terra::rast("E:/shipless_areas/tankers/2018/grid_float_Tankers_2018_12_converted.tif")


###### 2019 ######
tankers_2019_01 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_01_converted.tif")
tankers_2019_02 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_02_converted.tif")
tankers_2019_03 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_03_converted.tif")
tankers_2019_04 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_04_converted.tif")
tankers_2019_05 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_05_converted.tif")
tankers_2019_06 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_06_converted.tif")
tankers_2019_07 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_07_converted.tif")
tankers_2019_08 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_08_converted.tif")
tankers_2019_09 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_09_converted.tif")
tankers_2019_10 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_10_converted.tif")
tankers_2019_11 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_11_converted.tif")
tankers_2019_12 = terra::rast("E:/shipless_areas/tankers/2019/grid_float_Tankers_2019_12_converted.tif")


###### 2020 ######
tankers_2020_01 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_01_converted.tif")
tankers_2020_02 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_02_converted.tif")
tankers_2020_03 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_03_converted.tif")
tankers_2020_04 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_04_converted.tif")
tankers_2020_05 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_05_converted.tif")
tankers_2020_06 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_06_converted.tif")
tankers_2020_07 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_07_converted.tif")
tankers_2020_08 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_08_converted.tif")
tankers_2020_09 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_09_converted.tif")
tankers_2020_10 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_10_converted.tif")
tankers_2020_11 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_11_converted.tif")
tankers_2020_12 = terra::rast("E:/shipless_areas/tankers/2020/grid_float_Tankers_2020_12_converted.tif")


###### 2021 ######
tankers_2021_01 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_01_converted.tif")
tankers_2021_02 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_02_converted.tif")
tankers_2021_03 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_03_converted.tif")
tankers_2021_04 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_04_converted.tif")
tankers_2021_05 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_05_converted.tif")
tankers_2021_06 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_06_converted.tif")
tankers_2021_07 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_07_converted.tif")
tankers_2021_08 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_08_converted.tif")
tankers_2021_09 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_09_converted.tif")
tankers_2021_10 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_10_converted.tif")
tankers_2021_11 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_11_converted.tif")
tankers_2021_12 = terra::rast("E:/shipless_areas/tankers/2021/grid_float_Tankers_2021_12_converted.tif")


###### 2022 ######
tankers_2022_01 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_01_converted.tif")
tankers_2022_02 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_02_converted.tif")
tankers_2022_03 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_03_converted.tif")
tankers_2022_04 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_04_converted.tif")
tankers_2022_05 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_05_converted.tif")
tankers_2022_06 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_06_converted.tif")
tankers_2022_07 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_07_converted.tif")
tankers_2022_08 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_08_converted.tif")
tankers_2022_09 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_09_converted.tif")
tankers_2022_10 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_10_converted.tif")
tankers_2022_11 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_11_converted.tif")
tankers_2022_12 = terra::rast("E:/shipless_areas/tankers/2022/grid_float_Tankers_2022_12_converted.tif")


###### 2023 ######
tankers_2023_01 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_01_converted.tif")
tankers_2023_02 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_02_converted.tif")
tankers_2023_03 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_03_converted.tif")
tankers_2023_04 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_04_converted.tif")
tankers_2023_05 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_05_converted.tif")
tankers_2023_06 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_06_converted.tif")
tankers_2023_07 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_07_converted.tif")
tankers_2023_08 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_08_converted.tif")
tankers_2023_09 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_09_converted.tif")
tankers_2023_10 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_10_converted.tif")
tankers_2023_11 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_11_converted.tif")
tankers_2023_12 = terra::rast("E:/shipless_areas/tankers/2023/grid_float_Tankers_2023_12_converted.tif")


###################################### FISHING ######################################

###### 2011 ######
fishing_2011_01 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_01_converted.tif")
fishing_2011_02 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_02_converted.tif")
fishing_2011_03 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_03_converted.tif")
fishing_2011_04 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_04_converted.tif")
fishing_2011_05 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_05_converted.tif")
fishing_2011_06 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_06_converted.tif")
fishing_2011_07 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_07_converted.tif")
fishing_2011_08 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_08_converted.tif")
fishing_2011_09 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_09_converted.tif")
fishing_2011_10 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_10_converted.tif")
fishing_2011_11 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_11_converted.tif")
fishing_2011_12 = terra::rast("E:/shipless_areas/fishing/2011/grid_float_Fishing_2011_12_converted.tif")


###### 2012 ######
fishing_2012_01 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_01_converted.tif")
fishing_2012_02 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_02_converted.tif")
fishing_2012_03 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_03_converted.tif")
fishing_2012_04 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_04_converted.tif")
fishing_2012_05 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_05_converted.tif")
fishing_2012_06 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_06_converted.tif")
fishing_2012_07 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_07_converted.tif")
fishing_2012_08 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_08_converted.tif")
fishing_2012_09 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_09_converted.tif")
fishing_2012_10 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_10_converted.tif")
fishing_2012_11 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_11_converted.tif")
fishing_2012_12 = terra::rast("E:/shipless_areas/fishing/2012/grid_float_Fishing_2012_12_converted.tif")


###### 2013 ######
fishing_2013_01 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_01_converted.tif")
fishing_2013_02 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_02_converted.tif")
fishing_2013_03 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_03_converted.tif")
fishing_2013_04 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_04_converted.tif")
fishing_2013_05 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_05_converted.tif")
fishing_2013_06 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_06_converted.tif")
fishing_2013_07 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_07_converted.tif")
fishing_2013_08 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_08_converted.tif")
fishing_2013_09 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_09_converted.tif")
fishing_2013_10 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_10_converted.tif")
fishing_2013_11 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_11_converted.tif")
fishing_2013_12 = terra::rast("E:/shipless_areas/fishing/2013/grid_float_Fishing_2013_12_converted.tif")


###### 2014 ######
fishing_2014_01 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_01_converted.tif")
fishing_2014_02 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_02_converted.tif")
fishing_2014_03 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_03_converted.tif")
fishing_2014_04 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_04_converted.tif")
fishing_2014_05 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_05_converted.tif")
fishing_2014_06 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_06_converted.tif")
fishing_2014_07 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_07_converted.tif")
fishing_2014_08 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_08_converted.tif")
fishing_2014_09 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_09_converted.tif")
fishing_2014_10 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_10_converted.tif")
fishing_2014_11 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_11_converted.tif")
fishing_2014_12 = terra::rast("E:/shipless_areas/fishing/2014/grid_float_Fishing_2014_12_converted.tif")


###### 2015 ######
fishing_2015_01 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_01_converted.tif")
fishing_2015_02 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_02_converted.tif")
fishing_2015_03 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_03_converted.tif")
fishing_2015_04 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_04_converted.tif")
fishing_2015_05 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_05_converted.tif")
fishing_2015_06 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_06_converted.tif")
fishing_2015_07 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_07_converted.tif")
fishing_2015_08 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_08_converted.tif")
fishing_2015_09 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_09_converted.tif")
fishing_2015_10 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_10_converted.tif")
fishing_2015_11 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_11_converted.tif")
fishing_2015_12 = terra::rast("E:/shipless_areas/fishing/2015/grid_float_Fishing_2015_12_converted.tif")


###### 2016 ######
fishing_2016_01 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_01_converted.tif")
fishing_2016_02 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_02_converted.tif")
fishing_2016_03 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_03_converted.tif")
fishing_2016_04 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_04_converted.tif")
fishing_2016_05 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_05_converted.tif")
fishing_2016_06 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_06_converted.tif")
fishing_2016_07 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_07_converted.tif")
fishing_2016_08 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_08_converted.tif")
fishing_2016_09 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_09_converted.tif")
fishing_2016_10 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_10_converted.tif")
fishing_2016_11 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_11_converted.tif")
fishing_2016_12 = terra::rast("E:/shipless_areas/fishing/2016/grid_float_Fishing_2016_12_converted.tif")


###### 2017 ######
fishing_2017_01 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_01_converted.tif")
fishing_2017_02 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_02_converted.tif")
fishing_2017_03 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_03_converted.tif")
fishing_2017_04 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_04_converted.tif")
fishing_2017_05 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_05_converted.tif")
fishing_2017_06 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_06_converted.tif")
fishing_2017_07 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_07_converted.tif")
fishing_2017_08 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_08_converted.tif")
fishing_2017_09 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_09_converted.tif")
fishing_2017_10 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_10_converted.tif")
fishing_2017_11 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_11_converted.tif")
fishing_2017_12 = terra::rast("E:/shipless_areas/fishing/2017/grid_float_Fishing_2017_12_converted.tif")


###### 2018 ######
fishing_2018_01 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_01_converted.tif")
fishing_2018_02 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_02_converted.tif")
fishing_2018_03 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_03_converted.tif")
fishing_2018_04 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_04_converted.tif")
fishing_2018_05 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_05_converted.tif")
fishing_2018_06 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_06_converted.tif")
fishing_2018_07 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_07_converted.tif")
fishing_2018_08 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_08_converted.tif")
fishing_2018_09 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_09_converted.tif")
fishing_2018_10 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_10_converted.tif")
fishing_2018_11 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_11_converted.tif")
fishing_2018_12 = terra::rast("E:/shipless_areas/fishing/2018/grid_float_Fishing_2018_12_converted.tif")


###### 2019 ######
fishing_2019_01 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_01_converted.tif")
fishing_2019_02 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_02_converted.tif")
fishing_2019_03 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_03_converted.tif")
fishing_2019_04 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_04_converted.tif")
fishing_2019_05 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_05_converted.tif")
fishing_2019_06 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_06_converted.tif")
fishing_2019_07 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_07_converted.tif")
fishing_2019_08 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_08_converted.tif")
fishing_2019_09 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_09_converted.tif")
fishing_2019_10 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_10_converted.tif")
fishing_2019_11 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_11_converted.tif")
fishing_2019_12 = terra::rast("E:/shipless_areas/fishing/2019/grid_float_Fishing_2019_12_converted.tif")


###### 2020 ######
fishing_2020_01 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_01_converted.tif")
fishing_2020_02 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_02_converted.tif")
fishing_2020_03 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_03_converted.tif")
fishing_2020_04 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_04_converted.tif")
fishing_2020_05 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_05_converted.tif")
fishing_2020_06 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_06_converted.tif")
fishing_2020_07 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_07_converted.tif")
fishing_2020_08 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_08_converted.tif")
fishing_2020_09 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_09_converted.tif")
fishing_2020_10 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_10_converted.tif")
fishing_2020_11 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_11_converted.tif")
fishing_2020_12 = terra::rast("E:/shipless_areas/fishing/2020/grid_float_Fishing_2020_12_converted.tif")


###### 2021 ######
fishing_2021_01 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_01_converted.tif")
fishing_2021_02 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_02_converted.tif")
fishing_2021_03 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_03_converted.tif")
fishing_2021_04 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_04_converted.tif")
fishing_2021_05 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_05_converted.tif")
fishing_2021_06 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_06_converted.tif")
fishing_2021_07 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_07_converted.tif")
fishing_2021_08 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_08_converted.tif")
fishing_2021_09 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_09_converted.tif")
fishing_2021_10 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_10_converted.tif")
fishing_2021_11 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_11_converted.tif")
fishing_2021_12 = terra::rast("E:/shipless_areas/fishing/2021/grid_float_Fishing_2021_12_converted.tif")


###### 2022 ######
fishing_2022_01 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_01_converted.tif")
fishing_2022_02 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_02_converted.tif")
fishing_2022_03 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_03_converted.tif")
fishing_2022_04 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_04_converted.tif")
fishing_2022_05 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_05_converted.tif")
fishing_2022_06 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_06_converted.tif")
fishing_2022_07 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_07_converted.tif")
fishing_2022_08 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_08_converted.tif")
fishing_2022_09 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_09_converted.tif")
fishing_2022_10 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_10_converted.tif")
fishing_2022_11 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_11_converted.tif")
fishing_2022_12 = terra::rast("E:/shipless_areas/fishing/2022/grid_float_Fishing_2022_12_converted.tif")


###### 2023 ######
fishing_2023_01 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_01_converted.tif")
fishing_2023_02 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_02_converted.tif")
fishing_2023_03 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_03_converted.tif")
fishing_2023_04 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_04_converted.tif")
fishing_2023_05 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_05_converted.tif")
fishing_2023_06 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_06_converted.tif")
fishing_2023_07 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_07_converted.tif")
fishing_2023_08 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_08_converted.tif")
fishing_2023_09 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_09_converted.tif")
fishing_2023_10 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_10_converted.tif")
fishing_2023_11 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_11_converted.tif")
fishing_2023_12 = terra::rast("E:/shipless_areas/fishing/2023/grid_float_Fishing_2023_12_converted.tif")

