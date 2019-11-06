
#' Retrieve both image data and metadata
#'
#' This function queries both data and associated metadata from a BNF image
#' using specified parameters and return the information in a tidy data.frame
#' @param identifier \[`character(1+)`\]\cr{}
#'                   one or multiple identifier(s) of the document that begins
#'                   with `"ark:/"`
#' @inheritParams bi_image
#'
#' @return a tibble with both the image and the metadata, with one row per
#'         identifier
#' @export
bi_all_data = function(identifier = NULL, region = c(0L, 0L, 500L, 500L),
                       size = "full", rotation = 0,
                       quality = c("native", "color", "gray", "bitonal"),
                       format = c("jpg", "tif", "png", "gif", "jp2", "pdf")) {

  image = lapply(identifier, function(single_id) {
    bi_image(single_id, region, size, rotation, quality, format)
  })

  image = setNames(image, NULL)

  image_metadata = setNames(lapply(identifier, bi_metadata), NULL)

  tibble::tibble(identifier = identifier,
                 image      = image,
                 metadata   = image_metadata)
}
