#' Retrieve BnF image metadata
#'
#' @inheritParams bi_image
#' @export
bi_metadata = function(identifier = NULL) {
  if (is.null(identifier)) {
    stop("Define an identifier for your image")
  }

  bi_query = bi_GET(identifier, "manifest.json")
  httr::http_error(bi_query)
  httr::content(bi_query)
}
