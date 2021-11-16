library(rvest)
library(data.table)
library(xml2)

get_one_page <- function(t_url) {
  t <- read_html(t_url)
  
  write_html(t, 't.html')
  
  t_tiles <- t %>% html_nodes('.headline-link span') %>%  html_text()
  titles <- t_tiles[seq(2, length(t_tiles), by=2)]
  tags <- t_tiles[seq(2, length(t_tiles), by=2)]
  teaser <- t %>%  html_nodes('.teaser__text') %>% html_text()
  rel_links <- t %>% html_nodes('.headline-link') %>%  html_attr('href')
  
  links <- paste0('https://www.economist.com', rel_links)
  
  df <- data.frame('titles' = titles, 'tags' = tags, 'teaser' = teaser, 'links' = links)
  return(df)
}

df <- get_one_page("https://www.economist.com/leaders")

paging <- paste0('https://www.economist.com/leaders?page=', 1:3)

list_of_dfs <- lapply(paging, get_one_page)


# yachts ------------------------------------------------------------------

t_url <- "https://www.yachtworld.co.uk/yacht/2014-fairline-targa-48-open-6936343/"

t <- read_html(t_url)
t_list <- list()

t_list[['link']] <- t_url
t_list[['length']] <- t %>% html_nodes('.boat-length') %>% html_text()
t_list[['price']] <- t %>% html_nodes('.payment-total') %>% html_text()
t_list[['location']] <- t %>% html_nodes('.location') %>% html_text()


keys <- t %>% html_nodes('.datatable-title') %>%  html_text()
values <- t %>% html_nodes('.datatable-value') %>%  html_text()

for (i in 1:length(keys)) {
  t_list[[keys[i]]] <- values[i]
}

return(t_list)


t <- read_html('https')

# ultimatespecs -----------------------------------------------------------

t <- read_html("https://www.ultimatespecs.com/car-specs/Tesla/108327/Tesla-Model-S-P100D.html")

write_html(t, 't.html')

t_tiles <- t %>% html_nodes('.page_ficha_title_text span') %>%  html_text()
teaser <- t %>%  html_nodes('.ficha_specs_main') %>% html_text()
rel_links <- t %>% html_nodes('.headline-link') %>%  html_attr('href')

