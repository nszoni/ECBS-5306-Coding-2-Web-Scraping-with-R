
# NFO ---------------------------------------------------------------------

# Author: Son N. Nguyen
# Date: 13-11-2021
# Class: Coding2-Web Scraping

# TASK --------------------------------------------------------------------

#Create a function that will process one page and return with a data frame with one line data frame or list
#Create the links that you want to process, you also can write a function that will extract the links first then save them into a vector
#lapply your function to your links, you will get a list of data frames
#rbindlist your result into one data frame


# MY SOLUTION -------------------------------------------------------------

# Loading packages with pacman
if (!require("pacman")) {
  install.packages("pacman")
}

pacman::p_load(tidyverse, rvest, data.table,
               xml2, stringr)

# I scraped stackoverflow questions connected to one of my favourite ELT tool, dbt (data build tool)
url <- 'https://stackoverflow.com/questions/tagged/dbt'

get_one_page <- function(url) {
  t <- read_html(url)
  
relative_links <- t %>% 
    html_nodes('#questions .question-hyperlink') %>% html_attr('href')
  
links <- paste0(url, relative_links)
  
posts <- t %>% 
  html_nodes('#questions .question-hyperlink') %>% html_text()
  
views <- t %>% 
  html_nodes('.views') %>% html_text()

votes <- t %>% 
  html_nodes('.vote-count-post strong') %>% html_text()

tags <- t %>% 
  html_nodes('.t-dbt') %>% html_text()

df <- data.frame('title'=posts, 'tags'=tags, 'view_count'=views, 'score'=as.integer(votes), 'link'=links)

#Removing extra whitespaces and invisible characters from tags
df$tags <- gsub("[\r\n]", "", df$tags)
df$tags <- gsub('               ', ', ', df$tags)
df$tags <- gsub('    ', '', df$tags)

#Extract tags
df$tags <- sapply(strsplit(df$tags,","), `[`, 1)

#Set delimeter of tags
df$tags <- str_replace_all(df$tags, ' ',', ')

#Treat view_counts above 1000
df$view_count <- str_replace_all(df$view_count, 'k','000')

#Clean
df$view_count <- gsub("[\r\n]", "", df$view_count)
df$view_count <- gsub('    ', '', df$view_count)
df$view_count <- as.integer(sapply(strsplit(df$view_count," views"), `[`, 1))

  return(df)

}  

links <- paste0('https://stackoverflow.com/questions/tagged/dbt?tab=newest&pagesize=50&page=', 1:6)

list_of_dfs<- lapply(links, get_one_page)

stackoverflow_dbt <- rbindlist(list_of_dfs)