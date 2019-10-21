## code to prepare `parque_de_la_memoria` dataset goes here

library(rvest)
library(xml2)
library(tidyverse)
library(glue)

#base
# http://basededatos.parquedelamemoria.org.ar/registros/?page=1
# paginas 1:351

link <- 'http://basededatos.parquedelamemoria.org.ar/registros/?page=1'

get_links_df <- function(link){

  nodes <- read_html(link) %>%
    rvest::html_nodes("a")

  tibble(href=unlist(map(nodes, html_attr,'href')),
         children=map(nodes, html_children) ) %>%
    filter(str_detect(href,'registros/\\d+')) %>%
    mutate(sublink= xml2::url_absolute(href, base= link),
           nombre = unlist(map(children, function(x){x %>% pluck(1) %>% html_text()})),
           embarazada = unlist(map(children, function(x){x %>% pluck(2) %>% html_text()})),
           embarazada = trimws(str_remove_all(embarazada,'\n')),
           edad = unlist(map(children, function(x){x %>% pluck(3) %>% html_text()})),
           estado = unlist(map(children, function(x){x %>% pluck(4) %>% html_text()})),
           ano_en_monumento = unlist(map(children, function(x){x %>% pluck(5) %>% html_text()})),
           id =str_extract(sublink,'(?<=/registros/)\\d*(?=/)') ) %>%
    select(id,nombre,embarazada,edad,estado,ano_en_monumento,sublink)
}

get_person_data <- function(sublink){

  page <- read_html(sublink)
  df <- tibble(rows = page%>%
           html_nodes('div.row') %>%
           map(.,html_children)) %>%
    mutate(largo = unlist(map(rows, length))) %>%
    filter(largo==2) %>%
    mutate(variable = unlist(map(rows,function(x){x %>% pluck(1) %>% html_text()})),
           valor = unlist(map(rows,function(x){x %>% pluck(2) %>% html_text()})),
           valor = trimws(str_remove_all(valor,'\n'))) %>%
    filter(!str_detect(variable,'\n')) %>%
    select(-c(rows,largo)) %>%
    spread(variable, valor) %>%
    mutate(id=str_extract(sublink,'(?<=/registros/)\\d*(?=/)'))

  #fotos
  if (length(page %>% html_nodes('a.boton'))>0) {
    df <- df %>%
      mutate(foto = page %>% html_nodes('a.boton') %>% html_attr('href') %>%url_absolute(.,sublink))
  }
  #casos relacionados
  sub_paginas <- page %>%
    html_nodes('a')
  casos_relacionados <- tibble(texto = sub_paginas %>% html_text(), href = sub_paginas %>% html_attr('href')) %>%
    filter(str_detect(href,'(?<=/registros/)\\d*(?=/)')) %>%
    mutate(id=str_extract(href,'(?<=/registros/)\\d*(?=/)')) %>%
    select(nombre = texto, id)

  if (nrow(casos_relacionados)>0) {
  df$casos_relacionados <- list(casos_relacionados)
  }
  df
}

df <- tibble(link= glue('http://basededatos.parquedelamemoria.org.ar/registros/?page={1:351}') )


single_page <- single_page %>%
  mutate(person_data = map(sublink,get_person_data))

prueba <- single_page$person_data %>% bind_rows()
#usethis::use_data(parque_de_la_memoria, overwrite = TRUE)
