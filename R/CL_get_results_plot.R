### result splot
#' @export
get_results_plot <- function(dat){
  prod <- dat[[2]] %>%
    dplyr::mutate(Cohort = ifelse(dist == 'dist1' | dist == 'dist3', 'control', 'aphasia'),
           met = factor(ifelse(dist == 'dist1' | dist == 'dist2', 'Production', 'Efficiency'),
                        levels = c('Production', 'Efficiency'))
    ) %>%
    dplyr::filter(met == "Production") %>%
    ggplot2::ggplot(ggplot2::aes(x = val, color = Cohort, fill = Cohort)) +
    ggplot2::geom_density(alpha = .3, adjust = 3) +
    ggplot2::geom_vline(data = data.frame(xint=dat[[3]][[1]],met="Production"), 
                        ggplot2::aes(xintercept = xint), linetype = "dashed", size = 1) +
    ggplot2::theme_minimal(base_size = 14) +
    ggplot2::theme(#panel.background = element_rect(fill = "transparent"),
      legend.position = 'bottom',
      axis.title.y=ggplot2::element_blank(),
      axis.title.x=ggplot2::element_blank(),
      axis.text.y=ggplot2::element_blank(),
      axis.ticks.y=ggplot2::element_blank(),
      legend.title = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::labs(title = "Core words")
  
  eff <- dat[[2]] %>%
    dplyr::mutate(Cohort = ifelse(dist == 'dist1' | dist == 'dist3', 'control', 'aphasia'),
           met = factor(ifelse(dist == 'dist1' | dist == 'dist2', 'Production', 'Efficiency'),
                        levels = c('Production', 'Efficiency'))
    ) %>%
    dplyr::filter(met == "Efficiency") %>%
    ggplot2::ggplot(
      ggplot2::aes(x = val, color = Cohort, fill = Cohort)) +
    ggplot2::geom_density(alpha = .3, adjust = 3) +
    ggplot2::geom_vline(data = data.frame(xint=dat[[3]][[2]],met="Efficiency"), 
                        ggplot2::aes(xintercept = xint), linetype = "dashed", size = 1) +
    ggplot2::theme_minimal(base_size = 14) +
    ggplot2::theme(#panel.background = element_rect(fill = "transparent"),
      legend.position = 'bottom',
      axis.title.y=ggplot2::element_blank(),
      axis.title.x=ggplot2::element_blank(),
      axis.text.y=ggplot2::element_blank(),
      axis.ticks.y=ggplot2::element_blank(),
      legend.title = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::labs(title = "Core words / min")
  
  plot <- patchwork::wrap_plots(prod, eff) + patchwork::plot_layout(guides = 'collect') & ggplot2::theme(legend.position = 'bottom')
  return(plot)
}