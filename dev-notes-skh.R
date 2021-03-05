# Initiate package material
usethis::create_package("/Users/sarahhu/Desktop/Projects/exRcise")

# https://www.pipinghotdata.com/posts/2020-10-25-your-first-r-package-in-1-hour/
# https://r-pkgs.org/data.html#documenting-data

devtools::install_github("shu251/exRcise", force = TRUE)

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
usethis::use_r("run_workout")
usethis::use_r("run_workout_nosound")
usethis::use_r("run_tabata")
usethis::use_r("run_tabata_nosound")
# Cntrl + Alt + Shift + R

# document function
devtools::document()

# Add some data
usethis::use_data(workout_list)
## Adds .rda file with data in the /data director
## Add a .R file in /R/ to document the data
