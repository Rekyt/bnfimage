#' Retrieve image from BNF
#'
#' @param identifier \[`character(1)`\]\cr{}
#'                   identifier of the document that begins with `"ark:/"`
#' @param region     \[`character(1)` or `integer(4)`\]\cr{}
#'                   either `"full"` to retrieve the full image or a vector of
#'                   four integers that defines the region to extract from the
#'                   image
#' @param size       \[`character(1)` or `integer(2)`\]\cr{}
#'                   either `"full"` to retrieve the full region or a vector of
#'                   two integers that defines the size of the final image
#' @param rotation   \[`numeric(1)`\]\cr{}
#'                   an integer that defines the rotation in degrees to apply
#'                   to the final image (`0` for no rotation)
#' @param quality    \[`character(1)`\]\cr{}
#'
#' * `"native"` for native colors of the image or,
#' * `"color"` for the image in color,
#' * `"gray"` for levels of gray,
#' * `"bitonal"` for only black and white pixels.
#' @param format     \[`character(1)`\]\cr{}
#'
#' * `"jpg"` for JPEG image,
#' * `"tif"` for TIFF image,
#' * `"png"` for PNG image,
#' * `"gif"` for GIF image,
#' * `"jp2"` for JP2 image,
#' * `"pdf"` for PDF image.
#'
#' @return a matrix of the image
#' @export
bi_image = function(identifier = NULL, region = c(0L, 0L, 500L, 500L),
                    size = "full", rotation = 0,
                    quality = c("native", "color", "gray", "bitonal"),
                    format = c("jpg", "tif", "png", "gif", "jp2", "pdf")) {

  if (is_null_or_na(identifier)) {
    stop("Define an identifier for your image")
  }

  bi_check_identifier(identifier)

  if (is.numeric(region) & length(region) == 4) {
    region = paste(region, collapse = ",")
  } else if ((is.numeric(region) & length(region) != 4) |
             (is.character(region) &
              (region[1] != "full" | length(region) != 1))) {
    stop("region has to be a length 4 integer vector or 'full'")
  }

  if (is.numeric(size) & length(size) != 2) {
    stop("size has to be either 'full' or a numeric vector of length 2")
  } else if (is.numeric(size)) {
    size = paste(size, collapse = ",")
  } else if (size != "full" & !is.numeric(size)) {
    stop("size has to be either 'full' or a numeric vector of length 2")
  }

  if (!is.numeric(rotation) | (is.numeric(rotation) & length(rotation) != 1)) {
    stop("rotation has to be a numeric vector of length 1")
  }

  quality = match.arg(quality)
  format = match.arg(format)

  bi_query = bi_GET(identifier, region, size, rotation,
                    paste0(quality, ".", format))


  if (bi_query$status_code == 503) {
    stop("The API could not be reached, please try again later")
  } else if (bi_query$status_code == 500) {
    stop("The query gave no answer. Please try another query")
  }

  magick::image_read(bi_query$content)
}
