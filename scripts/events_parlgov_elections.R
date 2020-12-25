library("tidyverse")

# http://www.parlgov.org/static/data/development-utf-8/view_election.csv
parlgov_elections <- read_csv("../data_full/view_election.csv")

elections <- parlgov_elections %>% 
  group_by(country_name_short, election_type, election_date) %>% 
  summarise(
    country_name_short = unique(country_name_short),
    country_name = unique(country_name),
    subcategory = unique(election_type),
    date = unique(election_date),
    .groups = "drop"
  )

elections %>% 
  write_csv("../data_events/elections.csv")
