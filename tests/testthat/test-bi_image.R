test_that("bi_image() fails gracefully", {
  # Test for identifier
  expect_error(bi_image(NULL),
               "Define an identifier for your image", fixed = TRUE)

  # Test for region
  expect_error(bi_image("a", region = "a"),
               "region has to be a length 4 integer vector or 'full'",
               fixed = TRUE)
  expect_error(bi_image("a", region = c(0, 0)),
               "region has to be a length 4 integer vector or 'full'",
               fixed = TRUE)

  # Test for size
  expect_error(bi_image("a", size = "a"),
               "size has to be either 'full' or a numeric vector of length 2",
               fixed = TRUE)
  expect_error(bi_image("a", size = c(0, 0, 0)),
               "size has to be either 'full' or a numeric vector of length 2",
               fixed = TRUE)

  # Test for rotation
  expect_error(bi_image("a", rotation = "a"),
               "rotation has to be a numeric vector of length 1",
               fixed = TRUE)
  expect_error(bi_image("a", rotation = c(0, 0)),
               "rotation has to be a numeric vector of length 1",
               fixed = TRUE)

  # Test for quality
  expect_error(bi_image("a", quality = "a"),
               paste0("'arg' should be one of ", dQuote("native"), ", ",
                      dQuote("color"), ", ", dQuote("gray"), ", ",
                      dQuote("bitonal")),
               fixed = TRUE)
  expect_error(bi_image("a", quality = 1),
               "'arg' must be NULL or a character vector", fixed = TRUE)

  # Test for format
  expect_error(bi_image("a", format = "x"),
               paste0("'arg' should be one of ", dQuote("jpg"), ", ",
                      dQuote("tif"), ", ", dQuote("png"), ", ", dQuote("gif"),
                      ", ", dQuote("jp2"), ", ", dQuote("pdf")),
               fixed = TRUE)
  expect_error(bi_image("a", format = 1),
               "'arg' must be NULL or a character vector", fixed = TRUE)
})
