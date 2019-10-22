## code to prepare `parque_de_la_memoria` dataset goes here

#cargo librerias
library(rvest)
library(xml2)
library(tidyverse)
library(glue)
library(janitor)

# revision manual pagina
# http://basededatos.parquedelamemoria.org.ar/registros/?page=1
# paginas 1:351

#defino funciones
## progressbar
spawn_progressbar <- function(x, .name = .pb, .times = 1) {
  .name <- substitute(.name)
  n <- nrow(x) * .times
  eval(substitute(.name <<- dplyr::progress_estimated(n)))
  x
}

## recuperar links a los prefiles
get_links_df <- function(link, .pb){
  .pb$tick()$print()
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
## recuperar info de los perfiles
get_person_data <- function(sublink,.pb){
  .pb$tick()$print()
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
## separar campos que son listados
separar_campos <- function(string,.pb){
  .pb$tick()$print()
  tibble(listado= unlist(str_split(string,'\\+'))) %>%
    filter(listado !='') %>%
    mutate(listado = str_squish(listado))
}

# Scrappeo

## creo base
df <- tibble(link= glue('http://basededatos.parquedelamemoria.org.ar/registros/?page={1:351}') )

## Creo dataset con links a perfiles

# df <- df %>%
#   spawn_progressbar %>%
#   mutate(page = map(link, get_links_df, .pb))

# df %>% saveRDS('extdata/links_intermedios_pdlm.rds')

df <- read_rds('extdata/links_intermedios_pdlm.rds')

df <- df %>% unnest(cols = c(page))

## descargo la info de cada perfil
# df <- df %>%
#   spawn_progressbar() %>%
#   mutate(page = map(sublink,get_person_data,.pb))

# df %>% saveRDS('extdata/paginas_finales_pdlm.rds')

#Limpieza

df <- read_rds('extdata/paginas_finales_pdlm.rds')

df <- df %>%
  unnest(cols = c(page),names_repair='universal') %>%
  janitor::clean_names()

parque_de_la_memoria <- df %>%
  select(-c(link,edad_2,estado_2,nombre_2,id_23,embarazada_2)) %>%
  select(id=id_2, link=sublink, nombre, edad, everything())


parque_de_la_memoria <- parque_de_la_memoria %>%
  spawn_progressbar %>%
  mutate(militancia = map(militancia,separar_campos, .pb)) %>%
  spawn_progressbar %>%
  mutate(articulos_periodisticos = map(articulos_periodisticos,separar_campos, .pb))

parque_de_la_memoria <- parque_de_la_memoria %>%
  mutate(sexo = recode(sexo, "f" = "Femenino",
                              "None" = "NA"))

usethis::use_data(parque_de_la_memoria, overwrite = TRUE)
