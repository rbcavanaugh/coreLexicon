### result splot

get_results_plot <- function(dat){
  prod <- dat[[2]] %>%
    mutate(Cohort = ifelse(dist == 'dist1' | dist == 'dist3', 'control', 'aphasia'),
           met = factor(ifelse(dist == 'dist1' | dist == 'dist2', 'Production', 'Efficiency'),
                        levels = c('Production', 'Efficiency'))
    ) %>%
    dplyr::filter(met == "Production") %>%
    ggplot(aes(x = val, color = Cohort, fill = Cohort)) +
    geom_density(alpha = .3, adjust = 3) +
    geom_vline(data = data.frame(xint=dat[[3]][[1]],met="Production"), 
               aes(xintercept = xint), linetype = "dashed", size = 1) +
    theme_minimal(base_size = 14) +
    theme(#panel.background = element_rect(fill = "transparent"),
      legend.position = 'bottom',
      axis.title.y=element_blank(),
      axis.title.x=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.title = element_blank(),
      plot.title = element_text(hjust = 0.5)) +
    labs(title = "Core words")
  
  eff <- dat[[2]] %>%
    mutate(Cohort = ifelse(dist == 'dist1' | dist == 'dist3', 'control', 'aphasia'),
           met = factor(ifelse(dist == 'dist1' | dist == 'dist2', 'Production', 'Efficiency'),
                        levels = c('Production', 'Efficiency'))
    ) %>%
    dplyr::filter(met == "Efficiency") %>%
    ggplot(aes(x = val, color = Cohort, fill = Cohort)) +
    geom_density(alpha = .3, adjust = 3) +
    geom_vline(data = data.frame(xint=dat[[3]][[2]],met="Efficiency"), 
               aes(xintercept = xint), linetype = "dashed", size = 1) +
    theme_minimal(base_size = 14) +
    theme(#panel.background = element_rect(fill = "transparent"),
      legend.position = 'bottom',
      axis.title.y=element_blank(),
      axis.title.x=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank(),
      legend.title = element_blank(),
      plot.title = element_text(hjust = 0.5)) +
    labs(title = "Core words / min")
  
  prod + eff + plot_layout(guides = 'collect') & theme(legend.position = 'bottom')
}