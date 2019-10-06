test_that("bi_base() works", {
  expect_equal(bi_base(), "https://gallica.bnf.fr/iiif")
})

test_that("bi_ua() works", {
  expect_equal(bi_ua(), paste0("http://github.com/Rekyt/bnfimage R package ",
                               "bnfimage/v.0.0.1"))
})
