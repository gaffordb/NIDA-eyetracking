require(plyr)
require(dplyr)
library("base")

# Need to be above NIDA directory when calling this
disp = read.csv(file.path("C:/Users/Adam/Desktop/NIDA", "dispositionUpdate.csv"))
fileNames = disp$DaqName

for(i in 1:length(fileNames)){
  # Read data
  data1 = read.csv(file.path("C:/Users/Adam/Desktop/NIDA", "elemData", fileNames[i]))
  
  data2 = read.csv(file.path("C:/Users/Adam/Desktop/NIDA", "eyeData", fileNames[i]))
  
  
  data3 = inner_join(data1, data2, by = c("ET.frame.num" = "Frame.Num"))
  
 write.csv(data3, file.path("C:/Users/Adam/Desktop/NIDA", "MergedData", fileNames[i]))
}

data1 = read.csv("C:/Users/Adam/Desktop/NIDA/elemData/20121204090515.csv")
data2 = read.csv("C:/Users/Adam/Desktop/NIDA/eyeData/20121204090515.csv")
data3 = join(data1, data2)
write.csv(data3, file.path("C:/Users/Adam/Desktop/NIDA/", "MergedData", "yoro.csv"))
