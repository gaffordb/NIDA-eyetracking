library(hash)
library(dplyr)

root = "."

# Produce the runs corresponding to a given participant and given dosing conditions
# - you can provide the pre-read disposition as `run_info` to prevent rereading it every time
getRunNames = function(participantID = 21, dosages = c("XP", "ZM"), run_info = NA) {
  if(is.na(run_info)) {
    run_info = read_excel(file.path(root, "Data", "disposition.xls"))
  }
  run_info = run_info %>% filter(Subject == participantID, Reduced == "X" | Analyzed == "X")
  runs = hash()
  for(dosage in dosages) {
    cur_runs = filter(run_info, DosingLevel == dosage) 
    cur_runs = str_replace(cur_runs$DaqName, ".daq", ".csv")
    print(cur_runs)
    runs[[dosage]] = cur_runs
  }
  return(runs)
}

# Combine the data from all of these runs
# runs can be either a list of runs, or
combineRuns = function(runs) {
  # Read in files if they have not already been read in...
  if(typeof(runs) == "character") {
    runs = runs %>% 
      map(function(fname) {
        read_csv(fname)
      }) 
  } 
  
  # Concatenate all of the data together into one big dataframe
  runs = runs %>% reduce(bind_rows)
}

# Create some visuals
# provide the user id to look at and the dosages, or provide the specific runs to use (formatted as full paths)
makeVisuals = function(partipantID = 21, dosages = c("XP", "ZM"), runs = NA, labels = NA) {
  # Use user-supplied runs if possible
  runs = ifelse(is.na(runs), getRunNames(participantID, dosages), runs)
  
  for(dosage in dosages) {
    # Get the full path to the runs
    runs[[dosage]] = file.path(root, "Data", "CleanCSV", runs[[dosage]])
    
    # Combine all of the restarts together for a given dosage condition
    combined = combineRuns(runs[[dosage]])
    
    combined_task = filter(combined, SCC.MenuSearch != 0)
    combined_no_task = filter(combined, SCC.MenuSearch == 0)
    
    barplot(table(combined_task$Combined.Item.Name)/nrow(combined_task)*100, ylim=c(0,100), ylab = "Percent", xlab = "object index number", main = paste(dosage, ": Artist search task occurring"))
    barplot(table(combined_no_task$Combined.Item.Name)/nrow(combined_no_task)*100, ylim=c(0,100), ylab = "Percent", xlab = "object index number", main = paste(dosage, ": Artist search task not occurring"))
    
    sum(combined_task$Saccade == 1) / nrow(combined_task)
    sum(combined_no_task$Saccade == 1) / nrow(combined_no_task)
    
    gaze_info_task= getGazeInfo(as.character(combined_task$Combined.Item.Name))
    #gaze_info_task = filter(gaze_info_task, objs != "Nothing")
    
    gaze_info_no_task= getGazeInfo(as.character(combined_no_task$Combined.Item.Name))
    #gaze_info_no_task = filter(gaze_info_no_task, objs != "Nothing")
    
    summary(gaze_info_task)
    summary(gaze_info_no_task)
    
    boxplot(gaze_info_task$lens, ylab="Gaze Length Time", main = paste(dosage, ": Artist search task occurring"))
    boxplot(gaze_info_no_task$lens, ylab="Gaze Length Time", main = paste(dosage, ": Artist search task not occurring"))
    
    boxplot(gaze_info_task$lens, at = 1, xlim = c(0.5, 4.5), ylim = c(0,30), boxcol="red", medcol = "red", ylab="Gaze Length Time", main = "Gaze Length Time over Different Dosages and the Artist Search Task")
    boxplot(gaze_info_no_task$lens, at = 2, add = TRUE, boxcol="blue", ylim = c(0,30), medcol = "blue") 
  }
}