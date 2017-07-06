library(dplyr)
library(readr)
library(tidyr)

census <- read_csv('data_raw/census.csv')

census %>% 
  gather(age_gender, count, -Electorate, -State, -Total_Male, -Total_Female) %>%
  mutate(prop = count / (Total_Male + Total_Female),
         Electorate = stringr::str_to_title(Electorate)) %>%
  select(electorate = Electorate, state = State, age_gender, count, prop) %>%
  write_csv('data/census_clean.csv')