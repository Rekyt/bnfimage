test_that("bi_image() fails gracefully on wrong arguments", {
  # Test for identifier
  expect_error(bi_image(NULL),
               "Define an identifier for your image", fixed = TRUE)
  expect_error(bi_image(NA),
               "Define an identifier for your image", fixed = TRUE)
  expect_error(bi_image("abc"),
               "identifier is not valid", fixed = TRUE)

  # Test for region
  expect_error(bi_image("ark:/12148/abc", region = "a"),
               "region has to be a length 4 integer vector or 'full'",
               fixed = TRUE)
  expect_error(bi_image("ark:/12148/abc", region = c(0, 0)),
               "region has to be a length 4 integer vector or 'full'",
               fixed = TRUE)

  # Test for size
  expect_error(bi_image("ark:/12148/abc", size = "a"),
               "size has to be either 'full' or a numeric vector of length 2",
               fixed = TRUE)
  expect_error(bi_image("ark:/12148/abc", size = c(0, 0, 0)),
               "size has to be either 'full' or a numeric vector of length 2",
               fixed = TRUE)

  # Test for rotation
  expect_error(bi_image("ark:/12148/abc", rotation = "a"),
               "rotation has to be a numeric vector of length 1",
               fixed = TRUE)
  expect_error(bi_image("ark:/12148/abc", rotation = c(0, 0)),
               "rotation has to be a numeric vector of length 1",
               fixed = TRUE)

  # Test for quality
  expect_error(bi_image("ark:/12148/abc", quality = "a"),
               paste0("'arg' should be one of ", dQuote("native"), ", ",
                      dQuote("color"), ", ", dQuote("gray"), ", ",
                      dQuote("bitonal")),
               fixed = TRUE)
  expect_error(bi_image("ark:/12148/abc", quality = 1),
               "'arg' must be NULL or a character vector", fixed = TRUE)

  # Test for format
  expect_error(bi_image("ark:/12148/abc", format = "x"),
               paste0("'arg' should be one of ", dQuote("jpg"), ", ",
                      dQuote("tif"), ", ", dQuote("png"), ", ", dQuote("gif"),
                      ", ", dQuote("jp2"), ", ", dQuote("pdf")),
               fixed = TRUE)
  expect_error(bi_image("ark:/12148/abc", format = 1),
               "'arg' must be NULL or a character vector", fixed = TRUE)
})

use_cassette("bi_image_error", {
  test_that("bi_image() fails gracefully when sending a wrong query", {
    expect_error(
      bi_image(
        identifier = "ark:/12148/12345",
        region     = "full",
        size       = c(15, 7),
        rotation   = 0,
        quality    = "native",
        format     = "png"),
      "The query gave no answer. Please try another query", fixed = TRUE)
  })
})

use_cassette("bi_image_works", {
  test_that("bi_image() works with correct query", {

    # Regular query
    eiffel_tower = bi_image(
      identifier = "ark:/12148/btv1b9055204k/f1",
      region     = "full",
      size       = c(150, 75),
      rotation   = 0,
      quality    = "native",
      format     = "png")

    expect_is(eiffel_tower, "magick-image")

    eiffel_info = magick::image_info(eiffel_tower)

    expect_equal(eiffel_info,
                 tibble::tibble(
                   format = "PNG",
                   width = 150L,
                   height = 75L,
                   colorspace = "Gray",
                   matte = FALSE,
                   filesize = 22533L,
                   density = "+157x+157"
                 ))
  })
})

use_cassette("bi_image_smaller", {

  test_that("bi_image() works with options", {
    # Smaller size
    eiffel_tower = bi_image(
      identifier = "ark:/12148/btv1b9055204k/f1",
      region     = "full",
      size       = c(15, 7),
      rotation   = 0,
      quality    = "native",
      format     = "png")
    expect_is(eiffel_tower, "magick-image")

    eiffel_info = magick::image_info(eiffel_tower)

    expect_equal(eiffel_info,
                 tibble::tibble(
                   format = "PNG",
                   width = 15L,
                   height = 7L,
                   colorspace = "Gray",
                   matte = FALSE,
                   filesize = 306L,
                   density = "+157x+157"
                 ))


    # Change image format
    ## JPEG
    eiffel_tower = bi_image(
      identifier = "ark:/12148/btv1b9055204k/f1",
      region     = "full",
      size       = c(15, 7),
      rotation   = 0,
      quality    = "native",
      format     = "jpg")
    expect_is(eiffel_tower, "magick-image")

    eiffel_info = magick::image_info(eiffel_tower)

    expect_equal(eiffel_info,
                 tibble::tibble(
                   format = "JPEG",
                   width = 15L,
                   height = 7L,
                   colorspace = "Gray",
                   matte = FALSE,
                   filesize = 224L,
                   density = "+400x+400"
                 ))
    ## TIFF
    eiffel_tower = bi_image(
      identifier = "ark:/12148/btv1b9055204k/f1",
      region     = "full",
      size       = c(15, 7),
      rotation   = 0,
      quality    = "native",
      format     = "tif")
    expect_is(eiffel_tower, "magick-image")

    eiffel_info = magick::image_info(eiffel_tower)

    expect_equal(eiffel_info,
                 tibble::tibble(
                   format = "TIFF",
                   width = 15L,
                   height = 7L,
                   colorspace = "Gray",
                   matte = FALSE,
                   filesize = 525L,
                   density = "+400x+400"
                 ))

    # Color
    ## Color
    eiffel_tower = bi_image(
      identifier = "ark:/12148/btv1b9055204k/f1",
      region     = "full",
      size       = c(15, 7),
      rotation   = 0,
      quality    = "color",
      format     = "gif")
    expect_is(eiffel_tower, "magick-image")

    eiffel_info = magick::image_info(eiffel_tower)

    expect_equal(eiffel_info,
                 tibble::tibble(
                   format = "GIF",
                   width = 15L,
                   height = 7L,
                   colorspace = "sRGB",
                   matte = FALSE,
                   filesize = 526L,
                   density = "+72x+72"))
    ## Bitonal
    eiffel_tower = bi_image(
      identifier = "ark:/12148/btv1b9055204k/f1",
      region     = "full",
      size       = c(15, 7),
      rotation   = 0,
      quality    = "bitonal",
      format     = "gif")
    expect_is(eiffel_tower, "magick-image")

    eiffel_info = magick::image_info(eiffel_tower)

    expect_equal(eiffel_info,
                 tibble::tibble(
                   format = "GIF",
                   width = 15L,
                   height = 7L,
                   colorspace = "sRGB",
                   matte = FALSE,
                   filesize = 58L,
                   density = "+72x+72"))

  })
}, preserve_exact_body_bytes = TRUE)
