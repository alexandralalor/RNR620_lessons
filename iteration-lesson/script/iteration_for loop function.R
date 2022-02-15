# live code: https://tinyurl.com/ua-r-iteration

# most of the lesson materials: https://mcmaurer.github.io/R-DAVIS-3.0/lesson_iteration.html

install.packages(dplyr)
install.packages(purrr)
install.packages(ggplot2)
install.packages(broom)


library(dplyr)
library(purrr)
library(ggplot2)
library(broom)
library(tidyr)

x <-1:10
x
log(x)

# for loop
# index value i which takes on first value of the vector we gave it.
# starts with first, runs code, starts again with next.
for (i in 1:10) {
  print(i)
}
# this shows how i starts with 1, prints 1, prints 1^2, and then turns around and continues
# with 2, prints 2, prints 2^2, and continues to 3, all the way to 10
for (i in 1:10) {
  print(i)
  print(i^2)
}

# use i for indexing
# this is a good way to access each element in a data frame
for (i in 1:10) {
  print (letters[i])
  print(mtcars[1, ])
}

# just showing that i doesn't really mean anything. we assing it meaning
for (cat in 3:5){
  print(letters[cat])
}

for (i in 10){
  print(letters[i])
}

for (i in c(2,4,5,9,12)) {
  print(letters[i])
}

#generate empty object to hold results before running loop. will run more quickly
#this is a new place to put results rather than updating the existing df
results <- rep(NA, nrow(mtcars))
mtcars
results

for (i in 1:nrow(mtcars)){
  results[i] <- mtcars$wt[i]*mtcars$disp[i]
}
results
round(results,2)

#this method makes a new column in the mtcars dataframe
mtcars %>%
  mutate(result = wt*disp)

