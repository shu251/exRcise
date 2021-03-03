###
# Run tabata workout - 4 exercised repeated twice
###
run_tabata_workout <- function(rest, set){
  df <- tidyverse::filter(workout_list,
               Type == "main" & !(Sides == "sided")) %>%
    tidyverse::sample_n(4) %>%
    data.frame
  cat(paste("Workout preview:")); cat(paste("\n", as.character(unique(df$Workout))))
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
  beepr::beep(sound = 2)
  cat("\n","\n","Tabata time", " in.....", "\n")
  tabata_df <- df$Workout
  for (row in tabata_df) {
    cat("\n", "\n", "10 second transition", "\n", "\n")
    cat("Next up:", paste(row), "\n")
    countdown(rest)
    beepr::beep(sound = 2)
    cat("\n", "\n","GO!", "\n", "\n", paste(row), "\n")
    countdown(set)
    beepr::beep(sound = 5)
  }
  cat("\n", "\n", "Half way there! Round two.", "\n")
  for (row in tabata_df) {
    cat("\n", "\n", "10 second transition", "\n", "\n")
    cat("Next up:", paste(row), "\n")
    countdown(rest)
    beepr::beep(sound = 2)
    cat("\n", "\n","GO!", "\n", "\n", paste(row), "\n")
    countdown(set)
    beepr::beep(sound = 5)
  }
  beepr::beep(sound = 8) #Complete Mario sound
  cat("WORKOUT COMPLETE!!!", "\n", "\n","go drink some water")
}

## Usage:
# run_tabata_workout(10, 20)
