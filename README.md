
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
RUVTE::centros_clandestinos_detencion %>% sample_n(10)
#> # A tibble: 10 x 5
#>       ID lugar_emplazamien… denominacion    espacio_de_memo… ubicacion     
#>    <int> <chr>              <chr>           <lgl>            <chr>         
#>  1   197 POLICÍA PROVINCIAL COMISARÍA DE S… FALSE            Calle 41 y 3 …
#>  2    44 POLICÍA PROVINCIAL POZO DE QUILMES FALSE            ALLISON BELL …
#>  3  1245 PREFECTURA NAVAL   PREFECTURA FOR… FALSE            Av. 25 DE MAY…
#>  4   155 GENDARMERÍA NACIO… "ESCUADRÓN 13 … FALSE            Av. VICTORIA …
#>  5  1122 POLICÍA PROVINCIAL "CUARTEL GUARD… FALSE            SANTA FELICIA…
#>  6   182 POLICÍA PROVINCIAL COMISARÍA 13ª … FALSE            RIVADAVIA · S…
#>  7  1095 POLICÍA PROVINCIAL COMISARÍA 1ª D… FALSE            Av. ROCA (N) …
#>  8   902 EX EXTABLECIMIENT… LA ESCUELITA D… FALSE            Calle SELVA D…
#>  9   133 POLICÍA FEDERAL    COMISARÍA 50ª … FALSE            Av. GAONA 273…
#> 10    84 POLICÍA PROVINCIAL COMISARÍA 3ª D… FALSE            YATAY 553 · V…
RUVTE::apodos %>% sample_n(10)
#> # A tibble: 10 x 4
#>    nombre                    apellido_materno ID      apodo                
#>    <chr>                     <chr>            <chr>   <chr>                
#>  1 LÓPEZ FÉLIX ROBERTO       CARRIZO          " 8547" "  RAMÓN"            
#>  2 QUINTEROS SUSANA BEATRIZ  TRAVERSO         " 4093" "  CHAMARRA / CHAMAR…
#>  3 BERDINI CARLOS JOSÉ GUIL… PEREDA           " 632"  "  GUILLERMOTE"      
#>  4 BESSIO DALILA MATILDE     BASUALDO         " 643"  "  CATALINA / CATA /…
#>  5 JUÁREZ TELBA PETRONILA    BÉLIZ            " 2617" "  ELENA"            
#>  6 QUINTELA SILVIA MÓNICA    DALLASTA         " 4086" "  PETISA / PETI"    
#>  7 FERRAZA HORACIO LISANDRO  LEGUIZAMÓN       " 1633… "  CHACHI"           
#>  8 GUIDO RAÚL ALFREDO        KRUGER           " 2393" "  MARIO"            
#>  9 BAIBIENE ARTURO           ETCHETO          " 1608… "  NEGRO / NEGRITO"  
#> 10 SERRA SUSANA BEATRIZ      MIGNONE          " 4700" "  CUCA"
RUVTE::victimas_accionar_represivo_ilegal %>% sample_n(10)
#> # A tibble: 10 x 20
#>    anio_denuncia tipificacion_ru… id_unico_ruvte apellido_patern…
#>            <dbl> <chr>            <chr>          <chr>           
#>  1          1984 DESAPARICION FO… ID 4939        TEMPONE  VIRGIN…
#>  2          1984 DESAPARICION FO… ID 1158        CHIZZOLA  EDUAR…
#>  3          2013 ASESINATO        ID 17274       PIRAY  JUAN CAR…
#>  4          1984 DESAPARICION FO… ID 16088       BAIBIENE  ARTURO
#>  5          1984 DESAPARICION FO… ID 7232        QUINTANA  ANGEL…
#>  6          1987 ASESINATO        ID 11404       KOSSOY  RAUL GR…
#>  7          1984 DESAPARICION FO… ID 9470        STRAKA  OTTO    
#>  8          2004 ASESINATO        ID 16308       DOSIL  PEDRO GA…
#>  9          2004 DESAPARICION FO… ID 13779       CARETTI  CRISTI…
#> 10          1984 DESAPARICION FO… ID 8596        FIORITO  ALFRED…
#> # … with 16 more variables: apellido_materno <chr>, apellido_casada <chr>,
#> #   edad_al_momento_del_hecho <chr>, documentos <chr>,
#> #   anio_nacimiento <chr>, provincia_nacimiento <chr>,
#> #   pais_nacimiento <chr>, nacionalidad <chr>, embarazo <chr>,
#> #   fecha_detencion_secuestro <chr>, lugar_detencion_secuestro <chr>,
#> #   fecha_asesinato_o_hallazgo_de_restos <chr>,
#> #   lugar_asesinato_o_hallazgo_de_restos <chr>, fotografia <chr>,
#> #   provincia_nacimiento_indec_id <chr>, pais_nacimiento_indec_id <chr>
RUVTE::victimas_accionar_represivo_ilegal_sin_denuncia_formal %>% sample_n(10)
#> # A tibble: 10 x 21
#>    anio_denuncia tipificacion_ru… id_unico_ruvte apellido_patern…
#>            <dbl> <chr>            <chr>          <chr>           
#>  1          1984 PRESUNCION DE D… ID 1571        DIEZ  JOSE ALBE…
#>  2          1984 PRESUNCION DE D… ID 1799        FERNANDEZ  PRIM…
#>  3          2006 PRESUNCION DE D… ID 14051       BALLESTEROS  CA…
#>  4          1984 PRESUNCION DE D… ID 5011        TRAGAN  SILVIA  
#>  5          1984 PRESUNCION DE D… ID 3473        MUCCETTI  MIGUE…
#>  6          1984 PRESUNCION DE D… ID 1770        FERNANDEZ  DOLO…
#>  7          1984 PRESUNCION DE D… ID 4720        SIDUEÑA  VICTOR 
#>  8          1984 PRESUNCION DE D… ID 6184        FERNANDEZ  GERA…
#>  9          1984 PRESUNCION DE D… ID 7404        SERENELLI  ALDO 
#> 10          1984 PRESUNCION DE D… ID 6486        HERNANDEZ  HUGO 
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
