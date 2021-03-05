#' Run full workout
#'
#' Input data frame of randomly generated workout from ```generate_workout()``` function and run the series of warm-ups and workouts at intervals defined by the user (specify the length of each interval in seconds). In between each exercise, there are 10 seconds transition time built in.
#'
#'
#' @param workout_df Data frame with list of workouts randomly generated from the ```generate_workout()``` function.
#' @param warmup_seconds Length of warm-up exercises in seconds, 60 = 60 seconds.
#' @param workout_seconds Length of regular workout exercises in seconds, 60 = 60 seconds.
#'
#' @return
#' After executing this command, the console will turn into a countdown timer to run your workout. Sounds will play to indicate each transition. There will first be a 3 second prompt to get ready for the warm-up. Then the number of warm-ups from your workout will run one after another (with 10 second transitions). After the warm-up exercises conclude, there will be a 3 second transition before the main work out exercises begin. Work out exercises will run in the order provided from the input data frame and will run at an interval length defined by the user (in seconds).
#'
#' @export
#'
#' @examples
#'
#' # First run the generate_workout() command to make your workout
#' myworkout <- generate_workout(4, 8)
#' # Output will include 4 warm-ups and
#' ## 8 workouts saved as a dataframe called "myworkout"
#'
#' run_workout(myworkout, 45, 60)
#' # This will run 4 warm-up exercises for
#' ## 45 seconds each and then run 8 main
#' ## workout exercises for 60 seconds.
#' ## The console will become a countdown timer.
#'
#'
run_workout <- function(workout_df, warmup_seconds, workout_seconds){
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
  warmup_final <- dplyr::filter(workout_df, Type == "warm-up")
  warmup_list <- warmup_final$Workout
  for (row in warmup_list) {
    cat("\n", "Next:", paste(row), "in ", "\n")
    countdown(9) #transition countdown
    beepr::beep(sound = 2)
    cat("\n", paste(row), "\n")
    countdown(warmup_seconds) # warm-up defaults to 30 seconds
    beepr::beep(sound = 5)
  }
  ## Warm-up completed, countdown to workout
  cat("\n","\n","\n","Hope you're warm now", "\n")
  beepr::beep(sound = 2)
  cat("Workout in...", "\n")
  countdown(3)
  ## Start main workout
  wo_final <- dplyr::filter(workout_df, Type == "main")
  wo_list <- wo_final$Workout
  for (row in wo_list) {
    cat("\n", "Next:", paste(row), "in ", "\n")
    countdown(9) #transition countdown
    beepr::beep(sound = 2)
    cat("\n", "\n","GO!", "\n", "\n", paste(row), "\n")
    countdown(workout_seconds)
    beepr::beep(sound = 5)
  }
  beepr::beep(sound = 8) #Complete Mario sound
  cat("WORKOUT COMPLETED!!!", "\n", "\n","go drink some water")
}
