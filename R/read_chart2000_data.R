###########################################################################################
#' Importing Song Data from chart2000.com
#'
#' \code{ch2k_read_songs} reads the top 50 songs for every month starting in January 2000 published at \url{https://chart2000.com}.
#' A wrapper for readr::read_csv with convenient defaults, see parameters.
#'
#' Note that usage of data from chart2000.com is free under the following conditions:
#'
#' 1. Acknowledge the source.
#'
#' 2. Prominently link to \url{https://chart2000.com}
#'
#' 3. Always include version number.
#'
#' @family read functions
#'
#' @param version The version in string format. Defaults to function reading the current version from chart2000.com. Example: "0-3-0073".
#' @param na How unknown years are encoded, in string format.
#' @param ch2k_path URL to Website.
#' @param ... Pass additional parameters to readr::read_csv. See ?read_csv for details.
#' @return A tibble (and data.frame) created from readr::read_csv.
#' @return Additional attribute: file version. Access it: attr(data, "version")
#' @examples
#' \dontrun{
#' ## Read Top 50 songs for each month
#' songs2000 <- ch2k_read_songs()
#'
#' ## Access file version number:
#' attr(songs2000, "version")
#'}
#' @export

ch2k_read_songs <- function(version = ch2k_get_version(),
                           na = "unknown",
                           ch2k_path = "https://chart2000.com/data/",
                           ...)      {
  data <- readr::read_csv(paste0(ch2k_path, "chart2000-songmonth-", version, ".csv"),
                          na = c("", "NA", na), ...)
  attr(data, "version") <- version
  attr(data, "spec") <- NULL
  data
}


###########################################################################################
#' Importing Album Data from chart2000.com
#'
#' \code{ch2k_read_albums} reads the top 50 albums for every month starting in January 2000 published at \url{https://chart2000.com}.
#' A wrapper for readr::read_csv with convenient defaults, see parameters.
#'
#' Note that usage of data from chart2000.com is free under the following conditions:
#'
#' 1. Acknowledge the source.
#'
#' 2. Prominently link to \url{https://chart2000.com}
#'
#' 3. Always include version number.
#'
#' @family read functions
#' @inheritParams ch2k_read_songs
#' @examples
#' \dontrun{
#' ## Read Top 50 albums for each month
#' albums2000 <- ch2k_read_albums()
#'
#' ## Access file version number:
#' attr(albums2000, "version")
#'}
#' @export

ch2k_read_albums <- function(version = ch2k_get_version(),
                           na = "unknown",
                           ch2k_path = "https://chart2000.com/data/",
                           ...)      {
  data <- readr::read_csv(paste0(ch2k_path, "chart2000-albummonth-", version, ".csv"),
                          na = c("", "NA", na), ...)
  attr(data, "version") <- version
  attr(data, "spec") <- NULL
  data
}


########################################################################
#' Get current file version number
#'
#' \code{ch2k_get_version} Extracts the current file version used at \url{https://chart2000.com}.
#'
#' Note that usage of data from chart2000.com is free under the following conditions:
#'
#' 1. Acknowledge the source.
#'
#' 2. Prominently link to \url{https://chart2000.com}
#'
#' 3. Always include version number.
#'
#' @family read functions
#' @param url Website containing information on version numbers.
#' @examples
#' ## Get current file version.
#' tsm_get_version()
#' @export

ch2k_get_version <- function(url = "https://chart2000.com/about.htm") {
  version <- httr::GET(url)
  version <- httr::content(version, "text", encoding = "UTF-8")
  start <- stringi::stri_locate_first(version, fixed = "This is version ")[1, 2] + 1
  end <- stringi::stri_locate_first(version, fixed = "of the data")[1, 1] - 2
  version <- stringi::stri_sub(version, from = start, to = end)
  version <- stringi::stri_replace_all_fixed(version, ".", "-")
  version
  # list(version = version, start = start, end = end, suchtext = suchtext)
}

