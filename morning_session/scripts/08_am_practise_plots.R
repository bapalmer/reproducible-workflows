#########################################################################
# 1-day R workshop 
# Morning practical session C
# 30th October 2018
# 08_practise_plots.R
#########################################################################
# Have a go at generating some plots
# library(tidyverse)

# Load the data
who_tb_data <- read_csv("morning_session/data/clean_who_tb_data.csv")

# or
clean_brauer_data <- read_csv("morning_session/data/clean_brauer_data.csv")

# or use sample data that comes with ggplot2
diamonds <- ggplot2::diamonds

# Draw a couple of plots

# Play with the geoms, aesthetics and themes

# Save a few to file

# Create a few plot objects

# Suggestion: A bar plot of all TB cases in Ireland 
who_ire <- who_tb_data %>%
  filter(country == "Ireland") %>%
# Basic barplot with data by age shown
ggplot() +
  geom_bar(mapping = aes(x = year, y = total, fill = age),
           stat = "identity") 

who_ire_title <- who_ire + 
  labs(title = "I just added a title")

who_ire_title