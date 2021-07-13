library(shiny)
library(here)
library(shinyjs)
library(bslib)
library(tidyverse)
library(tokenizers)
library(textstem)
library(tidytext)
library(shinyWidgets)
library(shinipsum)
library(DT)
library(scales)
library(patchwork)
library(waiter)

transcriptDefault <- "Young boy is practicing playing soccer. Kicking the ball up and keeping it in the air. He miskicks. It fall goes and breaks the window of his house. Of the living room actually. And bounces into the living room knocking a lamp over where his father is sitting. The father picks up the soccer ball. Looks out the window. And calls for the little boy to come and explain."

intro_text <-
  tagList(
    tags$ul(
      tags$li(shinipsum::random_text(nwords = 40)),
      tags$li(shinipsum::random_text(nwords = 40)),
      tags$li(shinipsum::random_text(nwords = 40)),
      tags$li(shinipsum::random_text(nwords = 40)),
      tags$li(shinipsum::random_text(nwords = 40)),
    ),
    br(),
    h5("References:"),
    tags$ul(
      tags$li("Dalton, S. G., Hubbard, H. I., & Richardson, J. D. (2019). Moving toward non-transcription based discourse analysis in stable and progressive aphasia. In Seminars in speech and language. Thieme Medical Publishers."), 
      tags$li("Dalton, S. G., & Richardson, J. D. (2015). Core-lexicon and main-concept production during picture-sequence description in adults without brain damage and adults with aphasia. American Journal of Speech-Language Pathology, 24(4), S923-S938."),
      tags$li("Kim, H., & Wright, H. H. (2020, January). A tutorial on core lexicon: development, use, and application. In Seminars in speech and language (Vol. 41, No. 01, pp. 020-031). Thieme Medical Publishers."),
      tags$li("Silge J, Robinson D (2016). tidytext: Text Mining and Analysis Using Tidy Data Principles in R. JOSS, 1(3). doi: 10.21105/joss.00037")
    )
  )