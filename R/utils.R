bi_GET = function(...) {
  httr::GET(url = paste(bi_base(), ..., collapse = "/", sep = "/"),
            httr::add_headers("user-agent" = bi_ua()))
}

bi_base = function() {
  "https://gallica.bnf.fr/iiif"
}

bi_ua = function() {
  paste0("http://github.com/Rekyt/bnfimage R package bnfimage/v.",
         utils::packageVersion("bnfimage"))
}

is_null_or_na = function(x) {
  if (is.null(x)) {
    TRUE
  } else if (is.na(x)) {
    TRUE
  } else {
    FALSE
  }
}
