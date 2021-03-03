##
# Run regular workout
##
run_workout <- function(warmup_seconds, workout_seconds, INTERVAL){
  workout_df <- generate_workout(warmup_seconds, workout_seconds)
  ## Set countdown function
  countdown <- function(from)
  {
    print(from)
    while(from!=0)
    {
      Sys.sleep(1)
      from <- from - 1
      print(from)
    }
  }
  #
  ## Start warm-up countdown
  beepr::beep(sound = 2)
  cat("\n","\n","GET READY", "\n","\n","Warm-up!!!", "\n", "in.....", "\n")
  countdown(3)
  warmup_final <- tidyverse::filter(workout_df, Type == "warm-up")
  warmup_list <- warmup_final$Workout
  for (row in warmup_list) {
    cat("\n", "Next:", paste(row), "in ", "\n")
    countdown(9) #transition countdown
    beepr::beep(sound = 2)
    cat("\n", paste(row), "\n")
    countdown(30) # warm-up defaults to 30 seconds
    beepr::beep(sound = 5)
  }
  ## Warm-up completed, countdown to workout
  cat("\n","\n","\n","Hope you're warm now", "\n")
  beep(sound = 2)
  cat("Workout in...", "\n")
  countdown(3)
  ## Start main workout
  wo_final <- tidyverse::filter(workout_df, Type == "main")
  wo_list <- wo_final$Workout
  for (row in wo_list) {
    cat("\n", "Next:", paste(row), "in ", "\n")
    countdown(9) #transition countdown
    beepr::beep(sound = 2)
    cat("\n", "\n","GO!", "\n", "\n", paste(row), "\n")
    countdown(INTERVAL)
    beepr::beep(sound = 5)
  }
  beepr::beep(sound = 8) #Complete Mario sound
  cat("WORKOUT COMPLETED!!!", "\n", "\n","go drink some water")
}

## Usage:
# Run workout with warm up, main workout, and intervals
# run_workout(2, 4, 10)
