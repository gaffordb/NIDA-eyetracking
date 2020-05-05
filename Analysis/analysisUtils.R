library(hash)
library(dplyr)

root = "."

# Produce the runs corresponding to a given participant and given dosing conditions
# - you can provide the pre-read disposition as `run_info` to prevent rereading it every time
getRunNames = function(participantID = 21, dosages = c("XP", "ZM"), run_info = NA) {
  if(is.na(run_info)) {
    run_info = read_xls(file.path(root, "Data", "disposition.xls"))
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