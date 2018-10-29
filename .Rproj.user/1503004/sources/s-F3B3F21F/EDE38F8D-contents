#########################################################################
# 1-day R workshop 
#Afternoon practical session A
# 30th October 2018
# 02_pm_good_habits.R
#########################################################################
# 1. This file is already machine readable, but it needs to be human readable too
# Will you remember what you did in 6 months time?
# Frequently comment within your code to make the steps human readable
# Comment on any line that is ambiguous
# Every file should also contain a header

# 2. Organisation ---- 
# Using "----" allows for long scripts to be broken up into named sections

# 3. Assignment ----
# Always use <-, not =, for assignment
# Good
x <- 5

#Bad
x = 5

# 4. Variable names ----
# Variable and function names should be lowercase
# Use an underscore (_) to separate words within a name
# They should be descriptive and succinct
strwrs_df # here "_df" identifies the object as a data frame
strwrs_mx # here "_mx" indicates the object is a matrix
strwrs_lm # here "_lm" the object stores the output of a linear model

# Good
day_one
day_1

# Bad
first_day_of_the_month
DayOne
dayone

# 5. Object names ----
# Must start with a letter and can only contain letters, numbers, "_" and "."
# Good
this_is_recommended <- 5 #Although it should be shortened
so.is.this <- 5

#Bad
1.not.this <- 5
notthiseither <- 5

c <- 5 # This is problematic as the concatenate function is c()
# In functions T == TRUE and F == FALSE, so best avoid
T == TRUE
F == FALSE
T <- TRUE
T == 5
T == TRUE

# 6. Syntax ----
# Place spaces around all infix operators (=, +, -, <-, etc.)
# The same rule applies when using = in function calls
# Always put a space after a comma, and never before 
# Good
average <- mean(feet / 12 + inches, na.rm = TRUE)

# Bad
average<-mean(feet/12+inches,na.rm=TRUE)

# Important exception
# Double colons (:) don’t need spaces around them
x <- c(1:10, 15, 20, 25:30)

# Use extra spacing if it improves alignment
# Spread text over multiple lines to improve readability
# Good
x <- list(
     total = a + b + c, 
     mean  = (a + b + c) / n,
     places = c("Baltimore", "Youghal", "Fermoy", "Kanturk")
     )

# Bad
x <- list(total=a+b+c, mean=(a+b+c)/n, places=c("Baltimore", "Youghal", "Fermoy", "Kanturk"))
x <- list(total = a + b + c, mean  = (a + b + c) / n, places = c("Baltimore", "Youghal", "Fermoy", "Kanturk"))

# 7. Break the code up into digestible chunks
# Add notes to clarify why some operations were performed
# Here is some example code from a project I'm currently working on
clean_data <- read_csv("path to my data table.csv") %>%
  
  mutate(global.id = subject.number) %>%
  
  select(-safety.data, -education.log.form.4) %>% # These columns contained a solitary "." entry
 
  # Remove uninformative columns 
  select(-centre.number, -randomisation.envelope.number, -trial.start.date,
         -if.potassium.6mmoles.dietetic.review.undertaken,
         -height.cm, -ht.2, -date.started.dialysis, -vitamin.d..active,
         -if.previously.on.dialysis..record.the.total.number.of.months.previously.dialysed) %>%
  
  separate(subject.number, 
           c("centre.id", "pt.id"),
           sep = 2) %>% # split global.id by patient and centre
  
  # I'll reorder the columns here for easy viewing
  select(global.id, 
         centre.id, 
         pt.id, 
         everything()) %>%
  
  # Just making column names more intuitive 
  rename(diet = diet.allocation,
         age = age.pasted.values,
         diabetes = presence.of.diabetes,
         ethnicity = self.reported.ethenicity) %>%

  # Correcting inconsistencies in the raw data 
  mutate(ethnicity = gsub("caucasion", "caucasian", ethnicity),
         ethnicity = gsub("African", "african", ethnicity),
         ethnicity = gsub("malaysian", "asian", ethnicity)) %>%
  
  # Tidy up the column types
  mutate(diet = factor(diet, levels = c("a", "b")),
         diet = fct_recode(diet, "Standard" = "a"),
         diet = fct_recode(diet, "Modified" = "b"),
         age = as.numeric(age),
         sex = factor(sex),
         height.m = as.numeric(height.m))

# 8. Finish up and write to file as a record if required
# write_csv(clean_data, paste("afternoon_session/data/",Sys.Date(),"_clean_data.csv", sep=""))

# 9. Optional 
library(here) #  Build the path when you read or write a file
data_tibble <- read_csv(here("data", "raw_data.csv")) # Argument A is the folder
output_fig <- ggplot(df, aes(x, y)) + geom_point() 
ggsave(here("figs", "output_fig.png"))