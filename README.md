# exRcise

Generate and run a workout in R. :muscle:

```
git clone https://github.com/shu251/exRcise.git
cd exRcise
```

Launch and run in R (RStudio is best). Provided ```workout-list.txt``` comes with many different warm-up and main exercises.   


### How to get swole with R

1.Execute R workout functions: 
* ```generate_workout()``` : randomly selects a desired number of warm-up and main exercises. Output is a data frame with a list of exercises.
* ```run_workout()```: executes workout, starting with the warm-up. 10 second intervals between each workout move, user defined interval length (in seconds)
2. Import list of workouts and select the number of warm-up and regular workout moves you want in your workout. **Ex:** For 4 warm-ups and 5 regular workout intervals:
```
# Import workout list
workout_list <- read.delim("workout-list.txt")

# Use workout list to select number of warm-ups and workouts:
woRkout <- generate_workout(workout_list, 4, 5)
## Save this to a new dataframe. In this example it is called 'woRkouts'
```

3. Use the saved output from ```generate_workout()```, input into ```run_workout()```: specify how long you want the main exercises to be run (intervals :hourglass_flowing_sand:) in seconds. Workout will run in R console with a countdown of 10 seconds (transitions). Warm-ups default to 30 seconds each. :sound: Turn the volume up!

```
# To run the workout generated above, specify the number of seconds for each regular interval
run_workout(woRkout, 60)
```

The workout will run the warm-ups first for 30 seconds each, with a 10 second interval. Then will go through the regular workouts at the interval selected in the function.

4. Go wild and generate and run a tabata workout. 
```
# Generate tabata workout list
tabata <- generate_tabata_workout(workout_list)

# Run tabata workout, automatically runs 4 moves for 20 seconds with 10 second rests, x2
run_tabata_workout(tabata)
```

5. Hydrate. :potable_water:   

:trophy:  


Last updated: _Sarah Hu April 4, 2020_

