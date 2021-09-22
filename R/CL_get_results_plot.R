
#' get results plot
#'
#' @param dat data
#'
#' @export
get_results_plot <- function(dat, time, basesize = 16){
  prod <- dat[[2]] %>%
    dplyr::mutate(Cohort = ifelse(dists == 'dist1' | dists == 'dist3', 'control', 'aphasia'),
           met = factor(ifelse(dists == 'dist1' | dists == 'dist2', 'Production', 'Efficiency'),
                        levels = c('Production', 'Efficiency'))
    ) %>%
    dplyr::filter(met == "Production") %>%
    ggplot2::ggplot(ggplot2::aes(x = val, fill = Cohort)) +
    ggplot2::geom_density(alpha = .3, adjust = 3) +
    ggplot2::geom_vline(data = tibble::tibble(xint=dat[[3]][[1]],met="Production"), 
                        ggplot2::aes(xintercept = xint), linetype = "dashed", size = 1) +
    ggplot2::theme_minimal(base_size = basesize) +
    ggplot2::theme(#panel.background = element_rect(fill = "transparent"),
      legend.position = 'bottom',
      axis.title.y=ggplot2::element_blank(),
      axis.title.x=ggplot2::element_blank(),
      axis.text.y=ggplot2::element_blank(),
      axis.ticks.y=ggplot2::element_blank(),
      legend.title = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::scale_fill_manual(values = c("#E66100", "#5D3A9B")) +
    ggplot2::labs(title = "Core words")
  
  
  if(time>0){
  eff <- dat[[2]] %>%
    dplyr::mutate(Cohort = ifelse(dists == 'dist1' | dists == 'dist3', 'control', 'aphasia'),
           met = factor(ifelse(dists == 'dist1' | dists == 'dist2', 'Production', 'Efficiency'),
                        levels = c('Production', 'Efficiency'))
    ) %>%
    dplyr::filter(met == "Efficiency") %>%
    ggplot2::ggplot(
      ggplot2::aes(x = val, fill = Cohort)) +
    ggplot2::geom_density(alpha = .3, adjust = 3) +
    ggplot2::geom_vline(data = tibble::tibble(xint=dat[[3]][[2]],met="Efficiency"), 
                        ggplot2::aes(xintercept = xint), linetype = "dashed", size = 1) +
    ggplot2::theme_minimal(base_size = basesize) +
    ggplot2::theme(#panel.background = element_rect(fill = "transparent"),
      legend.position = 'bottom',
      axis.title.y=ggplot2::element_blank(),
      axis.title.x=ggplot2::element_blank(),
      axis.text.y=ggplot2::element_blank(),
      axis.ticks.y=ggplot2::element_blank(),
      legend.title = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::scale_fill_manual(values = c("#E66100", "#5D3A9B")) +
    ggplot2::labs(title = "Core words / min")
  } else {
    eff <- grid::textGrob('Duration not entered')
  }
  
  plot <- patchwork::wrap_plots(prod, eff) + patchwork::plot_layout(guides = 'collect') & ggplot2::theme(legend.position = 'bottom')
  return(plot)
}

  
  