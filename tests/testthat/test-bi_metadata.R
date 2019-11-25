
test_that("bi_metadata() fails when forgetting id", {
  expect_error(bi_metadata(NULL),
               "Define an identifier for your image",
               fixed = TRUE)
  expect_error(bi_metadata("abc"),
               "identifier is not valid", fixed = TRUE)
})

vcr::use_cassette("bi_metadata", {
  test_that("bi_metadata() fails gracefully", {
    expect_error(bi_metadata("ark:/12148/12345"),
                 "The query gave no answer. Please try another query",
                 fixed = TRUE)
  })


  test_that("bi_metadata() works when using good id", {
    expect_silent(eif  <- bi_metadata("ark:/12148/btv1b9055204k/f1"))

    expect_is(eif, "list")
    expect_length(eif, 13)
    expect_equal(eif[["@id"]],
                 paste0("https://gallica.bnf.fr/iiif/ark:/12148/btv1b9055204k/",
                        "manifest.json"))
    expect_equal(eif[["logo"]],
                 "https://gallica.bnf.fr/mbImage/logos/logo-bnf.png")
  })
})

