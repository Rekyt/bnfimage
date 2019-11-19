
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `bnfimage` – API client to BnF images

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Travis build
status](https://travis-ci.org/Rekyt/bnfimage.svg?branch=master)](https://travis-ci.org/Rekyt/bnfimage)
[![codecov](https://codecov.io/gh/Rekyt/bnfimage/branch/master/graph/badge.svg)](https://codecov.io/gh/Rekyt/bnfimage)
[![CRAN-version](https://www.r-pkg.org/badges/version/bnfimage)](https://cran.r-project.org/package=bnfimage)

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

str(eiffel_tower)
#> Class 'magick-image' <externalptr>

eiffel_tower
```

<img src="man/figures/README-example-1.png" width="100%" />

You can get the metadata associated with this image using
`bi_metadata()`:

``` r
eiffel_metadata = bi_metadata("ark:/12148/btv1b9055204k/f1")

str(eiffel_metadata)
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
#>   .. ..$ label: chr "Repository"
#>   .. ..$ value: chr "Bibliothèque nationale de France"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Digitised by"
#>   .. ..$ value: chr "Bibliothèque nationale de France"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Source Images"
#>   .. ..$ value: chr "https://gallica.bnf.fr/ark:/12148/btv1b9055204k"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Metadata Source"
#>   .. ..$ value: chr "http://oai.bnf.fr/oai2/OAIHandler?verb=GetRecord&metadataPrefix=oai_dc&identifier=oai:bnf.fr:gallica/ark:/12148/btv1b9055204k"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Shelfmark"
#>   .. ..$ value: chr "Bibliothèque nationale de France, département Estampes et photographie, EI-13 (2726)"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Title"
#>   .. ..$ value: chr "Monuments de Paris : La Tour Eiffel : [photographie de presse] / Agence Meurisse"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Date"
#>   .. ..$ value: chr "1922"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Language"
#>   .. ..$ value:List of 1
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ @value: chr "français"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Format"
#>   .. ..$ value:List of 3
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ @value: chr "1 photogr. nég. sur verre ; 13 x 18 cm (sup.) ou moins"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ @value: chr "image/jpeg"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ @value: chr "Nombre total de vues :  1"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Creator"
#>   .. ..$ value: chr "Agence de presse Meurisse. Agence photographique"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Relation"
#>   .. ..$ value: chr "Notice de recueil : http://catalogue.bnf.fr/ark:/12148/cb404994307"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Relation"
#>   .. ..$ value: chr "Appartient à : [Recueil. Actualités 1922-06-25**1923-05-14. Agence Meurisse MEU 98603-6091 A]"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Relation"
#>   .. ..$ value: chr "Notice du catalogue : http://catalogue.bnf.fr/ark:/12148/cb415818268"
#>   ..$ :List of 2
#>   .. ..$ label: chr "Type"
#>   .. ..$ value: chr "image"
#>  $ sequences  :List of 1
#>   ..$ :List of 4
#>   .. ..$ canvases:List of 1
#>   .. .. ..$ :List of 7
#>   .. .. .. ..$ @id      : chr "https://gallica.bnf.fr/iiif/ark:/12148/btv1b9055204k/canvas/f1"
#>   .. .. .. ..$ label    : chr "NP"
#>   .. .. .. ..$ height   : int 7000
#>   .. .. .. ..$ width    : int 5127
#>   .. .. .. ..$ images   :List of 1
#>   .. .. .. .. ..$ :List of 4
#>   .. .. .. .. .. ..$ motivation: chr "sc:painting"
#>   .. .. .. .. .. ..$ on        : chr "https://gallica.bnf.fr/iiif/ark:/12148/btv1b9055204k/canvas/f1"
#>   .. .. .. .. .. ..$ resource  :List of 6
#>   .. .. .. .. .. .. ..$ format : chr "image/jpeg"
#>   .. .. .. .. .. .. ..$ service:List of 3
#>   .. .. .. .. .. .. .. ..$ profile : chr "http://library.stanford.edu/iiif/image-api/1.1/compliance.html#level2"
#>   .. .. .. .. .. .. .. ..$ @context: chr "http://iiif.io/api/image/1/context.json"
#>   .. .. .. .. .. .. .. ..$ @id     : chr "https://gallica.bnf.fr/iiif/ark:/12148/btv1b9055204k/f1"
#>   .. .. .. .. .. .. ..$ height : int 7000
#>   .. .. .. .. .. .. ..$ width  : int 5127
#>   .. .. .. .. .. .. ..$ @id    : chr "https://gallica.bnf.fr/iiif/ark:/12148/btv1b9055204k/f1/full/full/0/native.jpg"
#>   .. .. .. .. .. .. ..$ @type  : chr "dctypes:Image"
#>   .. .. .. .. .. ..$ @type     : chr "oa:Annotation"
#>   .. .. .. ..$ thumbnail:List of 1
#>   .. .. .. .. ..$ @id: chr "https://gallica.bnf.fr/ark:/12148/btv1b9055204k/f1.thumbnail"
#>   .. .. .. ..$ @type    : chr "sc:Canvas"
#>   .. ..$ label   : chr "Current Page Order"
#>   .. ..$ @type   : chr "sc:Sequence"
#>   .. ..$ @id     : chr "https://gallica.bnf.fr/iiif/ark:/12148/btv1b9055204k/sequence/default"
#>  $ thumbnail  :List of 1
#>   ..$ @id: chr "https://gallica.bnf.fr/ark:/12148/btv1b9055204k.thumbnail"
#>  $ @type      : chr "sc:Manifest"
#>  $ @context   : chr "http://iiif.io/api/presentation/2/context.json"
```

## Related projects

[`gargallica`](GuillaumePressiat/gargallica) is a collection of script
and functions to retrieve data from the regular Gallica API.

## Code of Conduct

Please note that the `bnfimage` project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
