#########################################################################
# 1-day R workshop 
# Afternoon practical session C
# 30th October 2018
# 02_eg_plots.R
#########################################################################
# Read in the clean WHO TB data
source("scripts/01_eg_clean_data.R")

# Irish data preliminary plot ----
# Pick any question you'd like to ask of the data
# I'm from Ireland, so I might be interested in TB data for Ireland

# Plot A - early on in the project
who_ire <- who_tb_data %>%
  filter(country == "Ireland") %>%
# Basic barplot with data by age shown
ggplot() +
  geom_bar(mapping = aes(x = year, y = total, fill = age),
           stat = "identity") +
  labs(title = "Summary overview of TB cases in Ireland")

# End of project ----
# 2007 looked like a bad year
# Your own area of interest may be paediatrics
# What is the breakdown for the type of TB in the youngest cohort?
who_ire_v2 <- who_tb_data %>%
  
  filter(age == "014" & country == "Ireland") %>% #Feed this data directly to ggplot
  
  # Layered plot
  ggplot() +
  geom_point(mapping = aes(x = as.character(year), y = total, 
                           colour = type, shape = type)) + 
  
  # Assigns colours and shapes by the variable specified 
  scale_color_manual(values = c("black", "red", "green", "blue")) +
  
  # Manually assign the colour
  # ggplot2 accepts hexadecimal colours, e.g. "#000000" == "black"
  # "#FF0000" == "red"
  labs(x = "Year", y = "Total number of cases by type", # Label axes
       title = "TB cases by type in Irish 0 - 14 years olds",
       colour = "TB Type", # Rename your colour
       shape = "TB Type") + # Also, must specify the name of shape legend
  
  theme(axis.text.x = element_text(angle = 90),
        # Rotate the x-axis labels
        panel.background = element_blank(), #Remove grey background
        panel.grid.major = element_blank(), #Remove gridlines
        panel.grid.minor = element_blank(),
        axis.title = element_text(face = "bold", size = 12),
        axis.text = element_text(face = "bold", size = 10),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(hjust = 0.5)) # Centres the plot title

# This plot has a number of extra layers added to improve the quality

# Some points on the plot are zero
# To avoid them being shown, change the limts of your y-axis
who_ire_final <- who_tb_data %>%
  filter(age == "014" & country == "Ireland") %>%
  ggplot() +
  geom_point(mapping = aes(x = as.character(year), y = total, 
                           colour = type, shape = type)) + 
  
  scale_color_manual(values = c("black", "red", "green", "blue")) +
  
  ylim(y = c(0.1, 82)) + # This sets the limits
  
  # Note the error message whe you run the code
  # Compare this plot with the last one
  
  labs(x = "Year", y = "Total number of cases by type", # Label axes
       title = "TB cases by type in Irish 0 - 14 years olds",
       colour = "TB Type",
       shape = "TB Type") +
  
  theme(axis.text.x = element_text(angle = 90),
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.title = element_text(face = "bold", size = 12),
        axis.text = element_text(face = "bold", size = 10),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(hjust = 0.5))