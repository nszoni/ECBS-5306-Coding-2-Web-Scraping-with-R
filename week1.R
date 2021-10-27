welcome <- function(name) {
  return(paste0('Warm welcome ', name))
}

welcome(name = 'Sonny')

multi <- function(a, b) {
  if (is.numeric(a)&is.numeric(b)){
    return(a*b-b)
  } else {
    stop('Please five numbers')
  }
}

multi(2,5)

bmi_calc <- function(weight, height) {
  return(weight/(height/100)**2)
}

bmi_calc(75, 175)

for (i in 1:10) {
  print(i)
}

j <-1
while (j<10) {
  print('hello')
  j <- j+1
  if (j==5){
    break()
  }
}

for (i in 1:length(letters)){
  print(paste0("The ",i,". letter is ",letters[i]))
}

my_square <- function(x) {
  return(x**2)
}

sapply(1:10, my_square)

unlist(lapply(1:10, my_square))

lapply(1:10, function(x){return(x**3)})

install.packages('rvest')
library(rvest)

t <- read_html('week-1/index.html')

# tags
t %>% html_nodes('.demo-class') %>% html_text()

t %>% html_nodes('h1') %>% html_text()

t %>% html_nodes('#select-with-id') %>% html_text()

t <- read_html('https://www.boats.com/boats/prestige/420-8040261/')

install.packages('iai')
library(iai)

write_html(t, 't.html')

t %>% html_nodes('.oem-page__title--no-margin') %>% html_text()

t %>% html_nodes('.description-list__term') %>% html_text()


