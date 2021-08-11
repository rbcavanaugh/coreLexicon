
#' Run Core Lexicon App
#' @description Function to locally run the core lexicon app
#' @export
#' @import shiny 
#' @examples
#' \dontrun{
#' runCoreLex()
#' }
runCoreLex <- function(...) {
  ui <- app_ui
  server <- app_server
  shinyApp(ui, server, ...)
}

