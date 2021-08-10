
#' Run Core Lexicon App
#' @description Function to locally run the core lexicon app
#' @export
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

