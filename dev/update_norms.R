# load("~/github-repos/coreLexicon/R/sysdata.rda")
# library(tidyverse)
# library(googlesheets4)
# 
#     # links to google sheets for norms:
#     refused_umbrella_id = "1oYiwnUdO0dOsFVTmdZBCxkAQc5Ui-71GhUSchK_YY44"
#     broken_window_id = "12SAkAG8VCAkhCFv4ceJiqgRZ7U9-P9bEcet--hDeW2s"
#     cinderella_id = "1fpDq7aTrKVkfjdv8ka7BS5_iHEJ8HHI-q9nJI6wDAEA"
#     sandwich_id = "1o29bBQbyNlmtL05kkTuLV6z5auz1msDeLSxIO1p_3EA"
#     cat_rescue_id = "1sTvSX0Ws0kPTw-5HHyY8JO2CubqWVgEzDvE5BuGSefc"
# 
#     stim = c(broken_window_id,
#              refused_umbrella_id,
#              cat_rescue_id,
#              cinderella_id,
#              sandwich_id)
#     # go into deauth mode
#     googlesheets4::gs4_deauth()
# 
#     norms <- list()
# 
#     for(i in stim){
#         norms$acc[[i]] <- googlesheets4::read_sheet(ss = i, sheet = 3)
#         norms$eff[[i]] <- googlesheets4::read_sheet(ss = i, sheet = 4)
#     }
# 
#     names(norms$acc) <- c("broken_window",
#                           "refused_umbrella",
#                           "cat_rescue",
#                           "cinderella",
#                           "sandwich")
# 
#     names(norms$eff) <- c("broken_window",
#                           "refused_umbrella",
#                           "cat_rescue",
#                           "cinderella",
#                           "sandwich")
#     rm(i)
#     rm(stim)
#     rm(broken_window_id,
#        refused_umbrella_id,
#        cat_rescue_id,
#        sandwich_id,
#        cinderella_id)
# 
# # UPDATE DICTIonary
# dict <- lexicon::hash_lemmas
# 
# add_to_dict <- tibble::tribble(
#   ~token, ~ lemma,
#   "her", "she",
#   "him", "he",
# )
# 
# new_dict <- bind_rows(dict, add_to_dict)
# 
# usethis::use_data(internal = T, overwrite = T,
#                   broken_window,
#                   cat_rescue,
#                   cinderella,
#                   refused_umbrella,
#                   sandwich,
#                   transcriptDefault,
#                   corpus,
#                   norms, 
#                   new_dict)
