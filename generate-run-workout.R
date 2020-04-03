###
# Generate & run a workout in R!
### randomly create an interval-based warm-up & workout routine
### SHu - 02-04-2020
##
library(dplyr)
#
# Import list of workouts
workouts <- read.delim("workout-list.txt")
## Input table requires columns: c("Workout","Type","Sides")
# where Workout = name of workout
# Type = specify if "warm-up" or "main" workout move
# Sides = specify if move requires left and right sides ("sided") or not ("both")
#
# Generate workout
## df = input workout data table, REPS = total number of workouts you want to randomly subset. Warm-ups default to 6.
generate_workout <- function(df, REPS){
  warmup <- subset(df, Type == "warm-up")
  warmup_subset <- warmup[sample(nrow(warmup), 6), ]
  work <- subset(df, Type == "main")
  work_subset <- work[sample(nrow(work), REPS), ]
  # Run workout
  compiled <- rbind(warmup_subset, work_subset)
  compiled_left <- subset(compiled, Sides == "sided")
  compiled$SIDE <- ""
  compiled$SIDE[compiled$Sides == "sided"] = "RIGHT"
  compiled_left$SIDE <- "LEFT"
  compiled_sided <- rbind(compiled, compiled_left)
  compiled_ordered <- compiled_sided %>%
      group_by(Type, Workout) %>%
      arrange(desc(Type), Workout, desc(SIDE)) %>%
      data.frame
  compiled_ordered$WORKOUT <- paste(compiled_ordered$Workout, compiled_ordered$SIDE, sep=" ")
  return(compiled_ordered)
}
WORKOUT_1 <- generate_workout(workouts, 10)
#
run_workout <- function(df, INTERVAL){
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
  cat("GET READY", "\n","\n","Warm-up!!!", "\n", "in.....", "\n")
  countdown(3)
  warmup_final <- subset(df, Type == "warm-up")
  warmup_list <- warmup_final$WORKOUT
  for (row in warmup_list) {
    cat("\n", paste(row), "in ", "\n")
    countdown(3)
    cat("\n",paste(row), "\n")
    countdown(30)
  }
  cat("Hope you're warm now", "\n")
  cat("Workout in...", "\n")
  countdown(5)
  wo_final <- subset(df, Type == "main")
  wo_list <- wo_final$WORKOUT
  for (row in wo_list) {
    cat(paste(row), "in ", "\n")
    countdown(3)
    cat("GO!", "\n", "\n", paste(row), "\n")
    countdown(INTERVAL)
  }
  cat("WORKOUT COMPLETED!!!", "\n", "\n","go drink some water")
  
}
run_workout(WORKOUT_1, 10)
## Workout defaults to 30 sec intervals for warm-ups with 3 second transition and main workout includes 3 second transitions in between specified intervals (INTERVAL)
#
