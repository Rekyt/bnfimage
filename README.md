
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `bnfimage` – API client to BnF images

<!-- badges: start -->

<!-- badges: end -->

`bnfimage` is an R client for the [BnF images
API](http://api.bnf.fr/api-iiif-de-recuperation-des-images-de-gallica)

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

image(eiffel_tower)
```

You can get the metadata associated with this image using
`bi_metadata()`:

``` r
eiffel_metadata = bi_metadata("ark:/12148/btv1b9055204k/f1")

str(eiffel_metadata)
```

## Code of Conduct

Please note that the `bnfimage` project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
