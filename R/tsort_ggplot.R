#' Boxplots for tsort.info data
#'
#' Create boxplot including original data points.
#'
#' @param data Data frame to use for plotting
#' @param x Categorical variable
#' @param y Continuous variable
#' @param max_cats Maximum number of categories to be displayed
#' @param title Plot title
#' @param subtitle Plot subtitle
#' @param farben Vector of colors. Defaults to palette "Dark2".
#'
#' @return Data is returned silently, so that plotting can be used within a pipe.
#' @export
#'
#' @examples
#'
#' tsm_ggbox(albums)
#' tsm_ggbox(albums, title = "Release years of albums by selected bands"
#'                   subtitle = "")
#' tsm_ggbox(albums) + tsm_theme()

tsm_ggbox <- function(data,
                      x = artist, y = year,
                      max_cats = 15,
                      title = "Album release years",
                      subtitle = "Boxplots and raw data points",
                      farben = tmaptools::get_brewer_pal("Dark2", n = max_cats)) {
  if(length(levels(factor(data[["artist"]] > max_cats)))) {
    message(paste("More than", max_cats, "artists present in data.\nThe", max_cats, "most frequent artists are displayed."))
    artists <- data %>%
      group_by(artist) %>%
      summarise(N = n()) %>%
      arrange(desc(N)) %>%
      slice(1:max_cats) %>%
      pull(artist)
    data <- filter(data, artist %in% artists)
  }

  plot <- ggplot2::ggplot(data, ggplot2::aes(x = forcats::fct_rev(forcats::fct_infreq({{x}})), y = {{y}}, col = artist)) +
    ggplot2::geom_boxplot(outlier.color = NA) +
    ggplot2::geom_jitter(width = 0.3, alpha = 0.7) +
    ggplot2::coord_flip() +
    ggplot2::labs(x = "", y = "Release year",
         title = title,
         subtitle = subtitle,
         caption = paste("Source: tsort.info, version", attr(data, "version"))) +
    ggplot2::scale_color_manual(values = farben) +
    ggplot2::theme(legend.position = "none",
          panel.grid.major.y = ggplot2::element_blank(),
          panel.grid.minor.y = ggplot2::element_blank())
  print(plot)
  invisible(data)
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
