bi_GET = function(...) {
  httr::GET(url = paste(bi_base(), ..., collapse = "/", sep = "/"),
            httr::add_headers("user-agent" = bi_ua()))
}

# Rate limit version that allows only one query every 3 seconds
bi_GET_lim = ratelimitr::limit_rate(
  bi_GET, ratelimitr::rate(1, 3)
)

bi_base = function() {
  "https://gallica.bnf.fr/iiif"
}

bi_ua = function() {
  paste0("http://github.com/Rekyt/bnfimage R package bnfimage/v.",
         utils::packageVersion("bnfimage"))
}

bi_check_identifier = function(id) {
  if (!grepl("^ark:/12148/[\\w/]+$", toString(id), perl = TRUE)) {
    stop("identifier is not valid", call. = FALSE)
  }
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
