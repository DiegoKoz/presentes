#' @title centros_clandestinos_detencion
#' @description Información respecto a los Centros Clandestinos de Detención. Recuperado de https://www.argentina.gob.ar/sites/default/files/6._anexo_v_listado_de_ccd-investigacion_ruvte-ilid.pdf
#' @format A data frame with 762 rows and 5 variables:
#' \describe{
#'   \item{\code{ID}}{integer N° de orden e identificador único en la base de datos del Ruvte.}
#'   \item{\code{lugar_emplazamiento_propiedad}}{character propiedad de las dependencias, instalaciones o predios en los que el CCD
#'               hubiera estado emplazado}
#'   \item{\code{denominacion}}{character La denominación del CCD se define en base a criterios distintos, prevaleciendo,
#'               en general, el de “uso extendido”, que usualmente remite al nombre en clave, en jerga o coloquial
#'               utilizado por el personal actuante transmitido por los sobrevivientes.}
#'   \item{\code{espacio_de_memoria}}{logical Indica si el espacio es en la actualidad un Espacio de Memoria
#'               http://www.jus.gob.ar/derechoshumanos/red-federal-de-sitios-de-la-memoria.}
#'   \item{\code{ubicacion}}{character CALLE y NÚMERO u otras referencias · Barrio o paraje · LOCALIDAD · PARTIDO o DEPARTAMENTO ·
#'               PROVINCIA}
#'   \item{\code{lon}}{num longitud}
#'   \item{\code{lat}}{num latitud}
#'}

"centros_clandestinos_detencion"
