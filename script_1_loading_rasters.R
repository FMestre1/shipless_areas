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



################################################################################
#                               Summarize maps
################################################################################

#FMestre
#15-04-2024

#This script is just to evaluate the tendencies per vessel type across the years

#Clear environment
rm(list = ls()) 

#Load package
library(terra)
#library(ggplot2)

#Define the working directory
setwd("~/github/shipless_areas")

# Create folder for temp files

#In terminal
#mkdir temp

terraOptions(tempdir = "E:/shipless_areas/temp")

#Check tem files
tmpFiles()

# PLOT PER YEAR
# 2011 data were not used

### ALL ###
sum_all_2012 <- sum(all_2012_01, all_2012_02, all_2012_03, all_2012_04, all_2012_05, all_2012_06, all_2012_07, all_2012_08, all_2012_09, all_2012_10, all_2012_11, all_2012_12, na.rm = TRUE)
sum_all_2013 <- sum(all_2013_01, all_2013_02, all_2013_03, all_2013_04, all_2013_05, all_2013_06, all_2013_07, all_2013_08, all_2013_09, all_2013_10, all_2013_11, all_2013_12, na.rm = TRUE)
sum_all_2014 <- sum(all_2014_01, all_2014_02, all_2014_03, all_2014_04, all_2014_05, all_2014_06, all_2014_07, all_2014_08, all_2014_09, all_2014_10, all_2014_11, all_2014_12, na.rm = TRUE)
sum_all_2015 <- sum(all_2015_01, all_2015_02, all_2015_03, all_2015_04, all_2015_05, all_2015_06, all_2015_07, all_2015_08, all_2015_09, all_2015_10, all_2015_11, all_2015_12, na.rm = TRUE)
sum_all_2016 <- sum(all_2016_01, all_2016_02, all_2016_03, all_2016_04, all_2016_05, all_2016_06, all_2016_07, all_2016_08, all_2016_09, all_2016_10, all_2016_11, all_2016_12, na.rm = TRUE)
sum_all_2017 <- sum(all_2017_01, all_2017_02, all_2017_03, all_2017_04, all_2017_05, all_2017_06, all_2017_07, all_2017_08, all_2017_09, all_2017_10, all_2017_11, all_2017_12, na.rm = TRUE)
sum_all_2018 <- sum(all_2018_01, all_2018_02, all_2018_03, all_2018_04, all_2018_05, all_2018_06, all_2018_07, all_2018_08, all_2018_09, all_2018_10, all_2018_11, all_2018_12, na.rm = TRUE)
sum_all_2019 <- sum(all_2019_01, all_2019_02, all_2019_03, all_2019_04, all_2019_05, all_2019_06, all_2019_07, all_2019_08, all_2019_09, all_2019_10, all_2019_11, all_2019_12, na.rm = TRUE)
sum_all_2020 <- sum(all_2020_01, all_2020_02, all_2020_03, all_2020_04, all_2020_05, all_2020_06, all_2020_07, all_2020_08, all_2020_09, all_2020_10, all_2020_11, all_2020_12, na.rm = TRUE)
sum_all_2021 <- sum(all_2021_01, all_2021_02, all_2021_03, all_2021_04, all_2021_05, all_2021_06, all_2021_07, all_2021_08, all_2021_09, all_2021_10, all_2021_11, all_2021_12, na.rm = TRUE)
sum_all_2022 <- sum(all_2022_01, all_2022_02, all_2022_03, all_2022_04, all_2022_05, all_2022_06, all_2022_07, all_2022_08, all_2022_09, all_2022_10, all_2022_11, all_2022_12, na.rm = TRUE)
sum_all_2023 <- sum(all_2023_01, all_2023_02, all_2023_03, all_2023_04, all_2023_05, all_2023_06, all_2023_07, all_2023_08, all_2023_09, all_2023_10, all_2023_11, all_2023_12, na.rm = TRUE)
all_summed_no_2011 <- sum(sum_all_2012, sum_all_2013, sum_all_2014, sum_all_2015, sum_all_2016, sum_all_2017, sum_all_2018, sum_all_2019, sum_all_2020, sum_all_2021, sum_all_2022, sum_all_2023, na.rm = TRUE)
last_three_years_21_22_23 <- sum(sum_all_2021, sum_all_2022, sum_all_2023)
#plot(all_summed_no_2011)
#plot(last_three_years_21_22_23)

