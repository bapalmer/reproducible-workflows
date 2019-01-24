#########################################################################
# 1-day R workshop 
# Afternoon practical session A
# 9th February 2019
# 03_pm_tidyr.R
#########################################################################
# tidyr is loaded when the tidyverse package is called
# library(tidyverse)

# 1. Let's load some sample data
messy_data <- read_csv("afternoon_session/data/brauer_data.csv")

columns_we_need <- c("GID", "NAME", "G0.05", "G0.1", "G0.15", "G0.2", 
                     "G0.25", "G0.3")

messy_data <- messy_data[columns_we_need]

# 2. We will now separate the NAME column into four new columns
# Option A
separated_genes <- separate(data, 
                            column_to_be_separated,
                            c("Names", "of", "new", "columns"),
                            sep = "\\|\\|" # This is the delimiter
                            )

# Option B  
separated_genes <- data %>% # Here we pipe the data into the function
  separate(column_to_be_separated, # Now the column becomes the first argument
           c("Names", "of", "new", "columns"),
           sep = "\\|\\|" # This is the delimiter
           ) 

messy_data[1,2]
# A tibble: 1 x 1
# NAME                                                                                   
# <chr>                                                                                  
#  1 SFB2       || ER to Golgi transport || molecular function unknown || YNL049C || 1082129
# First element is the gene name
# Second element is the biological process
# Third element is the molecular function
# Fourth element is a systematic_name
# Fifth element is a number
separated_genes <- messy_data %>% 
  separate(NAME,
           c("gene", "biological_process", "molecular_function", 
             "systematic_name", "a_number"),
           sep = "\\|\\|"
           )

# 3. We still have column headers that are values rather than variables (e.g. G0.05)
# Gather takes multiple columns and collapses into key-value pairs, 
# duplicating all other columns as needed
# You use gather() when you notice that you have columns that are not variables
gathered_genes <- gather(separated_genes, 
                         key = sample, 
                         value = expression, 
                         G0.05:G0.3) 

# gather() takes multiple columns, and gathers them into key-value pairs: 
# the key would be the original column names with their associated values
# i.e. it makes "wide" data long
# The original column names become values in the newly created key column, sample
# The original values are placed in newly created value column, expression
# e.g. long_data <- gather(wide_data, 
#                          key = "new_column_A_name", 
#                          value = "new_column_B_name", 
#                          column_1:column_n)
# A useful arguement to include is na.rm = TRUE to remove NA cases

# 4. The data is still "untidy"
# The column is conveying two pieces of information (e.g. G0.05)
tidy_genes <- gathered_genes %>% 
  separate(sample,
           c("nutrient", "growth_rate"),
           sep = 1 # i.e. we will split the observation after the first character
  )

# 5. Let's reverse our actions above
# To do this we can use the functions unite() and spread()
undo_gather <- gathered_genes %>%
  spread(key = sample, value = expression)

undo_separate <- separated_genes %>%
  unite("my_column_name", 
        c("gene", "biological_process", "molecular_function", "systematic_name", "a_number"),
        sep = "-"
        )

# 6. How do we handle NA values if they are present?
# We got warnings earlier alerting us to the presence of some NAs within our data
na_rows <- messy_data[rowSums(is.na(messy_data)) > 0,] # This will give us all rows with NA
na_rows <- na_rows %>% 
  replace_na(list(G0.05 = list("unknown")))

na_rows$G0.1 %>% 
  replace_na(0.0000001)

rm(columns_we_need, gathered_genes, messy_data, na_rows, separated_genes, 
   undo_gather, undo_separate, tidy_genes)

# 7. Other useful tidyr functions:
# drop_na() - will remove whole rows containing an NA value
# This is useful if your data does not contain much missing information
# but if there are a lot of NAs, you will remove a lot of useful data too
# Including the "na.rm = TRUE" arguement within functions is another option

# complete() - takes a set of columns and finds all unique combinations
# It ensures the original data set has all combinations by filling them with NA

# fill() - Somethings values are missing as the value is carried forward, just not entered
# Fill will replace empty cells with the most recent non-missing value
