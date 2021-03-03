#' List of workout moves
#'
#' A dataframe containing all warm-ups and workouts. This list will be selected from for the package functions. Columns provide additional information, including if the move requires a repeat on the left and right side.
#'
#' @format A data frame with 47 rows and 3 columns:
#' \describe{
#'   \item{Workout}{Name of workout or warm-up}
#'   \item{Type}{Either 'warm-up' to specify a warm-up or 'main' to designate a main workout.}
#'   \item{Sides}{Indicates if the warm-up or workout requires reps that are left and right sided, specified by 'left,right'. Otherwise, 'both'}
#'   ...
#' }

"workout_list"