#Save
terra::writeRaster(sum_all_2012, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2012.tif")
terra::writeRaster(sum_all_2013, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2013.tif")
terra::writeRaster(sum_all_2014, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2014.tif")
terra::writeRaster(sum_all_2015, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2015.tif")
terra::writeRaster(sum_all_2016, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2016.tif")
terra::writeRaster(sum_all_2017, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2017.tif")
terra::writeRaster(sum_all_2018, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2018.tif")
terra::writeRaster(sum_all_2019, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2019.tif")
terra::writeRaster(sum_all_2020, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2020.tif")
terra::writeRaster(sum_all_2021, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2021.tif")
terra::writeRaster(sum_all_2022, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2022.tif")
terra::writeRaster(sum_all_2023, filename="E:/shipless_areas/sum_all_no_2011/sum_all_2023.tif")
terra::writeRaster(all_summed_no_2011, filename="E:/shipless_areas/sum_all_no_2011/all_summed_no_2011.tif")
terra::writeRaster(last_three_years_21_22_23, filename="E:/shipless_areas/sum_all_no_2011/last_three_years_21_22_23.tif")

#Load
sum_all_2012 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2012.tif")
sum_all_2013 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2013.tif")
sum_all_2014 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2014.tif")
sum_all_2015 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2015.tif")
sum_all_2016 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2016.tif")
sum_all_2017 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2017.tif")
sum_all_2018 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2018.tif")
sum_all_2019 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2019.tif")
sum_all_2020 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2020.tif")
sum_all_2021 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2021.tif")
sum_all_2022 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2022.tif")
sum_all_2023 <- terra::rast("E:/shipless_areas/sum_all_no_2011/sum_all_2023.tif")
all_summed_no_2011 <- terra::rast("E:/shipless_areas/sum_all_no_2011/all_summed_no_2011.tif")
last_three_years_21_22_23 <- terra::rast("E:/shipless_areas/sum_all_no_2011/last_three_years_21_22_23.tif")

# Mean and SD
all_summed_stack <- c(sum_all_2012, sum_all_2013, sum_all_2014, sum_all_2015, sum_all_2016, sum_all_2017, sum_all_2018, sum_all_2019, sum_all_2020, sum_all_2021, sum_all_2022, sum_all_2023)
rm(sum_all_2012, sum_all_2013, sum_all_2014, sum_all_2015, sum_all_2016, sum_all_2017, sum_all_2018, sum_all_2019, sum_all_2020, sum_all_2021, sum_all_2022, sum_all_2023)
#
mean_sd_all_summed_stack <- terra::global(all_summed_stack, c("mean", "sd"), na.rm=TRUE)
mean_sd_all_summed_stack <- data.frame(2012:2023, mean_sd_all_summed_stack)
names(mean_sd_all_summed_stack)[1] <- "years"
rownames(mean_sd_all_summed_stack) <- 1:nrow(mean_sd_all_summed_stack)
save(mean_sd_all_summed_stack, file = "mean_sd_all_summed_stack.RData")
plot(mean_sd_all_summed_stack$years, mean_sd_all_summed_stack$mean, type = "l", main = "All ships", xlab = "year", ylab = "Ship density (hours/cell)")
rm(list = ls())

### CARGO ###
sum_cargo_2012 <- sum(cargo_2012_01, cargo_2012_02, cargo_2012_03, cargo_2012_04, cargo_2012_05, cargo_2012_06, cargo_2012_07, cargo_2012_08, cargo_2012_09, cargo_2012_10, cargo_2012_11, cargo_2012_12, na.rm = TRUE)
sum_cargo_2013 <- sum(cargo_2013_01, cargo_2013_02, cargo_2013_03, cargo_2013_04, cargo_2013_05, cargo_2013_06, cargo_2013_07, cargo_2013_08, cargo_2013_09, cargo_2013_10, cargo_2013_11, cargo_2013_12, na.rm = TRUE)
sum_cargo_2014 <- sum(cargo_2014_01, cargo_2014_02, cargo_2014_03, cargo_2014_04, cargo_2014_05, cargo_2014_06, cargo_2014_07, cargo_2014_08, cargo_2014_09, cargo_2014_10, cargo_2014_11, cargo_2014_12, na.rm = TRUE)
sum_cargo_2015 <- sum(cargo_2015_01, cargo_2015_02, cargo_2015_03, cargo_2015_04, cargo_2015_05, cargo_2015_06, cargo_2015_07, cargo_2015_08, cargo_2015_09, cargo_2015_10, cargo_2015_11, cargo_2015_12, na.rm = TRUE)
sum_cargo_2016 <- sum(cargo_2016_01, cargo_2016_02, cargo_2016_03, cargo_2016_04, cargo_2016_05, cargo_2016_06, cargo_2016_07, cargo_2016_08, cargo_2016_09, cargo_2016_10, cargo_2016_11, cargo_2016_12, na.rm = TRUE)
sum_cargo_2017 <- sum(cargo_2017_01, cargo_2017_02, cargo_2017_03, cargo_2017_04, cargo_2017_05, cargo_2017_06, cargo_2017_07, cargo_2017_08, cargo_2017_09, cargo_2017_10, cargo_2017_11, cargo_2017_12, na.rm = TRUE)
sum_cargo_2018 <- sum(cargo_2018_01, cargo_2018_02, cargo_2018_03, cargo_2018_04, cargo_2018_05, cargo_2018_06, cargo_2018_07, cargo_2018_08, cargo_2018_09, cargo_2018_10, cargo_2018_11, cargo_2018_12, na.rm = TRUE)
sum_cargo_2019 <- sum(cargo_2019_01, cargo_2019_02, cargo_2019_03, cargo_2019_04, cargo_2019_05, cargo_2019_06, cargo_2019_07, cargo_2019_08, cargo_2019_09, cargo_2019_10, cargo_2019_11, cargo_2019_12, na.rm = TRUE)
sum_cargo_2020 <- sum(cargo_2020_01, cargo_2020_02, cargo_2020_03, cargo_2020_04, cargo_2020_05, cargo_2020_06, cargo_2020_07, cargo_2020_08, cargo_2020_09, cargo_2020_10, cargo_2020_11, cargo_2020_12, na.rm = TRUE)
sum_cargo_2021 <- sum(cargo_2021_01, cargo_2021_02, cargo_2021_03, cargo_2021_04, cargo_2021_05, cargo_2021_06, cargo_2021_07, cargo_2021_08, cargo_2021_09, cargo_2021_10, cargo_2021_11, cargo_2021_12, na.rm = TRUE)
sum_cargo_2022 <- sum(cargo_2022_01, cargo_2022_02, cargo_2022_03, cargo_2022_04, cargo_2022_05, cargo_2022_06, cargo_2022_07, cargo_2022_08, cargo_2022_09, cargo_2022_10, cargo_2022_11, cargo_2022_12, na.rm = TRUE)
sum_cargo_2023 <- sum(cargo_2023_01, cargo_2023_02, cargo_2023_03, cargo_2023_04, cargo_2023_05, cargo_2023_06, cargo_2023_07, cargo_2023_08, cargo_2023_09, cargo_2023_10, cargo_2023_11, cargo_2023_12, na.rm = TRUE)
cargo_summed <- sum(sum_cargo_2012, sum_cargo_2013, sum_cargo_2014, sum_cargo_2015, sum_cargo_2016, sum_cargo_2017, sum_cargo_2018, sum_cargo_2019, sum_cargo_2020, sum_cargo_2021, sum_cargo_2022, sum_cargo_2023, na.rm = TRUE)
#plot(cargo_summed)

#Save
terra::writeRaster(sum_cargo_2012, filename="E:/shipless_areas/sum_cargo/sum_cargo_2012.tif")
terra::writeRaster(sum_cargo_2013, filename="E:/shipless_areas/sum_cargo/sum_cargo_2013.tif")
terra::writeRaster(sum_cargo_2014, filename="E:/shipless_areas/sum_cargo/sum_cargo_2014.tif")
terra::writeRaster(sum_cargo_2015, filename="E:/shipless_areas/sum_cargo/sum_cargo_2015.tif")
terra::writeRaster(sum_cargo_2016, filename="E:/shipless_areas/sum_cargo/sum_cargo_2016.tif")
terra::writeRaster(sum_cargo_2017, filename="E:/shipless_areas/sum_cargo/sum_cargo_2017.tif")
terra::writeRaster(sum_cargo_2018, filename="E:/shipless_areas/sum_cargo/sum_cargo_2018.tif")
terra::writeRaster(sum_cargo_2019, filename="E:/shipless_areas/sum_cargo/sum_cargo_2019.tif")
terra::writeRaster(sum_cargo_2020, filename="E:/shipless_areas/sum_cargo/sum_cargo_2020.tif")
terra::writeRaster(sum_cargo_2021, filename="E:/shipless_areas/sum_cargo/sum_cargo_2021.tif")
terra::writeRaster(sum_cargo_2022, filename="E:/shipless_areas/sum_cargo/sum_cargo_2022.tif")
terra::writeRaster(sum_cargo_2023, filename="E:/shipless_areas/sum_cargo/sum_cargo_2023.tif")
terra::writeRaster(cargo_summed, filename="E:/shipless_areas/sum_cargo/cargo_summed.tif")

#Load
sum_cargo_2012 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2012.tif")
sum_cargo_2013 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2013.tif")
sum_cargo_2014 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2014.tif")
sum_cargo_2015 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2015.tif")
sum_cargo_2016 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2016.tif")
sum_cargo_2017 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2017.tif")
sum_cargo_2018 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2018.tif")
sum_cargo_2019 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2019.tif")
sum_cargo_2020 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2020.tif")
sum_cargo_2021 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2021.tif")
sum_cargo_2022 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2022.tif")
sum_cargo_2023 <- terra::rast("E:/shipless_areas/sum_cargo/sum_cargo_2023.tif")
cargo_summed <- terra::rast("E:/shipless_areas/sum_cargo/cargo_summed.tif")

# Mean and SD
cargo_summed_stack <- c(sum_cargo_2012, sum_cargo_2013, sum_cargo_2014, sum_cargo_2015, sum_cargo_2016, sum_cargo_2017, sum_cargo_2018, sum_cargo_2019, sum_cargo_2020, sum_cargo_2021, sum_cargo_2022, sum_cargo_2023)
rm(sum_cargo_2012, sum_cargo_2013, sum_cargo_2014, sum_cargo_2015, sum_cargo_2016, sum_cargo_2017, sum_cargo_2018, sum_cargo_2019, sum_cargo_2020, sum_cargo_2021, sum_cargo_2022, sum_cargo_2023)
#
#
mean_sd_cargo_summed_stack <- terra::global(cargo_summed_stack, c("mean", "sd"), na.rm=TRUE)
mean_sd_cargo_summed_stack <- data.frame(2011:2023, mean_sd_cargo_summed_stack)
names(mean_sd_cargo_summed_stack)[1] <- "years"
rownames(mean_sd_cargo_summed_stack) <- 1:nrow(mean_sd_cargo_summed_stack)
save(mean_sd_cargo_summed_stack, file = "mean_sd_cargo_summed_stack.RData")
plot(mean_sd_cargo_summed_stack$years, mean_sd_cargo_summed_stack$mean, type = "l", , main = "Cargo ships", xlab = "year", ylab = "Ship density (hours/cell)")
rm(list = ls())

### TANKERS ###
sum_tankers_2012 <- sum(tankers_2012_01, tankers_2012_02, tankers_2012_03, tankers_2012_04, tankers_2012_05, tankers_2012_06, tankers_2012_07, tankers_2012_08, tankers_2012_09, tankers_2012_10, tankers_2012_11, tankers_2012_12, na.rm = TRUE)
sum_tankers_2013 <- sum(tankers_2013_01, tankers_2013_02, tankers_2013_03, tankers_2013_04, tankers_2013_05, tankers_2013_06, tankers_2013_07, tankers_2013_08, tankers_2013_09, tankers_2013_10, tankers_2013_11, tankers_2013_12, na.rm = TRUE)
sum_tankers_2014 <- sum(tankers_2014_01, tankers_2014_02, tankers_2014_03, tankers_2014_04, tankers_2014_05, tankers_2014_06, tankers_2014_07, tankers_2014_08, tankers_2014_09, tankers_2014_10, tankers_2014_11, tankers_2014_12, na.rm = TRUE)
sum_tankers_2015 <- sum(tankers_2015_01, tankers_2015_02, tankers_2015_03, tankers_2015_04, tankers_2015_05, tankers_2015_06, tankers_2015_07, tankers_2015_08, tankers_2015_09, tankers_2015_10, tankers_2015_11, tankers_2015_12, na.rm = TRUE)
sum_tankers_2016 <- sum(tankers_2016_01, tankers_2016_02, tankers_2016_03, tankers_2016_04, tankers_2016_05, tankers_2016_06, tankers_2016_07, tankers_2016_08, tankers_2016_09, tankers_2016_10, tankers_2016_11, tankers_2016_12, na.rm = TRUE)
sum_tankers_2017 <- sum(tankers_2017_01, tankers_2017_02, tankers_2017_03, tankers_2017_04, tankers_2017_05, tankers_2017_06, tankers_2017_07, tankers_2017_08, tankers_2017_09, tankers_2017_10, tankers_2017_11, tankers_2017_12, na.rm = TRUE)
sum_tankers_2018 <- sum(tankers_2018_01, tankers_2018_02, tankers_2018_03, tankers_2018_04, tankers_2018_05, tankers_2018_06, tankers_2018_07, tankers_2018_08, tankers_2018_09, tankers_2018_10, tankers_2018_11, tankers_2018_12, na.rm = TRUE)
sum_tankers_2019 <- sum(tankers_2019_01, tankers_2019_02, tankers_2019_03, tankers_2019_04, tankers_2019_05, tankers_2019_06, tankers_2019_07, tankers_2019_08, tankers_2019_09, tankers_2019_10, tankers_2019_11, tankers_2019_12, na.rm = TRUE)
sum_tankers_2020 <- sum(tankers_2020_01, tankers_2020_02, tankers_2020_03, tankers_2020_04, tankers_2020_05, tankers_2020_06, tankers_2020_07, tankers_2020_08, tankers_2020_09, tankers_2020_10, tankers_2020_11, tankers_2020_12, na.rm = TRUE)
sum_tankers_2021 <- sum(tankers_2021_01, tankers_2021_02, tankers_2021_03, tankers_2021_04, tankers_2021_05, tankers_2021_06, tankers_2021_07, tankers_2021_08, tankers_2021_09, tankers_2021_10, tankers_2021_11, tankers_2021_12, na.rm = TRUE)
sum_tankers_2022 <- sum(tankers_2022_01, tankers_2022_02, tankers_2022_03, tankers_2022_04, tankers_2022_05, tankers_2022_06, tankers_2022_07, tankers_2022_08, tankers_2022_09, tankers_2022_10, tankers_2022_11, tankers_2022_12, na.rm = TRUE)
sum_tankers_2023 <- sum(tankers_2023_01, tankers_2023_02, tankers_2023_03, tankers_2023_04, tankers_2023_05, tankers_2023_06, tankers_2023_07, tankers_2023_08, tankers_2023_09, tankers_2023_10, tankers_2023_11, tankers_2023_12, na.rm = TRUE)
tankers_summed <- sum(sum_tankers_2012, sum_tankers_2013, sum_tankers_2014, sum_tankers_2015, sum_tankers_2016, sum_tankers_2017, sum_tankers_2018, sum_tankers_2019, sum_tankers_2020, sum_tankers_2021, sum_tankers_2022, sum_tankers_2023, na.rm = TRUE)
#plot(tankers_summed)

#Save
terra::writeRaster(sum_tankers_2012, filename="E:/shipless_areas/sum_tankers/sum_tankers_2012.tif")
terra::writeRaster(sum_tankers_2013, filename="E:/shipless_areas/sum_tankers/sum_tankers_2013.tif")
terra::writeRaster(sum_tankers_2014, filename="E:/shipless_areas/sum_tankers/sum_tankers_2014.tif")
terra::writeRaster(sum_tankers_2015, filename="E:/shipless_areas/sum_tankers/sum_tankers_2015.tif")
terra::writeRaster(sum_tankers_2016, filename="E:/shipless_areas/sum_tankers/sum_tankers_2016.tif")
terra::writeRaster(sum_tankers_2017, filename="E:/shipless_areas/sum_tankers/sum_tankers_2017.tif")
terra::writeRaster(sum_tankers_2018, filename="E:/shipless_areas/sum_tankers/sum_tankers_2018.tif")
terra::writeRaster(sum_tankers_2019, filename="E:/shipless_areas/sum_tankers/sum_tankers_2019.tif")
terra::writeRaster(sum_tankers_2020, filename="E:/shipless_areas/sum_tankers/sum_tankers_2020.tif")
terra::writeRaster(sum_tankers_2021, filename="E:/shipless_areas/sum_tankers/sum_tankers_2021.tif")
terra::writeRaster(sum_tankers_2022, filename="E:/shipless_areas/sum_tankers/sum_tankers_2022.tif")
terra::writeRaster(sum_tankers_2023, filename="E:/shipless_areas/sum_tankers/sum_tankers_2023.tif")
terra::writeRaster(tankers_summed, filename="E:/shipless_areas/sum_tankers/tankers_summed.tif")

#Load
sum_tankers_2012 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2012.tif")
sum_tankers_2013 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2013.tif")
sum_tankers_2014 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2014.tif")
sum_tankers_2015 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2015.tif")
sum_tankers_2016 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2016.tif")
sum_tankers_2017 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2017.tif")
sum_tankers_2018 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2018.tif")
sum_tankers_2019 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2019.tif")
sum_tankers_2020 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2020.tif")
sum_tankers_2021 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2021.tif")
sum_tankers_2022 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2022.tif")
sum_tankers_2023 <- terra::rast("E:/shipless_areas/sum_tankers/sum_tankers_2023.tif")
tankers_summed <- terra::rast("E:/shipless_areas/sum_tankers/tankers_summed.tif")

# Mean and SD
tankers_summed_stack <- c(sum_tankers_2012, sum_tankers_2013, sum_tankers_2014, sum_tankers_2015, sum_tankers_2016, sum_tankers_2017, sum_tankers_2018, sum_tankers_2019, sum_tankers_2020, sum_tankers_2021, sum_tankers_2022, sum_tankers_2023)
rm(sum_tankers_2012, sum_tankers_2013, sum_tankers_2014, sum_tankers_2015, sum_tankers_2016, sum_tankers_2017, sum_tankers_2018, sum_tankers_2019, sum_tankers_2020, sum_tankers_2021, sum_tankers_2022, sum_tankers_2023)
##
mean_sd_tankers_summed_stack <- terra::global(tankers_summed_stack, c("mean", "sd"), na.rm=TRUE)
mean_sd_tankers_summed_stack <- data.frame(2011:2023, mean_sd_tankers_summed_stack)
names(mean_sd_tankers_summed_stack)[1] <- "years"
rownames(mean_sd_tankers_summed_stack) <- 1:nrow(mean_sd_tankers_summed_stack)
save(mean_sd_tankers_summed_stack, file = "mean_sd_tankers_summed_stack.RData")
plot(mean_sd_tankers_summed_stack$years, mean_sd_tankers_summed_stack$mean, type = "l", main = "Tankers", xlab = "year", ylab = "Ship density (hours/cell)")
rm(list = ls())

### FISHING ###
sum_fishing_2012 <- sum(fishing_2012_01, fishing_2012_02, fishing_2012_03, fishing_2012_04, fishing_2012_05, fishing_2012_06, fishing_2012_07, fishing_2012_08, fishing_2012_09, fishing_2012_10, fishing_2012_11, fishing_2012_12, na.rm = TRUE)
sum_fishing_2013 <- sum(fishing_2013_01, fishing_2013_02, fishing_2013_03, fishing_2013_04, fishing_2013_05, fishing_2013_06, fishing_2013_07, fishing_2013_08, fishing_2013_09, fishing_2013_10, fishing_2013_11, fishing_2013_12, na.rm = TRUE)
sum_fishing_2014 <- sum(fishing_2014_01, fishing_2014_02, fishing_2014_03, fishing_2014_04, fishing_2014_05, fishing_2014_06, fishing_2014_07, fishing_2014_08, fishing_2014_09, fishing_2014_10, fishing_2014_11, fishing_2014_12, na.rm = TRUE)
sum_fishing_2015 <- sum(fishing_2015_01, fishing_2015_02, fishing_2015_03, fishing_2015_04, fishing_2015_05, fishing_2015_06, fishing_2015_07, fishing_2015_08, fishing_2015_09, fishing_2015_10, fishing_2015_11, fishing_2015_12, na.rm = TRUE)
sum_fishing_2016 <- sum(fishing_2016_01, fishing_2016_02, fishing_2016_03, fishing_2016_04, fishing_2016_05, fishing_2016_06, fishing_2016_07, fishing_2016_08, fishing_2016_09, fishing_2016_10, fishing_2016_11, fishing_2016_12, na.rm = TRUE)
sum_fishing_2017 <- sum(fishing_2017_01, fishing_2017_02, fishing_2017_03, fishing_2017_04, fishing_2017_05, fishing_2017_06, fishing_2017_07, fishing_2017_08, fishing_2017_09, fishing_2017_10, fishing_2017_11, fishing_2017_12, na.rm = TRUE)
sum_fishing_2018 <- sum(fishing_2018_01, fishing_2018_02, fishing_2018_03, fishing_2018_04, fishing_2018_05, fishing_2018_06, fishing_2018_07, fishing_2018_08, fishing_2018_09, fishing_2018_10, fishing_2018_11, fishing_2018_12, na.rm = TRUE)
sum_fishing_2019 <- sum(fishing_2019_01, fishing_2019_02, fishing_2019_03, fishing_2019_04, fishing_2019_05, fishing_2019_06, fishing_2019_07, fishing_2019_08, fishing_2019_09, fishing_2019_10, fishing_2019_11, fishing_2019_12, na.rm = TRUE)
sum_fishing_2020 <- sum(fishing_2020_01, fishing_2020_02, fishing_2020_03, fishing_2020_04, fishing_2020_05, fishing_2020_06, fishing_2020_07, fishing_2020_08, fishing_2020_09, fishing_2020_10, fishing_2020_11, fishing_2020_12, na.rm = TRUE)
sum_fishing_2021 <- sum(fishing_2021_01, fishing_2021_02, fishing_2021_03, fishing_2021_04, fishing_2021_05, fishing_2021_06, fishing_2021_07, fishing_2021_08, fishing_2021_09, fishing_2021_10, fishing_2021_11, fishing_2021_12, na.rm = TRUE)
sum_fishing_2022 <- sum(fishing_2022_01, fishing_2022_02, fishing_2022_03, fishing_2022_04, fishing_2022_05, fishing_2022_06, fishing_2022_07, fishing_2022_08, fishing_2022_09, fishing_2022_10, fishing_2022_11, fishing_2022_12, na.rm = TRUE)
sum_fishing_2023 <- sum(fishing_2023_01, fishing_2023_02, fishing_2023_03, fishing_2023_04, fishing_2023_05, fishing_2023_06, fishing_2023_07, fishing_2023_08, fishing_2023_09, fishing_2023_10, fishing_2023_11, fishing_2023_12, na.rm = TRUE)
fishing_summed <- sum( sum_fishing_2012, sum_fishing_2013, sum_fishing_2014, sum_fishing_2015, sum_fishing_2016, sum_fishing_2017, sum_fishing_2018, sum_fishing_2019, sum_fishing_2020, sum_fishing_2021, sum_fishing_2022, sum_fishing_2023, na.rm = TRUE)
#plot(fishing_summed)

#Save
terra::writeRaster(sum_fishing_2012, filename="E:/shipless_areas/sum_fishing/sum_fishing_2012.tif")
terra::writeRaster(sum_fishing_2013, filename="E:/shipless_areas/sum_fishing/sum_fishing_2013.tif")
terra::writeRaster(sum_fishing_2014, filename="E:/shipless_areas/sum_fishing/sum_fishing_2014.tif")
terra::writeRaster(sum_fishing_2015, filename="E:/shipless_areas/sum_fishing/sum_fishing_2015.tif")
terra::writeRaster(sum_fishing_2016, filename="E:/shipless_areas/sum_fishing/sum_fishing_2016.tif")
terra::writeRaster(sum_fishing_2017, filename="E:/shipless_areas/sum_fishing/sum_fishing_2017.tif")
terra::writeRaster(sum_fishing_2018, filename="E:/shipless_areas/sum_fishing/sum_fishing_2018.tif")
terra::writeRaster(sum_fishing_2019, filename="E:/shipless_areas/sum_fishing/sum_fishing_2019.tif")
terra::writeRaster(sum_fishing_2020, filename="E:/shipless_areas/sum_fishing/sum_fishing_2020.tif")
terra::writeRaster(sum_fishing_2021, filename="E:/shipless_areas/sum_fishing/sum_fishing_2021.tif")
terra::writeRaster(sum_fishing_2022, filename="E:/shipless_areas/sum_fishing/sum_fishing_2022.tif")
terra::writeRaster(sum_fishing_2023, filename="E:/shipless_areas/sum_fishing/sum_fishing_2023.tif")
terra::writeRaster(fishing_summed, filename="E:/shipless_areas/sum_fishing/fishing_summed.tif")

#Load
sum_fishing_2012 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2012.tif")
sum_fishing_2013 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2013.tif")
sum_fishing_2014 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2014.tif")
sum_fishing_2015 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2015.tif")
sum_fishing_2016 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2016.tif")
sum_fishing_2017 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2017.tif")
sum_fishing_2018 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2018.tif")
sum_fishing_2019 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2019.tif")
sum_fishing_2020 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2020.tif")
sum_fishing_2021 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2021.tif")
sum_fishing_2022 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2022.tif")
sum_fishing_2023 <- terra::rast("E:/shipless_areas/sum_fishing/sum_fishing_2023.tif")
fishing_summed <- terra::rast("E:/shipless_areas/sum_fishing/fishing_summed.tif")

# Mean and SD
fishing_summed_stack <- c(sum_fishing_2012, sum_fishing_2013, sum_fishing_2014, sum_fishing_2015, sum_fishing_2016, sum_fishing_2017, sum_fishing_2018, sum_fishing_2019, sum_fishing_2020, sum_fishing_2021, sum_fishing_2022, sum_fishing_2023)
rm(sum_fishing_2012, sum_fishing_2013, sum_fishing_2014, sum_fishing_2015, sum_fishing_2016, sum_fishing_2017, sum_fishing_2018, sum_fishing_2019, sum_fishing_2020, sum_fishing_2021, sum_fishing_2022, sum_fishing_2023)
#
mean_sd_fishing_summed_stack <- terra::global(fishing_summed_stack, c("mean", "sd"), na.rm=TRUE)
mean_sd_fishing_summed_stack <- data.frame(2011:2023, mean_sd_fishing_summed_stack)
names(mean_sd_fishing_summed_stack)[1] <- "years"
rownames(mean_sd_fishing_summed_stack) <- 1:nrow(mean_sd_fishing_summed_stack)
save(mean_sd_fishing_summed_stack, file = "mean_sd_fishing_summed_stack.RData")
plot(mean_sd_fishing_summed_stack$years, mean_sd_fishing_summed_stack$mean, type = "l", main = "Fishing ships", xlab = "year", ylab = "Ship density (hours/cell)")
rm(list = ls())

save(mean_sd_all_summed_stack, file = "mean_sd_all_summed_stack_v2.RData")
save(mean_sd_cargo_summed_stack, file = "mean_sd_cargo_summed_stack_v2.RData")
save(mean_sd_tankers_summed_stack, file = "mean_sd_tankers_summed_stack_v2.RData")
save(mean_sd_fishing_summed_stack, file = "mean_sd_fishing_summed_stack_v2.RData")

########################################################################################
#                     Month-based summary - (not really used!)
########################################################################################


### JANUARY ###
all_january <- sum(all_2011_01, all_2012_01, all_2013_01, all_2014_01, all_2015_01, all_2016_01, all_2017_01, all_2018_01, all_2019_01, all_2020_01, all_2021_01, all_2022_01, all_2023_01, na.rm = TRUE)
cargo_january <- sum(cargo_2011_01, cargo_2012_01, cargo_2013_01, cargo_2014_01, cargo_2015_01, cargo_2016_01, cargo_2017_01, cargo_2018_01, cargo_2019_01, cargo_2020_01, cargo_2021_01, cargo_2022_01, cargo_2023_01, na.rm = TRUE)
tankers_january <- sum(tankers_2011_01, tankers_2012_01, tankers_2013_01, tankers_2014_01, tankers_2015_01, tankers_2016_01, tankers_2017_01, tankers_2018_01, tankers_2019_01, tankers_2020_01, tankers_2021_01, tankers_2022_01, tankers_2023_01, na.rm = TRUE)
fishing_january <- sum(fishing_2011_01, fishing_2012_01, fishing_2013_01, fishing_2014_01, fishing_2015_01, fishing_2016_01, fishing_2017_01, fishing_2018_01, fishing_2019_01, fishing_2020_01, fishing_2021_01, fishing_2022_01, fishing_2023_01, na.rm = TRUE)
#Save
terra::writeRaster(all_january, filename="E:/shipless_areas/all_january.tif")
terra::writeRaster(cargo_january, filename="E:/shipless_areas/cargo_january.tif")
terra::writeRaster(tankers_january, filename="E:/shipless_areas/tankers_january.tif")
terra::writeRaster(fishing_january, filename="E:/shipless_areas/fishing_january.tif")

### FEBRUARY ###
all_february <- sum(all_2011_02, all_2012_02, all_2013_02, all_2014_02, all_2015_02, all_2016_02, all_2017_02, all_2018_02, all_2019_02, all_2020_02, all_2021_02, all_2022_02, all_2023_02, na.rm = TRUE)
cargo_february <- sum(cargo_2011_02, cargo_2012_02, cargo_2013_02, cargo_2014_02, cargo_2015_02, cargo_2016_02, cargo_2017_02, cargo_2018_02, cargo_2019_02, cargo_2020_02, cargo_2021_02, cargo_2022_02, cargo_2023_02, na.rm = TRUE)
tankers_february <- sum(tankers_2011_02, tankers_2012_02, tankers_2013_02, tankers_2014_02, tankers_2015_02, tankers_2016_02, tankers_2017_02, tankers_2018_02, tankers_2019_02, tankers_2020_02, tankers_2021_02, tankers_2022_02, tankers_2023_02, na.rm = TRUE)
fishing_february <- sum(fishing_2011_02, fishing_2012_02, fishing_2013_02, fishing_2014_02, fishing_2015_02, fishing_2016_02, fishing_2017_02, fishing_2018_02, fishing_2019_02, fishing_2020_02, fishing_2021_02, fishing_2022_02, fishing_2023_02, na.rm = TRUE)
#Save
terra::writeRaster(all_february, filename="E:/shipless_areas/all_february.tif")
terra::writeRaster(cargo_february, filename="E:/shipless_areas/cargo_february.tif")
terra::writeRaster(tankers_february, filename="E:/shipless_areas/tankers_february.tif")
terra::writeRaster(fishing_february, filename="E:/shipless_areas/fishing_february.tif")

### MARCH ###
all_march <- sum(all_2011_03, all_2012_03, all_2013_03, all_2014_03, all_2015_03, all_2016_03, all_2017_03, all_2018_03, all_2019_03, all_2020_03, all_2021_03, all_2022_03, all_2023_03, na.rm = TRUE)
cargo_march <- sum(cargo_2011_03, cargo_2012_03, cargo_2013_03, cargo_2014_03, cargo_2015_03, cargo_2016_03, cargo_2017_03, cargo_2018_03, cargo_2019_03, cargo_2020_03, cargo_2021_03, cargo_2022_03, cargo_2023_03, na.rm = TRUE)
tankers_march <- sum(tankers_2011_03, tankers_2012_03, tankers_2013_03, tankers_2014_03, tankers_2015_03, tankers_2016_03, tankers_2017_03, tankers_2018_03, tankers_2019_03, tankers_2020_03, tankers_2021_03, tankers_2022_03, tankers_2023_03, na.rm = TRUE)
fishing_march <- sum(fishing_2011_03, fishing_2012_03, fishing_2013_03, fishing_2014_03, fishing_2015_03, fishing_2016_03, fishing_2017_03, fishing_2018_03, fishing_2019_03, fishing_2020_03, fishing_2021_03, fishing_2022_03, fishing_2023_03, na.rm = TRUE)
#Save
terra::writeRaster(all_march, filename="E:/shipless_areas/all_march.tif")
terra::writeRaster(cargo_march, filename="E:/shipless_areas/cargo_march.tif")
terra::writeRaster(tankers_march, filename="E:/shipless_areas/tankers_march.tif")
terra::writeRaster(fishing_march, filename="E:/shipless_areas/fishing_march.tif")

### APRIL ###
all_april <- sum(all_2011_04, all_2012_04, all_2013_04, all_2014_04, all_2015_04, all_2016_04, all_2017_04, all_2018_04, all_2019_04, all_2020_04, all_2021_04, all_2022_04, all_2023_04, na.rm = TRUE)
cargo_april <- sum(cargo_2011_04, cargo_2012_04, cargo_2013_04, cargo_2014_04, cargo_2015_04, cargo_2016_04, cargo_2017_04, cargo_2018_04, cargo_2019_04, cargo_2020_04, cargo_2021_04, cargo_2022_04, cargo_2023_04, na.rm = TRUE)
tankers_april <- sum(tankers_2011_04, tankers_2012_04, tankers_2013_04, tankers_2014_04, tankers_2015_04, tankers_2016_04, tankers_2017_04, tankers_2018_04, tankers_2019_04, tankers_2020_04, tankers_2021_04, tankers_2022_04, tankers_2023_04, na.rm = TRUE)
fishing_april <- sum(fishing_2011_04, fishing_2012_04, fishing_2013_04, fishing_2014_04, fishing_2015_04, fishing_2016_04, fishing_2017_04, fishing_2018_04, fishing_2019_04, fishing_2020_04, fishing_2021_04, fishing_2022_04, fishing_2023_04, na.rm = TRUE)
#Save
terra::writeRaster(all_april, filename="E:/shipless_areas/all_april.tif")
terra::writeRaster(cargo_april, filename="E:/shipless_areas/cargo_april.tif")
terra::writeRaster(tankers_april, filename="E:/shipless_areas/tankers_april.tif")
terra::writeRaster(fishing_april, filename="E:/shipless_areas/fishing_april.tif")

### MAY ###
all_may <- sum(all_2011_05, all_2012_05, all_2013_05, all_2014_05, all_2015_05, all_2016_05, all_2017_05, all_2018_05, all_2019_05, all_2020_05, all_2021_05, all_2022_05, all_2023_05, na.rm = TRUE)
cargo_may <- sum(cargo_2011_05, cargo_2012_05, cargo_2013_05, cargo_2014_05, cargo_2015_05, cargo_2016_05, cargo_2017_05, cargo_2018_05, cargo_2019_05, cargo_2020_05, cargo_2021_05, cargo_2022_05, cargo_2023_05, na.rm = TRUE)
tankers_may <- sum(tankers_2011_05, tankers_2012_05, tankers_2013_05, tankers_2014_05, tankers_2015_05, tankers_2016_05, tankers_2017_05, tankers_2018_05, tankers_2019_05, tankers_2020_05, tankers_2021_05, tankers_2022_05, tankers_2023_05, na.rm = TRUE)
fishing_may <- sum(fishing_2011_05, fishing_2012_05, fishing_2013_05, fishing_2014_05, fishing_2015_05, fishing_2016_05, fishing_2017_05, fishing_2018_05, fishing_2019_05, fishing_2020_05, fishing_2021_05, fishing_2022_05, fishing_2023_05, na.rm = TRUE)
#Save
terra::writeRaster(all_may, filename="E:/shipless_areas/all_may.tif")
terra::writeRaster(cargo_may, filename="E:/shipless_areas/cargo_may.tif")
terra::writeRaster(tankers_may, filename="E:/shipless_areas/tankers_may.tif")
terra::writeRaster(fishing_may, filename="E:/shipless_areas/fishing_may.tif")

### JUNE ###
all_june <- sum(all_2011_06, all_2012_06, all_2013_06, all_2014_06, all_2015_06, all_2016_06, all_2017_06, all_2018_06, all_2019_06, all_2020_06, all_2021_06, all_2022_06, all_2023_06, na.rm = TRUE)
cargo_june <- sum(cargo_2011_06, cargo_2012_06, cargo_2013_06, cargo_2014_06, cargo_2015_06, cargo_2016_06, cargo_2017_06, cargo_2018_06, cargo_2019_06, cargo_2020_06, cargo_2021_06, cargo_2022_06, cargo_2023_06, na.rm = TRUE)
tankers_june <- sum(tankers_2011_06, tankers_2012_06, tankers_2013_06, tankers_2014_06, tankers_2015_06, tankers_2016_06, tankers_2017_06, tankers_2018_06, tankers_2019_06, tankers_2020_06, tankers_2021_06, tankers_2022_06, tankers_2023_06, na.rm = TRUE)
fishing_june <- sum(fishing_2011_06, fishing_2012_06, fishing_2013_06, fishing_2014_06, fishing_2015_06, fishing_2016_06, fishing_2017_06, fishing_2018_06, fishing_2019_06, fishing_2020_06, fishing_2021_06, fishing_2022_06, fishing_2023_06, na.rm = TRUE)
#Save
terra::writeRaster(all_june, filename="E:/shipless_areas/all_june.tif")
terra::writeRaster(cargo_june, filename="E:/shipless_areas/cargo_june.tif")
terra::writeRaster(tankers_june, filename="E:/shipless_areas/tankers_june.tif")
terra::writeRaster(fishing_june, filename="E:/shipless_areas/fishing_june.tif")

### JULY ###
all_july <- sum(all_2011_07, all_2012_07, all_2013_07, all_2014_07, all_2015_07, all_2016_07, all_2017_07, all_2018_07, all_2019_07, all_2020_07, all_2021_07, all_2022_07, all_2023_07, na.rm = TRUE)
cargo_july <- sum(cargo_2011_07, cargo_2012_07, cargo_2013_07, cargo_2014_07, cargo_2015_07, cargo_2016_07, cargo_2017_07, cargo_2018_07, cargo_2019_07, cargo_2020_07, cargo_2021_07, cargo_2022_07, cargo_2023_07, na.rm = TRUE)
tankers_july <- sum(tankers_2011_07, tankers_2012_07, tankers_2013_07, tankers_2014_07, tankers_2015_07, tankers_2016_07, tankers_2017_07, tankers_2018_07, tankers_2019_07, tankers_2020_07, tankers_2021_07, tankers_2022_07, tankers_2023_07, na.rm = TRUE)
fishing_july <- sum(fishing_2011_07, fishing_2012_07, fishing_2013_07, fishing_2014_07, fishing_2015_07, fishing_2016_07, fishing_2017_07, fishing_2018_07, fishing_2019_07, fishing_2020_07, fishing_2021_07, fishing_2022_07, fishing_2023_07, na.rm = TRUE)
#Save
terra::writeRaster(all_july, filename="E:/shipless_areas/all_july.tif")
terra::writeRaster(cargo_july, filename="E:/shipless_areas/cargo_july.tif")
terra::writeRaster(tankers_july, filename="E:/shipless_areas/tankers_july.tif")
terra::writeRaster(fishing_july, filename="E:/shipless_areas/fishing_july.tif")

### AUGUST ###
all_august <- sum(all_2011_08, all_2012_08, all_2013_08, all_2014_08, all_2015_08, all_2016_08, all_2017_08, all_2018_08, all_2019_08, all_2020_08, all_2021_08, all_2022_08, all_2023_08, na.rm = TRUE)
cargo_august <- sum(cargo_2011_08, cargo_2012_08, cargo_2013_08, cargo_2014_08, cargo_2015_08, cargo_2016_08, cargo_2017_08, cargo_2018_08, cargo_2019_08, cargo_2020_08, cargo_2021_08, cargo_2022_08, cargo_2023_08, na.rm = TRUE)
tankers_august <- sum(tankers_2011_08, tankers_2012_08, tankers_2013_08, tankers_2014_08, tankers_2015_08, tankers_2016_08, tankers_2017_08, tankers_2018_08, tankers_2019_08, tankers_2020_08, tankers_2021_08, tankers_2022_08, tankers_2023_08, na.rm = TRUE)
fishing_august <- sum(fishing_2011_08, fishing_2012_08, fishing_2013_08, fishing_2014_08, fishing_2015_08, fishing_2016_08, fishing_2017_08, fishing_2018_08, fishing_2019_08, fishing_2020_08, fishing_2021_08, fishing_2022_08, fishing_2023_08, na.rm = TRUE)
#Save
terra::writeRaster(all_august, filename="E:/shipless_areas/all_august.tif")
terra::writeRaster(cargo_august, filename="E:/shipless_areas/cargo_august.tif")
terra::writeRaster(tankers_august, filename="E:/shipless_areas/tankers_august.tif")
terra::writeRaster(fishing_august, filename="E:/shipless_areas/fishing_august.tif")

### SEPTEMBER ###
all_september <- sum(all_2011_09, all_2012_09, all_2013_09, all_2014_09, all_2015_09, all_2016_09, all_2017_09, all_2018_09, all_2019_09, all_2020_09, all_2021_09, all_2022_09, all_2023_09, na.rm = TRUE)
cargo_september <- sum(cargo_2011_09, cargo_2012_09, cargo_2013_09, cargo_2014_09, cargo_2015_09, cargo_2016_09, cargo_2017_09, cargo_2018_09, cargo_2019_09, cargo_2020_09, cargo_2021_09, cargo_2022_09, cargo_2023_09, na.rm = TRUE)
tankers_september <- sum(tankers_2011_09, tankers_2012_09, tankers_2013_09, tankers_2014_09, tankers_2015_09, tankers_2016_09, tankers_2017_09, tankers_2018_09, tankers_2019_09, tankers_2020_09, tankers_2021_09, tankers_2022_09, tankers_2023_09, na.rm = TRUE)
fishing_september <- sum(fishing_2011_09, fishing_2012_09, fishing_2013_09, fishing_2014_09, fishing_2015_09, fishing_2016_09, fishing_2017_09, fishing_2018_09, fishing_2019_09, fishing_2020_09, fishing_2021_09, fishing_2022_09, fishing_2023_09, na.rm = TRUE)
#Save
terra::writeRaster(all_september, filename="E:/shipless_areas/all_september.tif")
terra::writeRaster(cargo_september, filename="E:/shipless_areas/cargo_september.tif")
terra::writeRaster(tankers_september, filename="E:/shipless_areas/tankers_september.tif")
terra::writeRaster(fishing_september, filename="E:/shipless_areas/fishing_september.tif")

### OCTOBER ###
all_october <- sum(all_2011_10, all_2012_10, all_2013_10, all_2014_10, all_2015_10, all_2016_10, all_2017_10, all_2018_10, all_2019_10, all_2020_10, all_2021_10, all_2022_10, all_2023_10, na.rm = TRUE)
cargo_october <- sum(cargo_2011_10, cargo_2012_10, cargo_2013_10, cargo_2014_10, cargo_2015_10, cargo_2016_10, cargo_2017_10, cargo_2018_10, cargo_2019_10, cargo_2020_10, cargo_2021_10, cargo_2022_10, cargo_2023_10, na.rm = TRUE)
tankers_october <- sum(tankers_2011_10, tankers_2012_10, tankers_2013_10, tankers_2014_10, tankers_2015_10, tankers_2016_10, tankers_2017_10, tankers_2018_10, tankers_2019_10, tankers_2020_10, tankers_2021_10, tankers_2022_10, tankers_2023_10, na.rm = TRUE)
fishing_october <- sum(fishing_2011_10, fishing_2012_10, fishing_2013_10, fishing_2014_10, fishing_2015_10, fishing_2016_10, fishing_2017_10, fishing_2018_10, fishing_2019_10, fishing_2020_10, fishing_2021_10, fishing_2022_10, fishing_2023_10, na.rm = TRUE)
#Save
terra::writeRaster(all_october, filename="E:/shipless_areas/all_october.tif")
terra::writeRaster(cargo_october, filename="E:/shipless_areas/cargo_october.tif")
terra::writeRaster(tankers_october, filename="E:/shipless_areas/tankers_october.tif")
terra::writeRaster(fishing_october, filename="E:/shipless_areas/fishing_october.tif")

### NOVEMBER ###
all_november <- sum(all_2011_11, all_2012_11, all_2013_11, all_2014_11, all_2015_11, all_2016_11, all_2017_11, all_2018_11, all_2019_11, all_2020_11, all_2021_11, all_2022_11, all_2023_11, na.rm = TRUE)
cargo_november <- sum(cargo_2011_11, cargo_2012_11, cargo_2013_11, cargo_2014_11, cargo_2015_11, cargo_2016_11, cargo_2017_11, cargo_2018_11, cargo_2019_11, cargo_2020_11, cargo_2021_11, cargo_2022_11, cargo_2023_11, na.rm = TRUE)
tankers_november <- sum(tankers_2011_11, tankers_2012_11, tankers_2013_11, tankers_2014_11, tankers_2015_11, tankers_2016_11, tankers_2017_11, tankers_2018_11, tankers_2019_11, tankers_2020_11, tankers_2021_11, tankers_2022_11, tankers_2023_11, na.rm = TRUE)
fishing_november <- sum(fishing_2011_11, fishing_2012_11, fishing_2013_11, fishing_2014_11, fishing_2015_11, fishing_2016_11, fishing_2017_11, fishing_2018_11, fishing_2019_11, fishing_2020_11, fishing_2021_11, fishing_2022_11, fishing_2023_11, na.rm = TRUE)
#Save
terra::writeRaster(all_november, filename="E:/shipless_areas/all_november.tif")
terra::writeRaster(cargo_november, filename="E:/shipless_areas/cargo_november.tif")
terra::writeRaster(tankers_november, filename="E:/shipless_areas/tankers_november.tif")
terra::writeRaster(fishing_november, filename="E:/shipless_areas/fishing_november.tif")

### DECEMBER ###
all_december <- sum(all_2011_12, all_2012_12, all_2013_12, all_2014_12, all_2015_12, all_2016_12, all_2017_12, all_2018_12, all_2019_12, all_2020_12, all_2021_12, all_2022_12, all_2023_12, na.rm = TRUE)
cargo_december <- sum(cargo_2011_12, cargo_2012_12, cargo_2013_12, cargo_2014_12, cargo_2015_12, cargo_2016_12, cargo_2017_12, cargo_2018_12, cargo_2019_12, cargo_2020_12, cargo_2021_12, cargo_2022_12, cargo_2023_12, na.rm = TRUE)
tankers_december <- sum(tankers_2011_12, tankers_2012_12, tankers_2013_12, tankers_2014_12, tankers_2015_12, tankers_2016_12, tankers_2017_12, tankers_2018_12, tankers_2019_12, tankers_2020_12, tankers_2021_12, tankers_2022_12, tankers_2023_12, na.rm = TRUE)
fishing_december <- sum(fishing_2011_12, fishing_2012_12, fishing_2013_12, fishing_2014_12, fishing_2015_12, fishing_2016_12, fishing_2017_12, fishing_2018_12, fishing_2019_12, fishing_2020_12, fishing_2021_12, fishing_2022_12, fishing_2023_12, na.rm = TRUE)
#Save
terra::writeRaster(all_december, filename="E:/shipless_areas/all_december.tif")
terra::writeRaster(cargo_december, filename="E:/shipless_areas/cargo_december.tif")
terra::writeRaster(tankers_december, filename="E:/shipless_areas/tankers_december.tif")
terra::writeRaster(fishing_december, filename="E:/shipless_areas/fishing_december.tif")


################################################################################
#                                 Preparing maps
################################################################################

#FMestre
#18-09-2024

#https://timogrossenbacher.ch/bivariate-maps-with-ggplot2-and-sf/
#https://cran.r-project.org/web/packages/biscale/vignettes/biscale.html

#Clear environment
rm(list = ls())

#Define the working directory
setwd("~/github/shipless_areas")

#Load library
library(biscale)
library(terra)

#### 1. Load ship density maps

# CCMAR computer
all_summed_no_2011 <- terra::rast("E:/shipless_areas/sum_all_no_2011/all_summed_no_2011.tif")
last_three_years_21_22_23 <- terra::rast("E:/shipless_areas/sum_all_no_2011/last_three_years_21_22_23.tif")
cargo_summed <- terra::rast("E:/shipless_areas/sum_cargo/cargo_summed.tif")
tankers_summed <- terra::rast("E:/shipless_areas/sum_tankers/tankers_summed.tif")
fishing_summed <- terra::rast("E:/shipless_areas/sum_fishing/fishing_summed.tif")
#
#plot(all_summed)
#plot(cargo_summed)
#plot(tankers_summed)
#plot(fishing_summed)

#### 2. Load species richness maps
cetaceans_sr_raster <- terra::rast("cetaceans_sr_raster.tif")
testudines_sr_raster <- terra::rast("testudines_sr_raster.tif")
pinnipeds_sr_raster <- terra::rast("pinnipeds_sr_raster.tif")
seabirds_sr_raster <- terra::rast("seabirds_data/n_species_all_ranges.tif")

#### 3. Same resolution and extent

# 3.1. Check CRS of both rasters
terra::crs(all_summed_no_2011)
#terra::crs(cargo_summed)
#terra::crs(tankers_summed)
#terra::crs(fishing_summed)
#
terra::crs(cetaceans_sr_raster)
terra::crs(testudines_sr_raster)
terra::crs(pinnipeds_sr_raster)
terra::crs(seabirds_sr_raster)

# 3.2. Align rasters

#Check extent and resolution

terra::ext(all_summed_no_2011)
#terra::ext(cargo_summed)
#terra::ext(tankers_summed)
#terra::ext(fishing_summed)
#
terra::res(all_summed_no_2011)
#terra::res(cargo_summed)
#terra::res(tankers_summed)
#terra::res(fishing_summed)
#
terra::ext(cetaceans_sr_raster)
#terra::ext(testudines_sr_raster)
#terra::ext(pinnipeds_sr_raster)
#
terra::res(cetaceans_sr_raster)
#terra::res(testudines_sr_raster)
#terra::res(pinnipeds_sr_raster)

#
# Resample to match the resolution and extent
all_summed_resampled <- resample(all_summed_no_2011, cetaceans_sr_raster)
last_three_years_21_22_23_resampled <- resample(last_three_years_21_22_23, cetaceans_sr_raster)
cargo_summed_resampled <- resample(cargo_summed, cetaceans_sr_raster)
tankers_summed_resampled <- resample(tankers_summed, cetaceans_sr_raster)
fishing_summed_resampled <- resample(fishing_summed, cetaceans_sr_raster)
seabirds_sr_raster_resampled <- resample(seabirds_sr_raster, cetaceans_sr_raster)
#plot(seabirds_sr_raster_resampled)
#continents <- terra::vect("E:/shipless_areas/shapes/coastline.shp")
continents <- terra::vect("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/continents_close_seas.shp")

#plot(continents, add=TRUE)

# Crop the raster using the vector leaving out the continents 
extent_vector <- as.polygons(ext(continents))
#plot(extent_vector)
oceans <- erase(extent_vector, continents)
crs(oceans) <- crs(continents)
#plot(oceans, add=TRUE)
seabirds_sr_raster_resampled_cropped <- crop(seabirds_sr_raster_resampled, oceans, mask=TRUE)
#plot(seabirds_sr_raster_resampled_cropped)

#Save
terra::writeRaster(all_summed_resampled, filename = "all_summed_resampled_no_2011.tif", overwrite=TRUE)
terra::writeRaster(last_three_years_21_22_23_resampled, filename = "last_three_years_21_22_23_resampled.tif", overwrite=TRUE)
terra::writeRaster(cargo_summed_resampled, filename = "cargo_summed_resampled.tif", overwrite=TRUE)
terra::writeRaster(tankers_summed_resampled, filename = "tankers_summed_resampled.tif", overwrite=TRUE)
terra::writeRaster(fishing_summed_resampled, filename = "fishing_summed_resampled.tif", overwrite=TRUE)
#Load
all_summed_resampled <- terra::rast("all_summed_resampled_no_2011.tif")
last_three_years_21_22_23_resampled <- terra::rast("last_three_years_21_22_23_resampled.tif")
cargo_summed_resampled <- terra::rast("cargo_summed_resampled.tif")
tankers_summed_resampled <- terra::rast("tankers_summed_resampled.tif")
fishing_summed_resampled <- terra::rast("fishing_summed_resampled.tif")

#terra::res(all_summed_resampled)
#terra::res(cargo_summed_resampled)
#terra::res(tankers_summed_resampled)
#terra::res(fishing_summed_resampled)

################################################################################
#                        Set continents to NA, else to 0
################################################################################

#FMestre
#02-12-2024

#### 1. Load ships density maps
#Using raster (to keep compatibility with the functions)
all_summed_resampled <- terra::rast("all_summed_resampled_no_2011.tif")
last_three_years_21_22_23_resampled <- terra::rast("last_three_years_21_22_23_resampled.tif")
cargo_summed_resampled <- terra::rast("cargo_summed_resampled.tif")
tankers_summed_resampled <- terra::rast("tankers_summed_resampled.tif")
fishing_summed_resampled <- terra::rast("fishing_summed_resampled.tif")
#
cetaceans_sr_raster <- terra::rast("cetaceans_sr_raster.tif")
testudines_sr_raster <- terra::rast("testudines_sr_raster.tif")
pinnipeds_sr_raster <- terra::rast("pinnipeds_sr_raster.tif")
seabirds_sr_raster_resampled_cropped_ext <- terra::rast("seabirds_sr_raster_resampled_cropped_ext.tif")

#Convert NA to 0
all_summed_resampled[is.na(all_summed_resampled[])] <- 0 
last_three_years_21_22_23_resampled[is.na(last_three_years_21_22_23_resampled[])] <- 0 
cargo_summed_resampled[is.na(cargo_summed_resampled[])] <- 0 
tankers_summed_resampled[is.na(tankers_summed_resampled[])] <- 0 
fishing_summed_resampled[is.na(fishing_summed_resampled[])] <- 0 

cetaceans_sr_raster[is.na(cetaceans_sr_raster[])] <- 0 
testudines_sr_raster[is.na(testudines_sr_raster)] <- 0 
pinnipeds_sr_raster[is.na(pinnipeds_sr_raster[])] <- 0
seabirds_sr_raster_resampled_cropped_ext[is.na(seabirds_sr_raster_resampled_cropped_ext[])] <- 0

#Convert under vector to NA
continents <- terra::vect("C:/Users/mestr/Documents/0. Artigos/shipless_areas/gis/continents_close_seas.shp")
#plot(continents)

# Create a mask using the vector
all_summed_resampled_mask <- terra::mask(all_summed_resampled, continents)
last_three_years_21_22_23_resampled_mask <- terra::mask(last_three_years_21_22_23_resampled, continents)
cargo_summed_resampled_mask <- terra::mask(cargo_summed_resampled, continents)
tankers_summed_resampled_mask <- terra::mask(tankers_summed_resampled, continents)
fishing_summed_resampled_mask <- terra::mask(fishing_summed_resampled, continents)

cetaceans_sr_mask <- terra::mask(cetaceans_sr_raster, continents)
testudines_sr_raster_mask <- terra::mask(testudines_sr_raster, continents)
pinnipeds_sr_raster_mask <- terra::mask(pinnipeds_sr_raster, continents)
seabirds_sr_raster_resampled_cropped_ext_mask <- terra::mask(seabirds_sr_raster_resampled_cropped_ext, continents)

# Convert all values to NA outside the mask
all_summed_resampled[!is.na(all_summed_resampled_mask)] <- NA
last_three_years_21_22_23_resampled[!is.na(last_three_years_21_22_23_resampled_mask)] <- NA
cargo_summed_resampled[!is.na(cargo_summed_resampled_mask)] <- NA
tankers_summed_resampled[!is.na(tankers_summed_resampled_mask)] <- NA
fishing_summed_resampled[!is.na(fishing_summed_resampled_mask)] <- NA

cetaceans_sr_raster[!is.na(cetaceans_sr_mask)] <- NA
testudines_sr_raster[!is.na(testudines_sr_raster_mask)] <- NA
pinnipeds_sr_raster[!is.na(pinnipeds_sr_raster_mask)] <- NA
seabirds_sr_raster_resampled_cropped_ext[!is.na(seabirds_sr_raster_resampled_cropped_ext_mask)] <- NA

### SAVE
terra::writeRaster(all_summed_resampled,"final_rasters/all_summed_resampled_no_2011_NA.tif", overwrite=TRUE)
terra::writeRaster(last_three_years_21_22_23_resampled,"final_rasters/last_three_years_21_22_23_resampled_NA.tif", overwrite=TRUE)
terra::writeRaster(cargo_summed_resampled,"final_rasters/cargo_summed_resampled_NA.tif", overwrite=TRUE)
terra::writeRaster(tankers_summed_resampled,"final_rasters/tankers_summed_resampled_NA.tif", overwrite=TRUE)
terra::writeRaster(fishing_summed_resampled,"final_rasters/fishing_summed_resampled_NA.tif", overwrite=TRUE)

terra::writeRaster(cetaceans_sr_raster,"final_rasters/cetaceans_sr_raster_NA.tif", overwrite=TRUE)
terra::writeRaster(testudines_sr_raster,"final_rasters/testudines_sr_raster_NA.tif", overwrite=TRUE)
terra::writeRaster(pinnipeds_sr_raster,"final_rasters/pinnipeds_sr_raster_NA.tif", overwrite=TRUE)
terra::writeRaster(seabirds_sr_raster_resampled_cropped_ext,"final_rasters/seabirds_sr_raster_resampled_cropped_ext_NA.tif", overwrite=TRUE)


################################################################################
#                             Summarizing figures
################################################################################

#FMestre
#08-07-2024

#Clear environment
rm(list = ls()) 

#Load package
library(terra)

#Define the working directory
setwd("~/github/shipless_areas")

################################################################################
#                                Per ship type
################################################################################

#Load maps per ship type
all_summed <- terra::rast("E:/shipless_areas/sum_all/all_summed_no_2011.tif")
cargo_summed <- terra::rast("E:/shipless_areas/sum_cargo/cargo_summed.tif")
tankers_summed <- terra::rast("E:/shipless_areas/sum_tankers/tankers_summed.tif")
fishing_summed <- terra::rast("E:/shipless_areas/sum_fishing/fishing_summed.tif")
#Plot
terra::plot(all_summed)
terra::plot(cargo_summed)
terra::plot(tankers_summed)
terra::plot(fishing_summed)
#Vector
as.vector(all_summed)
as.vector(cargo_summed)
as.vector(tankers_summed)
as.vector(fishing_summed)
#Histogram
terra::hist(all_summed)
terra::hist(cargo_summed)
terra::hist(tankers_summed)
terra::hist(fishing_summed)
#Summary
terra::summary(all_summed)
terra::summary(cargo_summed)
terra::summary(tankers_summed)
terra::summary(fishing_summed)
#Plot
fun_color_range <- colorRampPalette(c("#FFF8DC", "#EE7600", "#CD6600", "#8B4500", "black"))
my_colours <- fun_color_range(100)
options(terra.pal=my_colours)
#
#Plot, defining the last class as +100 (as it is in the website)
all_summed_2 <- all_summed
all_summed_2[all_summed_2>=100] <- 100
terra::plot(all_summed_2, range=c(0,100), main = "All ships (Hrs/km2)")
#
cargo_summed_2 <- cargo_summed
cargo_summed_2[cargo_summed>=100] <- 100
terra::plot(cargo_summed_2, range=c(0,100), main = "Cargo ships (Hrs/km2)")
#
tankers_summed_2 <- tankers_summed
tankers_summed_2[tankers_summed>=100] <- 100
terra::plot(tankers_summed_2, range=c(0,100), main = "Tankers (Hrs/km2)")
#
fishing_summed_2 <- fishing_summed
fishing_summed_2[fishing_summed>=100] <- 100
terra::plot(fishing_summed_2, range=c(0,100), main = "Fishing ships (Hrs/km2)")


################################################################################
#                                Per month
################################################################################

fun_color_range <- colorRampPalette(c("#FFF8DC", "#EE7600", "#CD6600", "#8B4500", "black"))
my_colours <- fun_color_range(100)
options(terra.pal=my_colours)

#loading all monthly maps
all_january <- terra::rast("E:/shipless_areas/all_january.tif")
all_february <- terra::rast("E:/shipless_areas/all_february.tif")
all_march <- terra::rast("E:/shipless_areas/all_march.tif")
all_april <- terra::rast("E:/shipless_areas/all_april.tif")
all_may <- terra::rast("E:/shipless_areas/all_may.tif")
all_june <- terra::rast("E:/shipless_areas/all_june.tif")
all_july <- terra::rast("E:/shipless_areas/all_july.tif")
all_august <- terra::rast("E:/shipless_areas/all_august.tif")
all_september <- terra::rast("E:/shipless_areas/all_september.tif")
all_october <- terra::rast("E:/shipless_areas/all_october.tif")
all_november <- terra::rast("E:/shipless_areas/all_november.tif")
all_december <- terra::rast("E:/shipless_areas/all_december.tif")

#Plot
months_stack <- c(all_january, all_february, all_march, all_april, all_may, all_june, all_july, all_august, all_september, all_october, all_november, all_december)
#
mean_sd_months_stack <- terra::global(months_stack, c("mean", "sd"), na.rm=TRUE)
mean_sd_months_stack <- data.frame(1:12, c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"), mean_sd_months_stack)
names(mean_sd_months_stack)[1:2] <- c("months_numbers", "months")
rownames(mean_sd_months_stack) <- 1:nrow(mean_sd_months_stack)
save(mean_sd_months_stack, file = "mean_sd_months_stack.RData")

plot(mean_sd_months_stack$months_numbers , mean_sd_months_stack$mean, type = "l", xaxt="n", main = "Monthly averaged", xlab = "month", ylab = "Ship density (hours/cell)")
axis(1, at = 1:12, labels = mean_sd_months_stack$months) 

#### January ####
all_january_2 <- all_january
all_january_2[all_january_2>=100] <- 100
terra::plot(all_january_2, range=c(0,100), main = "January (all ships, Hrs/km2)")

#### February ####
all_february_2 <- all_february
all_february_2[all_february_2>=100] <- 100
terra::plot(all_february_2, range=c(0,100), main = "February (all ships, Hrs/km2)")

#### March ####
all_march_2 <- all_march
all_march_2[all_march_2>=100] <- 100
terra::plot(all_march_2, range=c(0,100), main = "March (all ships, Hrs/km2)")

#### April ####
all_april_2 <- all_april
all_april_2[all_april_2>=100] <- 100
terra::plot(all_april_2, range=c(0,100), main = "April (all ships, Hrs/km2)")

#### May ####
all_may_2 <- all_may
all_may_2[all_may_2>=100] <- 100
terra::plot(all_may_2, range=c(0,100), main = "May (all ships, Hrs/km2)")

#### June ####
all_june_2 <- all_june
all_june_2[all_june_2>=100] <- 100
terra::plot(all_june_2, range=c(0,100), main = "June (all ships, Hrs/km2)")

#### July ####
all_july_2 <- all_july
all_july_2[all_july_2>=100] <- 100
terra::plot(all_july_2, range=c(0,100), main = "july (all ships, Hrs/km2)")

#### August ####
all_august_2 <- all_august
all_august_2[all_august_2>=100] <- 100
terra::plot(all_august_2, range=c(0,100), main = "august (all ships, Hrs/km2)")

#### September ####
all_september_2 <- all_september
all_september_2[all_september_2>=100] <- 100
terra::plot(all_september_2, range=c(0,100), main = "september (all ships, Hrs/km2)")

#### October ####
all_october_2 <- all_october
all_october_2[all_october_2>=100] <- 100
terra::plot(all_october_2, range=c(0,100), main = "october (all ships, Hrs/km2)")

#### November ####
all_november_2 <- all_november
all_november_2[all_november_2>=100] <- 100
terra::plot(all_november_2, range=c(0,100), main = "november (all ships, Hrs/km2)")

#### December ####
all_december_2 <- all_december
all_december_2[all_december_2>=100] <- 100
terra::plot(all_december_2, range=c(0,100), main = "december (all ships, Hrs/km2)")

################################################################################
#                                Per year
################################################################################


fun_color_range <- colorRampPalette(c("#FFF8DC", "#EE7600", "#CD6600", "#8B4500", "black"))
my_colours <- fun_color_range(100)
options(terra.pal=my_colours)


#Loading all yearly maps
sum_all_2011 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2011.tif")
sum_all_2012 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2012.tif")
sum_all_2013 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2013.tif")
sum_all_2014 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2014.tif")
sum_all_2015 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2015.tif")
sum_all_2016 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2016.tif")
sum_all_2017 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2017.tif")
sum_all_2018 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2018.tif")
sum_all_2019 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2019.tif")
sum_all_2020 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2020.tif")
sum_all_2021 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2021.tif")
sum_all_2022 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2022.tif")
sum_all_2023 <- terra::rast("E:/shipless_areas/sum_all/sum_all_2023.tif")
all_summed <- terra::rast("E:/shipless_areas/sum_all/all_summed.tif")

#### 2011 ####
sum_all_2011_2 <- sum_all_2011
sum_all_2011_2[sum_all_2011_2>=100] <- 100
terra::plot(sum_all_2011_2, range=c(0,100), main = "Year 2011 (all ships, Hrs/km2)")

#### 2012 ####
sum_all_2012_2 <- sum_all_2012
sum_all_2012_2[sum_all_2012_2>=100] <- 100
terra::plot(sum_all_2012_2, range=c(0,100), main = "Year 2012 (all ships, Hrs/km2)")

#### 2013 ####
sum_all_2013_2 <- sum_all_2013
sum_all_2013_2[sum_all_2013_2>=100] <- 100
terra::plot(sum_all_2013_2, range=c(0,100), main = "Year 2013 (all ships, Hrs/km2)")

#### 2014 ####
sum_all_2014_2 <- sum_all_2014
sum_all_2014_2[sum_all_2014_2>=100] <- 100
terra::plot(sum_all_2014_2, range=c(0,100), main = "Year 2014 (all ships, Hrs/km2)")

#### 2015 ####
sum_all_2015_2 <- sum_all_2015
sum_all_2015_2[sum_all_2015_2>=100] <- 100
terra::plot(sum_all_2015_2, range=c(0,100), main = "Year 2015 (all ships, Hrs/km2)")

#### 2016 ####
sum_all_2016_2 <- sum_all_2016
sum_all_2016_2[sum_all_2016_2>=100] <- 100
terra::plot(sum_all_2016_2, range=c(0,100), main = "Year 2016 (all ships, Hrs/km2)")

#### 2017 ####
sum_all_2017_2 <- sum_all_2017
sum_all_2017_2[sum_all_2017_2>=100] <- 100
terra::plot(sum_all_2017_2, range=c(0,100), main = "Year 2017 (all ships, Hrs/km2)")

#### 2018 ####
sum_all_2018_2 <- sum_all_2018
sum_all_2018_2[sum_all_2018_2>=100] <- 100
terra::plot(sum_all_2018_2, range=c(0,100), main = "Year 2018 (all ships, Hrs/km2)")

#### 2019 ####
sum_all_2019_2 <- sum_all_2019
sum_all_2019_2[sum_all_2019_2>=100] <- 100
terra::plot(sum_all_2019_2, range=c(0,100), main = "Year 2019 (all ships, Hrs/km2)")

#### 2020 ####
sum_all_2020_2 <- sum_all_2020
sum_all_2020_2[sum_all_2020_2>=100] <- 100
terra::plot(sum_all_2020_2, range=c(0,100), main = "Year 2020 (all ships, Hrs/km2)")

#### 2021 ####
sum_all_2021_2 <- sum_all_2021
sum_all_2021_2[sum_all_2021_2>=100] <- 100
terra::plot(sum_all_2021_2, range=c(0,100), main = "Year 2021 (all ships, Hrs/km2)")

#### 2022 ####
sum_all_2022_2 <- sum_all_2022
sum_all_2022_2[sum_all_2022_2>=100] <- 100
terra::plot(sum_all_2022_2, range=c(0,100), main = "Year 2022 (all ships, Hrs/km2)")

#### 2023 ####
sum_all_2023_2 <- sum_all_2023
sum_all_2023_2[sum_all_2023_2>=100] <- 100
terra::plot(sum_all_2023_2, range=c(0,100), main = "Year 2023 (all ships, Hrs/km2)")

### ALL ###
all_summed_2 <- all_summed
all_summed_2[all_summed_2>=100] <- 100
terra::plot(all_summed_2, range=c(0,100), main = "All shipping activity (Hrs/km2)")