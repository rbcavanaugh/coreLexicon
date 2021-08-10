#' @export
get_selected_data <- function(stim, score_num_data, time, adj){
    
    task = dplyr::case_when(
      stim == 'broken_window' ~ 1,
      stim == 'refused_umbrella' ~ 2,
      stim == 'cat_rescue' ~ 3,
      stim == 'cinderella' ~ 4,
      stim == 'sandwich' ~ 5
    )
    
    #df <- core_lex(transcr, task, age)
    #matches <- df$match
    score_num = score_num_data + adj #sum(matches$produced) +
    score_eff = score_num/(time/60)
    
    # Norn data ####
    
    # ACCURACY #
    norm_mean = ecdf_fun(as.numeric(control_norms[[stim]]$Score), score_num)
    aphasia_mean = ecdf_fun(as.numeric(pwa_norms[[stim]]$Score), score_num)
    # EFFICIENCY 
    
    norm_mean_eff = dplyr::case_when(
      stim == 'broken_window' ~ list(c(34.8, 13.5, 6.7, 72.9)),
      stim == 'refused_umbrella' ~ list(c(41.3, 14.5, 16.6, 98.2)),
      stim == 'cat_rescue' ~ list(c(39.8, 14.3, 13.3, 100)),
      stim == 'cinderella' ~ list(c(24.7, 10.0,3.4, 72.0)),
      stim == 'sandwich' ~ list(c(40.5, 16.6, 8.6, 114.0))
    )
    
    aphasia_mean_eff = dplyr::case_when(
      stim == 'broken_window' ~ list(c(18.5, 13.3, 0, 84.0)),
      stim == 'refused_umbrella' ~ list(c(19.7, 13.4, 0, 67.5)),
      stim == 'cat_rescue' ~ list(c(16.9, 12.3, 0, 93.8)),
      stim == 'cinderella' ~ list(c(14.1, 9.1, 0.4, 62.5)),
      stim == 'sandwich' ~ list(c(24.1,20.1, 0, 156.0))
    )
    
    # Max 
    max_val = dplyr::case_when(
      stim == 'broken_window' ~ 24,
      stim == 'refused_umbrella' ~ 35,
      stim == 'cat_rescue' ~ 34,
      stim == 'cinderella' ~ 94,
      stim == 'sandwich' ~ 25
    )
    
    dist3 = truncnorm::rtruncnorm(500,
                                  mean = norm_mean_eff[[1]][[1]],
                                  sd = norm_mean_eff[[1]][[2]],
                                  a = norm_mean_eff[[1]][[3]],
                                  b = norm_mean_eff[[1]][[4]])
    percentile3 = scales::label_percent()(stats::ecdf(dist3)(score_eff))
    
    dist4 = truncnorm::rtruncnorm(500,
                                  mean = aphasia_mean_eff[[1]][[1]],
                                  sd = aphasia_mean_eff[[1]][[2]],
                                  a = aphasia_mean_eff[[1]][[3]],
                                  b = aphasia_mean_eff[[1]][[4]])
    percentile4 = scales::label_percent()(stats::ecdf(dist4)(score_eff))
    
    
    #####
    
    
    score = data.frame(
      Metric = c('Production', 'Efficiency'),
      Score = c(paste0(round(score_num,0),' core words'),
                paste0(round(score_eff, 1), ' core words/min')),
      ControlPercentile =  c(norm_mean, percentile3),
      AphasiaPercentile = c(aphasia_mean, percentile4)
    )
    
    score <- score %>%
      dplyr::mutate(
        ControlPercentile = ifelse(Metric != 'Production', ControlPercentile,
                                   ifelse(score_num > max_val,
                                          'exceeded max score',
                                          ControlPercentile)
        ),
        AphasiaPercentile = ifelse(Metric != 'Production', AphasiaPercentile,
                                   ifelse(score_num > max_val,
                                          'exceeded max score',
                                          AphasiaPercentile)
                                   
        )
      )
    
    colnames(score) <- c('Metric', 'Score', 'Control Percentile', 'Aphasia Percentile')
    
    dists <- data.frame(
      dist1 = c(as.numeric(control_norms[[stim]]$Score),rep(NA, 500-length(as.numeric(control_norms[[stim]]$Score)))),
      dist2 = c(as.numeric(pwa_norms[[stim]]$Score), rep(NA, 500-length(as.numeric(pwa_norms[[stim]]$Score)))),
      dist3 = dist3,
      dist4 = dist4
    ) %>%
      tidyr::pivot_longer(cols = 1:4, names_to = 'dist', values_to = 'val')
    
    core_lex_data <- list()
    core_lex_data[["score"]] = score
    core_lex_data[["dist"]] = dists
    core_lex_data[["scores"]] = c(score_num, score_eff)
    
    return(core_lex_data) # make this a list with the data for the histograms too. 

}