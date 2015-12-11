#### Get data ####
library(devtools)
library(dplyr)

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
