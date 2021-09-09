
#' get scoring div
#'
#' @export
#'
  get_scoring_div <- function(){
    column(width = 10, offset = 1, id = "scoring_div_for_waiter",
        fluidRow(
          column(width = 5, 
                 h4("Scoring Rules"),
                          tags$ol(
                            tags$li("Check that target lexemes match tokens and that target
                                    lexemes without a matched token were not missed by the algorithm."),
                            tags$li("Count any variation of mom/mother or dad/father.")
                          )
        ),
        column(width= 7, 
               h4("Scoring Table"),
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