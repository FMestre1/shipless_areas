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



