dict <- lexicon::hash_lemmas

add_to_dict <- tibble::tribble(
  ~token, ~ lemma,
  "her", "she",
  "him", "he",
)

new_dict <- bind_rows(dict, add_to_dict)
