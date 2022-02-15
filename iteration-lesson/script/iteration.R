# live code: https://tinyurl.com/ua-r-iteration

# most of the lesson materials: https://mcmaurer.github.io/R-DAVIS-3.0/lesson_iteration.html

#lessons with purrr
# https://jennybc.github.io/purrr-tutorial/
# https://emoriebeck.github.io/R-tutorials/purrr/

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


#introducing purrr and the map_ functions
map(1:10,sqrt)

#specify what data type you'll get (characters, decimal
map_dbl(1:10, sqrt)
map_chr(1:10,sqrt)
map_dbl(1:10, ~round(sqrt(.x), digits = 2))

#this is creating a new df with NAs
mtcars2 <- mtcars
mtcars2[3, c(1,6,8)] <- NA

#this is how to extract NAs before doing calculations for each column
#na.rm indicates whether NA values should be stripped before computation begins
map_dbl(mtcars, mean)
map_dbl (mtcars2, mean, na.rm=T)


#bootstrapping with map_
#map function can pack a lot of iterations into a tiny set of code

slice_sample(mtcars, prop = 0.8, replace = T) %>%
  lm(mpg~wt, data=.) %>%
  tidy()

folds <- map(1:100, ~slice_sample(mtcars, prop = 0.8, replace=T))
m <- map(.x = folds, .f = ~lm(mpg~wt, data = .x)) %>%
  map_dfr(.f = tidy, .id = "iter")
m %>%
  ggplot(aes(x=estimate)) +
  geom_histogram(bins=50) +
  facet_wrap(vars(term), scales = "free")



#conditional statements
for (i in 1:10){
  if(i<5){
    print(paste(i, "is less than 5"))
  } else {
    if (i == 5){
      print(paste(i, "is 5"))
    } else {
      print(paste(i, "is greater than 5"))
    }
  }
}



# case_when

mtcars %>%
  mutate(
    car_size = case_when(
      wt>3.5 | cyl == 8 ~"big", 
      wt>2.5 ~"medium",
      TRUE ~ NA_character_
    )
  )

#writing multiple CSVs
#and using *nested* dataframes

storms %>%
  group_by(year) %>%
  nest() %>%
  pwalk(.f = function(year,data){
    write.csv(x=data, file=paste0("iteration-lesson/output/storms_",year,".csv"))
  })
  
#using nest for data simulation
#keeps data frame in data frame, collapses info

expand_grid(mean=1:3, sd=c(0.1,1)) %>%
  rowwise() %>%
  mutate(data = list(rnorm(n=100, mean = mean, sd=sd))) %>%
  mutate(mean_d = mean(data))

expand_grid(mean=1:3, sd=c(0.1,1)) %>%
  rowwise() %>%
  mutate(data = list(rnorm(n=100, mean = mean, sd=sd))) %>%
  mutate(mean_d = mean(data)) %>%
  unnest(data) %>%
  ggplot(aes(x=data)) +
  geom_histogram(bins = 50) +
  facet_grid(rows = vars(mean), cols=vars(sd))

#conditional mutate
#these two examples do the same thing

diamonds %>%
  mutate(x=round(x),
         y=round(y),
         z=round(z))

diamonds %>%
  mutate(across(.cols = everything(), as.character))

diamonds %>%
  mutate(across(where(is.numeric), round, digits = 1))


diamonds %>%
  mutate(across(where(is.numeric), .fns = list(rd = round)))
