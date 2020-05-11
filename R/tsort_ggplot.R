#' Boxplots for tsort.info data
#'
#' Create boxplot including original data points.
#'
#' @param data data frame to use for plotting
#' @param xvar categorical variable
#' @param yvar continuous variable
#' @param label a variable that can be used in plotly::ggploty() to label data points
#' @param max_cats maximum number of categories to be displayed
#' @param title plot title
#' @param subtitle plot subtitle
#' @param farben vector of colors. Defaults to palette "Dark2"
#'
#' @return ggplot object, so that it can be further manipulated (e. g. apply different theme, theme options)
#' @export
#'
#' @examples
#'
#' library(dplyr)
#' tsm_ggbox(albums)
#' tsm_ggbox(albums, title = "Release years of albums by selected bands",
#'                   subtitle = "")
#' albums %>%
#'    filter(artist != "Original Soundtrack") %>%
#'    tsm_ggbox()

tsm_ggbox <- function(data,
                      xvar = artist, yvar = year,
                      label = name,
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
      dplyr::summarise(N = dplyr::n()) %>%
      dplyr::arrange(dplyr::desc(N)) %>%
      dplyr::slice(1:max_cats) %>%
      dplyr::pull({{ xvar }} )
    data <- data %>%
      dplyr::filter({{ xvar }} %in% selection)

  xvar <- forcats::fct_rev(forcats::fct_infreq(data[[deparse(substitute(xvar))]]))
  plot <- ggplot2::ggplot(data, ggplot2::aes(x = {{ xvar }}, y = {{ yvar }},
                                             label = {{ label }}, col = {{ xvar }})) +
    ggplot2::geom_boxplot(outlier.color = NA) +
    ggplot2::geom_jitter(width = 0.2, alpha = 0.7) +
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
  return(plot)
  # invisible(data)
}

#' A ggplot2 theme for plotting tsort.info data.
#'
#' Function to be used within ggplot2 calls or ggplot2 functions within the tsortmusicr package.
#'
#' @return A complete ggplot2 theme based on theme_bw(). Font size 14, text family "serif"
#' @export
#'
#' @examples
#' library(ggplot2)
#' p <- ggplot(albums, aes(x = year, y = final_score)) +
#'    geom_jitter(alpha = 0.7) +
#'    labs(title = "Final score by year")
#' p
#' p + tsm_theme()

tsm_theme <- function() {
  ggplot2::theme_bw() +
    ggplot2::theme(text = ggplot2::element_text(size = 14, family = "serif"))
}

#' Interactive boxplot using plotly
#'
#' @param p A ggplot2 boxplot, preferably created using tsm_ggbox()
#' @param tooltip Which information shall be displayed on mouseover? Choices are "x", "y", and "label"
#'
#' @return An interactive plotly boxplot
#' @export
#'
#' @examples
#' p <- tsm_ggbox(albums)
#' tsm_ggbox_plotly(p)

tsm_ggbox_plotly <- function(p, tooltip = c("x", "y", "label")) {
  plotly::ggplotly(p, tooltip = tooltip)
}
