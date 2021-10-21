

#' core lex function
#' where the magic happens
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
  # creates a data frame with a single column called word
  # has all the tokens from the sample. 
  text <- tibble::tibble(tidytext::unnest_tokens(text, word, text)) %>%
    dplyr::distinct() # unique list of tokens...
  # lemmatizes all of the tokens
  text$lemma <- textstem::lemmatize_words(text$word, dictionary = new_dict)
  colnames(text) = c('token', 'produced_lemma')
  return_list <- list()
  
  return_list$match <- stim %>%
    dplyr::left_join(text, by = c('target_lemma' = 'produced_lemma')) %>%
    dplyr::select(target_lemma, token) %>%
    dplyr::group_by(target_lemma) %>%
    dplyr::summarize(token = toString(token)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(produced = ifelse(token != "NA", 1,0)) # to string makes NA character. 
    

  return_list$extra <- text %>%
    dplyr::anti_join(stim, by = c('produced_lemma' = 'target_lemma'))
  
  return(return_list)
}


