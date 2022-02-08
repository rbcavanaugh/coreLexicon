
#' get selected data
#'
#' @param stim stim
#' @param score_num_data score
#' @param time time input
#' @param adj adjustment
#'
#' @export
get_selected_data <- function(stim, score_num_data, time, adj){
  control_norms_acc <- norms$acc[[stim]] %>% dplyr::filter(Aphasia == 0)
  pwa_norms_acc <- norms$acc[[stim]] %>% dplyr::filter(Aphasia == 1)
  control_norms_eff <- norms$eff[[stim]] %>% dplyr::filter(Aphasia == 0)
  pwa_norms_eff <- norms$eff[[stim]] %>% dplyr::filter(Aphasia == 1)
  
    task = dplyr::case_when(
      stim == 'broken_window' ~ 1,
      stim == 'refused_umbrella' ~ 2,
      stim == 'cat_rescue' ~ 3,
      stim == 'cinderella' ~ 4,
      stim == 'sandwich' ~ 5
    )
    
    score_num = score_num_data + adj #sum(matches$produced) +
    score_eff = score_num/(time/60)
    
    # Norn data ####
    
    # ACCURACY #
    norm_mean = ecdf_fun(as.numeric(control_norms_acc[[3]]), score_num)
    aphasia_mean = ecdf_fun(as.numeric(pwa_norms_acc[[3]]), score_num)
    # EFFICIENCY 
    
    norm_mean_eff = ecdf_fun(as.numeric(control_norms_eff[[3]]), score_num)
    aphasia_mean_eff = ecdf_fun(as.numeric(pwa_norms_eff[[3]]), score_num)
    
    # Max 
    max_val = dplyr::case_when(
      stim == 'broken_window' ~ 24,
      stim == 'refused_umbrella' ~ 35,
      stim == 'cat_rescue' ~ 34,
      stim == 'cinderella' ~ 94,
      stim == 'sandwich' ~ 25
    )
    
    score = data.frame(
      Metric = c('Production', 'Efficiency'),
      Score = c(paste0(round(score_num,0),' core words'),
                paste0(round(score_eff, 1), ' core words/min')),
      ControlPercentile =  c(norm_mean, norm_mean_eff),
      AphasiaPercentile = c(aphasia_mean, aphasia_mean_eff)
    ) %>%
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
      dist1 = c(as.numeric(control_norms_acc[[3]]),rep(NA, 500-length(as.numeric(control_norms_acc[[3]])))),
      dist2 = c(as.numeric(pwa_norms_acc[[3]]), rep(NA, 500-length(as.numeric(pwa_norms_acc[[3]])))),
      dist3 = c(as.numeric(control_norms_eff[[3]]),rep(NA, 500-length(as.numeric(control_norms_eff[[3]])))),
      dist4 = c(as.numeric(pwa_norms_eff[[3]]), rep(NA, 500-length(as.numeric(pwa_norms_eff[[3]]))))
    ) %>%
      tidyr::pivot_longer(cols = 1:4, names_to = 'dists', values_to = 'val')
    
    core_lex_data <- list()
    core_lex_data[["score"]] = score
    core_lex_data[["dists"]] = dists
    core_lex_data[["scores"]] = c(score_num, score_eff)
    
    return(core_lex_data) # make this a list with the data for the histograms too. 

}