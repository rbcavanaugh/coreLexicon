library(tidyverse)

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
  if(stimulus > 5){
    stim <- stim %>% filter(age == floor(age_input/10)*10) %>%
      select(lexeme)
      }
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

mobileDetect <- function(inputId, value = 0) {
  tagList(
    #singleton(tags$head(tags$script(src = "js/javascript.js"))),
    tags$input(id = inputId,
               class = "mobile-element",
               type = "hidden"
                )
  )
}

transcriptDefault <- "Young boy is practicing playing soccer. Kicking the ball up and keeping it in the air. He miskicks. It fall goes and breaks the window of his house. Of the living room actually. And bounces into the living room knocking a lamp over where his father is sitting. The father picks up the soccer ball. Looks out the window. And calls for the little boy to come and explain."

refsCl <- "Dalton, S. G., Hubbard, H. I., & Richardson, J. D. (2019). Moving toward non-transcription based discourse analysis in stable and progressive aphasia. In Seminars in speech and language. Thieme Medical Publishers.\

Dalton, S. G., & Richardson, J. D. (2015). Core-lexicon and main-concept production during picture-sequence description in adults without brain damage and adults with aphasia. American Journal of Speech-Language Pathology, 24(4), S923-S938.\

Kim, H., & Wright, H. H. (2020, January). A tutorial on core lexicon: development, use, and application. In Seminars in speech and language (Vol. 41, No. 01, pp. 020-031). Thieme Medical Publishers.\

Silge J, Robinson D (2016). tidytext: Text Mining and Analysis Using Tidy Data Principles in R. JOSS, 1(3). doi: 10.21105/joss.00037"



