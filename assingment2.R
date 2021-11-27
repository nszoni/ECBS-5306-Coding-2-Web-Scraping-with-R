require(httr)
require(jsonlite)

res <- httr::GET(url = 'https://tenders.guru/api/hu/tenders')

t <- fromJSON(content(res, 'text'), flatten = T)

df <- data.frame(t$data)

df_data <-
  rbindlist(lapply(t$data$awarded, function(x){
    data.frame(x, stringsAsFactors = F)
  }), fill=T)

t$data$awarded

 a<- lapply(t(lapply(t$data$awarded, data.frame)), data.frame)
 b <- rbindlist(t$data$awarded, fill = T)
 
 rbindlist(b$suppliers)
 
 head(df, 5)
 
freq <- df %>% group_by(date) %>%
   mutate(frequency = n()) %>% 
   arrange(desc(frequency))

ggplot(df) +
  geom_histogram(aes(category), stat="count")

df$days_due = as.numeric(difftime(df$deadline_date, df$date, units = "days"))

ggplot(df) +
  geom_bar(aes(days_due), stat="count") +
  geom_density(aes(days_due, y=..count..))

