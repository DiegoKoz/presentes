
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RUVTE

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/DiegoKoz/RUVTE.svg?branch=master)](https://travis-ci.org/DiegoKoz/RUVTE)
<!--[![Codecov test coverage](https://codecov.io/gh/DiegoKoz/RUVTE/branch/master/graph/badge.svg)](https://codecov.io/gh/DiegoKoz/RUVTE?branch=master)-->
<!-- badges: end -->

El objetivo de la librería RUVTE es poner a disposición la información
provista en
<http://datos.jus.gob.ar/dataset/registro-unificado-de-victimas-del-terrorismo-de-estado-ruvte>
y el informe
<https://www.argentina.gob.ar/sitiosdememoria/ruvte/informe>

## Son 30.000

Consideramos pertinente realizar la aclaración de que, aunque la
información provista por este dataset no cuenta con 30.000 registros,
esto no se debe a que no haya sido esa cantidad de víctimas del
terrorismo de Estado en Argentina durante la úlitma dictadura militar,
sino a que un gran número de casos no pudieron ser identificados y
sistematizados.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("DiegoKoz/RUVTE")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(RUVTE)
library(tidyverse)
library(DT)
```

``` r
RUVTE::centros_clandestinos_detencion %>% sample_n(10)
#> # A tibble: 10 x 7
#>       ID lugar_emplazami… denominacion espacio_de_memo… ubicacion   lon
#>    <dbl> <chr>            <chr>        <lgl>            <chr>     <dbl>
#>  1   939 POLICÍA PROVINC… COMISARÍA D… FALSE            ALBERDI … -58.7
#>  2   201 POLICÍA FEDERAL  PLANTA TRAN… FALSE            Av. MITR… -58.3
#>  3   270 POLICÍA PROVINC… COMISARÍA 1… FALSE            COLÓN 59… -59.3
#>  4   269 FUERZA AÉREA     CENTRO DE I… FALSE            Autopist… -58.5
#>  5   390 POLICÍA PROVINC… COMISARÍA D… FALSE            LAVALLE … -59.2
#>  6   980 GENDARMERÍA NAC… "ESCUADRÓN … FALSE            SAN MART… -58.8
#>  7   101 POLICÍA PROVINC… DESTACAMENT… FALSE            Puente d… -63.9
#>  8   433 POLICÍA PROVINC… COMISARÍA 1… FALSE            TOMÁS JU… -58.6
#>  9   983 ESTABLECIMIENTO… FUNDACIÓN O… FALSE            Ruta Nac… -58.9
#> 10    34 EJÉRCITO         "GRANJA \"L… FALSE            EUROPA s… -66.3
#> # … with 1 more variable: lat <dbl>
```

``` r
RUVTE::apodos %>% sample_n(10)
#> # A tibble: 10 x 4
#>    nombre                 apellido_materno ID      apodo                   
#>    <chr>                  <chr>            <chr>   <chr>                   
#>  1 DIOS RICARDO ANÍBAL    CASTRO           " 1168… "  LUCIANO"             
#>  2 MARINA MARÍA CELESTE   GALLO            " 3065" "  AZUL / AZULITA"      
#>  3 ARIAS CARLOS RAÚL      FRANCO           " 379"  "  CARUZO"              
#>  4 DI TOFFINO TOMÁS CARM… MARTÍNEZ         " 1581" "  DITO"                
#>  5 CHEGENIAN SEGUNDO      RODRÍGUEZ        " 1144" "  FERNANDO"            
#>  6 DAROQUI JORGE ARTURO   BARONTINI        " 1399" "  GALLEGO / GALLEGUITO…
#>  7 ARCHETTI HÉCTOR AMÍLC… PEREYRA          " 1232… "  PETISO / PETI"       
#>  8 MONASTEROLO MARÍA EMI… MEYNET           " 5533" "  VIRGINIA"            
#>  9 MOLINA JULIO CÉSAR     RODRÍGUEZ        " 3336" "  NEGRO / NEGRITO"     
#> 10 GRANADA ANA MARÍA DEL… VERA             " 8159" "  ANA / ANITA / ANI"
```

``` r
RUVTE::victimas_accionar_represivo_ilegal %>% sample_n(10)
#> # A tibble: 10 x 20
#>    anio_denuncia tipificacion_ru… id_unico_ruvte apellido_patern…
#>            <dbl> <chr>            <chr>          <chr>           
#>  1          1984 ASESINATO        ID 9113        MENENDEZ  FERNA…
#>  2          1984 DESAPARICION FO… ID 4901        TAKARA  JUAN    
#>  3          1984 DESAPARICION FO… ID 7797        AVILA  LUIS MAR…
#>  4          1984 DESAPARICION FO… ID 1223        COMMENT  ALBERT…
#>  5          1984 DESAPARICION FO… ID 355         ARCUSCHIN  MIGU…
#>  6          1984 DESAPARICION FO… ID 6525        IZAGUIRRE  JUAN…
#>  7          1984 DESAPARICION FO… ID 4811        SOTO  SUSANA RO…
#>  8          1984 DESAPARICION FO… ID 3668        ORTIZ  ANSELMO  
#>  9          1984 DESAPARICION FO… ID 1673        ERLICH  MARGARI…
#> 10          1989 DESAPARICION FO… ID 11704       CASTRO  HUGO DE…
#> # … with 16 more variables: apellido_materno <chr>, apellido_casada <chr>,
#> #   edad_al_momento_del_hecho <chr>, documentos <chr>,
#> #   anio_nacimiento <chr>, provincia_nacimiento <chr>,
#> #   pais_nacimiento <chr>, nacionalidad <chr>, embarazo <chr>,
#> #   fecha_detencion_secuestro <chr>, lugar_detencion_secuestro <chr>,
#> #   fecha_asesinato_o_hallazgo_de_restos <chr>,
#> #   lugar_asesinato_o_hallazgo_de_restos <chr>, fotografia <chr>,
#> #   provincia_nacimiento_indec_id <chr>, pais_nacimiento_indec_id <chr>
```

``` r
RUVTE::victimas_accionar_represivo_ilegal_sin_denuncia_formal %>% sample_n(10)
#> # A tibble: 10 x 21
#>    anio_denuncia tipificacion_ru… id_unico_ruvte apellido_patern…
#>            <dbl> <chr>            <chr>          <chr>           
#>  1          1984 PRESUNCION DE D… ID 7130        PIZAR  JUAN     
#>  2          1984 PRESUNCION DE D… ID 3091        MARRE  JORGE AL…
#>  3          1984 PRESUNCION DE D… ID 8794        JARA  MONICA    
#>  4          1984 PRESUNCION DE D… ID 4650        SCHRDEDER  MARI…
#>  5          1984 PRESUNCION DE D… ID 2150        GIBIO  ALDO OSC…
#>  6          1984 PRESUNCION DE D… ID 5985        CHADO  ALBERTO  
#>  7          1984 PRESUNCION DE D… ID 6375        GOLVAN  HECTOR  
#>  8          1984 PRESUNCION DE D… ID 249         ALVAREZ  JORGE …
#>  9          1984 PRESUNCION DE D… ID 8167        JIMENEZ  ESTHER…
#> 10          1984 PRESUNCION DE D… ID 460         AYCROA  ADERVAL 
#> # … with 17 more variables: apellido_materno <chr>, apellido_casada <chr>,
#> #   edad_al_momento_del_hecho <chr>, documentos <chr>,
#> #   anio_nacimiento <chr>, provincia_nacimiento <chr>,
#> #   pais_nacimiento <chr>, nacionalidad <chr>, embarazo <lgl>,
#> #   fecha_detencion_secuestro <chr>, lugar_detencion_secuestro <chr>,
#> #   fecha_asesinato_o_hallazgo_de_restos <chr>,
#> #   lugar_asesinato_o_hallazgo_de_restos <chr>, fotografia <chr>,
#> #   fuente_original <chr>, provincia_nacimiento_indec_id <chr>,
#> #   pais_nacimiento_indec_id <chr>
```
