#' Run a tabata workout
#'
#' Selects a random subset of 4 workout exercises and starts the countdown timer to run in a 'tabata' format, where the 4 exercises will be repeated once.
#'
#' @param rest Indicate the number of seconds in between sets. Numeric, recommend 10 (10 seconds).
#' @param set Indicate the length for each of the 4 exercises in seconds, recommend 30 (30 seconds).
#'
#' @return After executing this command, the console will turn into a countdown timer to run your workout. Sounds will play to indicate each transition.
#'
#'  The four exercises randomly selected will be counted down at the user specified set length (in seconds). Then the four exercises will be repeated. 4 exercises x 2 sets.
#'
#' @export
#'
#' @examples
#'
#' run_tabata_workout(10, 30)
#'
#' # Will start a workout set of 4 exercises
#' ## that will be repeated once (4 x2).
#' ## Workouts will run for 30 seconds
#' ## with 10 second transitions.
#'
#'
#'
run_tabata_workout <- function(rest, set){
  df <- dplyr::filter(workout_list,
               Type == "main" & !(Sides == "sided")) %>%
    dplyr::sample_n(4) %>%
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
