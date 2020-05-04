library(R.matlab, quietly = TRUE, warn.conflicts = FALSE) # Reads matlab files
library(stringr, quietly = TRUE, warn.conflicts = FALSE) # String manipulation
library(tidyverse, quietly = TRUE, warn.conflicts = FALSE)
library(readxl, quietly = TRUE, warn.conflicts = FALSE)
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(progress, quietly = TRUE)

root = file.path('Data')
# converToCSV----
## input----
## fileName: name of the file needed to covert to csv
## id: participant id from disposition file
## visit: visit number from disposition file
## output----
## save csv file version of this .mat file in assigned directory
convertToCSV <- function (fileName, id, visit) {
  path <- file.path(root, "ReducedDataEye", fileName)
  temp <- readMat(path)
  temp[[1]][[23]] = sapply(temp[[1]][[23]], toString)
  temp[[1]][[24]] = sapply(temp[[1]][[24]], toString)
  dim(temp[[1]][[23]]) <- c(length(temp[[1]][[23]]), 1) 
  dim(temp[[1]][[24]]) <- c(length(temp[[1]][[24]]), 1) 
  data <- temp$eyeData
  # Create dataframe including participantID, visit
  rowN <- length(data[[1]]) # how many rows this data contain
  tempdf <- data.frame("DaqName" = rep(fileName, rowN),"ID" = rep(id, rowN), "Visit" = rep(visit, rowN))
  r <- rownames(data)
  
  
  # Add variables from elemData
  for (var in 1:length(data)) {
    varName = paste0(r[var])
    if (ncol(data[[var]]) == 1) {
      tempdf[varName] = data[[var]]
    } else {
      for (i in 1:ncol(data[[var]])) {
        newColName = paste0(varName,".",i)
        tempdf[newColName] = data[[var]][,i]
      }
    }
  }
  # Convert dataframe to csv file
  write.csv(tempdf, file = file.path(root, "ReducedCSVEye", paste0(substr(fileName, 1, nchar(fileName)-4), ".csv")))
}

# Upload files ----
files <- list.files(file.path(root, "ReducedDataEye")) # list of name of .mat files

disp <- readxl::read_excel(file.path(root, "disposition.xls"))

# filter ignore/discard data
disp <- filter (disp, is.na(Ignore)) %>% filter(., is.na(Discard)) %>% filter(str_replace(DaqName, ".daq", ".mat") %in% files)
fileNames <- str_replace(disp$DaqName, ".daq", ".mat")

# Create directory if if doesn't already exist
if(!dir.exists(file.path(root, 'ReducedCSVEye'))) {
  dir.create(file.path(root, 'ReducedCSVEye'))
}

pb <- progress_bar$new(format = "[:bar] :current/:total (:percent)", total = length(fileNames), show_after = 0)
pb$tick(0)
for (i in 1:length(fileNames)) {
  if(file.exists(file.path(root, 'ReducedCSVEye', str_replace(fileNames[i], ".mat", ".csv")))) {
    #message(paste(fileNames[i], "eye data already converted to CSV."))
  } else {
    convertToCSV(fileNames[i], as.numeric(substr(disp$DaqPath[i],1,3)),disp$Visit[i])
    # message(paste("Converting", fileNames[i], "eye data to CSV."))
  }
  pb$tick()
}


