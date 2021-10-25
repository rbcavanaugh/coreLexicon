#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    waiter::use_waiter(),
    waiter::waiter_preloader(html = waiter::spin_dots(), color = "white"),
    shinyjs::useShinyjs(),
    navbarPage(title = div(
                          div("Core Lexicon Analysis"), # title
                          div(id = "navbar-right",
                          # buttons on the right
                          # not always shown
                          downloadButton("report", "Download Report"),
                          downloadButton("downloadData", "Download Data"),
                          actionButton("start_over",
                                       "Start Over",
                                       icon = icon("undo")),
                          style = "position: absolute; right: 5px; top: 8px;")
                ),
               id = "mainpage",
               footer = tags$div(
                 id = "footer_id",
                 class = "footer",
                 footer_div()
               ),
               
               theme = minimal_theme(),
               
               ############################ Instructions ############################## 
               tabPanel(value = "intro", title = "Intro", 
                        get_intro_div()
               ),
               ############################ Scoring ###################################
               tabPanel(value = "scoring", title = "Scoring",
                        get_scoring_div()
               ),
               ############################ Results ###################################
               tabPanel(value = "results", title = "Results",
                        get_results_div()
               )#, br(), br(), br(), br()
               ########################################################################
               
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'coreLexicon'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

