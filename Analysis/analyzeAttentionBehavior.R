# Set the sensitivity -- does 1 frame looking away from an object count as breaking the gaze? 2? 3? We'll figure it out, I suppose...
ATTN_SENSITIVITY = 1

getGazeInfo = function(obj_stream) {
  gaze_lens = vector()
  gaze_objs = vector()
  cur_gaze_len = 0
  cur_gaze_obj = ""
  for(i in 1:length(obj_stream)) {

    # We're looking at the same object this frame as last N frames
    if(obj_stream[i] %in% obj_stream[max(i-ATTN_SENSITIVITY,1):i-1]) {
      cur_gaze_len = cur_gaze_len + 1
      cur_gaze_obj = obj_stream[i]
    } else {
      # Append this gaze_len to all of them
      gaze_lens = c(gaze_lens, cur_gaze_len)
      gaze_objs = c(gaze_objs, cur_gaze_obj)
      
      # Reset cur gaze len
      cur_gaze_len = 1
      cur_gaze_obj = obj_stream[i]
    }
  }
  
  # Append this gaze_len to all of them
  gaze_lens = c(gaze_lens, cur_gaze_len)
  gaze_objs = c(gaze_objs, cur_gaze_obj)
  
  return(data.frame(lens = gaze_lens, objs = gaze_objs))
}