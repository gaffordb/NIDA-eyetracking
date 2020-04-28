require(plyr)
require(dplyr)
library("base")

disp = read.csv(file.path("Data", "dispositionUpdate.csv"))
fileNames = disp$DaqName

for(i in 1:length(fileNames)) {
  # Read data
  data1 = read.csv(file.path("Data", "reducedCSVElem", fileNames[i]))
  
  data2 = read.csv(file.path("Data", "reducedCSVEye", fileNames[i]))
  
  # Note: inner join because there are some bunk leading/trailing frames in the eyeData
  data3 = inner_join(data1, data2, by = c("ET.frame.num" = "Frame.Num"))
  
  write.csv(data3, file.path("Data", "CleanCSV", fileNames[i]))
}
