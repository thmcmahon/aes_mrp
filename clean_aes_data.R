library(tidyverse)
library(aes)

age_to_range <- function(x) {
  labels <- c('10-19', '20-29', '30-39', '40-49', '50-59', '60-69', '70-79',
              '80-89', '90-99', '100_plus')
  age_ranges <- seq(10,100,10)
  labels[findInterval(x, age_ranges)]
}

voters <- aes_2013 %>%
  select(id = uniqueid, electorate = division, state, party = b9reps, age,
         gender = h1) %>%
  mutate(age = as.numeric(as.character(age)),
         party = as.character(party),
         electorate = stringr::str_to_title(electorate))

voters$age_range <- sapply(voters$age, age_to_range)

voters$party <- recode(voters$party,
                       'Liberal Party' = 'LNP',
                       'Labor Party (ALP)' = 'ALP',
                       'National (Country) Party' = 'LNP',
                       'Other (please specify party)' = 'Other',
                       'Greens' = 'Other',
                       'Voted informal/Did not vote' = 'Informal')

voters$party[!is.na(voters$party) & voters$party == 'Informal'] <- NA

voters <- voters %>% filter(complete.cases(.))

write_csv(voters, 'data/voters.csv')