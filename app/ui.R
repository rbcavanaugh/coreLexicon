# Define UI
shinyUI(
  tagList(
    use_waiter(),
    waiter_preloader(html = spin_dots(), color = "white"),
    useShinyjs(),
    includeCSS("www/style.css"),
    navbarPage(title = "Core Lexicon Analysis",
               id = "mainpage",
               footer = tags$div(
                   id = "footer_id",
                   class = "footer",
                   footer_div
               ),
               
               theme = minimal_theme,
               
               ############################ Instructions ############################## 
               tabPanelBody(value = "intro",# title = "Intro", 
                            intro_tab_div
               ),
               ############################ Scoring ###################################
               tabPanelBody(value = "scoring",# title = "Scoring",
                            scoring_div
               ),
               ############################ Results ###################################
               tabPanelBody(value = "results",# title = "Results",
                            results_div
               ), br(), br(), br(), br()
               ########################################################################
              
    )
  )
)
