
#' Get intro div
#' @export
get_intro_div <- function() {
  column(
    width = 12,
    
    tabsetPanel(
      type = "hidden",
      id = "glide",
      
      tabPanelBody(value = "glide1",
                   column(
                     align = "center",
                     width = 8,
                     offset = 2,
                     h5("Welcome to the Core Lexicon Analysis Web-App"),br(),
                     div(
                       style = "display: inline-block; text-align: left;",
                       includeMarkdown(
                         system.file("app/www/corelex_intro.md", package = "coreLexicon")
                       ),
                       br(),
                       # start!
                       div(align = "center",
                           actionButton("glide_next1", "Get Started"))
                     )
                   )),
      
      tabPanelBody(value = "glide2",
                   column(
                     width = 10,
                     offset = 1,
                     div(
                       align = "center",
                       div(
                         style = "display: inline-block; text-align: left;",
                         h5("Enter test information"),
                         br(),
                         textInput("name", "Enter a Name"), br(),
                         selectInput(
                           inputId = "stim",
                           label = div("Select Stimulus ", HTML('<a id="stiminfo" href="#" class="action-button">
                                          <i class="fa fa-info-circle" role="presentation" aria-label="info icon"></i>
                                          </a>')
                                       ),
                           choices = c(
                             "Broken Window" = 'broken_window',
                             "Cat Rescue" = 'cat_rescue',
                             "Refused Umbrella" = 'refused_umbrella',
                             "Cinderella" = 'cinderella',
                             "Sandwich" = 'sandwich'
                           ),
                           selected = "broken_window"#,
                           #inline = F
                         ),
                         numericInput(
                           "time",
                           "Enter Duration (seconds)",
                           value = 0,
                           min = 0,
                           max = 720
                         ), br(),
                         textAreaInput(
                           "notes",
                           "Enter any notes",
                           width = "100%",
                           height = "100px"
                         ),
                         br(),
                         p(
                           tags$em(
                             "Note, for privacy reasons, data is not
                             retained after the page is closed or refreshed."
                           ),
                           style = "max-width:300px;"
                         ),
                         br()
                       )
                     ),
                     div(
                       align = "center",
                       actionButton("glide_back1", "Back"),
                       actionButton("glide_next2", "Next")
                     )
                   )),
      
      tabPanelBody(value = "glide3",
                   fluidRow(
                     column(
                       width = 5,
                       offset = 1,
                       h4("Transcribing"),
                       div(style = "height:500px; overflow:auto;",
                           includeMarkdown(
                             system.file("app/www/transcribing.md", package = "coreLexicon")
                           )),
                       checkboxInput(
                         inputId = "adj",
                         label = "Check if transcription included a Possessive ['s] (Cinderella only)",
                         value = FALSE
                       )
                     ),
                     column(
                       width = 5,
                       textAreaInput(
                         "transcr",
                         "Enter transcript (separate utterances with a period)",
                         height = "400px",
                         width = "100%",
                         value = "",#transcriptDefault
                       ),br(),
                       actionButton("full_transcription",
                                    "Detailed transcription rules")
                     )
                   ),
                   fluidRow(column(
                     width = 10,
                     offset = 1,
                     div(
                       align = "center",
                       actionButton("glide_back2", "Back"),
                       actionButton("start",
                                    "Next")
                     )
                   )))
    )
    
  )
}
