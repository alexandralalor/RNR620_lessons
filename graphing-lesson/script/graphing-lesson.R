#graph life expectancy v GDP

#read in data
gapminder_all <- read.csv(file = "data/gapminder-FiveYearData.csv")

#reality check on data
head(gapminder_all)
str(gapminder_all)
summary(gapminder_all)

#Extract 2007 data
#two equal signs is asking a question, while one equal sign is making a statement
gapminder <- gapminder_all[gapminder_all$year == 2007, ]

#make new column of log-transformed GDP
gapminder$logGDP <- log10(gapminder$gdpPercap)

#plot the data
plot(x=gapminder$gdpPercap, 
     y = gapminder$lifeExp, 
     main = "Life expectancy vs. GDP", 
     xlab = "Log(GDP per capita)", 
     ylab = "Life expectancy (years)")



