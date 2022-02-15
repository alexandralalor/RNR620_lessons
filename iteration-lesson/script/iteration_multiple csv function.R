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

