require(plyr)
require(dplyr)

# Can change this according to needs
COLUMNS_WE_WANT = c("DaqName", 
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

# Need to be above NIDA directory when calling this
disp = read.csv(file.path("NIDA", "dispositionUpdate.csv"))
fileNames = disp$DaqName

for(i in 1:length(fileNames)){
  # Read data
  data = read.csv(file.path("NIDA", "ReducedCSV", fileNames[i]))
  
  # Select only the important columns
  data = data %>% select(COLUMNS_WE_WANT)
  
  # Write data
  write.csv(data, file.path("NIDA", "MoreReducedCSV", fileNames[i]))
}
