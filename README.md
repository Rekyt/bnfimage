
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `bnfimage` – API client to BnF images

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![R-CMD-check](https://github.com/Rekyt/bnfimage/workflows/R-CMD-check/badge.svg)](https://github.com/Rekyt/bnfimage/actions)
[![codecov](https://codecov.io/gh/Rekyt/bnfimage/branch/master/graph/badge.svg)](https://codecov.io/gh/Rekyt/bnfimage)
[![CRAN-version](https://www.r-pkg.org/badges/version/bnfimage)](https://cran.r-project.org/package=bnfimage)
<!-- badges: end -->

`bnfimage` is an R client for the [BnF images
API](http://api.bnf.fr/api-iiif-de-recuperation-des-images-de-gallica).
The Bibliothèque Nationale de France (BnF), has a online repository
called [Gallica](https://gallica.bnf.fr/) contaning millions of
documents that are scanned. The BnF now offers an API to access all the
images programmatically, and this package allows you to access it
through R.

The BnF Image API is implemented following the [International Image
Interoperability Framework](https://iiif.io/) (IIIF) with Image API
implemented using v.1.1, the Presentation API implemented using v.2.0,
and the Search API not yet implemented.

## Installation

You can install the development version of bnfimage with:

``` r
remotes::install_github("Rekyt/bnfimage")
```

## Example

You can extract images with the `bi_image()` function:

``` r
library(bnfimage)
eiffel_tower = bi_image(
  identifier = "ark:/12148/btv1b9055204k/f1",
  region     = "full",
  size       = c(1500, 750),
  rotation   = 0,
  quality    = "native",
  format     = "png")
#> Called from: bi_image(identifier = "ark:/12148/btv1b9055204k/f1", region = "full", 
#>     size = c(1500, 750), rotation = 0, quality = "native", format = "png")
#> debug: bi_query = bi_GET(identifier, region, size, rotation, paste0(quality, 
#>     ".", format))
#> debug: if (bi_query$status_code == 503) {
#>     stop("The API could not be reached, please try again later")
#> } else if (bi_query$status_code == 500) {
#>     stop("The query gave no answer. Please try another query")
#> }
#> debug: if (bi_query$status_code == 500) {
#>     stop("The query gave no answer. Please try another query")
#> }
#> debug: magick::image_read(bi_query$content)

str(eiffel_tower)
#> Class 'magick-image' <externalptr>

eiffel_tower
```

<img src="man/figures/README-example-1.png" width="100%" />

You can get the metadata associated with this image using
`bi_metadata()`:

``` r
eiffel_metadata = bi_metadata("ark:/12148/btv1b9055204k/f1")

str(eiffel_metadata, max.l = 2)
#> List of 13
#>  $ @id        : chr "https://gallica.bnf.fr/iiif/ark:/12148/btv1b9055204k/manifest.json"
#>  $ label      : chr "BnF, département Estampes et photographie, EI-13 (2726)"
#>  $ attribution: chr "Bibliothèque nationale de France"
#>  $ license    : chr "https://gallica.bnf.fr/html/und/conditions-dutilisation-des-contenus-de-gallica"
#>  $ logo       : chr "https://gallica.bnf.fr/mbImage/logos/logo-bnf.png"
#>  $ related    : chr "https://gallica.bnf.fr/ark:/12148/btv1b9055204k"
#>  $ seeAlso    :List of 1
#>   ..$ : chr "http://oai.bnf.fr/oai2/OAIHandler?verb=GetRecord&metadataPrefix=oai_dc&identifier=oai:bnf.fr:gallica/ark:/12148/btv1b9055204k"
#>  $ description: chr "Monuments de Paris : La Tour Eiffel : [photographie de presse] / Agence Meurisse"
#>  $ metadata   :List of 14
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>   ..$ :List of 2
#>  $ sequences  :List of 1
#>   ..$ :List of 4
#>  $ thumbnail  :List of 1
#>   ..$ @id: chr "https://gallica.bnf.fr/ark:/12148/btv1b9055204k.thumbnail"
#>  $ @type      : chr "sc:Manifest"
#>  $ @context   : chr "http://iiif.io/api/presentation/2/context.json"
```

You can query both data and associated metadata using the
`bi_all_data()` function and get a nicely formatted tibble:

``` r
bi_all_data("ark:/12148/btv1b9055204k/f1", size = c(15, 7))
#> Called from: bi_image(single_id, region, size, rotation, quality, format)
#> debug: bi_query = bi_GET(identifier, region, size, rotation, paste0(quality, 
#>     ".", format))
#> debug: if (bi_query$status_code == 503) {
#>     stop("The API could not be reached, please try again later")
#> } else if (bi_query$status_code == 500) {
#>     stop("The query gave no answer. Please try another query")
#> }
#> debug: if (bi_query$status_code == 500) {
#>     stop("The query gave no answer. Please try another query")
#> }
#> debug: magick::image_read(bi_query$content)
#> # A tibble: 1 x 3
#>   identifier                  image      metadata         
#>   <chr>                       <list>     <list>           
#> 1 ark:/12148/btv1b9055204k/f1 <magck-mg> <named list [13]>
```

You can also provide several identifiers to `bi_all_data()`:

``` r
bi_all_data(c("ark:/12148/btv1b9055204k/f1",
              "ark:/12148/btv1b90055455/f1"))
#> Called from: bi_image(single_id, region, size, rotation, quality, format)
#> debug: bi_query = bi_GET(identifier, region, size, rotation, paste0(quality, 
#>     ".", format))
#> debug: if (bi_query$status_code == 503) {
#>     stop("The API could not be reached, please try again later")
#> } else if (bi_query$status_code == 500) {
#>     stop("The query gave no answer. Please try another query")
#> }
#> debug: if (bi_query$status_code == 500) {
#>     stop("The query gave no answer. Please try another query")
#> }
#> debug: magick::image_read(bi_query$content)
#> Called from: bi_image(single_id, region, size, rotation, quality, format)
#> debug: bi_query = bi_GET(identifier, region, size, rotation, paste0(quality, 
#>     ".", format))
#> debug: if (bi_query$status_code == 503) {
#>     stop("The API could not be reached, please try again later")
#> } else if (bi_query$status_code == 500) {
#>     stop("The query gave no answer. Please try another query")
#> }
#> debug: if (bi_query$status_code == 500) {
#>     stop("The query gave no answer. Please try another query")
#> }
#> debug: magick::image_read(bi_query$content)
#> # A tibble: 2 x 3
#>   identifier                  image      metadata         
#>   <chr>                       <list>     <list>           
#> 1 ark:/12148/btv1b9055204k/f1 <magck-mg> <named list [13]>
#> 2 ark:/12148/btv1b90055455/f1 <magck-mg> <named list [13]>
```

## Related projects

[`gargallica`](GuillaumePressiat/gargallica) is a collection of script
and functions to retrieve data from the regular Gallica API.

## Code of Conduct

Please note that the `bnfimage` project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
