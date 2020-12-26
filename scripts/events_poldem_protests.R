library("tidyverse")

# https://poldem.eui.eu/download/protest-events/
poldem_protests <- read_csv("../data_full/poldem-protest_30.csv")

protests <- poldem_protests %>% 
  select(country_name, date, action_form)

protests %>% 
  write_csv("../data_events/protests.csv")
