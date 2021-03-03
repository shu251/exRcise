# Initiate package material
usethis::create_package("/Users/sarahhu/Desktop/Projects/exRcise")

# check
devtools::check()

devtools::load_all()

# legit
usethis::use_mit_license("Sarah Hu")

usethis::use_package("dplyr")
usethis::use_package("tidyr")
usethis::use_package("beepr")
usethis::use_package("magrittr")

usethis::use_pipe() # allows you to have pipes in functions

devtools::document() #Adds to documentation

# Make a new function
usethis::use_r("generate_workout")

# document function
devtools::document()

# Add some data
usethis::use_data(workout_list)
## Adds .rda file with data in the /data director
## Add a .R file in /R/ to document the data
