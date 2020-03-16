#' Boxplots for tsort.info data
#'
#' Create boxplot including original data points.
#'
#' @param data Data frame to use for plotting
#' @param xvar Categorical variable
#' @param yvar Continuous variable
#' @param max_cats Maximum number of categories to be displayed
#' @param title Plot title
#' @param subtitle Plot subtitle
#' @param farben Vector of colors. Defaults to palette "Dark2".
#'
#' @return ggplot object, so that it can be further manipulated (e. g. apply different theme, theme options)
#' @export
#'
#' @examples
#'
#' tsm_ggbox(albums)
#' tsm_ggbox(albums, title = "Release years of albums by selected bands"
#'                   subtitle = "")
#' albums %>%
#'    filter(artist != "Original Soundtrack") %>%
#'    tsm_ggbox()

tsm_ggbox <- function(data,
                      xvar = artist, yvar = year,
                      max_cats = 15,
                      title = "Album release years",
                      subtitle = "Boxplots and raw data points",
                      farben = tmaptools::get_brewer_pal("Dark2", n = max_cats, plot = FALSE)) {

  nlev <- data %>%
    dplyr::pull({{ xvar }}) %>%
    factor() %>%
    levels() %>%
    length()

  if(nlev > max_cats) {
    message(paste0("More than ", max_cats, " unique values of ", deparse(substitute(xvar)), " present in data.\nThe ",
                   max_cats, " most frequent values are displayed."))
  }

  selection <- data %>%
      dplyr::group_by({{ xvar }}) %>%
      dplyr::summarise(N = n()) %>%
      dplyr::arrange(desc(N)) %>%
      dplyr::slice(1:max_cats) %>%
      dplyr::pull({{ xvar}} )
    data <- data %>%
      dplyr::filter({{ xvar }} %in% selection)

  plot <- ggplot2::ggplot(data, ggplot2::aes(x = forcats::fct_rev(forcats::fct_infreq({{ xvar }})),
                                             y = {{ yvar }}, col = {{ xvar }})) +
    ggplot2::geom_boxplot(outlier.color = NA) +
    ggplot2::geom_jitter(width = 0.3, alpha = 0.7) +
    ggplot2::coord_flip() +
    ggplot2::labs(x = "", y = "Release year",
         title = title,
         subtitle = subtitle,
         caption = paste("Source: tsort.info, version", attr(data, "version"))) +
    ggplot2::scale_color_manual(values = farben) +
    tsm_theme() +
    ggplot2::theme(legend.position = "none",
          panel.grid.major.y = ggplot2::element_blank(),
          panel.grid.minor.y = ggplot2::element_blank())
  print(plot)
  # invisible(data)
}

#' A ggplot2 theme for plotting tsort.info data.
#'
#' Function to be used within ggplot2 calls or ggplot2 functions within the tsortmusicr package.
#'
#' @return No return value.
#' @export
#'
#' @examples tsm_ggbox() + tsm_theme()

tsm_theme <- function() {
  ggplot2::theme_bw() +
    ggplot2::theme(text = ggplot2::element_text(size = 16, family = "serif"))
}
