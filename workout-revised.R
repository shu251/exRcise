
library(devtools)
library(tidyverse)
library(fs)
library(roxygen2)

devtools::document()

###

head(workout_list)
library(tidyverse); library(beepr)

workout_list <- read.delim(file = "../exRcise/workout-list.txt")

###
# Function to generate workout
###
generate_workout <- function(warmupREPS, workoutREPS){
  # Select main workouts
  main <- workout_list %>%
    filter(Type == "main") %>%
    sample_n(workoutREPS) %>%
    # Duplicate for sided workouts
    # separate_rows(Sides, sep = ",", convert = TRUE) %>%
    data.frame
  # Add warm-ups to the workout
  workout <- workout_list %>%
    # Select warm-ups
    filter(Type == "warm-up") %>%
    sample_n(warmupREPS) %>%
    # Add warm-ups to main workout
    bind_rows(main) %>%
    # Duplicate for sided workouts
    separate_rows(Sides, sep = ",", convert = TRUE) %>%
    data.frame
}

# Create random workout list
workout_list_df <- generate_workout(3, 7)

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
  beep(sound = 2)
  cat("\n","\n","GET READY", "\n","\n","Warm-up!!!", "\n", "in.....", "\n")
  countdown(3)
  warmup_final <- filter(workout_df, Type == "warm-up")
  warmup_list <- warmup_final$Workout
  for (row in warmup_list) {
    cat("\n", "Next:", paste(row), "in ", "\n")
    countdown(9) #transition countdown
    beep(sound = 2)
    cat("\n", paste(row), "\n")
    countdown(30) # warm-up defaults to 30 seconds
    beep(sound = 5)
  }
  ## Warm-up completed, countdown to workout
  cat("\n","\n","\n","Hope you're warm now", "\n")
  beep(sound = 2)
  cat("Workout in...", "\n")
  countdown(3)
  ## Start main workout
  wo_final <- filter(workout_df, Type == "main")
  wo_list <- wo_final$Workout
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

# Run workout with warm up, main workout, and intervals
run_workout(2, 4, 10)


###
# Run tabata workout - 4 exercised repeated twice
###
run_tabata_workout <- function(rest, set){
  df <- filter(workout_list,
               Type == "main" & !(Sides == "sided")) %>%
    sample_n(4) %>%
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
  beep(sound = 2)
  cat("\n","\n","Tabata time", " in.....", "\n")
  tabata_df <- df$Workout
  for (row in tabata_df) {
    cat("\n", "\n", "10 second transition", "\n", "\n")
    cat("Next up:", paste(row), "\n")
    countdown(rest)
    beep(sound = 2)
    cat("\n", "\n","GO!", "\n", "\n", paste(row), "\n")
    countdown(set)
    beep(sound = 5)
  }
  cat("\n", "\n", "Half way there! Round two.", "\n")
  for (row in tabata_df) {
    cat("\n", "\n", "10 second transition", "\n", "\n")
    cat("Next up:", paste(row), "\n")
    countdown(rest)
    beep(sound = 2)
    cat("\n", "\n","GO!", "\n", "\n", paste(row), "\n")
    countdown(set)
    beep(sound = 5)
  }
  beep(sound = 8) #Complete Mario sound
  cat("WORKOUT COMPLETE!!!", "\n", "\n","go drink some water")
}

run_tabata_workout(10, 20)





