#plot gapminder GDP distribution
#Allie Lalor
#allielalor@email.arizona.edu
#first created: 2022-03-01
#last updated: 2022-03-01

library(ggplot2)

#load in data
gapminder <- read.csv(file = "data_raw/gapminder.csv")

#create plot object
#to get rid of axis labels, you need to write "element_blank"
#we use [] when we want to only use part of the data
gdp_plot <- ggplot(data = gapminder[gapminder$continent != "Oceania",],
                   mapping = aes(x = continent, 
                                 y = gdpPercap,
                                 fill = continent)) +
  geom_violin() +
  scale_y_log10() +
  ylab(label = "GDP per capita") +
  theme_bw() +
  facet_wrap(~ year) +
  theme(axis.text.x = element_blank(),
        axis.title.x = element_blank()) +
  scale_fill_manual(values = c("red","orange","forestgreen","darkblue","violet"))


#print plot
print(gdp_plot)

#save plot
ggsave(plot = gdp_plot, filename = "output/gdp_violin_plot.pdf",
       width = 6, height = 6)
