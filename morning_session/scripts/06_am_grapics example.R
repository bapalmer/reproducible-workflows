#########################################################################
# 1-day R workshop 
# Morning practical session C
# 30th October 2018
# 06_graphics_example.R
#########################################################################
# Here's an example using the graphics packages that comes with base R
plot(iris$Sepal.Length, iris$Sepal.Width, 
     bg = iris$Species, # Fill colour
     pch = 21, # Shape: circles that can filed
     xlab = "Sepal Length", ylab = "Sepal Width", # Labels
     axes = FALSE, # Don't plot the axes
     frame.plot = FALSE, # Remove the frame 
     xlim = c(4, 8), ylim = c(2, 4.5), # Limits
     panel.first = abline(h = seq(2, 4.5, 0.5), col = "grey80"))

at = pretty(iris$Sepal.Length)
mtext(side = 1, text = at, at = at, 
      col = "grey20", line = 1, cex = 0.9)

at = pretty(iris$Sepal.Width)
mtext(side = 2, text = at, at = at, col = "grey20", line = 1, cex = 0.9)

legend("topright", legend = c("Setosa", "Versicolor", "Virginica"),
       title = "Species", fill=c("black", "red", "green"), cex=0.8)

title("The infamous IRIS data", 
      cex.main = 0.8, font.main = 2, col.main = "black")

# Now lets view the ggplot2 version
# library(tidyverse)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) + 
  geom_point() + 
  scale_colour_manual(values = c("black", "red", "green")) +
  theme_minimal() +
  labs(title = "The infamous IRIS data",
       x = "Sepal Length",
       y = "Sepal Width")

rm(at)
