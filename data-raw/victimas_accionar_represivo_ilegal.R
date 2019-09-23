## code to prepare `victimas_accionar_represivo_ilegal` dataset goes here

library(readr)
library(tidyverse)
victimas_accionar_represivo_ilegal <- read_csv("extdata/victimas-accionar-represivo-ilegal.csv",
                                               locale = locale(encoding = "ISO-8859-1"))


victimas_accionar_represivo_ilegal <- victimas_accionar_represivo_ilegal %>%
  separate(fecha_lugar_detencion_secuestro,
           into = c('fecha_detencion_secuestro','lugar_detencion_secuestro'),
           sep = '   ',
           remove = TRUE) %>%
  separate(fecha_lugar_asesinato_o_hallazgo_de_restos,
           into = c('fecha_asesinato_o_hallazgo_de_restos','lugar_asesinato_o_hallazgo_de_restos'),
           sep = '   ',
           remove = TRUE) %>%
  mutate(fecha_detencion_secuestro= case_when(fecha_detencion_secuestro=='---'~ NA_character_,
                                              fecha_detencion_secuestro=='sin datos fecha'~ NA_character_,
                                              TRUE~fecha_detencion_secuestro),
         lugar_detencion_secuestro= case_when(lugar_detencion_secuestro=='sin datos lugar'~ NA_character_,
                                              TRUE~ lugar_detencion_secuestro),
         fecha_asesinato_o_hallazgo_de_restos= case_when(fecha_asesinato_o_hallazgo_de_restos=='---'~ NA_character_,
                                              fecha_asesinato_o_hallazgo_de_restos=='sin datos fecha'~ NA_character_,
                                              TRUE~fecha_asesinato_o_hallazgo_de_restos),
         lugar_asesinato_o_hallazgo_de_restos= case_when(lugar_asesinato_o_hallazgo_de_restos=='sin datos lugar'~ NA_character_,
                                              TRUE~ lugar_asesinato_o_hallazgo_de_restos)
         )

usethis::use_data(victimas_accionar_represivo_ilegal,overwrite = TRUE)
