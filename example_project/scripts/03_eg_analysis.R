#########################################################################
# 1-day R workshop 
# Morning practical session C
# 30th October 2018
# 03_eg_analysis.R
#########################################################################
# Read in the clean WHO TB data
source("scripts/01_eg_clean_data.R")

# Country comparison for 0-14 year old cohort ----
ctry_comp <- who_tb_data %>% # Lets compare TB cases in the youngest
  # cohort between countries with similarly sized populations
  # Perform summary on full data frame
  filter(age == "014") %>%
  group_by(country, year) %>%
  summarise(most = sum(total)) %>% # Get total number of cases
  filter(country %in% c("Ireland", "New Zealand", "Costa Rica",
                        "Norway")) %>% 
  arrange(desc(most)) # Arrange the results in the table by highest
# to lowest number of cases recorded per year per country 

# head(ctry_comp)
# Certainly a bad year by international standards for the Irish 0-14 
# year old cohort

# Summary of information by country
table_of_info <- ctry_comp %>% 
  group_by(country) %>%
  summarise(Mean = round(mean(most, na.rm = TRUE), digits = 2),
            SD = round(sd(most, na.rm = TRUE), digits = 2))

# Once the analysis is complete, you might want to capture your environment
# It can be recreated anytime you run this script
writeLines(capture.output(sessionInfo()), 
           paste("docs/",Sys.Date(),"_end_of_project_session_info.txt",
                 sep = ""))
