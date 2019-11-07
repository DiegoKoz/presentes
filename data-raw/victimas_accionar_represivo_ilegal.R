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
  mutate(fecha_detencion_secuestro = case_when(fecha_detencion_secuestro=='---'~ NA_character_,
                                               fecha_detencion_secuestro=='sin datos fecha'~ NA_character_,
                                               TRUE~fecha_detencion_secuestro),
         lugar_detencion_secuestro = case_when(lugar_detencion_secuestro=='sin datos lugar'~ NA_character_,
                                               TRUE~ lugar_detencion_secuestro),
         fecha_asesinato_o_hallazgo_de_restos = case_when(fecha_asesinato_o_hallazgo_de_restos=='---'~ NA_character_,
                                                          fecha_asesinato_o_hallazgo_de_restos=='sin datos fecha'~ NA_character_,
                                                          TRUE~fecha_asesinato_o_hallazgo_de_restos),
         lugar_asesinato_o_hallazgo_de_restos = case_when(lugar_asesinato_o_hallazgo_de_restos=='sin datos lugar'~ NA_character_,
                                                          TRUE~ lugar_asesinato_o_hallazgo_de_restos)
  )

victimas_accionar_represivo_ilegal <- victimas_accionar_represivo_ilegal %>%
  mutate(id_unico_ruvte = str_extract(id_unico_ruvte, '\\d+')) %>%
  select(id_unico_ruvte, everything())

library(data.table)   # porque Elio no sabe dplyr
# Agega columna de edad estandarizada. Queda todo en años (messes y días queda fraccional)
# Sin datos se convierte en NA y nacidos en cautiverio queda 0.
victimas_accionar_represivo_ilegal %<>%
  as.data.table() %>%
  .[, unidad := gsub("\\d", "", edad_al_momento_del_hecho)] %>%
  .[, edad_al_momento_del_hecho_numerico := unglue::unglue_data(edad_al_momento_del_hecho, "{edad} {unidad}")$edad] %>%
  .[unidad %like% "caut.", edad_al_momento_del_hecho_numerico := 0] %>%
  .[unidad == "sin datos", edad_al_momento_del_hecho_numerico := NA] %>%
  .[, edad_al_momento_del_hecho_numerico := as.numeric(edad_al_momento_del_hecho_numerico)] %>%
  .[unidad %like% "mes", edad_al_momento_del_hecho_numerico := edad_al_momento_del_hecho_numerico/12] %>%
  .[unidad %like% "día", edad_al_momento_del_hecho_numerico := edad_al_momento_del_hecho_numerico/365] %>%
  .[, unidad := NULL] %>%
  select(1:edad_al_momento_del_hecho, edad_al_momento_del_hecho_numerico, everything())


usethis::use_data(victimas_accionar_represivo_ilegal,overwrite = TRUE)
