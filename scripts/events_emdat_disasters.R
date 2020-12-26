library("tidyverse")
library("readxl")

# https://public.emdat.be/data
emdat_disasters <- read_xlsx("../data_full/emdat_public_2020_12_20_query_uid-qBgFYM.xlsx", skip = 6)

disasters <- emdat_disasters %>% 
  #filter(imonth != 0, iday != 0) %>% 
  drop_na(`Start Year`, `Start Month`, `Start Day`) %>% 
  mutate(event_date = lubridate::ymd(paste(`Start Year`, `Start Month`, `Start Day`, sep="-"))) %>% 
  transmute(Country, event_date, subcategory = `Disaster Type`, description = paste0(`Disaster Subtype`, ": ", `Event Name`))

disasters %>% 
  write_csv("../data_events/disasters.csv")
