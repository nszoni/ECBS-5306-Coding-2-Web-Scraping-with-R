-   [Economist scraper](#economist-scraper)
-   [Yachtworld scraper](#yachtworld-scraper)
-   [Tasks : ultimatespecs scraper](#tasks-ultimatespecs-scraper)

``` r
library(rvest)
library(data.table)
```

Typical HTML process task:

-   Create a function that will process one page and return with a data frame with one line
-   Create the links that you want to process, you also can write a function that will extract the links first then save them into a vector
-   `lapply` your function to your links, you will get a list of data frames
-   `rbindlist` your result into one dataframe

Economist scraper
=================

``` r
url <- 'https://www.economist.com/leaders/'

get_one_page <- function(url) {
  t <- read_html(url)
  
  relative_links <- 
  t %>% 
    html_nodes('.teaser__text a')%>%
    html_attr('href')
  
  links <- paste0('https://www.economist.com', relative_links)
  
  teasers <-
  t %>% 
    html_nodes('.teaser__text')%>%
    html_text()
  #
  
  titles <- t %>% 
    html_nodes('.headline-link span' )
  
  
  title_text <- 
  titles[
  t %>% 
    html_nodes('.headline-link span' ) %>%
    html_attr('class')=='teaser__headline teaser__headline--sc3'
  ] %>% html_text()
  
  return(data.frame('title'= title_text, 'teaser'= teasers, 'link'= links))
  #
}  

df <- get_one_page(url = url)

links <- paste0('https://www.economist.com/leaders?page=', 1:3)

list_of_dfs<- lapply(links, get_one_page)

final_df <- rbindlist(list_of_dfs)

head(final_df)
```

    ##                                                                  title
    ## 1:              Boris Johnson treats checks and balances with contempt
    ## 2:                                          Revolt of the bond traders
    ## 3:                     The calamity facing Joe Biden and the Democrats
    ## 4: By falsifying history, China’s leaders risk repeating past mistakes
    ## 5:                            Act now to avert a bloodbath in Ethiopia
    ## 6:                                The uses and abuses of green finance
    ##                                                                                                                                          teaser
    ## 1:                            Government in BritainBoris Johnson treats checks and balances with contemptHe seems to think rules are for losers
    ## 2:                                                  Markets and inflationRevolt of the bond tradersThe message from unruly fixed-income markets
    ## 3:               One year onThe calamity facing Joe Biden and the DemocratsThe president needs to distance himself from his party’s left fringe
    ## 4: The ghost of MaoBy falsifying history, China’s leaders risk repeating past mistakesTo learn from the past, one must study it dispassionately
    ## 5:                           Abiy’s abyssAct now to avert a bloodbath in EthiopiaAs rebels march on the capital, ethnic persecution accelerates
    ## 6:             Climate change and investingThe uses and abuses of green financeWhy the net-zero pledges of financial firms won’t save the world
    ##                                                                                                              link
    ## 1:            https://www.economist.com/leaders/2021/11/06/boris-johnson-treats-checks-and-balances-with-contempt
    ## 2:                                        https://www.economist.com/leaders/2021/11/06/revolt-of-the-bond-traders
    ## 3:                   https://www.economist.com/leaders/2021/11/06/the-calamity-facing-joe-biden-and-the-democrats
    ## 4: https://www.economist.com/leaders/2021/11/04/by-falsifying-history-chinas-leaders-risk-repeating-past-mistakes
    ## 5:                          https://www.economist.com/leaders/2021/11/04/act-now-to-avert-a-bloodbath-in-ethiopia
    ## 6:                                https://www.economist.com/leaders/the-uses-and-abuses-of-green-finance/21806111

Yachtworld scraper
==================

The base url is <https://www.yachtworld.co.uk/boats-for-sale/>

``` r
# scraper for one page 
url <- 'https://www.yachtworld.co.uk/yacht/2021-ryck-280-8036770/'
t_list <- list()

t <- read_html(url)
t_list[['title']] <- t %>% html_node('.heading') %>% html_text()
t_list[['length']] <- t %>% html_nodes('.boat-length') %>% html_text()
t_list[['price']] <- t %>% html_nodes('.payment-total') %>% html_text()
t_list[['location']] <- t %>% html_node('.location') %>% html_text()


keys <- t %>% html_nodes('.datatable-title') %>% html_text()
values <- t %>% html_nodes('.datatable-value') %>% html_text()
if (length(keys)==length(values)) {
  for (i in 1:length(keys)) {
    t_list[[keys[i]]] <- values[i]
  }
}



get_one_yachts  <- function(url) {
  t_list <- list()
  
  t <- read_html(url)
  t_list[['title']] <- t %>% html_node('.heading') %>% html_text()
  t_list[['length']] <- t %>% html_nodes('.boat-length') %>% html_text()
  t_list[['price']] <- t %>% html_nodes('.payment-total') %>% html_text()
  t_list[['location']] <- t %>% html_node('.location') %>% html_text()
  
  
  keys <- t %>% html_nodes('.datatable-title') %>% html_text()
  values <- t %>% html_nodes('.datatable-value') %>% html_text()
  if (length(keys)==length(values)) {
    for (i in 1:length(keys)) {
      t_list[[keys[i]]] <- values[i]
    }
  }
  return(t_list)

}
```

``` r
links <- c('https://www.yachtworld.co.uk/yacht/2021-ryck-280-8036770/',
           'https://www.yachtworld.co.uk/yacht/1892-de-vries-lentsch-classic-7186643/',
           'https://www.yachtworld.co.uk/yacht/1897-ketch-javelin-8087189/')


data_list <- lapply(links, get_one_yachts)

df <- rbindlist(data_list, fill = T)
```

Tasks : ultimatespecs scraper
=============================

Open that site: <https://www.ultimatespecs.com/car-specs/Tesla/M8552/Model-S> and get the links of the cars

``` r
t <- read_html('https://www.ultimatespecs.com/car-specs/Tesla/M8552/Model-S')
linkek <- t %>% html_nodes('#hybrid_electric a') %>% html_attr('href')

links <- paste0('https://www.ultimatespecs.com',linkek[linkek!='#'])
```

Write a function that will take one link and return with a list containing the specifications, the name, and the link.

``` r
get_one_car_details <- function(url) {
  t_list <- list()
  
  t <- read_html(url)
  t_list[['name']] <- t %>% html_node('h1') %>% html_text()
  t_list[['link']] <- url

  
  keys <- t %>% html_nodes('.tabletd') %>% html_text()
  keys<- trimws(gsub(':', '', keys, fixed = T))
  
  values <- t %>% html_nodes('.tabletd_right') %>% html_text()
  values <- trimws(values)
  
  if (length(keys)==length(values)) {
    for (i in 1:length(keys)) {
      t_list[[keys[i]]] <- values[i]
    }
  }
  return(t_list)

}
```

``` r
# if it runs to error, that means that you have to many request
t <- get_one_car_details('https://www.ultimatespecs.com/car-specs/Tesla/106267/Tesla-Model-S-70.html')

str(t)

df <- rbindlist(lapply(links, get_one_car_details), fill = T)

head(df,3)
```
