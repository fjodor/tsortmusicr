#' Importing Full Data from tsort.info
#'
#' \code{read_chart} reads the complete set of data published at https://tsort.info.
#'
#' @family read functions
#'
#' @param version The version in string format.
#' @param na How unknown years are encoded, in string format.
#' @param tsort_path URL to Website.
#'
#'@export
#'
tsm_read_chart <- function(version = "2-8-0023",
                       na = "unknown",
                       tsort_path = "https://tsort.info/")      {
  readr::read_csv(paste0(tsort_path, "tsort-chart-", version),
                  na = c("", "NA", na))
}

#'

# test <- read_chart()

# test <- read_chart(version = "3")
# Error handling

#' Importing Song Data from tsort.info
#'
#' \code{read_songs} reads the top 5000 songs.
#'
#' @family read functions
#' @inheritParams tsm_read_chart
#' @export

tsm_read_songs <- function(version = "2-8-0023",
                           na = "unknown",
                           tsort_path = "https://tsort.info/csv/")      {
  readr::read_csv(paste0(tsort_path, "top5000songs-", version),
                  na = c("", "NA", na))
}



########################################################################
# Comments
# read_chart <- function(version = "2-8-0023", na = "unknown") {
  # readr::read_csv(paste0(music_path, "tsort-chart-", version),
  #                 col_types = cols(year = col_integer()))
  # readr::read_csv(paste0(music_path, "tsort-chart-", version))
  # readr::read_csv(paste0(music_path, "tsort-chart-", version),
                  # na = c("", "NA", na))
  # read.csv(paste0(music_path, "tsort-chart-", version))
  # readr is better
# }
