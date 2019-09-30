## code to prepare `apodos` dataset goes here
library(pdftools)
library(tidyverse)

pdf_raw <- pdf_text('extdata/4._anexo_iii_ndice_de_apodos-investigacion_ruvte-ilid.pdf')

text <- strsplit(pdf_raw, "\n")

normalizar_texto <- function(texto_crudo){
  tibble(texto=texto_crudo) %>%
    filter(!str_detect(texto, pattern = 'ANEXO III')) %>%
    mutate(es_apodo= !str_detect(texto, '[:space:]{2,}ID'),
           apodo = case_when(es_apodo ~ texto)) %>%
    fill(apodo, .direction = 'down') %>%
    filter(!es_apodo) %>%
    select(-es_apodo) %>%
    separate(texto, c('nombres', 'ID'), sep='[:space:]{2,}ID') %>%
    mutate(nombres=trimws(nombres)) %>%
    separate(nombres, c('nombre', 'apellido_materno'),sep = '[:space:]{2,}',fill = 'right')
}


apodos <- map_df(text, normalizar_texto)

usethis::use_data(apodos)

write_csv(apodos,'extdata/apodos.csv')
