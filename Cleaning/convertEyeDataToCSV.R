library(R.matlab) # Reads matlab files
library(stringr) # String manipulation
library(tidyverse)
library (readxl)
library (dplyr)

# Upload files ----
files <- list.files(file.path("Data", "ReducedDataEye")) # list of name of .mat files

disp <- readxl::read_excel(file.path("Data", "disposition.xls"))

# filter ignore/discard data
disp <- filter (disp, is.na(Ignore)) %>% filter(., is.na(Discard))
fileNames <- str_replace(disp$DaqName, ".daq", ".mat")

# Convert every analyze/reduced files into csv format including participant id and visit number
for (i in 1:length(fileNames)) {
  convertToCSV(fileNames[i], as.numeric(substr(disp$DaqPath[i],1,3)),disp$Visit[i])
}

# converToCSV----
## input----
## fileName: name of the file needed to covert to csv
## id: participant id from disposition file
## visit: visit number from disposition file
## output----
## save csv file version of this .mat file in assigned directory
convertToCSV <- function (fileName, id, visit) {
  path <- file.path("Data", "ReducedDataEye", fileName)
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
  write.csv(tempdf, file = file.path("Data", "ReducedCSVEye", paste0(substr(fileName, 1, nchar(fileName)-4), ".csv")))
}
