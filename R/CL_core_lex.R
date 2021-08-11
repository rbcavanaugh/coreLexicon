

#' core lex function
#'
#' @param text text input
#' @param stimulus stimulus
#'
#' @export
core_lex <- function(text, stimulus){
  stim = corpus[[stimulus]]

  colnames(stim) = 'target_lemma'
  text = tibble::tibble(text)
  colnames(text) = 'text'
  text <- tibble::tibble(tidytext::unnest_tokens(text, word, text)) %>%
    dplyr::distinct()
  text$lemma <- textstem::lemmatize_words(text$word)
  colnames(text) = c('token', 'produced_lemma')
  
  return_list <- list()
  
  return_list$match <- stim %>%
    dplyr::left_join(text, by = c('target_lemma' = 'produced_lemma')) %>%
    dplyr::mutate(produced = ifelse(!is.na(token), 1,0)) %>%
    dplyr::select(target_lemma, produced, token)
  
  return_list$extra <- text %>%
    dplyr::anti_join(stim, by = c('produced_lemma' = 'target_lemma'))
  
  
  return(return_list)
}


