library(pdftools)
library(tidyverse)


pdf_raw <- pdf_text('data/4._anexo_iii_ndice_de_apodos-investigacion_ruvte-ilid.pdf')

text <- strsplit(pdf_raw, "\n")

normalizar_texto <- function(texto_crudo){
tibble(texto=texto_crudo) %>%
  filter(!str_detect(texto, pattern = 'ANEXO III')) %>%
  mutate(es_apodo= !str_detect(texto, 'ID'),
         apodo = case_when(es_apodo ~ texto)) %>%
  fill(apodo, .direction = 'down') %>%
  filter(!es_apodo) %>%
  separate(texto, c('nombres', 'ID'), sep='ID') %>%
  mutate(nombres=trimws(nombres)) %>%
  separate(nombres, c('nombre', 'apellido_materno'),sep = '[:space:]{2,}',fill = 'right')
}

texto_normalizado <- map_df(text, normalizar_texto)
