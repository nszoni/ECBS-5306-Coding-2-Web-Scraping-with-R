-   [Jsonlite](#jsonlite)
-   [Json in html document imdb](#json-in-html-document-imdb)
-   [Json in html document payscale](#json-in-html-document-payscale)
-   [GET & POST](#get-post)
-   [Task exchange rate](#task-exchange-rate)
-   [Nasdaq data](#nasdaq-data)
-   [Task forbes](#task-forbes)

``` r
library(rvest)
library(data.table)
library(jsonlite)
library(httr)
```

Jsonlite
========

``` r
t_list <- fromJSON('{"first_json": "hello ceu", "year":2021, "class":"BA"} ')

# with nested dfs use , flatten = T

toJSON(t_list)
```

    ## {"first_json":["hello ceu"],"year":[2021],"class":["BA"]}

``` r
toJSON(t_list, auto_unbox = T)
```

    ## {"first_json":"hello ceu","year":2021,"class":"BA"}

``` r
toJSON(t_list, auto_unbox = T, pretty = T)
```

    ## {
    ##   "first_json": "hello ceu",
    ##   "year": 2021,
    ##   "class": "BA"
    ## }

Json in html document imdb
==========================

``` r
t <- read_html('https://www.imdb.com/title/tt4154796/')

# get the json of it. 
json_data <- 
  fromJSON(
    t %>%
      html_nodes(xpath = "//script[@type='application/ld+json']")%>%
      html_text()
  )


json_2_data <- 
  fromJSON(
    t %>%
      html_nodes(xpath = "//script[@id='__NEXT_DATA__']")%>%
      html_text()
  )

# toJSON(json_data, pretty = T, auto_unbox = T)
# toJSON(json_2_data, pretty = T, auto_unbox = T)
```

Json in html document payscale
==============================

``` r
t <- read_html('https://www.payscale.com/research/US/Job=Product_Manager%2C_Software/Salary')
td  <- fromJSON(t %>%
                       html_nodes(xpath = "//script[@type='application/ld+json']")%>%
                       html_text()
)

td2  <- fromJSON(t %>%
                        html_nodes(xpath = "//script[@type='application/json']")%>%
                        html_text()
)

# toJSON(td, pretty = T, auto_unbox = T)
# toJSON(td2, pretty = T, auto_unbox = T)

# http://jsonviewer.stack.hu/
```

GET & POST
==========

``` r
# https://github.com/daroczig/CEU-R-mastering

# https://exchangerate.host/#/#our-services

# https://www.youtube.com/watch?v=UObINRj2EGY


url <- 'https://api.exchangerate.host/convert?from=USD&to=EUR'
data <- fromJSON(url)
print(data)
```

    ## $motd
    ## $motd$msg
    ## [1] "If you or your company use this project or like what we doing, please consider backing us so we can continue maintaining and evolving this project."
    ## 
    ## $motd$url
    ## [1] "https://exchangerate.host/#/donate"
    ## 
    ## 
    ## $success
    ## [1] TRUE
    ## 
    ## $query
    ## $query$from
    ## [1] "USD"
    ## 
    ## $query$to
    ## [1] "EUR"
    ## 
    ## $query$amount
    ## [1] 1
    ## 
    ## 
    ## $info
    ## $info$rate
    ## [1] 0.879038
    ## 
    ## 
    ## $historical
    ## [1] FALSE
    ## 
    ## $date
    ## [1] "2021-11-16"
    ## 
    ## $result
    ## [1] 0.879038

``` r
t <- GET('https://api.exchangerate.host/convert', query=list(from="USD", to="EUR"))



t <- fromJSON(content(t, "text"))

t <- GET('https://api.exchangerate.host/convert', query=list(from="USD", to="EUR"), verbose(info = T))
```

Task exchange rate
==================

[https://exchangerate.host/\#/\#our-services](https://exchangerate.host/#/#our-services) Write a function which will return exchange rates, inputs: `start_date`, `end_date`, `base`, `to`. Check Time-Series endpoint

    ##          date    value
    ## 1  2021-10-01 308.2557
    ## 2  2021-10-02 308.1968
    ## 3  2021-10-03 307.5822
    ## 4  2021-10-04 306.8719
    ## 5  2021-10-05 308.1535
    ## 6  2021-10-06 310.6234
    ## 7  2021-10-07 310.4860
    ## 8  2021-10-08 311.2507
    ## 9  2021-10-09 311.1399
    ## 10 2021-10-10 311.8014
    ## 11 2021-10-11 311.0437
    ## 12 2021-10-12 312.6558
    ## 13 2021-10-13 310.5366
    ## 14 2021-10-14 309.3231
    ## 15 2021-10-15 310.1837
    ## 16 2021-10-16 310.3273
    ## 17 2021-10-17 309.8468
    ## 18 2021-10-18 311.5191
    ## 19 2021-10-19 311.1388
    ## 20 2021-10-20 310.6663
    ## 21 2021-10-21 313.1650
    ## 22 2021-10-22 313.1058
    ## 23 2021-10-23 313.0132
    ## 24 2021-10-24 312.7591
    ## 25 2021-10-25 314.8506
    ## 26 2021-10-26 314.8175
    ## 27 2021-10-27 313.1018
    ## 28 2021-10-28 309.4093
    ## 29 2021-10-29 311.2931
    ## 30 2021-10-30 311.2140
    ## 31 2021-10-31 311.5306
    ## 32 2021-11-01 310.7169
    ## 33 2021-11-02 310.0904
    ## 34 2021-11-03 308.6243
    ## 35 2021-11-04 311.5075
    ## 36 2021-11-05 310.1675
    ## 37 2021-11-06 310.1885
    ## 38 2021-11-07 310.2571
    ## 39 2021-11-08 311.3437
    ## 40 2021-11-09 311.1597
    ## 41 2021-11-10 316.3754
    ## 42 2021-11-11 318.7115
    ## 43 2021-11-12 320.5741
    ## 44 2021-11-13 320.5870
    ## 45 2021-11-14 320.2339
    ## 46 2021-11-15 321.5623
    ## 47 2021-11-16 321.5355

``` r
df <- exchange_currency(start_date = Sys.Date() -30 , end_date = Sys.Date(), base = 'USD', to = "HUF")
head(df)
```

    ##         date    value
    ## 1 2021-10-17 309.8468
    ## 2 2021-10-18 311.5191
    ## 3 2021-10-19 311.1388
    ## 4 2021-10-20 310.6663
    ## 5 2021-10-21 313.1650
    ## 6 2021-10-22 313.1058

Nasdaq data
===========

<https://www.nasdaq.com/market-activity/stocks/screener>

``` r
t <- fromJSON('https://api.nasdaq.com/api/screener/stocks?tableonly=true&limit=25&offset=150')
t$data$table$rows[1:5]
```

    ##    symbol                                                          name
    ## 1     ENB                                     Enbridge Inc Common Stock
    ## 2     CME                           CME Group Inc. Class A Common Stock
    ## 3     BTI British American Tobacco  Industries, p.l.c. Common Stock ADR
    ## 4     BNS                Bank Nova Scotia Halifax Pfd 3 Ordinary Shares
    ## 5     CCI          Crown Castle International Corp. (REIT) Common Stock
    ## 6    LCID                                Lucid Group, Inc. Common Stock
    ## 7      ZM          Zoom Video Communications, Inc. Class A Common Stock
    ## 8       F                               Ford Motor Company Common Stock
    ## 9     CSX                                  CSX Corporation Common Stock
    ## 10    DUK        Duke Energy Corporation (Holding Company) Common Stock
    ## 11    ICE                   Intercontinental Exchange Inc. Common Stock
    ## 12    ITW                         Illinois Tool Works Inc. Common Stock
    ## 13   MELI                               MercadoLibre, Inc. Common Stock
    ## 14    HCA                             HCA Healthcare, Inc. Common Stock
    ## 15   WDAY                            Workday, Inc. Class A Common Stock
    ## 16    MCO                              Moody's Corporation Common Stock
    ## 17     EW                 Edwards Lifesciences Corporation Common Stock
    ## 18     CI                                Cigna Corporation Common Stock
    ## 19   ADSK                                   Autodesk, Inc. Common Stock
    ## 20   MUFG             Mitsubishi UFJ Financial Group, Inc. Common Stock
    ## 21    BMO                                 Bank Of Montreal Common Stock
    ## 22   EQIX                               Equinix, Inc. Common Stock REIT
    ## 23    IBN                               ICICI Bank Limited Common Stock
    ## 24    BDX                    Becton, Dickinson and Company Common Stock
    ## 25    ABB                                          ABB Ltd Common Stock
    ##     lastsale netchange pctchange
    ## 1     $40.39     -0.04   -0.099%
    ## 2    $226.80      0.12    0.053%
    ## 3     $35.24     -0.17    -0.48%
    ## 4     $65.95     -0.31   -0.468%
    ## 5    $183.23      0.45    0.246%
    ## 6     $48.71      3.83    8.534%
    ## 7    $264.22      0.51    0.193%
    ## 8     $19.62     -0.24   -1.208%
    ## 9     $35.27      0.08    0.227%
    ## 10   $100.15     -0.45   -0.447%
    ## 11   $135.98      0.69     0.51%
    ## 12   $242.35      3.33    1.393%
    ## 13  $1526.62   -106.59   -6.526%
    ## 14   $242.74      0.18    0.074%
    ## 15 $301.1665    5.5665    1.883%
    ## 16  $397.805     7.025    1.798%
    ## 17   $117.67      0.98     0.84%
    ## 18   $219.63      4.10    1.902%
    ## 19   $330.52      4.13    1.265%
    ## 20     $5.66     -0.11   -1.906%
    ## 21   $111.37     -0.70   -0.625%
    ## 22   $799.32      4.35    0.547%
    ## 23    $20.30     -0.22   -1.072%
    ## 24   $244.24      0.56     0.23%
    ## 25    $35.09      0.21    0.602%

Task forbes
===========

Find the json when you load this page: <https://www.forbes.com/lists/global2000/>
