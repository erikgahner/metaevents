library("tidyverse")

data_cabinets_raw <- read_csv("../data_events/cabinets.csv")
data_elections_raw <- read_csv("../data_events/elections.csv")
data_protests_raw <- read_csv("../data_events/protests.csv")
data_terror_raw <- read_csv("../data_events/terror.csv")
data_disasters_raw <- read_csv("../data_events/disasters.csv")

data_cabinets <- data_cabinets_raw %>% 
  transmute(country_name, event_date = start_date, category = "Cabinet formation", subcategory = NA, description)

data_elections <- data_elections_raw %>% 
  transmute(country_name, event_date = election_date, category = "Election", subcategory, description = NA)

data_protests <- data_protests_raw %>% 
  transmute(country_name, event_date = date, category = "Protest", subcategory = action_form, description = NA)

data_terror <- data_terror_raw %>% 
  transmute(country_name = country_txt, event_date = date, category = "Terror", subcategory = attacktype1_txt, description = NA)

data_disasters <- data_disasters_raw %>% 
  transmute(country_name = Country, event_date, category = "Disaster", subcategory, description)

data_events_raw <- bind_rows(
  data_cabinets,
  data_elections,
  data_protests,
  data_terror,
  data_disasters
)


data_events <- data_events_raw %>% 
  mutate(country_name = case_when(
    country_name %in% c("northern ireland") ~ "United Kingdom",
    country_name %in% c("East Germany (GDR)") ~ "Germany",
    TRUE ~ country_name
  )) %>% 
  mutate(iso2c = countrycode::countrycode(country_name, "country.name", "iso2c")) %>% 
  # Make sure all country names are similar
  mutate(country_name = countrycode::countrycode(iso2c, "iso2c", "country.name")) %>% 
  mutate(region = countrycode::countrycode(iso2c, "iso2c", "region23")) %>% 
  select(region, iso2c, country_name, everything()) %>% 
  arrange(iso2c, event_date) %>% 
  mutate(description = str_remove(description, ": NA"))


write_csv(data_events, "../metaevents.csv")
