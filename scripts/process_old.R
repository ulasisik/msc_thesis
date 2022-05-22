library(tidyverse)

path = "/Users/ulas/Projects/msc_thesis/data/processed_old/"
files = list.files(path, full.names = F)

exp_data = list()
ages_data = list()

for (file in files){
  tmp = readRDS(paste0(path, file))
  is_ages = grepl("ages", file)
  if (isTRUE(is_ages)) {
    if (isTRUE(grepl("Colantuoni", file))) tmp = tmp*365
    ages_data[[gsub("_ages.rds", "", file)]] = tmp
  } else{
    exp_data[[gsub(".rds", "", file)]] = tmp
  }
}

length(ages_data)
names(exp_data)

write_rds(ages_data, file="/Users/ulas/Projects/msc_thesis/data/processed/list_all_ages.rds")
write_rds(exp_data, file="/Users/ulas/Projects/msc_thesis/data/processed/list_all_exprs.rds")
