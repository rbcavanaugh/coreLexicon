
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
runCoreLex <- function() {
  appDir <- system.file("shiny-apps", "coreLexicon", package = "coreLexicon")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}

