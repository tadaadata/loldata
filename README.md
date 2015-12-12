# loldata

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/loldata)](http://cran.r-project.org/package=loldata)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

Miscellaneous datasets provided for the lulz

## Installation

```
if (!("devtools" %in% installed.packages())){
  install.packages(devtools)
}

devtools::install_github("tadaadata/loldata")
```

## Contained data

* `penis`: The world penis data retrieved from [everyoneweb.com/worldpenissize](http://www.everyoneweb.com/worldpenissize)
* `gameofthrones`: Game of Thrones episode data from [trakt.tv](https://trakt.tv) via the [tRakt package](https://github.com/jemus42/tRakt)
* `popularshows`: Popular show data from [trakt.tv](https://trakt.tv) via the [tRakt package](https://github.com/jemus42/tRakt)
* `popularmovies`: Popular movie data from [trakt.tv](https://trakt.tv) via the [tRakt package](https://github.com/jemus42/tRakt)
* `worldrankings`: Various world rankings taken from Wikipedia combined in one dataset:
    * `literacy`: [Literacy rate](https://en.wikipedia.org/wiki/List_of_countries_by_literacy_rate)
    * `happiness`: [Happiness](https://en.wikipedia.org/wiki/World_Happiness_Report)
    * `smartphone_adoption`: [Smartphone penetration](https://en.wikipedia.org/wiki/List_of_countries_by_smartphone_penetration)
    * `discrimination_index`: [Discrimination Index](https://en.wikipedia.org/wiki/List_of_countries_by_discrimination_and_violence_against_minorities)
    * `homicide_rate`: [Homicide rate](https://en.wikipedia.org/wiki/List_of_countries_by_intentional_homicide_rate)
    * `education`: [Education index (most recent value)](https://en.wikipedia.org/wiki/Education_Index)
    * `income`: [Disposable income](https://en.wikipedia.org/wiki/List_of_countries_by_average_wage)


