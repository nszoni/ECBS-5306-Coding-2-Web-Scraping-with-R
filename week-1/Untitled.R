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