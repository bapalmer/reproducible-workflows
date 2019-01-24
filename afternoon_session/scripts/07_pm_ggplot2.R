#########################################################################
# 1-day R workshop 
# Afternoon practical session C
# 9th February 2019
# 07_ggplot2.R
#########################################################################
# ggplot2 is loaded when the tidyverse package is called
# library(tidyverse)

# The key thing to note is that all elements of the plot can be modified

# Load the data
clean_genes <- read_csv("afternoon_session/data/clean_brauer_data.csv")

# Let's zoom in on a single gene 
leu1 <- clean_genes %>%
  filter(gene == "LEU1") %>%
  select(gene, growth_rate, expression)

# What are the three main elements needed to generate a ggplot2 graph?
# A. The data
# B. The geom function
# C. The mappings

# 1. The first part of building a plot is the data 

plot_a <- ggplot(data = leu1) # Creates a coordinate system
plot_a # i.e. an empty graph

# The second part is defining the coordinate system;
# What elements of the data are to be plotted
# geoms are geometric objects that represent the data
plot_b <- plot_a + # In ggplot2 we add layers to develop the plot
  geom_point(mapping = aes(x = growth_rate, y = expression)) 
plot_b

# This can also be written as;
plot_c <- ggplot(data = leu1, mapping = aes(x = growth_rate, y = expression)) +
  geom_point()
plot_c

# What's the difference between these?
# Well lets try adding another geom....

plot_b +
  geom_smooth(method = "lm")

plot_c + 
  geom_smooth(method = "lm")

