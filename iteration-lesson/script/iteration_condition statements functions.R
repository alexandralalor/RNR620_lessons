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
