library(tidyverse)
data <- read_csv("/Users/bridgetzhang/ma415/ma4615-fa22-final-project-abct/dataset/school_scores_data_clean.csv")
summary_stats <- summary(data)
View(summary_stats)
