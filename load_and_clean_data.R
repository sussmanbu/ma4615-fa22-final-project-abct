library(tidyverse)

school_scores_data <- read_csv(here::here("dataset", "school_scores.csv"))

## CLEAN the data
school_scores_data_clean <- school_scores_data

write_csv(school_scores_data_clean, file = here::here("dataset", "school_scores_data_clean.csv"))

save(school_scores_data_clean, file = here::here("dataset/school_scores.RData"))