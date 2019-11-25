test_that("bi_base() works", {
  expect_equal(bi_base(), "https://gallica.bnf.fr/iiif")
})

test_that("bi_ua() works", {
  expect_equal(bi_ua(), paste0("http://github.com/Rekyt/bnfimage R package ",
                               "bnfimage/v.0.0.1"))
})

test_that("is_null_or_na() works", {
  expect_true(is_null_or_na(NULL))
  expect_true(is_null_or_na(NA))
  expect_true(is_null_or_na(NA_character_))
  expect_true(is_null_or_na(NA_complex_))
  expect_true(is_null_or_na(NA_integer_))
  expect_true(is_null_or_na(NA_real_))

  expect_false(is_null_or_na(""))
  expect_false(is_null_or_na(0))
  expect_false(is_null_or_na(0L))
  expect_false(is_null_or_na(factor("a")))
})

test_that("bi_check_identifier() works", {
  expect_error(bi_check_identifier(NULL), "identifier is not valid",
               fixed = TRUE)
  expect_error(bi_check_identifier(NA), "identifier is not valid",
               fixed = TRUE)
  expect_error(bi_check_identifier(123), "identifier is not valid",
               fixed = TRUE)
  expect_error(bi_check_identifier("abc"), "identifier is not valid",
               fixed = TRUE)
  expect_error(bi_check_identifier("ark"), "identifier is not valid",
               fixed = TRUE)
  expect_error(bi_check_identifier("ark:/"), "identifier is not valid",
               fixed = TRUE)
  expect_error(bi_check_identifier("ark:/12148"), "identifier is not valid",
               fixed = TRUE)
  expect_error(bi_check_identifier("ark:/12148/"), "identifier is not valid",
               fixed = TRUE)
  expect_silent(bi_check_identifier("ark:/12148/abc"))
  expect_silent(bi_check_identifier("ark:/12148/123"))
  expect_silent(bi_check_identifier("ark:/12148/abc123"))
  expect_silent(bi_check_identifier("ark:/12148/btv1b9055204k/f1"))
})
