
#' Run Core Lexicon App
#' @description Function to locally run the core lexicon app
#' @export
#' @import shiny bslib dplyr tidyr ggplot2 patchwork waiter truncnorm pkgload markdown
#' @importFrom tibble tibble
#' @importFrom scales label_percent
#' @importFrom shinyjs enable disable show hide hidden useShinyjs
#' @importFrom DT renderDT DTOutput
#' @importFrom htmlwidgets JS
#' @importFrom textstem lemmatize_words
#' @importFrom tidytext unnest_tokens
#' 
#'
#' @examples
#' \dontrun{
#' runCoreLex()
#' }
runCoreLex <- function(...) {
  ui <- app_ui
  server <- app_server
  shinyApp(ui, server, ...)
}

