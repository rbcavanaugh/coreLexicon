
#' Get results div
#'
#' @export
get_results_div <- function(){
  column(width = 8, offset = 2,
         fluidRow(textOutput("words_results")),
         br(),
         fluidRow(plotOutput("plot_cl", height = '350px'))
        )
}

