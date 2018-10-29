#########################################################################
# 1-day R workshop 
# Morning practical session B
# 30th October 2018
# 04_am_dplyr.R
#########################################################################
# dplyr is loaded when the tidyverse package is called
# library(tidyverse)

# 1. Let's reload our messy data from earlier and select the columns we want
messy_data <- read_csv("morning_session/data/brauer_data.csv") %>%
  
  select(c("GID", "NAME", "G0.05", "G0.1", "G0.15", "G0.2", 
           "G0.25", "G0.3"))

# We could also do this.....
messy_data <- read_csv("morning_session/data/brauer_data.csv") %>%
  
  select(GID, NAME, G0.05, G0.1, G0.15, G0.2, G0.25, G0.3)

# Or this.......
messy_data <- read_csv("morning_session/data/brauer_data.csv") %>%
  
  select(GID, NAME, G0.05:G0.3)

# Generally, whatever lead to the least amount of writing is the winner

# 2. The column "GID" is not worth keeping
# Let's get rid of it
messy_data <- messy_data %>%
  
  select(-GID)

# 3. Let's re-run of tidy code from earlier
tidy_data <- messy_data %>%
  
  separate(NAME,
           c("gene", "biological_process", "molecular_function", 
             "systematic_name", "a_number"),
           sep = "\\|\\|") %>%
  
  gather(key = sample,
         value = expression,
         G0.05:G0.3) %>%
  
  separate(sample,
           c("nutrient", "growth_rate"),
           sep = 1)

# 4. When we separated by "|", we ended up with whitespace at the start and end
# of some of the columns

colnames(tidy_data)

tidy_data <- tidy_data %>%
  
  mutate_at(vars(gene:expression), 
            funs(trimws)) # This will remove whitespace

# 5. What if we want to narrow the field?
length(unique(tidy_data$gene))
length(unique(tidy_data$biological_process))

# Lets reduce our data down to a specific process
leucine <- tidy_data %>%
  filter(biological_process == "leucine biosynthesis")

# 6. Repeat this using a logical operator
leu1 <- tidy_data %>%
  
  filter(biological_process == "leucine biosynthesis" &
           gene == "LEU1")

not_leu1 <- tidy_data %>%
  
  filter(biological_process == "leucine biosynthesis" &
           !gene == "LEU1")

leu1_leu2 <- leu1 <- tidy_data %>%
  
  filter(gene == "LEU1" | gene == "LEU2")

rm(leu1_leu2, leucine, messy_data, not_leu1, tidy_data)

# 7. Some mutate() examples
# When we separated our columns earlier, the data within
# underwent coercion to character vectors
leu1 <- leu1 %>%
  
  mutate(growth_rate = as.numeric(growth_rate),
         expression = as.numeric(expression))

leu1 <- leu1 %>%
  
  mutate(total = growth_rate * expression)

# 8. group_by() allows actions to be performed by group
leu1_gp <- leu1 %>%
  
  group_by(gene)

# Not very much happened there except that the tibble is
# now a grouped_df
# The power of group_by is realised in combination with summarise()

# 9. summarise() reduces multiple values down to a single summary
# Lets make some use of our grouped data
leu1_gp %>%
  
  summarise(mean = mean(expression),
            median = median(expression),
            sd = sd(expression))

# 10. If you need to remove the grouping.....
leu_ungp <- ungroup(leu1_gp)

rm(leu_ungp, leu1, leu1_gp)

# 11. Other useful dplyr functions:
# arrange()
# left_join(), right_join, full_join
# bind_rows()
# bind_cols

# 12. Some useful helper functions
# vars()
# everything()
# contains()
# n()

