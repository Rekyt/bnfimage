
#' Retrieve both image data and metadata
#'
#' @inheritParams bi_image
#'
#' @return a tibble with both the image and the metadata
bi_all_data = function(identifier = NULL, region = c(0L, 0L, 500L, 500L),
                       size = "full", rotation = 0,
                       quality = c("native", "color", "gray", "bitonal"),
                       format = c("jpg", "tif", "png", "gif", "jp2", "pdf")) {

  image = bi_image(identifier, region, size, rotation,
                   quality, format)

  image_metadata = bi_metadata(identifier)
}
