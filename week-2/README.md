-   [Economist scraper](#economist-scraper)
-   [Yachtworld scraper](#yachtworld-scraper)
-   [Tasks : ultimatespecs scraper](#tasks-ultimatespecs-scraper)

``` r
library(rvest)
library(data.table)
```

Typical HTML process task: \* Create a function that will process one page and return with a data frame with one line \* Create the links that you want to process, you also can write a function that will extract the links first then save them into a vector \* `lapply` your function to your links, you will get a list of data frames \* `rbindlist` your result into one dataframe

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

Write a function that will take one link and return with a list containing the specifications, the name, and the link.

``` r
t <- get_one_car_details('https://www.ultimatespecs.com/car-specs/Tesla/106267/Tesla-Model-S-70.html')

str(t)
```

    ## List of 39
    ##  $ name                                    : chr "Tesla Model S 70 Specs"
    ##  $ link                                    : chr "https://www.ultimatespecs.com/car-specs/Tesla/106267/Tesla-Model-S-70.html"
    ##  $ Engine Type                             : chr "Electric"
    ##  $ Total electric power                    : chr "320 PS or 316 bhp or 235 kW"
    ##  $ Total electric torque                   : chr "441 Nm or 325 lb.ft"
    ##  $ Maximum power - Output - Horsepower     : chr "320 PS or 316 bhp or 235 kW"
    ##  $ Maximum torque                          : chr "441 Nm or 325 lb.ft"
    ##  $ Electric engine 1 type                  : chr "Three-phase AC Induction Motor"
    ##  $ Drive wheels - Traction - Drivetrain    : chr "RWD"
    ##  $ Transmission Gearbox - Number of speeds : chr "1 speed Direct Drive   Transmission Relations1st Gear Ratio: Reverse Gear Ratio: Final Drive Ratio: -"
    ##  $ Range (EPA)                             : chr "370 Km or 230 miles"
    ##  $ Range (NEDC)                            : chr "420 Km or 261 miles"
    ##  $ Battery Type                            : chr "Lithium Ion"
    ##  $ Battery capacity                        : chr "- kWh"
    ##  $ CO2 emissions                           : chr "- g/Km (Tesla)"
    ##  $ CO2 emissions WLTP                      : chr "g/Km (Tesla)"
    ##  $ Top Speed                               : chr "230 km/h or 143 Mph"
    ##  $ Acceleration 0 to 60 mph (0 to 96 Km/h) : chr "5.5 s"
    ##  $ Acceleration 0 to 100 km/h (0 to 62 mph): chr "5.8 s"
    ##  $ Body                                    : chr "Turismo"
    ##  $ Num. of Doors                           : chr "5"
    ##  $ Wheelbase                               : chr "296 cm or 116.54 inches"
    ##  $ Length                                  : chr "497.9 cm or 196.02 inches"
    ##  $ Width                                   : chr "218.7 cm or 86.1 inches"
    ##  $ Height                                  : chr "144.5 cm or 56.89 inches"
    ##  $ Front Axle                              : chr "166.2 cm or 65.43 inches"
    ##  $ Rear Axle                               : chr "170 cm or 66.93 inches"
    ##  $ Num. of Seats                           : chr "5"
    ##  $ Aerodynamic drag coefficient - Cx       : chr "0.24"
    ##  $ Front Brakes - Disc dimensions          : chr "Vented Discs (355 mm)"
    ##  $ Rear Brakes - Dics dimensions           : chr "Vented Discs (365 mm)"
    ##  $ Front Tyres - Rims dimensions           : chr "245/45 R19"
    ##  $ Rear Tyres - Rims dimensions            : chr "245/45 R19"
    ##  $ Turning radius                          : chr "11.3 m / 37.1 feet"
    ##  $ Curb Weight                             : chr "- kg OR - lbs"
    ##  $ Trunk / Boot capacity                   : chr "745 - 1645 L"
    ##  $ Steering                                : chr "Electric"
    ##  $ Front Suspension                        : chr "Double wishbone, virtual steer axis coil spring"
    ##  $ Rear Suspension                         : chr "Independent multi-link coil spring"

``` r
df <- rbindlist(lapply(linkek, get_one_car_details), fill = T)

head(df,3)
```

    ##                                    name
    ## 1: Tesla Model S 100D Performance Specs
    ## 2:               Tesla Model S 70 Specs
    ## 3:              Tesla Model S 70D Specs
    ##                                                                                        link
    ## 1: https://www.ultimatespecs.com/car-specs/Tesla/116161/Tesla-Model-S-100D-Performance.html
    ## 2:               https://www.ultimatespecs.com/car-specs/Tesla/106267/Tesla-Model-S-70.html
    ## 3:              https://www.ultimatespecs.com/car-specs/Tesla/106268/Tesla-Model-S-70D.html
    ##    Engine Type        Total electric power Total electric torque
    ## 1:    Electric 612 PS or 604 bhp or 450 kW   967 Nm or 713 lb.ft
    ## 2:    Electric 320 PS or 316 bhp or 235 kW   441 Nm or 325 lb.ft
    ## 3:    Electric 333 PS or 328 bhp or 245 kW   525 Nm or 387 lb.ft
    ##    Maximum power - Output - Horsepower      Maximum torque
    ## 1:         612 PS or 604 bhp or 450 kW 967 Nm or 713 lb.ft
    ## 2:         320 PS or 316 bhp or 235 kW 441 Nm or 325 lb.ft
    ## 3:         333 PS or 328 bhp or 245 kW 525 Nm or 387 lb.ft
    ##    Number of electric engines         Electric engine 1 type
    ## 1:                          2             AC Induction Motor
    ## 2:                       <NA> Three-phase AC Induction Motor
    ## 3:                       <NA> Three-phase AC Induction Motor
    ##    Drive wheels - Traction - Drivetrain
    ## 1:                                  AWD
    ## 2:                                  RWD
    ## 3:                                  AWD
    ##                                                                  Transmission Gearbox - Number of speeds
    ## 1:       1 speed Auto CVT   Transmission Relations1st Gear Ratio: Reverse Gear Ratio: Final Drive Ratio:
    ## 2: 1 speed Direct Drive   Transmission Relations1st Gear Ratio: Reverse Gear Ratio: Final Drive Ratio: -
    ## 3:                                                           speed Direct Drive   Transmission Relations
    ##           Range (NEDC)          Average energy consumption Battery Type
    ## 1: 613 Km or 381 miles 15.3 kWh / 100 km (0.25 kWh / mile)  Lithium-ion
    ## 2: 420 Km or 261 miles                                <NA>  Lithium Ion
    ## 3: 442 Km or 275 miles                                <NA>  Lithium Ion
    ##    Charging Time Fast Charging Time Fast charge current Battery capacity
    ## 1:   06:28 (H:m)        00:55 (H:m)        120 kW DC kW          100 kWh
    ## 2:          <NA>               <NA>                <NA>            - kWh
    ## 3:          <NA>               <NA>                <NA>            - kWh
    ##     CO2 emissions CO2 emissions WLTP           Top Speed
    ## 1: 0 g/Km (Tesla)     - g/Km (Tesla) 250 km/h or 155 Mph
    ## 2: - g/Km (Tesla)       g/Km (Tesla) 230 km/h or 143 Mph
    ## 3: - g/Km (Tesla)       g/Km (Tesla) 230 km/h or 143 Mph
    ##    Acceleration 0 to 100 km/h (0 to 62 mph)      Body Num. of Doors
    ## 1:                                    3.2 s Hatchback             5
    ## 2:                                    5.8 s   Turismo             5
    ## 3:                                    5.4 s   Turismo             5
    ##                  Wheelbase                    Length
    ## 1: 296 cm or 116.54 inches   497 cm or 195.67 inches
    ## 2: 296 cm or 116.54 inches 497.9 cm or 196.02 inches
    ## 3: 296 cm or 116.54 inches 497.9 cm or 196.02 inches
    ##                       Width                   Height
    ## 1: 196.4 cm or 77.32 inches 144.5 cm or 56.89 inches
    ## 2:  218.7 cm or 86.1 inches 144.5 cm or 56.89 inches
    ## 3:  218.7 cm or 86.1 inches 144.5 cm or 56.89 inches
    ##                  Front Axle              Rear Axle      Ground clearance
    ## 1: 166.2 cm or 65.43 inches 170 cm or 66.93 inches 14.4 cm / 5.67 inches
    ## 2: 166.2 cm or 65.43 inches 170 cm or 66.93 inches                  <NA>
    ## 3: 166.2 cm or 65.43 inches 170 cm or 66.93 inches                  <NA>
    ##    Num. of Seats Aerodynamic drag coefficient - Cx
    ## 1:             5                                 -
    ## 2:             5                              0.24
    ## 3:             5                              0.24
    ##    Front Brakes - Disc dimensions Rear Brakes - Dics dimensions
    ## 1:         Vented Discs ( 355 mm)        Vented Discs ( 365 mm)
    ## 2:          Vented Discs (355 mm)         Vented Discs (365 mm)
    ## 3:          Vented Discs (355 mm)         Vented Discs (365 mm)
    ##    Front Tyres - Rims dimensions Rear Tyres - Rims dimensions
    ## 1:                    245/35 R21                   245/35 R21
    ## 2:                    245/45 R19                   245/45 R19
    ## 3:                    245/45 R19                   245/45 R19
    ##        Turning radius         Curb Weight Weight-Power Output Ratio
    ## 1: 11.3 m / 37.1 feet 2267 kg OR 4998 lbs                 3.7 kg/hp
    ## 2: 11.3 m / 37.1 feet       - kg OR - lbs                      <NA>
    ## 3: 11.3 m / 37.1 feet       - kg OR - lbs                      <NA>
    ##    Trunk / Boot capacity
    ## 1:            745-1645 L
    ## 2:          745 - 1645 L
    ## 3:          745 - 1645 L
    ##                                                Front Suspension
    ## 1: Independent Double Wishbones. Air Suspension. Anti-roll bar.
    ## 2:              Double wishbone, virtual steer axis coil spring
    ## 3:              Double wishbone, virtual steer axis coil spring
    ##                              Rear Suspension         Range (EPA)
    ## 1: Multilink. Air Suspension. Anti-roll bar.                <NA>
    ## 2:        Independent multi-link coil spring 370 Km or 230 miles
    ## 3:        Independent multi-link coil spring 390 Km or 242 miles
    ##    Acceleration 0 to 60 mph (0 to 96 Km/h) Steering Range (WLTP)
    ## 1:                                    <NA>     <NA>         <NA>
    ## 2:                                   5.5 s Electric         <NA>
    ## 3:                                   5.2 s Electric         <NA>
    ##    Average energy consumption WLTP
    ## 1:                            <NA>
    ## 2:                            <NA>
    ## 3:                            <NA>
