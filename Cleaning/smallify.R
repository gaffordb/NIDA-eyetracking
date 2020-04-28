require(plyr)
require(dplyr)

# NOTE: this is only used if you want to further reduce the dataset 
# if you identify any columns don't need to exist anymore

# Can change this according to needs
COLUMNS_WE_WANT_ELEM = c("DaqName", 
                    "ID", 
                    "Visit", 
                    "ET.filtered.gaze.object.name",
                    "ET.filtered.gaze.object.index",
                    "ET.frame.num", 
                    "SCC.MenuSearch", 
                    "SCC.MessageReading", 
                    "SCC.MirrorDisplaySetting", 
                    "Frames", 
                    "Time")

COLUMNS_WE_WANT_EYE = c("") #TODO Adam
  
# Need to be above Data directory when calling this
disp = read.csv(file.path("Data", "dispositionUpdate.csv"))
fileNames = disp$DaqName

for(i in 1:length(fileNames)){
  # Read data
  eyeData = read.csv(file.path("Data", "ReducedCSVEye", fileNames[i]))
  elemData = read.csv(file.path("Data", "ReducedCSVElem", fileNames[i]))
  
  # Select only the important columns
  eyeData = eyeData %>% select(COLUMNS_WE_WANT_EYE)
  elemData = elemData %>% select(COLUMNS_WE_WANT_ELEM)
  
  # Write data
  write.csv(eyeData, file.path("Data", "ReducedCSVEye", fileNames[i]))
  write.csv(elemData, file.path("Data", "ReducedCSVElem", fileNames[i]))
}
