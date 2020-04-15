# loldata

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/loldata)](http://cran.r-project.org/package=loldata)
[![Project Status: Abandoned – Initial development has started, but there has not yet been a stable, usable release; the project has been abandoned and the author(s) do not intend on continuing development.](https://www.repostatus.org/badges/latest/abandoned.svg)](https://www.repostatus.org/#abandoned)

Miscellaneous datasets provided for the lulz

## Installation

```
if (!("remotes" %in% installed.packages())){
  install.packages(devtools)
}

remotes::install_github("tadaadata/loldata")
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
    * `gini`: [World Bank Gini index (income inequality)](https://en.wikipedia.org/wiki/List_of_countries_by_income_equality)
    * `suicide`: [Suicide rate (both sexes)](https://en.wikipedia.org/wiki/List_of_countries_by_suicide_rate)
    * `gun_deaths`: [Gun related death rate (total)](https://en.wikipedia.org/wiki/List_of_countries_by_firearm-related_death_rate)
    * `internet_speed`: [Internet connection speed (Mbps)](https://en.wikipedia.org/wiki/List_of_countries_by_Internet_connection_speeds)
    * `population`: [Population](https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population)
    * `gender_equality`: [Gender equality score (1 is equality) (2014)](https://en.wikipedia.org/wiki/Global_Gender_Gap_Report)
    * [Social progress index](https://en.wikipedia.org/wiki/List_of_countries_by_Social_Progress_Index)
        * `social_progress`: Social progress index
        * `humand_needs`: Basic human needs
        * `well_being`: Foundations of well-being
        * `opprtunity`: Opportunity
    * `life_expectancy`: [Overall life expectancy](https://en.wikipedia.org/wiki/List_of_countries_by_life_expectancy)
    * `terrorism_score`: [Terrorism Score](https://en.wikipedia.org/wiki/Global_Terrorism_Index)
    * `peace_index`: [Peace Index (2015)](https://en.wikipedia.org/wiki/Global_Peace_Index)
    * `satisfaction`: [Satisfaction with Life Index](https://en.wikipedia.org/wiki/Satisfaction_with_Life_Index)
    * `web_index`: [Web Index (2014)](https://en.wikipedia.org/wiki/Web_index)
