#' Functions to work with data from https://tsort.info/ - The World's Music Charts
#'
#' Work in progress! Not a finished package! Functions and function names are likely to change in future versions.
#'
#' Currently implemented:
#'
#' Functions to read data from https://tsort.info
#'
#' \itemize{
#'     \item tsm_read_songs(): Wrapper around readr::read_csv to read Top 5000 songs from tsort.info, with convenient defaults (url, file name, NA coding).
#'     \item tsm_read_albums(): Wrapper around readr::read_csv to read Top 3000 albums from tsort.info, with convenient defaults.
#'     \item tsm_read_chart(): Wrapper around readr::read_csv to read full chart data from tsort.info, with convenient defaults.
#'     \item tsm_get_version(): Function to find out current file version.
#' }
#'
#' Functions to read data from https://chart2000.com
#'
#' \itemize{
#'     \item ch2k_read_songs(): Wrapper around readr::read_csv to read Top 50 songs from chart2000.com, with convenient defaults (url, file name, NA coding).
#'     \item ch2k_read_albums(): Wrapper around readr::read_csv to read Top 50 albums from chart2000.com, with convenient defaults.
#'     \item ch2k_get_version(): Function to find out current file version.
#' }
#'
#' @section Data frames:
#' Note that usage of data from tsort.info and chart2000.com is free under the following conditions:
#'
#' \enumerate{
#'     \item Acknowledge the source.
#'     \item Prominently link to https://tsort.info or https://chart2000.com respectively.
#'     \item Always include version number.
#' }
#'
#' Data frames that ship with the package:
#'
#' \itemize{
#'     \item songs: Top 5000 Songs from tsort.info, 9 variables, version 2-8-0025.
#'     \item albums: Top 3000 Albums from tsort.info, 9 variables, version 2-8-0025.
#'     \item chart: Full data from tsort.info, 71141 rows, 17 variables, version 2-8-0025.
#' }
#'
#' @section Plans:
#' Provide some functions for displaying these data.
#'
#' @name tsortmusicr
"_PACKAGE"
