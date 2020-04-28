require(plyr)
require(dplyr)
require(compareDF)

# task_length (in seconds) -- assume task length is 10 seconds
TASK_LENGTH_SEC = 10
TASK_LENGTH = TASK_LENGTH_SEC*60

# Need to be above NIDA directory when calling this
disp = read.csv(file.path("NIDA", "dispositionUpdate.csv"))
fileNames = disp$DaqName

cleanMenuSearch = function(df) {
  #debug_data = vector()
  cur_val = df$SCC.MenuSearch[1]
  task_active = 0
  for(i in 1:length(df$SCC.MenuSearch)) {
    # Task is active
    if(task_active > 0) {
      #debug_data = append(debug_data, "TASK_ACTIVE")
      task_active = task_active-1
      
    # Task just became active
    } else if(cur_val != df$SCC.MenuSearch[i]) {
      #debug_data = append(debug_data,"TASK_STARTED")
      cur_val = df$SCC.MenuSearch[i]
      task_active = TASK_LENGTH-1
    # Task is inactive
    } else {
      #debug_data = append(debug_data, "TASK_INACTIVE")
      df$SCC.MenuSearch[i] = 0
    }
  }
  
  return(df)
}

for(i in 1:length(fileNames)){
  # Read data
  data = read.csv(file.path("NIDA", "ReducedCSV", fileNames[i]))
  
  data_new = cleanMenuSearch(data)
  
  #compare_df(data_new, data, c("SCC.MenuSearch"))
  
  # Write data
  write.csv(data_new, file.path("NIDA", "ReducedCSVCleaned", fileNames[i]))
}
