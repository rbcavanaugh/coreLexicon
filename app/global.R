library(shiny)
library(here)
library(shinyjs)
library(bslib)
library(dplyr)
library(tidyr)
library(tibble)
library(ggplot2)
library(textstem)
library(tidytext)
library(DT)
library(scales)
library(patchwork)
library(waiter)

transcriptDefault <- "Young boy is practicing playing soccer. Kicking the ball up and keeping it in the air. He miskicks. It fall goes and breaks the window of his house. Of the living room actually. And bounces into the living room knocking a lamp over where his father is sitting. The father picks up the soccer ball. Looks out the window. And calls for the little boy to come and explain."

pwa_norms = readRDS(here("app", "data", "corelex_pwa_norms.rds"))
control_norms = readRDS(here("app", "data", "corelex_control_norms.rds"))

ecdf_fun <- function(x,perc) label_percent()(ecdf(x)(perc))
