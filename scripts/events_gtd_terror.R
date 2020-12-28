library("tidyverse")
library("readxl")

# https://gtd.terrorismdata.com/files/gtd-1970-2018/
gtd_terror <- read_xlsx("../data_full/globalterrorismdb_0919dist.xlsx")

terror <- gtd_terror %>% 
  filter(imonth != 0, iday != 0) %>% 
  mutate(date = lubridate::ymd(paste(iyear, imonth, iday, sep="-"))) %>% 
  select(country_txt, date, attacktype1_txt)

terror %>% 
  write_csv("../data_events/terror.csv")
