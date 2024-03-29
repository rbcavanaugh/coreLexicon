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
    shinyjs::useShinyjs(),
    navbarPage(title = "Core Lexicon Analysis",
               id = "mainpage",
               
               theme = minimal_theme(),
               
               ############################ Instructions ############################## 
               tabPanelBody(value = "intro", 
                        get_intro_div()
               ),
               ############################ Scoring ###################################
               tabPanelBody(value = "scoring", 
                        get_scoring_div()
               ),
               ############################ Results ###################################
               tabPanelBody(value = "results", 
                        get_results_div()
               ),
                !!!list(bslib::nav_spacer(),
                        bslib::nav_item(pagetitle()),
                        bslib::nav_item(
                          tags$a(icon("github"),
                                 href = "https://github.com/aphasia-apps/coreLexicon",
                                 target = "_blank",
                                 style = "color:black;")
                        )
                )
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

