test_that("bi_all_data() fails for all bad arguments to bi_image()", {
  # Test for identifier
  expect_error(bi_all_data(NA),
               "Define an identifier for your image", fixed = TRUE)
  expect_error(bi_all_data("abc"),
               "identifier is not valid", fixed = TRUE)

  # Test for region
  expect_error(bi_all_data("ark:/12148/abc", region = "a"),
               "region has to be a length 4 integer vector or 'full'",
               fixed = TRUE)
  expect_error(bi_all_data("ark:/12148/abc", region = c(0, 0)),
               "region has to be a length 4 integer vector or 'full'",
               fixed = TRUE)

  # Test for size
  expect_error(bi_all_data("ark:/12148/abc", size = "a"),
               "size has to be either 'full' or a numeric vector of length 2",
               fixed = TRUE)
  expect_error(bi_all_data("ark:/12148/abc", size = c(0, 0, 0)),
               "size has to be either 'full' or a numeric vector of length 2",
               fixed = TRUE)

  # Test for rotation
  expect_error(bi_all_data("ark:/12148/abc", rotation = "a"),
               "rotation has to be a numeric vector of length 1",
               fixed = TRUE)
  expect_error(bi_all_data("ark:/12148/abc", rotation = c(0, 0)),
               "rotation has to be a numeric vector of length 1",
               fixed = TRUE)

  # Test for quality
  expect_error(bi_all_data("ark:/12148/abc", quality = "a"),
               paste0("'arg' should be one of ", dQuote("native"), ", ",
                      dQuote("color"), ", ", dQuote("gray"), ", ",
                      dQuote("bitonal")),
               fixed = TRUE)
  expect_error(bi_all_data("ark:/12148/abc", quality = 1),
               "'arg' must be NULL or a character vector", fixed = TRUE)

  # Test for format
  expect_error(bi_all_data("ark:/12148/abc", format = "x"),
               paste0("'arg' should be one of ", dQuote("jpg"), ", ",
                      dQuote("tif"), ", ", dQuote("png"), ", ", dQuote("gif"),
                      ", ", dQuote("jp2"), ", ", dQuote("pdf")),
               fixed = TRUE)
  expect_error(bi_all_data("ark:/12148/abc", format = 1),
               "'arg' must be NULL or a character vector", fixed = TRUE)
})

test_that("bi_all_data() works for a single image", {

  skip_on_os("windows")

  vcr::use_cassette("bi_all_data_single_image", {
    expect_silent(eiffel_tower <- bi_all_data(
      identifier = "ark:/12148/btv1b9055204k/f1",
      region     = "full",
      size       = c(15, 7),
      rotation   = 0,
      quality    = "native",
      format     = "png"))

    # Check general data.frame
    expect_is(eiffel_tower, "tbl_df")
    expect_equal(dim(eiffel_tower), c(1, 3))
    expect_named(eiffel_tower, c("identifier", "image", "metadata"))
    # Check identifier column
    expect_is(eiffel_tower$identifier, "character")
    expect_equal(eiffel_tower$identifier[[1]], "ark:/12148/btv1b9055204k/f1")
    # Check image column
    expect_is(eiffel_tower$image, "list")
    expect_is(eiffel_tower$image[[1]], "magick-image")

    eiffel_info = magick::image_info(eiffel_tower$image[[1]])
    expect_equal(eiffel_info,
                 tibble::tibble(
                   format = "PNG",
                   width = 15L,
                   height = 7L,
                   colorspace = "Gray",
                   matte = FALSE,
                   filesize = 306L,
                   density = "157x157"
                 ))
    # Check metadata column
    expect_is(eiffel_tower$metadata, "list")
    expect_is(eiffel_tower$metadata[[1]], "list")
    expect_equal(eiffel_tower$metadata[[1]]$attribution,
                 "Bibliothèque nationale de France")
  }, preserve_exact_body_bytes = TRUE)

})

test_that("bi_all_data() works for several images", {

  skip_on_os("windows")

  vcr::use_cassette("bi_all_data_several_images", {
    expect_silent(eiffel_tower <- bi_all_data(
      identifier = c("ark:/12148/btv1b9055204k/f1",
                     "ark:/12148/btv1b90055455/f1"),
      region     = "full",
      size       = c(15, 7),
      rotation   = 0,
      quality    = "native",
      format     = "png"))

    # Check general data.frame
    expect_is(eiffel_tower, "tbl_df")
    expect_equal(dim(eiffel_tower), c(2, 3))
    expect_named(eiffel_tower, c("identifier", "image", "metadata"))
    # Check identifier column
    expect_is(eiffel_tower$identifier, "character")
    expect_equal(eiffel_tower$identifier[[1]], "ark:/12148/btv1b9055204k/f1")
    expect_equal(eiffel_tower$identifier[[2]], "ark:/12148/btv1b90055455/f1")
    # Check image column
    expect_is(eiffel_tower$image, "list")
    expect_is(eiffel_tower$image[[1]], "magick-image")
    expect_is(eiffel_tower$image[[2]], "magick-image")

    eiffel_info = magick::image_info(eiffel_tower$image[[1]])
    expect_equal(eiffel_info,
                 tibble::tibble(
                   format = "PNG",
                   width = 15L,
                   height = 7L,
                   colorspace = "Gray",
                   matte = FALSE,
                   filesize = 306L,
                   density = "157x157"
                 ))
    eiffel_info = magick::image_info(eiffel_tower$image[[2]])
    expect_equal(eiffel_info,
                 tibble::tibble(
                   format = "PNG",
                   width = 15L,
                   height = 7L,
                   colorspace = "sRGB",
                   matte = FALSE,
                   filesize = 1021L,
                   density = "118x118"
                 ))
    # Check metadata column
    expect_is(eiffel_tower$metadata, "list")
    expect_is(eiffel_tower$metadata[[1]], "list")
    expect_is(eiffel_tower$metadata[[2]], "list")
    expect_equal(eiffel_tower$metadata[[1]]$attribution,
                 "Bibliothèque nationale de France")
    expect_equal(eiffel_tower$metadata[[2]]$attribution,
                 "Bibliothèque nationale de France")
    expect_equal(eiffel_tower$metadata[[1]]$label,
                 "BnF, département Estampes et photographie, EI-13 (2726)")
    expect_equal(eiffel_tower$metadata[[2]]$label,
                 "BnF, ENT DN-1 (CHERET,Jules/98)-ROUL")
  }, preserve_exact_body_bytes = TRUE)
})
