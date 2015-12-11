#### Get data ####
library(devtools)
library(dplyr)
library(magrittr)

#### penis ####
# Site broke my script :(

#### Game of Thrones ####
library(tRakt)

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
library(stringr)

## Happiness ##
happiness <- read_html("https://en.wikipedia.org/wiki/World_Happiness_Report") %>%
             html_table(fill = TRUE) %>%
             extract2(1) %>%
             select(Country, Happiness) %>%
             mutate(Country = str_trim(Country, "both"))
names(happiness) <- c("country", "happiness")

## Literacy ##
literacy <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_literacy_rate") %>%
            html_table(fill = TRUE) %>%
            extract2(1)
literacy <- literacy[c(1, 2)] %>% slice(-1)
names(literacy) <- c("country", "literacy")

literacy <- literacy %>%
              mutate(literacy = gsub("not reported by UNESCO 2015", NA, literacy),
              literacy = as.numeric(str_extract(literacy, "^.{4}")),
              country = str_trim(country, "both")) %>%
              filter(country != "World")

## Smartphone adoption ##
smartphones <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_smartphone_penetration") %>%
                html_table(fill = TRUE) %>% extract2(1) %>% select(-1)
names(smartphones) <- c("country", "smartphone_adoption")
smartphones <- smartphones %>%
               mutate(country = str_trim(country, "both"),
               smartphone_adoption = as.numeric(str_sub(smartphone_adoption, 1, 4)))

## Combining ##
worldrankings <- tbl_df(full_join(full_join(smartphones, happiness), literacy))
use_data(worldrankings, overwrite = TRUE)
