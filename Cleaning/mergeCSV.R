library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library("base", quietly = TRUE, warn.conflicts = FALSE)

root = "Data"

disp = read.csv(file.path(root, "dispositionUpdate.csv"))
fileNames = disp$DaqName

for(i in 1:length(fileNames)) {
  
  if(file.exists(file.path(root, "CleanCSV", fileNames[i]))) {
    message(paste(fileNames[i], "already exists."))
  } else {
    # Read data
    data1 = read.csv(file.path(root, "reducedCSVElem", fileNames[i]))
    data2 = read.csv(file.path(root, "reducedCSVEye", fileNames[i]))
    
    # Note: inner join because there are some bunk leading/trailing frames in the eyeData
    data3 = inner_join(data1, data2, by = c("ET.frame.num" = "Frame.Num"))
    
    # Create directory if if doesn't already exist
    if(!dir.exists(file.path(root, 'CleanCSV'))) {
      dir.create(file.path(root, 'CleanCSV'))
    }
    
    write.csv(data3, file.path(root, "CleanCSV", fileNames[i]))
  }
}
