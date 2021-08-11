# library(tidyverse)
# library(readxl)
# library(janitor)
# library(here)
# 
# path <- here("app", "data", "corelex_norms.xlsx")
# df_control = path %>% 
#   excel_sheets() %>% 
#   set_names() %>% 
#   map(read_excel, path = path) %>%
#   map(t) %>%
#   map(data.frame) %>%
#   map(rownames_to_column) %>%
#   map(janitor::row_to_names, row_number = 1)
# 
# df_control_all <- names(df_control) %>% 
#   str_detect('All') %>%
#   keep(df_control, .) %>%
#   map(setNames, c("ID", "Age", "Sex", "Group", "Score")) %>%
#   map(mutate, File = row_number())
# 
# names(df_control_all)
# names(df_control_all) = c("broken_window", "cat_rescue", "refused_umbrella", "cinderella", "sandwich")
# 
# path2 <- here("app", "data", "corelex_norms_pwa.xlsx")
# df_pwa = path2 %>% 
#   excel_sheets() %>% 
#   set_names() %>% 
#   map(read_excel, path = path2) %>%
#   map(t) %>%
#   map(data.frame) %>%
#   map(rownames_to_column) %>%
#   map(janitor::row_to_names, row_number = 1) %>%
#   map(setNames, c("ID", "Age", "Sex", "Group", "Score"))%>%
#   map(mutate, File = row_number())
# 
# names(df_pwa)
# names(df_pwa) = c("broken_window", "cat_rescue", "refused_umbrella", "cinderella", "sandwich")
# 
# write_rds(df_control_all, file = here("app", "data", "corelex_control_norms.rds"))
# write_rds(df_pwa, file = here("app", "data", "corelex_pwa_norms.rds"))
