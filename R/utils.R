bi_GET = function(...) {
  httr::GET(url = paste(bi_base(), ..., collapse = "/", sep = "/"))
}

bi_base = function() {
  "https://gallica.bnf.fr/iiif"
}
