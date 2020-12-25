library("tidyverse")

# http://www.parlgov.org/static/data/development-utf-8/view_cabinet.csv
parlgov_cabinets <- read_csv("../data_full/view_cabinet.csv")


cabinets <- parlgov_cabinets  %>% 
  group_by(country_name_short, start_date) %>% 
  summarise(
    country_name_short = unique(country_name_short),
    country_name = unique(country_name),
    start_date = unique(start_date),
    description = unique(cabinet_name),
    .groups = "drop"
  )

cabinets %>% 
  write_csv("../data_events/cabinets.csv")
