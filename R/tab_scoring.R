
#' get scoring div
#'
#' @export
#'
  get_scoring_div <- function(){
    column(width = 10, offset = 1, id = "scoring_div_for_waiter",
        fluidRow(
            column(width = 6, 
                   tags$h4("Check transcript scoring:"),
                   includeMarkdown(
                     system.file("app/www/scoring.md", package = "coreLexicon")
                   ),
                   tags$h4("Transcript"), 
                   div(style="max-height:200px;overflow-y: scroll;",
                   uiOutput("transcription_reference")
                   )
          ),
          column(width= 6,
                 DT::DTOutput("table_cl")
                 )
        ), br(), br(), br(),
        fluidRow(
          column(align = "center", width = 12,
                 actionButton("go_back", "Go Back"),
                 actionButton("go_to_results", "Done")
                 )
        )
    )
  
}