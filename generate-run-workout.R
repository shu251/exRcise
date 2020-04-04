###
# Generate & run a workout in R!
### randomly create an interval-based warm-up & workout routine
### SHu - 02-04-2020
#
# install.packages("dplyr")
# install.packages("beepr")
library(dplyr);library(beepr)
#
# Import list of workouts
workouts <- read.delim("workout-list.txt")
#
## Input table requires columns: c("Workout","Type","Sides")
# where Workout = name of workout
# Type = specify if "warm-up" or "main" workout move
# Sides = specify if move requires left and right sides ("sided") or not ("both")
#
# Generate workout
## df = input workout data table, REPS = total number of workouts you want to randomly select
#
generate_workout <- function(df, warmupREPS, workoutREPS){
  warmup <- subset(df, Type == "warm-up")
  warmup_subset <- warmup[sample(nrow(warmup), warmupREPS), ]
  work <- subset(df, Type == "main")
  work_subset <- work[sample(nrow(work), workoutREPS), ]
  # Combine & sort sided workout moves
  compiled <- rbind(warmup_subset, work_subset)
  compiled
  compiled_left <- subset(compiled, Sides == "sided")
  if (dim(compiled_left)[1] > 0) {
    compiled$SIDE <- ""
    compiled$SIDE[compiled$Sides == "sided"] = "RIGHT"
    compiled_left$SIDE <- "LEFT" #Will produce error if there were no "sided" workouts randomly selected
    compiled_sided <- rbind(compiled, compiled_left)
  } else {
    compiled$SIDE <- ""
    compiled_sided <- compiled
  }
  compiled_ordered <- compiled_sided %>%
      group_by(Type, Workout) %>%
      arrange(desc(Type), Workout, desc(SIDE)) %>%
      data.frame
  compiled_ordered$WORKOUT <- paste(compiled_ordered$Workout, compiled_ordered$SIDE, sep=" ")
  return(compiled_ordered)
}
#
# Example workout, selecting 5 warm-ups and 10 main workouts
woRkout_1 <- generate_workout(workouts, 5, 10)
woRkout_1 # view workout
#
# Run workout
## INTERVAL = in seconds
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
  beep(sound = 2)
  cat("\n","\n","GET READY", "\n","\n","Warm-up!!!", "\n", "in.....", "\n")
  countdown(3)
  warmup_final <- subset(df, Type == "warm-up")
  warmup_list <- warmup_final$WORKOUT
  for (row in warmup_list) {
    cat("\n", "Next:",paste(row), "in ", "\n")
    countdown(9) #transition countdown
    beep(sound = 2)
    cat("\n",paste(row), "\n")
    countdown(30) # warm-up defaults to 30 seconds
    beep(sound = 5)
  }
  cat("\n","\n","\n","Hope you're warm now", "\n")
  beep(sound = 2)
  cat("Workout in...", "\n")
  countdown(15)
  wo_final <- subset(df, Type == "main")
  wo_list <- wo_final$WORKOUT
  for (row in wo_list) {
    cat("\n", "Next:", paste(row), "in ", "\n")
    countdown(9) #transition countdown
    beep(sound = 2)
    cat("\n", "\n","GO!", "\n", "\n", paste(row), "\n")
    countdown(INTERVAL)
    beep(sound = 5)
  }
  beep(sound = 8) #Complete Mario sound
  cat("WORKOUT COMPLETED!!!", "\n", "\n","go drink some water")
}
#
# Run workout so main workout moves run for 25 seconds each
run_workout(woRkout_1, 25)
## Workout defaults to 30 sec intervals for warm-ups with 10 second transition and main workout includes 10 second transitions in between specified intervals (INTERVAL)
#
###
# Generate & run a tabata workout:
###
## Subsets 4 random workouts
generate_tabata_workout <- function(df){
  work <- subset(df, Type == "main" & !(Sides == "sided"))
  tabata <- work[sample(nrow(work), 4), ]
  return(tabata)
}
# Tabata workout will randomly select 4 main moves
tabata_1 <- generate_tabata_workout(workouts)
tabata_1
#
# Run tabata workout function:
run_tabata_workout <- function(df){
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
  beep(sound = 2)
  cat("\n","\n","Tabata time", " in.....", "\n")
  tabata_list <- df$Workout
  for (row in tabata_list) {
    cat("\n", "\n", "10 second transition", "\n", "\n")
    cat("Next up:", paste(row))
    countdown(10)
    beep(sound = 2)
    cat("\n", "\n","GO!", "\n", "\n", paste(row), "\n")
    countdown(20)
    beep(sound = 5)
  }
  cat("\n", "\n", "Half way there! Round two.", "\n")
  for (row in tabata_list) {
    cat("\n", "\n", "10 second transition", "\n", "\n")
    cat("Next up:", paste(row))
    countdown(10)
    beep(sound = 2)
    cat("\n", "\n","GO!", "\n", "\n", paste(row), "\n")
    countdown(20)
    beep(sound = 5)
  }
  beep(sound = 8) #Complete Mario sound
  cat("WORKOUT COMPLETE!!!", "\n", "\n","go drink some water")
}
#
# Run tabata workout, 4 moves for 20 seconds with 10 second rests, x2
tabata_1
run_tabata_workout(tabata_1)
#
# Go drink some water. You rocked it.
# SKH
