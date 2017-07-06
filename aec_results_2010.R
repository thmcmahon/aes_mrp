library(rvest)
library(readr)
rslt_url <- 'http://results.aec.gov.au/15508/Website/HouseFirstPrefsTppByDivision-15508-NAT.htm'
aec_results <- read_html(rslt_url)
aec_results <- aec_results %>% 
  html_nodes('table') %>% 
  .[[1]] %>%
  html_table(fill = TRUE)
col_names <- as.character(aec_results[7,1:10])
col_names[9:10] <- c("ALP_2PP", "LNP_2PP")
aec_results <- aec_results[10:nrow(aec_results)-2,1:10]
names(aec_results) <- col_names
rownames(aec_results) <- NULL
write_csv(aec_results, 'data/results_2010_aec.csv')