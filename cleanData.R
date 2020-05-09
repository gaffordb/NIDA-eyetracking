
# using function copied from https://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them
using<-function(...) {
  libs<-unlist(list(...))
  req<-unlist(lapply(libs,require,character.only=TRUE))
  need<-libs[req==FALSE]
  if(length(need)>0){ 
    install.packages(need, repos = "http://cran.us.r-project.org")
    suppressWarnings(lapply(need,require,character.only=TRUE))
  }
}

# Suppress tidyverse output bc it's ugly
options(tidyverse.quiet = TRUE)

suppressPackageStartupMessages(using("matlabr","ggplot2", "dplyr", "R.matlab", "progress"))

library(matlabr, quietly = TRUE, warn.conflicts = FALSE)

# Reduce the Matfiles
if(have_matlab()) {
  message("This may take a while...")
  message("-------------------------------------")
  message("Reducing mat files...")
  run_matlab_script(file.path("Cleaning", "reduceMatfile.m"), verbose = FALSE)
  message("Matfiles have been reduced.")
  
} else {
  message("Could not find matlab on your system. Unable to clean data.")
  quit(save = "no")
}

message("-------------------------------------")

# Convert the Matfiles to CSV
message("Converting elemData to CSV...")
source(file.path("Cleaning", "convertElemDataToCSV.R"))
message("ElemData has been converted to CSV.")

message("-------------------------------------")

message("Converting eyedata to CSV...")
source(file.path("Cleaning", "convertEyeDataToCSV.R"))
message("eyeData has been converted to CSV.")

message("-------------------------------------")

message("Updating disposition...")
source(file.path("Cleaning", "updateDisposition.R"))
message("Updated disposition has been created.")

message("-------------------------------------")

# Reduce the CSVs further
message("Reducing CSVs further...")
source(file.path("Cleaning", "smallify.R"))
message("CSVs have been reduced further.")

message("-------------------------------------")


# Merge the eye and elem data
message("Merging the eye data and the elem data...")
source(file.path("Cleaning", "mergeCSV.R"))
message("Eye data and elem data have been merged.")

message("-------------------------------------")

# Clean the task data
message("Cleaning tasks...")
source(file.path("Cleaning", "cleanTasks.R"))
message("Tasks have been cleaned.")

message("Data is ready for analysis.")