# 2. Add some colour
ggplot(data = leu1, 
       mapping = aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() 

# 3. Lets combine with the geom for a best fit line to the data
ggplot(data = leu1, 
       mapping =  aes(x = growth_rate, y = expression,  color = gene)) +
  geom_point() +
  # Now, lets add in a layer of code, i.e. a best fit line to the data
  geom_smooth(method = "lm", se = FALSE) 

# Instead of looking at one gene we can use the "biological_process" column 
# to identify groups of genes involved in the same biological pathway
# We can also pipe our data directly into ggplot
clean_genes %>%
  filter(biological_process == "leucine biosynthesis") %>%
  ggplot(mapping = aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) 

# 4. Instead of colour, we can identify by shape
# If you have more than six groups you will need to define the shapes 
# R has 25 built in shapes that are identified by numbers
clean_genes %>%
  filter(biological_process == "leucine biosynthesis") %>%
  ggplot(mapping = aes(x = growth_rate, y = expression, shape = gene)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) 

# You can't define the shape of a line graph, but you can define the linetype
clean_genes %>%
  filter(biological_process == "leucine biosynthesis") %>%
  ggplot(mapping = aes(x = growth_rate, y = expression, shape = gene)) +
  geom_point() +
  geom_smooth(mapping = aes(linetype = gene), method = "lm", se = FALSE) 

# 5. Using "facet_wrap" we can create subplots
clean_genes %>%
  filter(biological_process == "leucine biosynthesis") %>%
  ggplot(mapping = aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ gene)

# 6. It is possible to define different aesthetics in different layers
# You can also specify different data for each layer
# The local argument for the geom overrides the global argument from ggplot
# for that layer only
leucine_genes <- clean_genes %>%
  filter(biological_process == "leucine biosynthesis")
ggplot(data = leucine_genes,
       mapping = aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() +
  geom_smooth(data = filter(leucine_genes, gene == "LEU1"),
              method = "lm",  se = FALSE)

# 7. Modifying other elements of the output using labels and themes
# Basic plot
ggplot(data = leu1, 
       mapping =  aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() +
  geom_line() 

# Add some labels
ggplot(data = leu1, 
       mapping =  aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() +
  geom_line() +
  labs(x = "Growth rate (pg/ms)", y = "Expression (%)", # Define labels
       title = "Leucine biosynthesis genes") +
    theme_classic() # Format the background

# Add some more labels
ggplot(data = leu1, 
       mapping =  aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() +
  geom_line() +
  labs(x = "Growth rate (pg/ms)", y = "Expression (%)", # Define labels
       title = "Leucine biosynthesis genes",
       subtitle = "Preliminary analysis",
       caption = "Data from Brauer et al., 2008") +
  theme_classic() # Format the background

# 8. Change the axis ticks
# Add a line
ggplot(data = leu1, 
       mapping =  aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() +
  geom_line() +
  geom_hline(yintercept = c(-0.5, 0), linetype="dashed", color = "green", size = 1) +
  labs(x = "Growth rate (pg/ms)", y = "Expression (%)", 
       title = "Leucine biosynthesis genes") + 
  scale_y_continuous(breaks = seq(-1.0, 0.0, by = 0.2)) +
  theme_classic()  

# 9. Themes
ggplot(data = leu1, 
       mapping =  aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() +
  geom_line() +
  geom_hline(yintercept = c(-0.5, 0), linetype="dashed", color = "green", size = 1) +
  labs(x = "Growth rate (pg/ms)", y = "Expression (%)", 
       title = "Leucine biosynthesis genes") + 
  scale_y_continuous(breaks = seq(-1.0, 0.0, by = 0.2)) +
  theme_classic()   +
  theme(axis.line.x = element_line(color="orange", size = 1), # Format x axis
        axis.line.y = element_line(color="purple", size = 1), # Format y axis
        panel.grid.major = element_line(colour = "black"), # Format major gridlines
        panel.grid.minor = element_blank(), # Format minor gridlines
        axis.title = element_text(face = "bold", size = 15),
        axis.text = element_text(face = "bold", size = 6),
        plot.title = element_text(hjust = 0.5, vjust = 1))


# 10. Legends
ggplot(data = leu1, 
       mapping =  aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() +
  geom_line() +
  geom_hline(yintercept = c(-0.5, 0), linetype="dashed", color = "black", size = 1) +
  labs(x = "Growth rate (pg/ms)", y = "Expression (%)", 
       title = "") + 
  scale_y_continuous(breaks = seq(-1.0, 0.0, by = 0.2)) +
  theme_classic()   +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1), 
        axis.title = element_text(face = "bold", size = 8),
        axis.text = element_text(face = "bold", size = 8),
        legend.position ="none") # Remove the legend

ggplot(data = leu1, 
       mapping =  aes(x = growth_rate, y = expression, color = gene)) +
  geom_point() +
  geom_line() +
  geom_hline(yintercept = c(-0.5, 0), linetype="dashed", color = "black", size = 1) +
  labs(x = "Growth rate (pg/ms)", y = "Expression (%)", 
       title = "") + 
  scale_y_continuous(breaks = seq(-1.0, 0.0, by = 0.2)) +
  theme_classic()   +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1), 
        axis.title = element_text(face = "bold", size = 8),
        axis.text = element_text(face = "bold", size = 8),
        legend.position ="bottom",
        legend.title = element_blank()) # Remove the legend title

# 11. ggsave() conveniently saves your plots
# It defaults to saving the last plot you can also specify which plot to save
ggsave("morning_session/plots/my_last_plot_default.png")

# Or specify the size
ggsave("morning_session/plots/leu1_plot.png",
       width = 10, 
       height = 8, 
       dpi = 300, 
       units = "cm")

# Or change the ouptput type
ggsave("morning_session/plots/leu1_plot.pdf",
       width = 10, 
       height = 8, 
       dpi = 300, 
       units = "cm")

# 12. One other nice function....
ggplot(data = leucine_genes,
       mapping = aes(x = gene, y = expression, group = growth_rate)) +
  geom_bar(mapping = aes(fill = gene, colour = growth_rate),
           stat = "identity")

ggplot(data = leucine_genes,
       mapping = aes(x = gene, y = expression, group = growth_rate)) +
  geom_bar(mapping = aes(fill = gene, colour = growth_rate),
           stat = "identity") +
  coord_flip() # Very useful if your axis labels overlap

rm(clean_genes, leu1, leucine_genes, plot_a, plot_b, plot_c)
