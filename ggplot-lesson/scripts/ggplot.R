#ggplot lesson. plot gapminder data
#Allie Lalor
#allielalor@email.arizona.edu
#2022-03-01

#install.packages("ggplot2")
library(ggplot2)

#Load in data
gapminder <- read.csv(file = "data_raw/gapminder.csv")

#Create plot object
#alpha = 0.5 means transparency is 50%
lifeExp_plot <- ggplot(data = gapminder,
                       mapping = aes(x = gdpPercap, 
                                     y = lifeExp,
                                     color=continent)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  xlab(label = "GDP per capita") +
  ylab(label = "Life expectancy") +
  scale_color_manual(values = c("red", "orange", "forestgreen", "#2222FF", "violet"),
                     labels = c("AFR", "AME", "ASI", "EUR", "OCE"))

#Draw the plot
print(lifeExp_plot)

#Save the plot
ggsave(plot = lifeExp_plot, filename = "output/lifeExp_plot.pdf",
       width = 6, height = 6)
