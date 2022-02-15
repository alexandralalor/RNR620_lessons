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