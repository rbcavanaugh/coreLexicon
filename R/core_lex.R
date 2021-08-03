
# need to give a way for clinicians to take away or add points manually to adjust the score...

broken_window=tibble(c("a","and","ball","be","boy","break","go","he","in",
                       "it","kick","lamp","look","of","out","over","play","sit",
                       "soccer","the","through","to","up","window"))

refused_umbrella=tibble(c("a", 'and', 'back', 'be', 'boy', 'do', 'get', 'go', 'have','he',
                          'home', 'i', 'in', 'it', 'little', 'mother', 'mom', 'need', 'not', 'out',
                          'rain', 'say', 'school', 'she', 'so', 'start', 'take', 'that', 'the',
                          'then', 'to', 'umbrella', 'walk', 'wet', 'with', 'you'))

cat_rescue=tibble(c("a","and","bark","be","call","cat","climb","come","department", 'dad',
                    "dog","down","father","fire","get","girl","go","have","he",
                    "in","ladder","little","tree","not","up", 'out', 'with', 'she', 'fireman',
                    'so', 'stick', 'the', 'their', 'there', 'to'))

cinderella = tibble(c('a', 'after', 'all', 'and', 'as', 'at', 'away', 'back','ball',
                      'be', 'beautiful', 'because', 'but', 'by', 'cinderella', 'clock', 'come',
                      'could', 'dance','daughter', 'do', 'dress', 'ever', 'fairy', 'father',
                      'dad', 'find', 'fit', 'foot', 'for', 'get', 'girl', 'glass', 'go',
                      'godmother', 'happy', 'have', 'he', 'home', 'horse', 'house', 'i', 'in',
                      'into', 'it', 'know', 'leave', 'like', 'little', 'live', 'look', 'lose',
                      'make', 'marry', 'midnight', 'mother', 'mom', 'mouse', 'not', 'of',
                      'off', 'on', 'one', 'out', 'prince', 'pumpkin', 'run', 'say', 'she',
                      'shoe', 'sister', 'slipper', 'so', 'strike', 'take', 'tell', 'that',
                      'the', 'then', 'there', 'they', 'this', 'time', 'to', 'try',
                      'turn', 'two', 'up', 'very', 'want', 'well', 'when', 'who', 'will', 'with'))

sandwich = tibble(c("a","and","bread","butter","get","it","jelly","knife","of", 'on',
                    "one","other","out","peanut","piece","put","slice","spread","take",
                    "the","then","to","together","two","you"))



corpus <- list(broken_window, refused_umbrella, cat_rescue, cinderella, sandwich)


core_lex <- function(text, stimulus, age_input){
  stim = corpus[[stimulus]]

  colnames(stim) = 'target_lemma'
  text = tibble(text)
  colnames(text) = 'text'
  text <- tibble(unnest_tokens(text, word, text)) %>% distinct()
  text$lemma <- lemmatize_words(text$word)
  colnames(text) = c('token', 'produced_lemma')
  
  return_list <- list()
  
  return_list$match <- stim %>%
    left_join(text, by = c('target_lemma' = 'produced_lemma')) %>%
    mutate(produced = ifelse(!is.na(token), 1,0)) %>%
    select(target_lemma, produced, token)
  
  return_list$extra <- text %>%
    anti_join(stim, by = c('produced_lemma' = 'target_lemma'))
  
  
  return(return_list)
}


