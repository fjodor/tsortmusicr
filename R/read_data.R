###########################################################################################
#' Importing Full Data from tsort.info
#'
#' \code{tsm_read_chart} reads the complete set of data published at \url{https://tsort.info}.
#' A wrapper for readr::read_csv.
#'
#' Note that usage of data from tsort.info is free under the following conditions:
#'
#' 1. Acknowledge the source.
#'
#' 2. Prominently link to \url{https://tsort.info}
#'
#' 3. Always include version number.
#'
#' @family read functions
#'
#' @param version The version in string format.
#' @param na How unknown years are encoded, in string format.
#' @param tsort_path URL to Website.
#' @param ... Pass additional parameters to readr::read_csv. See ?read_csv for details.
#' @return A tibble (and data.frame) created from readr::read_csv.
#' @return Additional attribute: file version. Access it: attr(data, "version")
#' @examples
#' \dontrun{
#' ## Read full data; this takes a while to run
#' chart <- tsm_read_chart()
#'
#' ## Using additional parameter from readr::read_csv
#' ## Extract only first 1000 rows of data
#' chart <- tsm_read_chart(n_max = 1000)
#'
#' ## Access file version number:
#' attr(chart, "version")
#' }
#' @export
#'
tsm_read_chart <- function(version = "2-8-0023",
                       na = "unknown",
                       tsort_path = "https://tsort.info/",
                       ...) {
  data <- readr::read_csv(paste0(tsort_path, "tsort-chart-", version),
                  na = c("", "NA", na), ...)
  attr(data, "version") <- version
  data
}

#'

# test <- read_chart()

# test <- read_chart(version = "3")
# Error handling


###########################################################################################
#' Importing Song Data from tsort.info
#'
#' \code{tsm_read_songs} reads the top 5000 songs.
#' A wrapper for readr::read_csv.
#'
#' Note that usage of data from tsort.info is free under the following conditions:
#'
#' 1. Acknowledge the source.
#'
#' 2. Prominently link to \url{https://tsort.info}
#'
#' 3. Always include version number.
#'
#' @family read functions
#' @inheritParams tsm_read_chart
#' @examples
#' \dontrun{
#' ## Read Top 5000 songs
#' songs <- tsm_read_songs(version = "2-8-0023")
#'
#' ## Access file version number:
#' attr(songs, "version")
#'}
#' @export

tsm_read_songs <- function(version = "2-8-0023",
                           na = "unknown",
                           tsort_path = "https://tsort.info/csv/",
                           ...)      {
  data <- readr::read_csv(paste0(tsort_path, "top5000songs-", version),
                  na = c("", "NA", na), ...)
  attr(data, "version") <- version
  data
}



########################################################################
# Get current file version number
#'
#' \code{tsm_get_version} Extracts the current file version used at \url{https://tsort.info}.
#' @example
#' ## Get current file version.
#' tsm_get_version()
#' @export

tsm_get_version <- function(url = "https://tsort.info/music/faq_version_numbers.htm") {
  # webpage_version <- read_html(url)
  # webpage_version <- read.table(file = url)
  version <- httr::GET(url)
  version <- httr::content(version, "text")
  start <- stringi::stri_locate_first(version, fixed = "CSV File: tsort-chart-")[1, 2] + 1
  suchtext <- substr(x = version, start = start, stop = start + 14)
  end <- stringi::stri_locate_first(suchtext, fixed = ".csv")[1, 1] - 1
  # list(version = version, start = start, end = end)
  version <- substr(x = version, start = start, stop = start + end - 1)
  version
}

webpage_version <- tsm_get_version()
