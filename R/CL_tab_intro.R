
#' Get intro div
#' @export
get_intro_div <- function(){
  column(width = 12,
         
         tabsetPanel(type="hidden", id = "glide",
                     
                     tabPanelBody(value = "glide1",
                                  column(align = "center", width = 8, offset = 2,
                                         h5("Welcome to the Core Lexicon Analysis Shiny App"),
                                         div(style="display: inline-block; text-align: left;",
                                             includeMarkdown(system.file("app/www/corelex_intro.md", package = "cl")),
                                             br(),
                                             # start!
                                             div(align="center",
                                                 actionButton("glide_next1", "Next")
                                             )
                                         )
                                  )
                     ),
                     
                     tabPanelBody(value = "glide2",
                                  column(width = 10, offset = 1,
                                      div(align = "center",
                                          div(style="display: inline-block; text-align: left;",
                                              
                                              h5("Input participant information"), br(),
                                              textInput("name", "Enter a Name"),
                                              selectInput(inputId = "stim",
                                                          label = "Select stimulus",
                                                          c("Broken Window" = 'broken_window',
                                                            "Cat Rescue" = 'cat_rescue',
                                                            "Refused Umbrella" = 'refused_umbrella',
                                                            "Cinderella" = 'cinderella',
                                                            "Sandwich" = 'sandwich'),
                                                          selected = "broken_window"#, 
                                                          #inline = F
                                              ),
                                              numericInput("time",
                                                           "Enter Duration (seconds)",
                                                           value = 0,
                                                           min = 0,
                                                           max = 720
                                              ),
                                              textAreaInput("notes", "Enter any notes", width = "100%", height = "100px"),
                                             # fileInput("file1", "Upload previous results", accept = ".csv"),
                                          )
                                       ),
                                      div(align = "center",
                                          actionButton("glide_back1", "Back"),
                                          actionButton("glide_next2", "Next")
                                      )
                                  )
                     ),
                     
                     tabPanelBody(value = "glide3",
                                  fluidRow(
                                    column(width = 5, offset = 1,
                                           h4("Transcrition"),br(),
                                              includeMarkdown(system.file("app/www/transcribing.md", package = "cl")),
                                           "We recommended copying and saving samples into a text editor
                                   (e.g. microsoft word) after transcribing and before scoring.", br(), br(),
                                   checkboxInput(inputId = "adj",
                                                 label = "Check if transcription included a Possessive ['s] (Cinderella only)", 
                                                 value = FALSE
                                                 )
                                           ),
                                   column(width = 5,
                                          textAreaInput("transcr",
                                                        "Enter transcript (separate utterances with a period)",
                                                        height = "400px",
                                                        width = "100%",
                                                        value = transcriptDefault
                                          ),
                                   )
                                  ),
                                  fluidRow(
                                    column(width = 10, offset = 1,
                                           div(align = "center",
                                               actionButton("glide_back2", "Back"),
                                               actionButton("start",
                                                            "Next")
                                           )
                                      )
                                  )
                     )
         )
         
  )
}
