# Define UI
shinyUI(
  tagList(
    waiter::use_waiter(),
    waiter::waiter_preloader(html = waiter::spin_dots(), color = "white"),
    shinyjs::useShinyjs(),
    includeCSS("www/style.css"),
    navbarPage(title = "Core Lexicon Analysis",
               id = "mainpage",
               footer = tags$div(
                   id = "footer_id",
                   class = "footer",
                   footer_div()
               ),
               
               theme = bslib::bs_theme(
                 bootswatch = "default",
                 #base_font = bslib::font_google("Open Sans"),
                 #heading_font = bslib::font_google("Open Sans"),
                 version = "4",
                 `enable-rounded` = T,
                 `enable-transitions` = F,
                 primary = "#1665AC",
                 "navbar-bg" = "#e9ecef"
               ),
                 #minimal_theme(),
               
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
               ), br(), br(), br(), br()
               ########################################################################
              
    )
  )
)
