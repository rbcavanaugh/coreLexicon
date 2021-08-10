#' @export
runCoreLex <- function() {
  appDir <- system.file("shiny-apps", "coreLexicon", package = "corelexicon")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}