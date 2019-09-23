
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RUVTE

<!-- badges: start -->

<!-- badges: end -->

The goal of RUVTE is to …

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
#> ── Attaching packages ─────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──
#> ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
#> ✔ tibble  2.1.3     ✔ dplyr   0.8.3
#> ✔ tidyr   1.0.0     ✔ stringr 1.4.0
#> ✔ readr   1.3.1     ✔ forcats 0.4.0
#> ── Conflicts ────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
library(DT)
RUVTE::centros_clandestinos_detencion
#> # A tibble: 762 x 5
#>       ID lugar_emplazamien… denominacion     espacio_de_memo… ubicacion    
#>    <int> <chr>              <chr>            <lgl>            <chr>        
#>  1     1 POLICÍA FEDERAL    OLIMPO           TRUE             RAMÓN FALCÓN…
#>  2     2 EJÉRCITO           LA PERLA         TRUE             Ruta Nac. Nº…
#>  3     3 ARMADA             ESCUELA DE MECÁ… TRUE             Av. DEL LIBE…
#>  4     4 SERVICIO PENITENC… UNIDAD PENAL DE… FALSE            Av. HIPÓLITO…
#>  5     5 POLICÍA PROVINCIAL EL BANCO         FALSE            "Autopista R…
#>  6     6 EJÉRCITO           COMPAÑÍA DE COM… FALSE            BOULOGNE SUR…
#>  7     7 SERVICIO PENITENC… UNIDAD PENAL DE… FALSE            CORONDA · SA…
#>  8     8 POLICÍA PROVINCIAL COMISARÍA 14ª D… FALSE            MARCOS PAZ 6…
#>  9     9 POLICÍA PROVINCIAL DIVISIÓN CUATRE… TRUE             Calle 640 y …
#> 10    10 POLICÍA PROVINCIAL BRIGADA DE INVE… TRUE             12 DE OCTUBR…
#> # … with 752 more rows
RUVTE::apodos
#> # A tibble: 5,362 x 4
#>    nombre                  apellido_materno ID      apodo                  
#>    <chr>                   <chr>            <chr>   <chr>                  
#>  1 SOBKO PEDRO MIGUEL      KOLENKO          " 7420" "  \"ADOLFO SCHMIDT\"" 
#>  2 CABILLA VERÓNICA MARÍA  ÁVALOS GOYCOOLEA " 821"  "  \"ADRIANA SALAS\""  
#>  3 POLTI MIGUEL ÁNGEL      RAVIER           " 1723… "  \"AGUSTÍN AMADO ARC…
#>  4 GUADIX GERVASIO MARTÍN  VIGNEAU          " 8014" "  \"ALBERTO LUCIO CAS…
#>  5 MOZÉ MIGUEL ÁNGEL       SUSA             " 1297… "  \"ALBERTO MARULL\"" 
#>  6 MERBILHAÁ EDUARDO RAÚL  CORTELEZZI       " 3247" "  \"ALBERTO VEGA\""   
#>  7 NAVARRO LEOPOLDO REYNA… SANTOS CRUZ      " 1217… "  \"ALDO NAVARRO\""   
#>  8 MOYANO LUIS ROQUE       HERRERA          " 1297… "  \"ALFREDO RAÚL CALL…
#>  9 CHAHER ROSA DELICIA     LÓPEZ            " 9891" "  \"ALICIA CHAER\""   
#> 10 AGUILAR ANA TERESA DEL… VILLALBA         " 6104" "  \"AMANDA BEATRIZ TO…
#> # … with 5,352 more rows
RUVTE::victimas_accionar_represivo_ilegal
#> # A tibble: 8,753 x 20
#>    anio_denuncia tipificacion_ru… id_unico_ruvte apellido_patern…
#>            <dbl> <chr>            <chr>          <chr>           
#>  1          1984 DESAPARICION FO… ID 5389        ABACHIAN  JUAN …
#>  2          1984 DESAPARICION FO… ID 87          ABAD  ANA CATAL…
#>  3          1984 DESAPARICION FO… ID 11788       ABAD  JULIO RIC…
#>  4          1984 ASESINATO        ID 9907        ABAD  OSCAR GER…
#>  5          1984 DESAPARICION FO… ID 89          ABAD  ROBERTO R…
#>  6          1984 DESAPARICION FO… ID 88          ABAD  ROUMALDO …
#>  7          1984 ASESINATO        ID 9906        ABAD  SUSANA BE…
#>  8          1984 DESAPARICION FO… ID 90          ABADI  CARLOS A…
#>  9          1984 DESAPARICION FO… ID 91          ABADIA  DOMINGA 
#> 10          1984 DESAPARICION FO… ID 92          ABADIA  FELICID…
#> # … with 8,743 more rows, and 16 more variables: apellido_materno <chr>,
#> #   apellido_casada <chr>, edad_al_momento_del_hecho <chr>,
#> #   documentos <chr>, anio_nacimiento <chr>, provincia_nacimiento <chr>,
#> #   pais_nacimiento <chr>, nacionalidad <chr>, embarazo <chr>,
#> #   fecha_detencion_secuestro <chr>, lugar_detencion_secuestro <chr>,
#> #   fecha_asesinato_o_hallazgo_de_restos <chr>,
#> #   lugar_asesinato_o_hallazgo_de_restos <chr>, fotografia <chr>,
#> #   provincia_nacimiento_indec_id <chr>, pais_nacimiento_indec_id <chr>
RUVTE::victimas_accionar_represivo_ilegal_sin_denuncia_formal
#> # A tibble: 784 x 21
#>    anio_denuncia tipificacion_ru… id_unico_ruvte apellido_patern…
#>            <dbl> <chr>            <chr>          <chr>           
#>  1          1984 PRESUNCION DE D… ID 103         ABRERA  LORENZO…
#>  2          1984 PRESUNCION DE D… ID 5390        ABUERTO  HECTOR 
#>  3          1984 PRESUNCION DE D… ID 117         ACUÑA  HEBE ELSA
#>  4          1984 PRESUNCION DE D… ID 118         ACUÑA  JORGE LU…
#>  5          1984 PRESUNCION DE D… ID 123         ACUÑA  VICTORIO 
#>  6          1984 PRESUNCION DE D… ID 128         ADAUF  LILIAN M…
#>  7          1984 PRESUNCION DE D… ID 131         ADREANI  OMAR   
#>  8          1984 PRESUNCION DE D… ID 135         AGALLA  JUAN GR…
#>  9          1984 PRESUNCION DE D… ID 161         AGUIRRE  MARIA  
#> 10          1984 PRESUNCION DE D… ID 175         AKEL  JUAN CARL…
#> # … with 774 more rows, and 17 more variables: apellido_materno <chr>,
#> #   apellido_casada <chr>, edad_al_momento_del_hecho <chr>,
#> #   documentos <chr>, anio_nacimiento <chr>, provincia_nacimiento <chr>,
#> #   pais_nacimiento <chr>, nacionalidad <chr>, embarazo <lgl>,
#> #   fecha_detencion_secuestro <chr>, lugar_detencion_secuestro <chr>,
#> #   fecha_asesinato_o_hallazgo_de_restos <chr>,
#> #   lugar_asesinato_o_hallazgo_de_restos <chr>, fotografia <chr>,
#> #   fuente_original <chr>, provincia_nacimiento_indec_id <chr>,
#> #   pais_nacimiento_indec_id <chr>
```
