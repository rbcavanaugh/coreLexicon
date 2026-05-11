
#' get results plot
#'
#' @param dat data
#' @param interactive TRUE for plotly (Shiny), FALSE for static ggplot (PDF report)
#'
#' @export
get_results_plot <- function(dat, time, basesize = 16, interactive = TRUE){

  prod <- dat[[2]] %>%
    dplyr::mutate(
      Cohort = ifelse(dists == 'dist1' | dists == 'dist3', 'control', 'aphasia'),
      met = factor(ifelse(dists == 'dist1' | dists == 'dist2', 'Production', 'Efficiency'),
                   levels = c('Production', 'Efficiency'))
    ) %>%
    dplyr::filter(met == "Production") %>%
    ggplot2::ggplot(ggplot2::aes(x = val, fill = Cohort)) +
    ggplot2::geom_density(alpha = .3, adjust = 1.5) +
    ggplot2::geom_vline(data = tibble::tibble(xint = dat[[3]][[1]]),
                        ggplot2::aes(xintercept = xint), linetype = "dashed", size = 1) +
    ggplot2::theme_minimal(base_size = basesize) +
    ggplot2::theme(
      legend.position = 'bottom',
      axis.title.y = ggplot2::element_blank(),
      axis.title.x = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank(),
      legend.title = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::scale_fill_manual(values = c("#E66100", "#5D3A9B"))

  if(time > 0){
    eff <- dat[[2]] %>%
      dplyr::mutate(
        Cohort = ifelse(dists == 'dist1' | dists == 'dist3', 'control', 'aphasia'),
        met = factor(ifelse(dists == 'dist1' | dists == 'dist2', 'Production', 'Efficiency'),
                     levels = c('Production', 'Efficiency'))
      ) %>%
      dplyr::filter(met == "Efficiency") %>%
      ggplot2::ggplot(ggplot2::aes(x = val, fill = Cohort)) +
      ggplot2::geom_density(alpha = .3, adjust = 1.5) +
      ggplot2::geom_vline(data = tibble::tibble(xint = dat[[3]][[2]]),
                          ggplot2::aes(xintercept = xint), linetype = "dashed", size = 1) +
      ggplot2::theme_minimal(base_size = basesize) +
      ggplot2::theme(
        legend.position = 'bottom',
        axis.title.y = ggplot2::element_blank(),
        axis.title.x = ggplot2::element_blank(),
        axis.text.y = ggplot2::element_blank(),
        axis.ticks.y = ggplot2::element_blank(),
        legend.title = ggplot2::element_blank(),
        plot.title = ggplot2::element_text(hjust = 0.5)) +
      ggplot2::scale_fill_manual(values = c("#E66100", "#5D3A9B"))
  } else {
    eff <- NULL
  }

  if(!interactive){
    eff_static <- if(time > 0) eff + ggplot2::labs(title = "Core words / min") else grid::textGrob('Duration not entered')
    plot <- patchwork::wrap_plots(prod + ggplot2::labs(title = "Core words"), eff_static) +
      patchwork::plot_layout(guides = 'collect') &
      ggplot2::theme(legend.position = 'bottom')
    return(plot)
  }

  # Interactive plotly path
  add_percentile_hover <- function(p, ctrl_vec, aph_vec, score_label){
    ctrl_ecdf <- stats::ecdf(ctrl_vec)
    aph_ecdf  <- stats::ecdf(aph_vec)

    for(i in seq_along(p$x$data)){
      trace <- p$x$data[[i]]
      if(is.null(trace$x) || length(trace$x) <= 2) next

      nm <- trace$name
      if(identical(nm, "control")){
        rx <- round(trace$x, 0)
        pcts <- paste0(round(ctrl_ecdf(rx) * 100, 0), "%")
        p$x$data[[i]]$text <- paste0(rx, " ", score_label, "<br>Control: ", pcts)
      } else if(identical(nm, "aphasia")){
        rx <- round(trace$x, 0)
        pcts <- paste0(round(aph_ecdf(rx) * 100, 0), "%")
        p$x$data[[i]]$text <- paste0(rx, " ", score_label, "<br>Aphasia: ", pcts)
      }
      p$x$data[[i]]$hovertemplate <- "%{text}<extra></extra>"
    }
    p
  }

  ctrl_acc <- dat[[2]] %>% dplyr::filter(dists == 'dist1') %>% dplyr::pull(val) %>% stats::na.omit()
  aph_acc  <- dat[[2]] %>% dplyr::filter(dists == 'dist2') %>% dplyr::pull(val) %>% stats::na.omit()

  prod_plotly <- plotly::ggplotly(prod) %>%
    add_percentile_hover(ctrl_acc, aph_acc, "core words")

  if(time > 0){
    ctrl_eff <- dat[[2]] %>% dplyr::filter(dists == 'dist3') %>% dplyr::pull(val) %>% stats::na.omit()
    aph_eff  <- dat[[2]] %>% dplyr::filter(dists == 'dist4') %>% dplyr::pull(val) %>% stats::na.omit()

    eff_plotly <- plotly::ggplotly(eff) %>%
      add_percentile_hover(ctrl_eff, aph_eff, "core words/min") %>%
      plotly::style(showlegend = FALSE)
  } else {
    eff_plotly <- plotly::plot_ly() %>%
      plotly::add_annotations(
        text = "Duration not entered", showarrow = FALSE,
        x = 0.5, y = 0.5, xref = "paper", yref = "paper"
      )
  }

  plotly::subplot(prod_plotly, eff_plotly, shareY = FALSE, titleX = TRUE) %>%
    plotly::layout(
      legend = list(orientation = "h", y = -0.1, x = 0.5, xanchor = "center"),
      annotations = list(
        list(text = "Core words", x = 0.25, y = 1.05, xref = "paper", yref = "paper",
             showarrow = FALSE, xanchor = "center", font = list(size = 14)),
        list(text = "Core words / min", x = 0.75, y = 1.05, xref = "paper", yref = "paper",
             showarrow = FALSE, xanchor = "center", font = list(size = 14))
      )
    ) %>%
    plotly::config(displayModeBar = FALSE)
}
