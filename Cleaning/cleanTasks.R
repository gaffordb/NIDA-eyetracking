require(plyr)
require(dplyr)

# task_length (in seconds) -- assume task length is 10 seconds, and assumes that 1 row = 1 frame
TASK_LENGTH_SEC = 10
TASK_LENGTH = TASK_LENGTH_SEC*60

# Need to be above Data directory when calling this
disp = read.csv(file.path("Data", "dispositionUpdate.csv"))
fileNames = disp$DaqName

cleanMenuSearch = function(df) {
  cur_val = df$SCC.MenuSearch[1]
  task_active = 0
  for(i in 1:length(df$SCC.MenuSearch)) {
    # Task is active
    if(task_active > 0) {
      task_active = task_active-1
      
    # Task just became active
    } else if(cur_val != df$SCC.MenuSearch[i]) {
      cur_val = df$SCC.MenuSearch[i]
      task_active = TASK_LENGTH-1
    # Task is inactive
    } else {
      df$SCC.MenuSearch[i] = 0
    }
  }
  
  return(df)
}

for(i in 1:length(fileNames)){
  # Read data
  data = read.csv(file.path("Data", "CleanCSV", fileNames[i]))
  
  data_new = cleanMenuSearch(data)
  
  # Write data
  write.csv(data_new, file.path("Data", "CleanCSV", fileNames[i]))
}
