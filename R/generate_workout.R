#' Generate a random workout
#'
#' @param warmupREPS input number of desired warm-ups, numeric (i.e., 3). Maximum is 15.
#' @param workoutREPS input number of desiered workouts, numeric (i.e., 4). Maximum is 32.
#'
#' @return A data frame that lists warm-ups and workouts (user defined), and splits moves that require left and right sides into a LEFT and RIGHT size.
#'
#' Make sure to set equal to a new data frame to save this workout.
#'
#' @export
#'
#' @examples
#' myworkout <- generate_workout(4, 8)
#' # Output will include 4 warm-ups and 8 workouts
#'
#' myworkout <- generate_workout(3, 5)
#' myworkout
#'
#' # Example output:
#' # Workout
#' # 1           lateral / side lunges (alternate sides)
#' # 2                                      butt kickers
#' # 3                                       jump squats
#' # 4                                 single-leg squats
#' # 5                                 single-leg squats
#' # 6 step-up / box jump (use stair, a chair, or couch)
#' # 7                                       plank jacks
#' # 8                                        plank hold
#' # 9                                            squats
#' # Type Sides
#' # 1 warm-up  both
#' # 2 warm-up  both
#' # 3 warm-up  both
#' # 4    main right
#' # 5    main  left
#' # 6    main  both
#' # 7    main  both
#' # 8    main  both
#' # 9    main  both
#'
#'
generate_workout <- function(warmupREPS, workoutREPS){
  # Select main workouts
  main <- workout_list %>%
    dplyr::filter(Type == "main") %>%
    dplyr::sample_n(workoutREPS) %>%
    # Duplicate for sided workouts
    tidyr::separate_rows(Sides, sep = ",", convert = TRUE) %>%
    data.frame
  # Add warm-ups to the workout
  workout <- workout_list %>%
    # Select warm-ups
    dplyr::filter(Type == "warm-up") %>%
    dplyr::sample_n(warmupREPS) %>%
    # Add warm-ups to main workout
    dplyr::bind_rows(main) %>%
    # Duplicate for sided workouts
    tidyr::separate_rows(Sides, sep = ",", convert = TRUE) %>%
    data.frame
}
