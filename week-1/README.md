-   [Functions](#functions)
-   [Loops](#loops)
-   [Sapply, lapply](#sapply-lapply)
-   [HTML structure](#html-structure)
-   [Rvest](#rvest)

Functions
=========

``` r
welcome <- function(name) {
  return(paste0('Warm welcome ', name))
}

welcome(name = 'Ceu')
```

    ## [1] "Warm welcome Ceu"

**Task**<br> Create a function called `multi` which will take argument `a` and `b` and return with the `a * b - b`

``` r
multi(2,5)
```

    ## [1] 5

**Task**<br> Create a function named `bmi_calc` which will have two inputs `weight`(kg) and `height`(cm) and calculate the BMI index `weight/height(meter)^2`. Check your result [here](https://www.nhlbi.nih.gov/health/educational/lose_wt/BMI/bmicalc.htm)

``` r
bmi_calc(weight = 75, height = 175)
```

    ## [1] 24.4898

Loops
=====

``` r
for (i in 1:10) {
  print(i)
}
```

    ## [1] 1
    ## [1] 2
    ## [1] 3
    ## [1] 4
    ## [1] 5
    ## [1] 6
    ## [1] 7
    ## [1] 8
    ## [1] 9
    ## [1] 10

``` r
j <-1
while (j<10) {
  t_url <- paste0('https://baseurl.com/page', j)
  print(t_url)
  j <- j+1
}
```

    ## [1] "https://baseurl.com/page1"
    ## [1] "https://baseurl.com/page2"
    ## [1] "https://baseurl.com/page3"
    ## [1] "https://baseurl.com/page4"
    ## [1] "https://baseurl.com/page5"
    ## [1] "https://baseurl.com/page6"
    ## [1] "https://baseurl.com/page7"
    ## [1] "https://baseurl.com/page8"
    ## [1] "https://baseurl.com/page9"

**Task**<br> Reproduce the following printing with a for loop. (Use builtin vector called `letters`)

    ## [1] "The 1. letter is a"
    ## [1] "The 2. letter is b"
    ## [1] "The 3. letter is c"
    ## [1] "The 4. letter is d"
    ## [1] "The 5. letter is e"
    ## [1] "The 6. letter is f"
    ## [1] "The 7. letter is g"
    ## [1] "The 8. letter is h"
    ## [1] "The 9. letter is i"
    ## [1] "The 10. letter is j"
    ## [1] "The 11. letter is k"
    ## [1] "The 12. letter is l"
    ## [1] "The 13. letter is m"
    ## [1] "The 14. letter is n"
    ## [1] "The 15. letter is o"
    ## [1] "The 16. letter is p"
    ## [1] "The 17. letter is q"
    ## [1] "The 18. letter is r"
    ## [1] "The 19. letter is s"
    ## [1] "The 20. letter is t"
    ## [1] "The 21. letter is u"
    ## [1] "The 22. letter is v"
    ## [1] "The 23. letter is w"
    ## [1] "The 24. letter is x"
    ## [1] "The 25. letter is y"
    ## [1] "The 26. letter is z"

Create a function which will return the square of the input number.

``` r
my_square(11)
```

    ## [1] 121

Sapply, lapply
==============

Sapply and lapply takes two element, first a list and second a function<br>

Sapply returns with a vector

``` r
sapply(1:10, my_square)
```

    ##  [1]   1   4   9  16  25  36  49  64  81 100

Lapply returns with a list

``` r
lapply(1:10, my_square)
```

    ## [[1]]
    ## [1] 1
    ## 
    ## [[2]]
    ## [1] 4
    ## 
    ## [[3]]
    ## [1] 9
    ## 
    ## [[4]]
    ## [1] 16
    ## 
    ## [[5]]
    ## [1] 25
    ## 
    ## [[6]]
    ## [1] 36
    ## 
    ## [[7]]
    ## [1] 49
    ## 
    ## [[8]]
    ## [1] 64
    ## 
    ## [[9]]
    ## [1] 81
    ## 
    ## [[10]]
    ## [1] 100

``` r
lapply(1:10, function(x){x^3})
```

    ## [[1]]
    ## [1] 1
    ## 
    ## [[2]]
    ## [1] 8
    ## 
    ## [[3]]
    ## [1] 27
    ## 
    ## [[4]]
    ## [1] 64
    ## 
    ## [[5]]
    ## [1] 125
    ## 
    ## [[6]]
    ## [1] 216
    ## 
    ## [[7]]
    ## [1] 343
    ## 
    ## [[8]]
    ## [1] 512
    ## 
    ## [[9]]
    ## [1] 729
    ## 
    ## [[10]]
    ## [1] 1000

unlist will flat the list into a vector

``` r
unlist(lapply(1:10, function(x){x^3}))
```

    ##  [1]    1    8   27   64  125  216  343  512  729 1000

HTML structure
==============

-   [elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element)
-   [div](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/div)
-   [id](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/id)

Load any site, press F12<br> In the console you can select elements with `document.querySelector('')`. <br> You can get the text of any div, element or id with `innerText` attribute `document.querySelector('h1').innerText`. <br> You can also overwrite the text of the selected element `document.querySelector('h1').innerText=='hello'` It will change the first h1 text to hello. <br>

Try out with elements, id, and div.

**Task**<br> Change two element on [this](https://www.guinnessworldrecords.com/world-records/most-lasso-texas-skips-in-one-minute) site

-   who should contain your name
-   where should contain your country
-   take a screenshoot

`div` use `.` <br> `id` use `#` <br> `tag` use just the name of the tag.

Rvest
=====

Install and load the rvest library

``` r
#install.packages("rvest")
library(rvest)
# load the index.html page
t <- read_html('index.html')

# tags
t %>% html_node('h1') %>% html_text()
```

    ## [1] "Hello Class"

``` r
t %>% html_nodes('h1') %>% html_text()
```

    ## [1] "Hello Class" "this is h1"  "also h1"

``` r
t %>% html_node('.demo-class') %>% html_text()
```

    ## [1] "\n      also h1\n      that is smaller h2\n        that is a paragraph within h2\n      \n    "

``` r
t %>% html_nodes('#select-with-id') %>% html_text()
```

    ## [1] "\n      This text within an id called select-with-id, in this class you can find a link as well.\n      to my  github page\n    "

``` r
t <- read_html('https://www.boats.com/boats/prestige/420-8040261/')
t %>% html_nodes('#specifications .oem-page__title') %>% html_text()
```

    ## [1] "Prestige 420 Specifications"

``` r
t %>% html_nodes('.description-list__term') %>% html_text()
```

    ##  [1] "Price"                "Year"                 "Type"                
    ##  [4] "Class"                "Length"               "Fuel Type"           
    ##  [7] "Hull Material"        "LOA"                  "Length on Deck"      
    ## [10] "Beam"                 "Min. Draft"           "Dry Weight"          
    ## [13] "Max Bridge Clearance" "Cruising Speed"       "Maximum Speed"       
    ## [16] "Range"                "Number of Engines"    "Engine Type"         
    ## [19] "Engine Make"          "Engine Model"         "Power"               
    ## [22] "Drive Type"           "Number of Engines"    "Engine Type"         
    ## [25] "Engine Make"          "Engine Model"         "Power"               
    ## [28] "Drive Type"           "Max Passengers"       "Fuel Tanks"          
    ## [31] "Fresh Water Tanks"    "Holding Tanks"        "Windlass"            
    ## [34] "Hull Shape"           "Designer"

``` r
t %>% html_nodes('.description-list__description') %>% html_text()
```

    ##  [1] "\nRequest Price\n"                                
    ##  [2] "2022"                                             
    ##  [3] "Power"                                            
    ##  [4] "Motor Yacht, Flybridge"                           
    ##  [5] "42 ft 10 in"                                      
    ##  [6] "Diesel"                                           
    ##  [7] "Fiberglass"                                       
    ##  [8] "42 ft 10 in"                                      
    ##  [9] "37 ft 3 in"                                       
    ## [10] "13 ft 5 in"                                       
    ## [11] "3 ft 7 in"                                        
    ## [12] "22928 lb"                                         
    ## [13] "16 ft 1 in"                                       
    ## [14] "22 kn"                                            
    ## [15] "30 kn"                                            
    ## [16] "210 nmi"                                          
    ## [17] "2"                                                
    ## [18] "Inboard"                                          
    ## [19] "Cummins"                                          
    ## [20] "QSB 6.7"                                          
    ## [21] "380 hp"                                           
    ## [22] "V-drive"                                          
    ## [23] "2"                                                
    ## [24] "Inboard"                                          
    ## [25] "Cummins"                                          
    ## [26] "QSB 6.7"                                          
    ## [27] "425 hp"                                           
    ## [28] "V-drive"                                          
    ## [29] "4"                                                
    ## [30] "309 gal "                                         
    ## [31] "112 gal "                                         
    ## [32] "32 gal "                                          
    ## [33] "Electric Windlass"                                
    ## [34] "Semi-Displacement"                                
    ## [35] "Garroni Design, JP Concepts, Prestige Engineering"
