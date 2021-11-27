require(httr)
library(jsonlite)

headers = c(
  `accept` = 'application/json'
)

params = list(
  `include_platform` = 'false'
)

res <- httr::GET(url = 'https://api.coingecko.com/api/v3/coins/list', httr::add_headers(.headers=headers), query = params)


df <- fromJSON(content(res, 'text'), flatten = T)

df <- fromJSON("https://api.coingecko.com/api/v3/coins/list?include_platform=false")

doge <- data.frame(fromJSON("https://api.coingecko.com/api/v3/coins/dogecoin/ohlc?vs_currency=usd&days=365"))

doge$X1 <- as.POSIXct(doge$X1/1000, origin="1970-01-01")

names(doge) <- c('date', 'open', 'high', 'low', 'close')

ggplot(doge, aes(date, close)) +
  geom_line()
