-   [Coingecko api](#coingecko-api)
-   [Tradingview](#tradingview)
-   [Eu fundings](#eu-fundings)
-   [Task forbes](#task-forbes)

``` r
library(rvest)
library(data.table)
library(jsonlite)
library(httr)
```

Coingecko api
=============

``` r
head(get_all_data())
```

    ##      id         name symbol         slug num_market_pairs
    ## 1:    1      Bitcoin    BTC      bitcoin             8317
    ## 2: 1027     Ethereum    ETH     ethereum             4667
    ## 3: 1839 Binance Coin    BNB binance-coin              562
    ## 4:  825       Tether   USDT       tether            19984
    ## 5: 5426       Solana    SOL       solana              189
    ## 6: 2010      Cardano    ADA      cardano              304
    ##                  date_added
    ## 1: 2013-04-28T00:00:00.000Z
    ## 2: 2015-08-07T00:00:00.000Z
    ## 3: 2017-07-25T00:00:00.000Z
    ## 4: 2015-02-25T00:00:00.000Z
    ## 5: 2020-04-10T00:00:00.000Z
    ## 6: 2017-10-01T00:00:00.000Z
    ##                                                                                                            tags
    ## 1:                            mineable,pow,sha-256,store-of-value,state-channel,coinbase-ventures-portfolio,...
    ## 2:          mineable,pow,smart-contracts,ethereum-ecosystem,binance-smart-chain,coinbase-ventures-portfolio,...
    ## 3: marketplace,centralized-exchange,payments,smart-contracts,binance-smart-chain,alameda-research-portfolio,...
    ## 4:         payments,stablecoin,asset-backed-stablecoin,binance-smart-chain,avalanche-ecosystem,solana-ecosystem
    ## 5:          pos,platform,solana-ecosystem,cms-holdings-portfolio,kinetic-capital,alameda-research-portfolio,...
    ## 6:                                                      mineable,dpos,pos,platform,research,smart-contracts,...
    ##     max_supply circulating_supply total_supply platform.id platform.name
    ## 1:    21000000           18880212     18880212          NA          <NA>
    ## 2:          NA          118443751    118443751          NA          <NA>
    ## 3:   166801148          166801148    166801148          NA          <NA>
    ## 4:          NA        73086543702  76357051672        1027      Ethereum
    ## 5:          NA          303778219    509600041          NA          <NA>
    ## 6: 45000000000        33313246915  33719282563          NA          <NA>
    ##    platform.symbol platform.slug
    ## 1:            <NA>          <NA>
    ## 2:            <NA>          <NA>
    ## 3:            <NA>          <NA>
    ## 4:             ETH      ethereum
    ## 5:            <NA>          <NA>
    ## 6:            <NA>          <NA>
    ##                        platform.token_address cmc_rank
    ## 1:                                       <NA>        1
    ## 2:                                       <NA>        2
    ## 3:                                       <NA>        3
    ## 4: 0xdac17f958d2ee523a2206206994597c13d831ec7        4
    ## 5:                                       <NA>        5
    ## 6:                                       <NA>        6
    ##                last_updated quote.USD.price quote.USD.volume_24h
    ## 1: 2021-11-22T12:43:02.000Z    57389.008471          31449596068
    ## 2: 2021-11-22T12:43:03.000Z     4191.978871          17018355947
    ## 3: 2021-11-22T12:42:23.000Z      572.621625           2151503039
    ## 4: 2021-11-22T12:42:24.000Z        1.000113          77567476661
    ## 5: 2021-11-22T12:42:05.000Z      219.994007           3492302176
    ## 6: 2021-11-22T12:42:25.000Z        1.806605           1478531465
    ##    quote.USD.volume_change_24h quote.USD.percent_change_1h
    ## 1:                     20.7674                 -0.23715240
    ## 2:                     22.3144                 -0.21370051
    ## 3:                     -4.4674                 -0.07017586
    ## 4:                     11.9596                 -0.06899594
    ## 5:                    102.2800                 -0.57912543
    ## 6:                      0.8331                 -0.36079031
    ##    quote.USD.percent_change_24h quote.USD.percent_change_7d
    ## 1:                  -2.70838692                -12.80777309
    ## 2:                  -3.11851987                -11.40420836
    ## 3:                  -1.88245213                -11.19157365
    ## 4:                  -0.05290613                 -0.05165106
    ## 5:                   3.22164436                -10.19095899
    ## 6:                  -3.49338293                -12.38018488
    ##    quote.USD.percent_change_30d quote.USD.percent_change_60d
    ## 1:                  -6.94539495                  30.84651980
    ## 2:                   3.68103253                  35.56097807
    ## 3:                  18.60430337                  52.95645670
    ## 4:                  -0.00773223                  -0.07945279
    ## 5:                   8.88576122                  50.31741657
    ## 6:                 -16.35398840                 -18.52410203
    ##    quote.USD.percent_change_90d quote.USD.market_cap
    ## 1:                  16.60892625         1.083517e+12
    ## 2:                  26.62347746         4.965137e+11
    ## 3:                  16.98734783         9.551394e+10
    ## 4:                  -0.06856015         7.309481e+10
    ## 5:                 186.91831198         6.682939e+10
    ## 6:                 -36.70206238         6.018388e+10
    ##    quote.USD.market_cap_dominance quote.USD.fully_diluted_market_cap
    ## 1:                        41.9508                       1.205169e+12
    ## 2:                        19.1991                       4.965137e+11
    ## 3:                         3.6933                       9.551394e+10
    ## 4:                         2.8361                       7.636569e+10
    ## 5:                         2.5906                       1.121090e+11
    ## 6:                         2.3330                       8.129722e+10
    ##      quote.USD.last_updated
    ## 1: 2021-11-22T12:43:02.000Z
    ## 2: 2021-11-22T12:43:03.000Z
    ## 3: 2021-11-22T12:42:23.000Z
    ## 4: 2021-11-22T12:42:24.000Z
    ## 5: 2021-11-22T12:42:05.000Z
    ## 6: 2021-11-22T12:42:25.000Z

Tradingview
===========

``` r
head(trd('{"filter":[{"left":"market_cap_basic","operation":"nempty"},{"left":"type","operation":"in_range","right":["stock","dr","fund"]},{"left":"subtype","operation":"in_range","right":["common","","etf","unit","mutual","money","reit","trust"]},{"left":"exchange","operation":"in_range","right":["AMEX","NASDAQ","NYSE"]}],"options":{"lang":"en"},"symbols":{"query":{"types":[]},"tickers":[]},"columns":["logoid","name","close","change","change_abs","Recommend.All","volume","market_cap_basic","price_earnings_ttm","earnings_per_share_basic_ttm","number_of_employees","industry","sector","SMA50","SMA100","SMA200","RSI","Perf.Y","Perf.3M","Perf.6M","Perf.1M","Perf.W","High.3M","High.6M","price_52_week_high","description","name","type","subtype","update_mode","pricescale","minmov","fractional","minmove2","SMA50","close","SMA100","SMA200","RSI","RSI[1]"],"sort":{"sortBy":"market_cap_basic","sortOrder":"desc"},"range":[0,100]}'))
```

    ##    exchange    logoid  name   close      change change_abs Recommend.All
    ## 1:   NASDAQ     apple  AAPL  160.55  1.69759929       2.68    0.51212121
    ## 2:   NASDAQ microsoft  MSFT  343.11  0.53916254       1.84    0.42121212
    ## 3:   NASDAQ  alphabet GOOGL 2978.53 -0.60865532     -18.24           0.4
    ## 4:   NASDAQ  alphabet  GOOG 2999.05 -0.50196073     -15.13           0.4
    ## 5:   NASDAQ    amazon  AMZN 3676.57 -0.52731828     -19.49    0.37575758
    ## 6:   NASDAQ     tesla  TSLA 1137.06  3.71039238      40.68    0.51212121
    ##       volume market_cap_basic price_earnings_ttm
    ## 1: 117305089    2634047005635        28.15537444
    ## 2:  21963302    2576063068653        38.14905485
    ## 3:   1684969    1983693493039        28.86188571
    ## 4:    989148    1983693493039        29.02956139
    ## 5:   4946173    1864563736127        72.27110611
    ## 6:  21642156    1141909497599       354.99935242
    ##    earnings_per_share_basic_ttm number_of_employees
    ## 1:                       5.6625              154000
    ## 2:                       9.0128              181000
    ## 3:                     105.3074              135301
    ## 4:                     105.3074              135301
    ## 5:                      52.0986             1298000
    ## 6:                       3.5344               70757
    ##                        industry                sector     SMA50    SMA100
    ## 1: Telecommunications Equipment Electronic Technology  147.3724  147.5176
    ## 2:            Packaged Software   Technology Services   311.045  300.3618
    ## 3:   Internet Software/Services   Technology Services 2846.6236 2773.0235
    ## 4:   Internet Software/Services   Technology Services  2856.411 2799.4546
    ## 5:              Internet Retail          Retail Trade 3402.8934 3433.7326
    ## 6:               Motor Vehicles     Consumer Durables   917.374  804.2385
    ##        SMA200         RSI       Perf.Y     Perf.3M     Perf.6M     Perf.1M
    ## 1:  137.69755 74.83089134  36.82461224  8.34064377  27.9996811  7.56398231
    ## 2: 273.895425 75.17589845  63.08284614 12.73163359 39.94779133 11.61315507
    ## 3: 2503.26675 59.10600791  71.53676039  8.36574389 29.83265988  5.04870599
    ## 4:  2533.6532 60.65315444  72.14253325  8.31822417 27.88580444  5.29263069
    ## 5: 3343.24645 66.76692232  18.62199135 14.89460773  14.7823345  7.65755214
    ## 6:  736.90595 62.27820485 132.23790364 67.15079528 95.74783088 31.33056133
    ##         Perf.W  High.3M   High.6M price_52_week_high           description
    ## 1:  7.04046936   161.02    161.02             161.02            Apple Inc.
    ## 2:  1.89771917    345.1     345.1              345.1 Microsoft Corporation
    ## 3:  0.16713972  3019.33   3019.33            3019.33         Alphabet Inc.
    ## 4:  0.20515151     3037      3037               3037         Alphabet Inc.
    ## 5:  4.29542005 3762.145 3773.0782          3773.0782      Amazon.com, Inc.
    ## 6: 10.02883629  1243.49   1243.49            1243.49           Tesla, Inc.
    ##     name  type subtype           update_mode pricescale minmov fractional
    ## 1:  AAPL stock  common delayed_streaming_900        100      1      false
    ## 2:  MSFT stock  common delayed_streaming_900        100      1      false
    ## 3: GOOGL stock  common delayed_streaming_900        100      1      false
    ## 4:  GOOG stock  common delayed_streaming_900        100      1      false
    ## 5:  AMZN stock  common delayed_streaming_900        100      1      false
    ## 6:  TSLA stock  common delayed_streaming_900        100      1      false
    ##    minmove2     SMA50   close    SMA100     SMA200         RSI      RSI[1]
    ## 1:        0  147.3724  160.55  147.5176  137.69755 74.83089134 71.29629081
    ## 2:        0   311.045  343.11  300.3618 273.895425 75.17589845 73.80358985
    ## 3:        0 2846.6236 2978.53 2773.0235 2503.26675 59.10600791 61.97945149
    ## 4:        0  2856.411 2999.05 2799.4546  2533.6532 60.65315444 63.22265057
    ## 5:        0 3402.8934 3676.57 3433.7326 3343.24645 66.76692232 68.86883011
    ## 6:        0   917.374 1137.06  804.2385  736.90595 62.27820485 58.56232194

Eu fundings
===========

``` r
# POST demo
# eu fundings demo
# open the site: https://www.palyazat.gov.hu/tamogatott_projektkereso
# click to next page, find the data source 
# show with terminal

head(my_data)
```

    ##   fejlesztesi_program_nev forras kiiras_eve op_kod
    ## 1          Széchenyi 2020   ESZA         NA   EFOP
    ## 2          Széchenyi 2020   ESZA         NA   EFOP
    ## 3          Széchenyi 2020   ESZA         NA   EFOP
    ## 4          Széchenyi 2020   ESZA         NA   EFOP
    ## 5          Széchenyi 2020   ESZA         NA   EFOP
    ## 6          Széchenyi 2020   ESZA         NA   EFOP
    ##                                                  konstrukcio_nev
    ## 1                 Megváltozott munkaképességű emberek támogatása
    ## 2 Nő az esély - képzés és foglalkoztatás felhívás megjelentetése
    ## 3                                   Nő az esély – foglalkoztatás
    ## 4                                   Nő az esély – foglalkoztatás
    ## 5                                   Nő az esély – foglalkoztatás
    ## 6                                   Nő az esély – foglalkoztatás
    ##   konstrukcio_kod
    ## 1   EFOP-1.1.1-15
    ## 2   EFOP-1.1.2-16
    ## 3   EFOP-1.1.3-17
    ## 4   EFOP-1.1.3-17
    ## 5   EFOP-1.1.3-17
    ## 6   EFOP-1.1.3-17
    ##                                                  palyazo_neve
    ## 1                 NEMZETI REHABILITÁCIÓS ÉS SZOCIÁLIS HIVATAL
    ## 2                   SZOCIÁLIS ÉS GYERMEKVÉDELMI FŐIGAZGATÓSÁG
    ## 3                         "Fogjunk Össze" Közhasznú Egyesület
    ## 4 "Rózsakert" Gondoskodás az Egészséges Életmódért Alapítvány
    ## 5                                        Bababirtok Egyesület
    ## 6                             Békéscsabai Tankerületi Központ
    ##                                                                                                projekt_cime
    ## 1                                                            Megváltozott munkaképességű emberek támogatása
    ## 2                                                                    Nő az esély - képzés és foglalkoztatás
    ## 3 Adjuk meg az esélyt azon nőnek ki a segítő területet hivatásának érzi és ezen a pályán képzeli el jövőjét
    ## 4                                     Foglalkoztatás növelése a Rózsakert Alapítvány Gondozási Központjában
    ## 5                             "Adj esélyt" - A Bababirtok Egyesület társadalmi befogadást erősítő programja
    ## 6                                Nő az esély-foglalkoztatás a békéscsabai Szent László Általános Iskolában 
    ##     megval_regio_nev megval_megye_nev kisterseg_nev helyseg_nev
    ## 1 Közép-Magyarország         Budapest      Budapest    Budapest
    ## 2 Közép-Magyarország         Budapest      Budapest    Budapest
    ## 3         Dél-Alföld            Békés        Békési  Mezőberény
    ## 4         Dél-Alföld            Békés      Szarvasi    Kondoros
    ## 5         Dél-Alföld      Bács-Kiskun         Bajai        Baja
    ## 6         Dél-Alföld            Békés   Békéscsabai  Békéscsaba
    ##   tam_dont_datum megitelt_tamogatas id_palyazat                load_date
    ## 1     2016.02.02        16965294850   248150201 2021-11-22T02:12:12.000Z
    ## 2     2017.01.31         8620286516  1060520201 2021-11-22T02:12:12.000Z
    ## 3     2017.12.04            6865524  1618580201 2021-11-22T02:12:12.000Z
    ## 4     2017.12.04           20762709  1641690201 2021-11-22T02:12:12.000Z
    ## 5     2017.12.04            8681462  1612540201 2021-11-22T02:12:12.000Z
    ## 6     2017.12.04           11377513  1637350201 2021-11-22T02:12:12.000Z
    ##     jaras_nev
    ## 1    Budapest
    ## 2    Budapest
    ## 3      Békési
    ## 4    Szarvasi
    ## 5       Bajai
    ## 6 Békéscsabai

Task forbes
===========

Find the json when you load this page: <https://www.forbes.com/lists/global2000/>

    ## No encoding supplied: defaulting to UTF-8.

    ## [1] "\n<!doctype html>\n<html lang=\"en\">\n\t<head>\n\t\t<meta http-equiv=\"Content-Language\" content=\"en_US\">\n\n\t\t<script type=\"text/javascript\">\n\t\t\t(function () {\n\t\t\t\tfunction isValidUrl(toURL) {\n\t\t\t\t\t// Regex taken from welcome ad.\n\t\t\t\t\treturn (toURL || '').match(/^(?:https?:?\\/\\/)?(?:[^.(){}\\\\\\/]*)?\\.?forbes\\.com(?:\\/|\\?|$)/i);\n\t\t\t\t}\n\n\t\t\t\tfunction getUrlParameter(name) {\n\t\t\t\t\tname = name.replace(/[\\[]/, '\\\\[').replace(/[\\]]/, '\\\\]');\n\t\t\t\t\tvar regex = new RegExp('[\\\\?&]' + name + '=([^&#]*)');\n\t\t\t\t\tvar results = regex.exec(location.search);\n\t\t\t\t\treturn results === null ? '' : decodeURIComponent(results[1].replace(/\\+/g, ' '));\n\t\t\t\t};\n\n\t\t\t\tfunction consentIsSet(message) {\n\t\t\t\t\tconsole.log(message);\n\t\t\t\t\tvar result = JSON.parse(message.data);\n\t\t\t\t\tif(result.message == \"submit_preferences\"){\n\t\t\t\t\t\tvar toURL = getUrlParameter(\"toURL\");\n\t\t\t\t\t\tif(!isValidUrl(toURL)){\n\t\t\t\t\t\t\ttoURL = \"https://www.forbes.com/\";\n\t\t\t\t\t\t}\n\t\t\t\t\t\tlocation.href=toURL;\n\t\t\t\t\t}\n\t\t\t\t}\n\n\t\t\t\tvar apiObject = {\n\t\t\t\t\tPrivacyManagerAPI:\n\t\t\t\t\t{\n\t\t\t\t\t\taction: \"getConsent\",\n\t\t\t\t\t\ttimestamp: new Date().getTime(),\n\t\t\t\t\t\tself: \"forbes.com\"\n\t\t\t\t\t}\n\t\t\t\t};\n\t\t\t\tvar json = JSON.stringify(apiObject);\n\t\t\t\twindow.top.postMessage(json,\"*\");\n\t\t\t\twindow.addEventListener(\"message\", consentIsSet, false);\n\t\t\t})();\n\t\t</script>\n\n\t\t<script>\n\t\t\t(function () {\n\t\t\t\tvar makeStub = function () {\n\t\t\t\t\tvar TCF_LOCATOR_NAME = '__tcfapiLocator';\n\t\t\t\t\tvar TCF_LOCATOR_ID = '__tcfapiTrustarc';\n\t\t\t\t\tvar win = window;\n\t\t\t\t\tvar queue = [];\n\t\t\t\t\tvar cmpFrame;\n\t\t\t\t\tfunction addFrame() {\n\t\t\t\t\t\tvar doc = win.document;\n\t\t\t\t\t\tvar otherCMP = !!(win.frames[TCF_LOCATOR_NAME]);\n\t\t\t\t\t\tif (!otherCMP) {\n\t\t\t\t\t\t\tif (doc.body) {\n\t\t\t\t\t\t\t\tvar iframe = doc.createElement('iframe');\n\t\t\t\t\t\t\t\tiframe.name = TCF_LOCATOR_NAME;\n\t\t\t\t\t\t\t\tiframe.style.display = 'none';\n\t\t\t\t\t\t\t\tiframe.id = TCF_LOCATOR_ID;\n\t\t\t\t\t\t\t\tiframe.src = 'https://trustarc.mgr.consensu.org/asset/cmpcookie.v2.html';\n\t\t\t\t\t\t\t\tdoc.body.appendChild(iframe);\n\t\t\t\t\t\t\t} else {\n\t\t\t\t\t\t\t\tsetTimeout(addFrame, 5);\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t}\n\t\t\t\t\t\treturn !otherCMP;\n\t\t\t\t\t}\n\t\t\t\t\tfunction tcfAPIHandler() {\n\t\t\t\t\t\tvar args = arguments;\n\t\t\t\t\t\tvar gdprApplies;\n\t\t\t\t\t\tif (!args.length) {\n\t\t\t\t\t\t\t/**\n\t\t\t\t\t\t\t* shortcut to get the queue when the full CMP\n\t\t\t\t\t\t\t* implementation loads; it can call tcfapiHandler()\n\t\t\t\t\t\t\t* with no arguments to get the queued arguments\n\t\t\t\t\t\t\t*/\n\t\t\t\t\t\t\treturn queue;\n\t\t\t\t\t\t} else if (args[0] === 'setGdprApplies') {\n\t\t\t\t\t\t\t/**\n\t\t\t\t\t\t\t* shortcut to set gdprApplies if the publisher\n\t\t\t\t\t\t\t* knows that they apply GDPR rules to all\n\t\t\t\t\t\t\t* traffic (see the section on \"What does the\n\t\t\t\t\t\t\t* gdprApplies value mean\" for more\n\t\t\t\t\t\t\t*/\n\t\t\t\t\t\t\tif (args.length > 3 && parseInt(args[1], 10) === 2 && typeof args[3] === 'boolean') {\n\t\t\t\t\t\t\t\tgdprApplies = args[3];\n\t\t\t\t\t\t\t\tif (typeof args[2] === 'function') {\n\t\t\t\t\t\t\t\t\targs[2]('set', true);\n\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t} else if (args[0] === 'ping') {\n\t\t\t\t\t\t\t/**\n\t\t\t\t\t\t\t* Only supported method; give PingReturn\n\t\t\t\t\t\t\t* object as response\n\t\t\t\t\t\t\t*/\n\t\t\t\t\t\t\tvar retr = {\n\t\t\t\t\t\t\t\tgdprApplies: gdprApplies,\n\t\t\t\t\t\t\t\tcmpLoaded: false,\n\t\t\t\t\t\t\t\tcmpStatus: 'stubCMP',\n\t\t\t\t\t\t\t\tapiVersion: '2.0'\n\t\t\t\t\t\t\t};\n\t\t\t\t\t\t\tif (typeof args[2] === 'function') {\n\t\t\t\t\t\t\t\targs[2](retr, true);\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t} else {\n\t\t\t\t\t\t\t/**\n\t\t\t\t\t\t\t* some other method, just queue it for the\n\t\t\t\t\t\t\t* full CMP implementation to deal with\n\t\t\t\t\t\t\t*/\n\t\t\t\t\t\t\tqueue.push(args);\n\t\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t\t\t\tfunction postMessageEventHandler(event) {\n\t\t\t\t\t\tvar msgIsString = typeof event.data === 'string';\n\t\t\t\t\t\tvar json = {};\n\t\t\t\t\t\ttry {\n\t\t\t\t\t\t\t/**\n\t\t\t\t\t\t\t* Try to parse the data from the event.  This is important\n\t\t\t\t\t\t\t* to have in a try/catch because often messages may come\n\t\t\t\t\t\t\t* through that are not JSON\n\t\t\t\t\t\t\t*/\n\t\t\t\t\t\t\tif (msgIsString) {\n\t\t\t\t\t\t\t\tjson = JSON.parse(event.data);\n\t\t\t\t\t\t\t} else {\n\t\t\t\t\t\t\t\tjson = event.data;\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t} catch (ignore) {}\n\t\t\t\t\t\tvar payload = json.__tcfapiCall;\n\t\t\t\t\t\tif (payload) {\n\t\t\t\t\t\t\twindow.__tcfapi(\n\t\t\t\t\t\t\t\tpayload.command,\n\t\t\t\t\t\t\t\tpayload.version,\n\t\t\t\t\t\t\t\tfunction (retValue, success) {\n\t\t\t\t\t\t\t\t\tvar returnMsg = {\n\t\t\t\t\t\t\t\t\t\t__tcfapiReturn: {\n\t\t\t\t\t\t\t\t\t\t\treturnValue: retValue,\n\t\t\t\t\t\t\t\t\t\t\tsuccess: success,\n\t\t\t\t\t\t\t\t\t\t\tcallId: payload.callId,\n\t\t\t\t\t\t\t\t\t\t},\n\t\t\t\t\t\t\t\t\t};\n\t\t\t\t\t\t\t\t\tif (msgIsString) {\n\t\t\t\t\t\t\t\t\t\treturnMsg = JSON.stringify(returnMsg);\n\t\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t\t\tevent.source.postMessage(returnMsg, '*');\n\t\t\t\t\t\t\t\t},\n\t\t\t\t\t\t\t\tpayload.parameter\n\t\t\t\t\t\t\t);\n\t\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t\t\t\t/**\n\t\t\t\t\t* Iterate up to the top window checking for an already-created\n\t\t\t\t\t* \"__tcfapilLocator\" frame on every level. If one exists already then we are\n\t\t\t\t\t* not the master CMP and will not queue commands.\n\t\t\t\t\t*/\n\t\t\t\t\twhile (win) {\n\t\t\t\t\t\ttry {\n\t\t\t\t\t\t\tif (win.frames[TCF_LOCATOR_NAME]) {\n\t\t\t\t\t\t\t\tcmpFrame = win;\n\t\t\t\t\t\t\t\tbreak;\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t} catch (ignore) {}\n\t\t\t\t\t\t// if we're at the top and no cmpFrame\n\t\t\t\t\t\tif (win === window.top) {\n\t\t\t\t\t\t\tbreak;\n\t\t\t\t\t\t}\n\t\t\t\t\t\t// Move up\n\t\t\t\t\t\twin = win.parent;\n\t\t\t\t\t}\n\t\t\t\t\tif (!cmpFrame) {\n\t\t\t\t\t\t// we have recur'd up the windows and have found no __tcfapiLocator frame\n\t\t\t\t\t\taddFrame();\n\t\t\t\t\t\twin.__tcfapi = tcfAPIHandler;\n\t\t\t\t\t\twin.addEventListener('message', postMessageEventHandler, false);\n\t\t\t\t\t}\n\t\t\t\t};\n\t\t\t\tmakeStub();\n\t\t\t}());\n\t\t</script>\n\t</head>\n\t<div id='consent_blackbar'></div>\n\t<div id='teconsent'>\n\t\t<script async=\"async\" type=\"text/javascript\" crossorigin src='//consent.trustarc.com/notice?domain=forbes_iab2.com&c=teconsent&js=nj&noticeType=bb&gtm=1'></script>\n\t</div>\n\t<body>\n\t</body>\n</html>\n"

    ##          name year month                                    uri
    ## 1 Global 2000 2021     5                                   icbc
    ## 2 Global 2000 2021     5                         jpmorgan-chase
    ## 3 Global 2000 2021     5                     berkshire-hathaway
    ## 4 Global 2000 2021     5                china-construction-bank
    ## 5 Global 2000 2021     5 saudi-arabian-oil-company-saudi-aramco
    ## 6 Global 2000 2021     5                                  apple
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         description
    ## 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   Industrial & Commercial Bank of China Ltd. engages in the provision of commercial banking and financial services. It operates through the following business segments: Corporate Banking, Personal Banking, Treasury Operations, and Others. The Corporate Banking segment provides corporate loans, trade financing, deposit-taking activities, corporate wealth management services, custody activities, and various types of corporate intermediary services to corporations, government agencies and financial institutions. The Personal Banking segment offers personal loans, deposit-taking activities, card business, personal wealth management services, and various types of personal intermediary services to individual customers. The Treasury Operations segment issues money market transactions, investment securities, foreign exchange transactions and the holding of derivative positions, for its own account or on behalf of customers. The Others segment includes assets, liabilities, income, and expenses that cannot be allocated to a segment. The company was founded on January 1, 1984 and is headquartered in Beijing, China.
    ## 2                                                                              JPMorgan Chase & Co. is a financial holding company. It provides financial and investment banking services. The firm offers a range of investment banking products and services in all capital markets, including advising on corporate strategy and structure, capital raising in equity and debt markets, risk management, market making in cash securities and derivative instruments, and brokerage and research. It operates through the following segments: Consumer and Community Banking, Corporate and Investment Bank, Commercial Banking and Asset and Wealth Management. The Consumer and Community Banking segment serves consumers and businesses through personal service at bank branches and through automated teller machine, online, mobile, and telephone banking. The Corporate and Investment Bank segment offers a suite of investment banking, market-making, prime brokerage, and treasury and securities products and services to a global client base of corporations, investors, financial institutions, government and municipal entities. The Commercial Banking segment delivers services to U.S. and its multinational clients, including corporations, municipalities, financial institutions, and non profit entities. It also provides financing to real estate investors and owners as well as financial solutions, including lending, treasury services, investment banking, and asset management. The Asset and Wealth Management segment provides asset and wealth management services. The company was founded in 1968 and is headquartered in New York, NY.
    ## 3 Berkshire Hathaway, Inc. provides property and casualty insurance and reinsurance, utilities and energy, freight rail transportation, finance, manufacturing, retailing, and services. It operates through following segments: GEICO, Berkshire Hathaway Reinsurance Group, Berkshire Hathaway Primary Group, Burlington Northern Santa Fe, LLC (BNSF), Berkshire Hathaway Energy, McLane Company, Manufacturing, and Service and Retailing. The GEICO segments involves in underwriting private passenger automobile insurance mainly by direct response methods. The Berkshire Hathaway Reinsurance Group segment consists of underwriting excess-of-loss and quota-share and facultative reinsurance worldwide. The Berkshire Hathaway Primary Group segment comprises of underwriting multiple lines of property and casualty insurance policies for primarily commercial accounts. The BNSF segment operates railroad systems in North America. The Berkshire Hathaway Energy segments deals with regulated electric and gas utility, including power generation and distribution activities, and real estate brokerage activities. The McLane Company segment offers wholesale distribution of groceries and non-food items. The Manufacturing segment includes industrial and end-user products, building products, and apparel. The Service and Retailing segment provides fractional aircraft ownership programs, aviation pilot training, electronic components distribution, and various retailing businesses, including automobile dealerships, and trailer and furniture leasing. The company was founded by Oliver Chace in 1839 and is headquartered in Omaha, NE.
    ## 4                                                                                                                                                                                                                                                                                                                                                                                                China Construction Bank Corp. engages in the provision of a wide range of financial services to corporate and personal customers. It operates through the following business segments: Corporate Banking, Personal Banking, Treasury, and Others. The Corporate Banking segment provides a range of financial products and services to corporations, government agencies and financial institutions, which comprises of corporate loans, trade financing, deposit taking and wealth management services, agency services, financial consulting and advisory services, cash management services, remittance and settlement services, custody services, and guarantee services. The Personal Banking segment provides personal loans, deposit taking  and wealth management services, card business, remittance services, and agency services to individual customers. The Treasury segment represents inter-bank money market transactions, repurchase and resale transactions, investments in debt securities, and trade of derivatives and foreign currency. The Others segment refers to equity investments and revenues, results, assets and liabilities of overseas branches and subsidiaries. The company was founded in October 1954 and is headquartered in Beijing, China.
    ## 5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Saudi Arabian Oil Co. engages in the exploration, production, transportation, and sale of crude oil and natural gas. It operates through the following segments: Upstream, Downstream, and Corporate. The Upstream segment includes crude oil, natural gas and natural gas liquids exploration, field development, and production. The Downstream segment focuses on refining, logistics, power generation, and the marketing of crude oil, petroleum and petrochemical products, and related services to international and domestic customers. The Corporate segment offers supporting services including human resources, finance, and information technology. The company was founded on May 29, 1933 and is headquartered in Dhahran, Saudi Arabia.
    ## 6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Apple, Inc. engages in the design, manufacture, and sale of smartphones, personal computers, tablets, wearables and accessories, and other variety of related services. It operates through the following geographical segments: Americas, Europe, Greater China, Japan, and Rest of Asia Pacific. The Americas segment includes North and South America. The Europe segment consists of European countries, as well as India, the Middle East, and Africa. The Greater China segment comprises of China, Hong Kong, and Taiwan. The Rest of Asia Pacific segment includes Australia and Asian countries. Its products and services include iPhone, Mac, iPad, AirPods, Apple TV, Apple Watch, Beats products, Apple Care, iCloud, digital content stores, streaming, and licensing services. The company was founded by Steven Paul Jobs, Ronald Gerald Wayne, and Stephen G. Wozniak on April 1, 1976 and is headquartered in Cupertino, CA.
    ##   rank    listUri                        organization.name
    ## 1    1 global2000                                     ICBC
    ## 2    2 global2000                           JPMorgan Chase
    ## 3    3 global2000                       Berkshire Hathaway
    ## 4    4 global2000                  China Construction Bank
    ## 5    5 global2000 Saudi Arabian Oil Company (Saudi Aramco)
    ## 6    6 global2000                                    Apple
    ##                         organization.uri organization.imageExists
    ## 1                                   icbc                     TRUE
    ## 2                         jpmorgan-chase                     TRUE
    ## 3                     berkshire-hathaway                     TRUE
    ## 4                china-construction-bank                     TRUE
    ## 5 saudi-arabian-oil-company-saudi-aramco                    FALSE
    ## 6                                  apple                     TRUE
    ##                                                                                  organization.image
    ## 1                                   http://images.forbes.com/media/lists/companies/icbc_416x416.jpg
    ## 2                         http://images.forbes.com/media/lists/companies/jpmorgan-chase_416x416.jpg
    ## 3                     http://images.forbes.com/media/lists/companies/berkshire-hathaway_416x416.jpg
    ## 4                http://images.forbes.com/media/lists/companies/china-construction-bank_416x416.jpg
    ## 5 http://images.forbes.com/media/lists/companies/saudi-arabian-oil-company-saudi-aramco_416x416.jpg
    ## 6                                  http://images.forbes.com/media/lists/companies/apple_416x416.jpg
    ##                                                                                                                    organization.squareImage
    ## 1                                                                                                                                      <NA>
    ## 2                                                                                                                                      <NA>
    ## 3                                                                                                                                      <NA>
    ## 4                                                                                                                                      <NA>
    ## 5                                                                                                                                      <NA>
    ## 6 //specials-images.forbesimg.com/imageserve/5c13d14731358e5b4339c564/416x416.jpg?background=000000&cropX1=0&cropX2=416&cropY1=0&cropY2=416
    ##   visible position                         organizationName    timestamp
    ## 1    TRUE        1                                     ICBC 1.620684e+12
    ## 2    TRUE        2                           JPMorgan Chase 1.620684e+12
    ## 3    TRUE        3                       Berkshire Hathaway 1.620684e+12
    ## 4    TRUE        4                  China Construction Bank 1.620684e+12
    ## 5    TRUE        5 Saudi Arabian Oil Company (Saudi Aramco) 1.620684e+12
    ## 6    TRUE        6                                    Apple 1.620684e+12
    ##   version                      naturalId imageExists
    ## 1       1   fred/companies/F2K/2021/2176        TRUE
    ## 2       1   fred/companies/F2K/2021/2370        TRUE
    ## 3       1    fred/companies/F2K/2021/595        TRUE
    ## 4       1    fred/companies/F2K/2021/907        TRUE
    ## 5       1 fred/companies/F2K/2021/111716       FALSE
    ## 6       1    fred/companies/F2K/2021/280        TRUE
    ##                                                                                               image
    ## 1                                   http://images.forbes.com/media/lists/companies/icbc_416x416.jpg
    ## 2                         http://images.forbes.com/media/lists/companies/jpmorgan-chase_416x416.jpg
    ## 3                     http://images.forbes.com/media/lists/companies/berkshire-hathaway_416x416.jpg
    ## 4                http://images.forbes.com/media/lists/companies/china-construction-bank_416x416.jpg
    ## 5 http://images.forbes.com/media/lists/companies/saudi-arabian-oil-company-saudi-aramco_416x416.jpg
    ## 6                                  http://images.forbes.com/media/lists/companies/apple_416x416.jpg
    ##                          industry       country revenue profits  assets
    ## 1                         Banking         China  190467 45768.7 4914670
    ## 2          Diversified Financials United States  136187 40371.0 3689336
    ## 3          Diversified Financials United States  245510 42521.0  873729
    ## 4                         Banking         China  173478 39299.2 4301700
    ## 5            Oil & Gas Operations  Saudi Arabia  229747 49282.8  510252
    ## 6 Technology Hardware & Equipment United States  293971 63930.0  354054
    ##   marketValue profitsRank assetsRank marketValueRank revenueRank
    ## 1      249532           4          1              33          16
    ## 2      464822           6          6              14          34
    ## 3      624408           5         48              10          10
    ## 4      210435           8          2              49          23
    ## 5     1897165           3         84               3          12
    ## 6     2252292           1        111               1           3
    ##                     ceoName                ceoTitle
    ## 1                    Shu Gu                     CEO
    ## 2               Jamie Dimon Chief Executive Officer
    ## 3     Warren Edward Buffett Chief Executive Officer
    ## 4                 Wang Zuji                     CEO
    ## 5 Amin bin Hassan Al-Nasser Chief Executive Officer
    ## 6                  Tim Cook Chief Executive Officer
    ##                                                                                                   revenueList
    ## 1          190467.0, 177230.5, 175874.0, 165337.9, 151381.0, 171076.8, 166796.0, 150233.4, 134410.1, 109422.6
    ## 2                                 136187, 142927, 132912, 118180, 102494, 99881, 97817, 107328, 99835, 111840
    ## 3                              245510, 254616, 247837, 235165, 222935, 210821, 194673, 182150, 162463, 143688
    ## 4 173478.00, 162147.27, 150313.00, 143202.39, 134242.00, 146815.60, 130473.00, 125342.85, 113094.74, 89432.83
    ## 5                                                                                          229747.0, 329762.1
    ## 6                              293971, 267712, 261705, 247535, 217481, 233273, 199378, 170866, 155971, 108598
    ##                                                                                 assetsList
    ## 1 4914670, 4322528, 4034482, 4210927, 3473238, 3420257, 3322043, 3124887, 2815630, 2458988
    ## 2 3689336, 3139431, 2737188, 2609785, 2512986, 2423808, 2593562, 2435283, 2377204, 2278648
    ## 3           873729, 817729, 707794, 702651, 620854, 561068, 534618, 493362, 437236, 403187
    ## 4 4301700, 3822048, 3382422, 3631583, 3016578, 2825983, 2698925, 2537900, 2242722, 1951356
    ## 5                                                                       510252.0, 398295.5
    ## 6           354054, 320400, 373719, 367502, 331141, 293284, 261894, 207000, 176064, 116371
    ##                                                                                           profitList
    ## 1 45768.70, 45283.62, 45223.00, 43669.41, 41983.70, 44160.28, 44757.25, 42723.26, 37803.80, 32218.48
    ## 2                               40371, 29954, 32738, 26496, 24231, 23548, 21219, 17398, 20530, 18197
    ## 3                                42521, 81417, 4021, 39742, 24074, 24083, 19872, 19476, 14824, 10254
    ## 4 39299.20, 38914.77, 38841.00, 37203.08, 34981.40, 36393.44, 37038.93, 34916.73, 30616.02, 26184.12
    ## 5                                                                                 49282.80, 88204.98
    ## 6                               63930, 57215, 59431, 53318, 45217, 53731, 44462, 37037, 41733, 25922
    ##                                                                    employeesList
    ## 1                 449296, 453048, 461749, 466346, 462282, 441902, 427356, 408859
    ## 2 255351, 256981, 256105, 167000, 243355, 234598, 241359, 251196, 258965, 260157
    ## 3 360000, 391500, 389000, 377000, 367700, 331000, 316000, 302000, 288500, 271000
    ## 4                 352621, 352621, 362482, 369183, 372321, 368410, 348955, 329438
    ## 5                                                                   66800, 69867
    ## 6      147000, 137000, 132000, 80000, 116000, 110000, 92600, 80300, 76100, 63300
    ##           date      city
    ## 1 1.620947e+12   Beijing
    ## 2 1.620947e+12  New York
    ## 3 1.620947e+12     Omaha
    ## 4 1.620947e+12   Beijing
    ## 5 1.620947e+12   Dhahran
    ## 6 1.620947e+12 Cupertino
    ##                                                                  csfDisplayFields
    ## 1 rank, organizationName, country, industry, ceoName, marketValue, premiumProfile
    ## 2 rank, organizationName, country, industry, ceoName, marketValue, premiumProfile
    ## 3 rank, organizationName, country, industry, ceoName, marketValue, premiumProfile
    ## 4 rank, organizationName, country, industry, ceoName, marketValue, premiumProfile
    ## 5 rank, organizationName, country, industry, ceoName, marketValue, premiumProfile
    ## 6 rank, organizationName, country, industry, ceoName, marketValue, premiumProfile
    ##   yearFounded                          webSite industryLeader      state
    ## 1        2011          http://www.icbc-ltd.com          FALSE       <NA>
    ## 2        1968     http://www.jpmorganchase.com          FALSE   New York
    ## 3        1955 http://www.berkshirehathaway.com          FALSE   Nebraska
    ## 4        2014               http://www.ccb.com          FALSE       <NA>
    ## 5        1933       http://http:www.aramco.com          FALSE       <NA>
    ## 6        1976             http://www.apple.com          FALSE California
    ##   employees
    ## 1        NA
    ## 2    255351
    ## 3    360000
    ## 4        NA
    ## 5     66800
    ## 6    147000
    ##                                                                                                          thumbnail
    ## 1                                                                                                             <NA>
    ## 2                                                                                                             <NA>
    ## 3                                                                                                             <NA>
    ## 4                                                                                                             <NA>
    ## 5                                                                                                             <NA>
    ## 6 http://specials-images.forbesimg.com/imageserve/5c13d14731358e5b4339c564/280x425.jpg?fit=scale&background=000000
    ##                                                                                                                                 squareImage
    ## 1                                                                                                                                      <NA>
    ## 2                                                                                                                                      <NA>
    ## 3                                                                                                                                      <NA>
    ## 4                                                                                                                                      <NA>
    ## 5                                                                                                                                      <NA>
    ## 6 //specials-images.forbesimg.com/imageserve/5c13d14731358e5b4339c564/416x416.jpg?background=000000&cropX1=0&cropX2=416&cropY1=0&cropY2=416
    ##                                                                                                                                  portraitImage
    ## 1                                                                                                                                         <NA>
    ## 2                                                                                                                                         <NA>
    ## 3                                                                                                                                         <NA>
    ## 4                                                                                                                                         <NA>
    ## 5                                                                                                                                         <NA>
    ## 6 //specials-images.forbesimg.com/imageserve/580f8c9e31358e238316147e/416x874.jpg?background=000000&cropX1=308&cropX2=902&cropY1=0&cropY2=1248
    ##                                                                                                                                 landscapeImage
    ## 1                                                                                                                                         <NA>
    ## 2                                                                                                                                         <NA>
    ## 3                                                                                                                                         <NA>
    ## 4                                                                                                                                         <NA>
    ## 5                                                                                                                                         <NA>
    ## 6 //specials-images.forbesimg.com/imageserve/580f8c9e31358e238316147e/874x416.jpg?background=000000&cropX1=0&cropX2=1248&cropY1=333&cropY2=927
    ##   premiumProfile ceoCompensations clients
    ## 1             NA               NA    NULL
    ## 2             NA               NA    NULL
    ## 3             NA               NA    NULL
    ## 4             NA               NA    NULL
    ## 5             NA               NA    NULL
    ## 6             NA               NA    NULL
