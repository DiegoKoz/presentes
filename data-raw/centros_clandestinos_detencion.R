## code to prepare `centros_clandestinos_detencion` dataset goes here
## code to prepare `apodos` dataset goes here
library(pdftools)
library(tidyverse)

pdf_raw <- pdf_text('extdata/6._anexo_v_listado_de_ccd-investigacion_ruvte-ilid.pdf')

ccd_parser <- function(pdf_page_raw){
tibble(texto= unlist(str_split(pdf_page_raw,'\n[[:blank:]]*(?=ID)'))) %>%
  mutate(es_ccd = str_detect(texto, '^ID ')) %>%
  filter(es_ccd) %>%
   mutate(
    ID= as.integer(trimws(str_extract(texto, '(?<=ID)[[:blank:]]+\\d*'))),
    lugar_emplazamiento_propiedad =trimws(str_extract(texto, '(?<=[[:blank:]]{3}).*(?=\n)')),
    denominacion =trimws(str_extract(texto, '(?<=\n).*(?=\n)')),
    texto = str_remove(texto, '\nSecretaría de Derechos Humanos de la Nación · Registro unificado de víctimas del terrorismo de Estado.*'),
    espacio_de_memoria = str_detect(texto,'ESPACIO DE MEMORIA'),
    texto = str_remove(texto, '\n[[:blank:]]+ESPACIO DE MEMORIA.*'),
    ubicacion = trimws(str_extract(texto, '(?<=\n).*·.*([[:blank:]]{3,}|$|\n)'))) %>%
    select(-c(texto,es_ccd))

}


centros_clandestinos_detencion <- map_df(pdf_raw[17:92], ccd_parser) %>%
  arrange(ID)

usethis::use_data(centros_clandestinos_detencion,overwrite = TRUE)


write_csv(centros_clandestinos_detencion,'extdata/centros_clandestinos_detencion.csv')
