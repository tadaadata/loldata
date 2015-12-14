#### Get data ####
library(devtools)
library(dplyr)
library(magrittr)
library(rvest)
library(stringr)
library(tRakt)

#### penis ####
# Site broke my script :(

penis <- readRDS("inst/extdata/penis.rds")
penis <- penis %>% rename(country = Country,
                          region  = Region,
                          method  = Method,
                          n       = N) %>%
                   select(-ends_with("_in"), -Source) %>%
                   tbl_df

use_data(penis, overwrite = TRUE)

#### Game of Thrones ####
gameofthrones <- trakt.get_all_episodes("game-of-thrones") %>%
                   select(-available_translations, epnum, zrating.season) %>%
                   tbl_df()

use_data(gameofthrones, overwrite = TRUE)

#### Popular shows ####
popularshows <- trakt.shows.popular(100, extended = "full") %>%
                  select(-available_translations)
airs         <- popularshows$airs
names(airs)  <- c("airs_day", "airs_time", "airs_timezone")
popularshows <- popularshows %>% select(-airs) %>% bind_cols(airs) %>% tbl_df

use_data(popularshows, overwrite = TRUE)

#### Popular movies ####
popularmovies <- trakt.movies.popular(100, extended = "full") %>%
                   select(-available_translations) %>%
                   tbl_df()

use_data(popularmovies, overwrite = TRUE)

#### World rankings ####
# https://en.wikipedia.org/wiki/List_of_international_rankings

## Happiness ##
happiness <- read_html("https://en.wikipedia.org/wiki/World_Happiness_Report") %>%
             html_table(fill = TRUE, trim = TRUE) %>%
             extract2(1) %>%
             select(Country, Happiness) %>%
             mutate(Country = str_trim(Country, "both")) %>%
             set_colnames(c("country", "happiness"))

## Literacy ##
literacy <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_literacy_rate") %>%
              html_table(fill = TRUE, trim = TRUE) %>%
              extract2(1) %>%
              extract(-1, c(1, 2)) %>%
              set_colnames(c("country", "literacy")) %>%
              mutate(literacy = gsub("not reported by UNESCO 2015", NA, literacy),
                     literacy = as.numeric(str_extract(literacy, "^.{4}")),
                     country  = str_trim(country, "both")) %>%
              filter(country != "World")

## Smartphone adoption ##
smartphones <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_smartphone_penetration") %>%
                 html_table(fill = TRUE, trim = TRUE) %>%
                 extract2(1) %>%
                 select(-1) %>%
                 set_colnames(c("country", "smartphone_adoption")) %>%
                 mutate(country = str_trim(country, "both"),
                        smartphone_adoption = as.numeric(str_sub(smartphone_adoption, 1, 4)))

## Discrimination index ##
discrimination <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_discrimination_and_violence_against_minorities") %>%
                    html_table(fill = TRUE, trim = TRUE) %>%
                    extract2(1) %>% select(-1) %>%
                    set_colnames(c("country", "discrimination_index")) %>%
                    mutate(country = str_trim(country, "both"))

## Homicide ##
homicide <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_intentional_homicide_rate") %>%
              html_table(fill = TRUE, trim = TRUE) %>%
              extract2(4) %>%
              extract(c(-1, -2), ) %>%
              set_colnames(c("country", "homicide_rate", "homicide_count", "region", "subregion", "year")) %>%
              select(country, homicide_rate, region, subregion) %>%
              mutate(homicide_rate = as.numeric(homicide_rate),
                     country = str_trim(country, "both"))

## Education ##
education <- read_html("https://en.wikipedia.org/wiki/Education_Index") %>%
               html_table(fill = TRUE, trim = TRUE) %>% extract2(1) %>%
               extract(-1, c(1, (ncol(.) - 1))) %>%
               set_colnames(c("country", "education")) %>%
               mutate(country = str_trim(country, "both"))

## Income ##
income <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_average_wage") %>%
            html_table(fill = TRUE, trim = TRUE) %>%
            extract2(3) %>%
            select(1, 2) %>%
            set_colnames(c("country", "income")) %>%
            mutate(income = as.numeric(str_replace(income, ",", "")),
                   country = str_trim(country, "both"))

## Gini Index ##
gini <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_income_equality") %>%
          html_table(fill = TRUE, trim = TRUE) %>% extract2(4) %>% extract(c(-1, -2), c(1, 4)) %>%
          set_colnames(c("country", "gini")) %>%
          mutate(gini = as.numeric(gini),
                 country = str_trim(country, "both"))

## Suicide rate ##
suicide <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_suicide_rate") %>%
             html_table(fill = TRUE) %>%
             extract2(2) %>%
             select(1:3) %>%
             set_colnames(c("rank", "country", "suicide_rate"))

suicideA <- suicide %>% filter(str_detect(rank, "^\\w")) %>%
              select(-1)

suicideB <- suicide %>% filter(!(str_detect(rank, "^\\w"))) %>%
              select(-3) %>%
              set_colnames(c("country", "suicide_rate")) %>%
              mutate(suicide_rate = as.numeric(suicide_rate))

suicide <- bind_rows(suicideA, suicideB) %>%
             mutate(country = str_replace_all(country, "\\(more info\\)", ""),
                    country = str_trim(country, "both"))

## Gun related deaths ##
guns <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_firearm-related_death_rate") %>%
          html_table(fill = TRUE) %>% extract2(1) %>%
          select(1, 2) %>%
          set_colnames(c("country", "gun_deaths")) %>%
          filter(country != "Country") %>%
          mutate(country = str_replace_all(country, "^.*!", ""),
                 country = str_trim(country, "both"),
                 gun_deaths = as.numeric(gun_deaths))

## Internet speed ##
internet <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_Internet_connection_speeds") %>%
            html_table(fill = TRUE, trim = TRUE) %>%
            extract2(1) %>%
            set_colnames(c("rank", "country", "internet_speed")) %>%
            select(-rank) %>% filter(country != "World average") %>%
            mutate(country = str_trim(country, "both"))

## Combining ##
worldrankings <- full_join(smartphones, happiness) %>%
                 full_join(literacy) %>%
                 full_join(discrimination) %>%
                 full_join(homicide) %>%
                 full_join(education) %>%
                 full_join(income) %>%
                 full_join(gini) %>%
                 full_join(suicide) %>%
                 full_join(guns) %>%
                 full_join(internet) %>%
                 tbl_df %>%
                 select(country, subregion, region, everything()) %>%
                 filter(!str_detect(country, "World"))
use_data(worldrankings, overwrite = TRUE)
