#GitHub lesson, simulate plot data
#Allie Lalor
#allielalor@gmail.cm
#First created: 2022-03-15
#Last updated: 2022-03-15

#simulate predictor variable
x <- rnorm(n=100)

#calculate response variable and add noise
y <- 2 * x + rnorm(n=100, sd = 0.2)

#plot the data
plot(x=x, y=y)
