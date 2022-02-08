
#' Returns the page title for the navbar
#' 
#' Reveals keys for testing inputs during tests (not permitted by keys).
#' Code for download buttons, start-over, help, and github link
#'
#' @export
pagetitle <- function(){
  
  title = div(
    downloadButton("report", "Report"),
    downloadButton("downloadData", "Data"),
    actionButton("start_over",
                 "Start Over",
    ),
    actionButton(
      inputId = "faq",
      label = "FAQ",
    ),
    actionButton(
      inputId = "about",
      label = "About",
    ),
    actionButton(
      inputId = "feedback",
      label = "Feedback",
    )
  )
  
  return(title)
}