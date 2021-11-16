library(rvest)
library(jsonlite)
library(data.table)
library(httr)
library(xml2)


library(jsonlite)

url <- 'https://api.exchangerate.host/latest'
data <- fromJSON(url)
print(data)

t <- GET('https://api.exchangerate.host/convert', query=list(from="USD", to="EUR"))



t <- fromJSON(content(t, "text"))

t <- GET('https://api.exchangerate.host/convert', query=list(from="USD", to="EUR"), verbose(info = T))

library(jsonlite)

url <- 'https://api.exchangerate.host/timeseries?start_date=2020-01-01&end_date=2020-01-04'
data <- fromJSON(url)
print(data)

f1 <- function(start_date, end_date, base, symbols){
  t <- GET(paste0('https://api.exchangerate.host/timeseries?start_date=', start_date, '&end_date=', end_date, '&base=', base, '&symbols=', symbols))
  t <- fromJSON(content(t, "text"))
  t <- data.frame(names=names(t$rates), values=as.numeric(unlist(t$rates)))
  return(t)
}

df <- f1(start_date="2020-01-01", end_date="2020-01-04", base="USD", symbols = "HUF")
