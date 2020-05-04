require(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(progress, quietly = TRUE)

root = file.path("Data")

# task_length (in seconds) -- assume task length is 10 seconds, and assumes that 1 row = 1 frame
TASK_LENGTH_SEC = 10
TASK_LENGTH = TASK_LENGTH_SEC*60

# Need to be above Data directory when calling this
disp = read.csv(file.path(root, "dispositionUpdate.csv"))
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

cleaned = if(file.exists(file.path(root, "CleanCSV", ".meta"))) readLines(file.path(root, "CleanCSV", ".meta")) else ""

pb <- progress_bar$new(format = "[:bar] :current/:total (:percent)", total = length(fileNames), show_after = 0)
pb$tick(0)
for (i in 1:length(fileNames)) {
  if(fileNames[i] %in% cleaned) {
    #message(paste(fileNames[i], "already cleaned."))
  } else {
    # Read data
    data = read.csv(file.path(root, "CleanCSV", fileNames[i]))
    
    data_new = cleanMenuSearch(data)

    # So we know which ones have already been done...
    write(as.character(fileNames[i]), file = file.path(root, "CleanCSV", ".meta"), append = TRUE)
    
    # Write data
    write.csv(data_new, file.path(root, "CleanCSV", fileNames[i]))
  }
  pb$tick()
}
