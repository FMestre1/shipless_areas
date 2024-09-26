################################################################################
#                         Getting data from Movebank
################################################################################

#FMestre
#25-09-2024

#Movebank
#https://www.movebank.org/cms/movebank-main

#Browsing Movebank within R
#https://www.movebank.org/

#Example analysis of albatross trajectories
#https://cran.r-project.org/web/packages/move2/vignettes/albatross.html

#How move functions map to move2 functions
#https://cran.r-project.org/web/packages/move2/vignettes/convert.html

#Filtering trajectories
#https://cran.r-project.org/web/packages/move2/vignettes/filtering_tracks.html

#Downloading data from movebank
#https://cran.r-project.org/web/packages/move2/vignettes/movebank.html

#Programming with a move2 object
#https://cran.r-project.org/web/packages/move2/vignettes/programming_move2_object.html

#Trajectory analysis of Turkey vultures
#https://cran.r-project.org/web/packages/move2/vignettes/trajectory_analysis.html

#Load packages
#install.packages("move2")
library(move2)
library(dplyr)
library(stringr)

### 0. Login to Movebank ###

#movebank_store_credentials("fmestre77", "cervidae77@")
#login <- movebankLogin(username = "fmestre77", password = "cervidae77@")

### 1. Getting all the studies in Movebank ###

# Authenticate with Movebank
login <- movebankLogin(username = "fmestre77", password = "cervidae77@")


# Get all available studies (with study names and IDs)
all_studies <- getMovebankStudies(login = login)


# Remove all those studies with repeated names, it will cause problems later
freq_names <- as.data.frame(table(all_studies))
remove_these_names <- freq_names[freq_names$Freq != 1,]$all_studies
#
all_studies_2 <- all_studies[!(all_studies %in% remove_these_names)]
#length(all_studies_2)
all_studies_2[i]
View(data.frame(table(all_studies_2)))

# Create an empty data frame to store study info
study_info <- as.data.frame(matrix(ncol=6, nrow=length(all_studies_2)))
colnames(study_info) <- c("study_id", "study_name", "taxon_id", "nr_individuals", "can_see_data", "permission")
#View(study_info)
#study_info[i-1,]
#study_info[i,]
#study_info[i+1,]
#jumped through 6619, 6620 - the error for some reason:   There was more than one study with the name: Vulture Movements

# Loop through each study to get the description
for (i in 1:length(all_studies_2)) {
  
  study_id <-  getMovebankID(study = all_studies_2[i], login)
  study_name <- all_studies_2[i]
  
  # Get study details, which includes the description
  study_details <- getMovebankStudy(study = study_id, login = login)
  
  # Add study name and description to the data frame
  study_info$study_id[i] = study_id 
  study_info$study_name[i] = study_name
  study_info$taxon_id[i] = study_details$taxon_ids
  study_info$nr_individuals[i] = study_details$number_of_individuals
  study_info$can_see_data[i] = study_details$i_can_see_data
  study_info$permission[i] = study_details$study_permission

  message(i)
  
}

# Print the study info with descriptions
#View(study_info)

# Optionally, save to CSV
write.csv(study_info, "movebank_studies.csv", row.names = FALSE)

### 2. Selecting studies  with available data ###

study_info_can_see_data <- study_info[study_info$can_see_data == "true",]
download_access <- c() 
study_info <- list()

length(download_access)

for(i in 1543:nrow(study_info_can_see_data)){

  id1 <- study_info_can_see_data$study_id[i]
  if(!is.na(id1)) st1 <- movebank_download_study_info(study_id = id1)
  if(is.na(id1)) st1 <- NA
  study_info[[i]] <- st1
  if(!is.na(id1)) download_access[i] <- st1$i_have_download_access
  if(is.na(id1)) download_access[i] <- st1

  message(i)

}

study_info_can_see_data_2 <- data.frame(study_info_can_see_data, download_access)
#View(study_info_can_see_data_2)

#select those with download access
study_info_can_see_data_3 <- study_info_can_see_data_2[study_info_can_see_data_2$download_access == "TRUE",]
#View(study_info_can_see_data_3)

### 3. Get studies for sea turtles ###

#Leatherback turtle - Dermochelys coriacea
#Loggerhead turtle - Caretta caretta
#Kemp’s ridley turtle - Lepidochelys kempii
#Green sea turtle - Chelonia mydas
#Olive ridley turtle - Lepidochelys olivacea
#Hawksbill turtle - Eretmochelys imbricata
#Flatback turtle - Natator depressus

#Get any of these relevant keywords
turtle_words <- c("Leatherback", "Dermochelys", "coriacea", "Loggerhead", "Caretta", "caretta", "Kemp’s ridley", "Lepidochelys", "kempii", 
  "Green seaturtle", "Chelonia", "mydas", "Olive ridley", "Lepidochelys", "olivacea", "Hawksbill", "Eretmochelys", "imbricata", "Flatback", "Natator", "depressus")

# Filter rows where any of the turtle words appear in any column
filtered_rows_turtles <- study_info_can_see_data_3 %>%
  filter(if_any(everything(), ~ str_detect(., paste(turtle_words, collapse = "|"))))

# Display filtered rows
#View(filtered_rows_turtles)
studies_id_turtles <- filtered_rows_turtles$study_id
studies_names_turtles <- filtered_rows_turtles$study_name


movebank_download_study_info(study_id = studies_id_turtles[1])
movebank_retrieve(entity_type = "study", study_id = studies_id_turtles[1])

#movebank_download_study(study_id = studies_id_turtles[1], attributes = "all", remove_movebank_outliers = TRUE)


#?movebank_download_study
studies_names_turtles[2]
data1 <- movebank_download_study(studies_id_turtles[2], md5 = '7881109b458cdcde7ed0e6036c224b7f')
plot(data1)




















