dict <- lexicon::hash_lemmas

add_to_dict <- tibble::tribble(
  ~token, ~ lemma,
  "its", "it",
  "itself", "it",
  "your", "you",
  "yours", "you",
  "yourself", "you",
  "him", "he",
  "himself", "he",
  "his", "he",
  "her", "she",
  "herself", "she",
  "them", "they",
  "themselves", "they",
  "their", "they",
  "theirs", "they",
  "me", "i",
  "my", "i",
  "mine", "i",
  "myself", "i",
  "is", "am",
  "are", "am",
  "was", "am",
  "were", "am",
  "be", "am",
  "being", "am",
  "been", "am",
  "daddy", "dad",
  "father", "dad",
  "papa", "dad",
  "pa", "dad",
  "mommy", "mom",
  "mother", "mom",
  "mama", "mom",
  "ma", "mom"
) 

`%nin%` <- Negate(`%in%`)

new_dict <- dict %>%
  dplyr::filter(token %nin% add_to_dict$token) %>%
  dplyr::bind_rows(add_to_dict) %>%
  dplyr::distinct()

# new_dict %>%
#   dplyr::count(token, lemma) %>%
#   dplyr::arrange(desc(n))

