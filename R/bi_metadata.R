#' Retrieve BnF image metadata
#'
#' @inheritParams bi_image
#' @includeRmd man/rmdchunks/_rate_limitation.Rmd
#' @export
bi_metadata = function(identifier = NULL) {
  if (is.null(identifier)) {
    stop("Define an identifier for your image")
  }

  bi_check_identifier(identifier)

  bi_query = bi_GET_lim(identifier, "manifest.json")

  bi_content = httr::content(bi_query, encoding = "UTF-8")

  bi_error = ifelse(!is.null(bi_content$ErrorFragment$contenu), TRUE, FALSE)

  if (bi_query$status_code == 503) {
    stop("The API could not be reached, please try again later")
  } else if (bi_query$status_code == 500 |
             bi_error) {
    stop("The query gave no answer. Please try another query")
  }

  return(bi_content)
}
