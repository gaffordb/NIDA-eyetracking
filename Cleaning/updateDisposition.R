library(stringr)
library(tidyverse)
library ("readxl")
library ("dplyr")

# Note: which one this (Eye vs Elem)  doesn't matter -- it's just pulling the filenames
csv_dir = if(file.exists(file.path("Data", "CleanCSV"))) "CleanCSV" else "ReducedCSVElem"

files <- list.files(file.path("Data", csv_dir))

disp <- readxl::read_excel(file.path("Data", "disposition.xls"))

# filter ignore/discard data
disp <- filter (disp, is.na(Ignore)) %>% filter(., is.na(Discard))

disp = disp[str_replace(disp$DaqName, ".daq", ".csv") %in% files,]

fileNames <- str_replace(disp$DaqName, ".daq", ".csv")

#fileNames = fileNames[fileNames %in% files]

noevents <- c()
for (i in 1:length(fileNames)){
  try(tempFile <- read.csv(file.path("Data", csv_dir, fileNames[i])))
  if ((length(unique(tempFile$SCC.MenuSearch)) != 4)&&(length(unique(tempFile$SCC.MenuSearch)) != 5)){
    noevents <- append (noevents, fileNames[i])
  }
}

disp$DaqName <- str_replace(disp$DaqName, ".daq", ".csv")
disp <- filter (disp, !(DaqName %in% noevents))
# drop when restart also has 3 events
#disp <- disp[!(disp$DaqName %in% c("20121205113805.csv". "20130612092744.csv", "20140104105417.csv")),]
ID <- as.numeric(substr(disp$DaqPath,1,3))
newDisp <- data.frame(ID, disp[,5:7], disp[,9:16], disp[,18:19]) 

# Convert dataframe to csv file
write.csv(newDisp, file = file.path("Data", "dispositionUpdate.csv"), row.names=FALSE)
