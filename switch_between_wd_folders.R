################################################################################
#                                Manage Folders
################################################################################

#FMestre
#16-07-2024

#The WD to be used
setwd("~/shipless_areas")

#The External Drive
setwd("/media/jorgeassis/FMestre/shipless_areas")

#List files in the disk's folder
list.files("/media/jorgeassis/FMestre/shipless_areas")

#Check free space in my external drive
system("df -h /media/jorgeassis/FMestre")

#Check WD
getwd()
