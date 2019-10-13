## code to geocode `centros_clandestinos_detencion` dataset goes here
library(stringr)
library(purrr)
library(ggmap)

# Truco para evitar desconexiones HTTP al georeferenciar
httr::set_config(httr::config(http_version = 0))


# Se requere API
gogle_maps_API_key <- "BLAHBLAHBLAHA7ibZfaoJXaI8er02UaoG"
register_google(key = gogle_maps_API_key)

# Datos de entrada
centros_clandestinos_detencion <- read.csv("extdata/centros_clandestinos_detencion.csv",
                    stringsAsFactors = FALSE)

# Funcion de geocoding
georeferenciar <- function(midf) {

  # Función para extraer las provincias del campo ubicación
  get_provincia <- function(ubicacion) {

    componentes <- strsplit(ubicacion, " · ")

    provincia <- map_chr(componentes, function(x) x[length(x)])

    #Retiramos la descripción que a veces aparece a continuación de la provincia
    # ejemplo: "CÓRDOBA                          EX DEPCIAS. DEL ARMA BRIGADA DE CABALLERÍA AEROTRANSPORTADA (CUERPO DE EJÉRCITO III)"

    provincia <- str_remove(provincia, '  +.*')
    # A Google no le gusta el nombre oficial de Tierra del Fuego
    # y de paso actualizamos Capital Federal a CABA
    provincia <- str_replace_all(provincia,
                                 c("TIERRA DEL FUEGO, ANTÁRTIDA E ISLAS DEL ATLÁNTICO SUR" = "TIERRA DEL FUEGO",
                                   "CAPITAL FEDERAL" = "CABA"))
  }


  # parámetros adicionales para "inyectar" en la URL enviada a la API de geocoding
  # sirven para especificar área geográfica a considerar
  inyectar <- paste0("components=administrativeArea:",
                     map_chr(get_provincia(midf$ubicacion), URLencode),
                     "%20Province|country:AR")


  # Función para limpiar direcciones
  limpiar_direccion <- function(ubicacion) {

    str_replace_all(ubicacion, c("·" = ",", "esq." = "y"))
  }


  # Último paso: georeferenciar via Google Maps API
  # Usamos geocode() en lugar de mutate_geocode() para poder "curstomizar"
  # cada query concentrando la busqueda en la provincia de cada ubicacion

  ubicaciones <- limpiar_direccion(midf$ubicacion)

  coordenadas <- pmap_df(list(location = ubicaciones, inject = inyectar),
                         geocode)

  # devolver dataframe original con colunas de coordendas
  cbind(midf, coordenadas)


}

centros_clandestinos_detencion <- georeferenciar(centros_clandestinos_detencion)
write.csv(centros_clandestinos_detencion,'georef/centros_clandestinos_detencion.csv')
