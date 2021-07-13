
intro_tab_div <-
   column(width = 12,
          
          tabsetPanel(type="hidden", id = "glide",
                      
                      tabPanelBody(value = "glide1",
                                   column(align = "center", width = 8, offset = 2,
                                          h5("About and Instructions:"),
                                          div(style="display: inline-block; text-align: left;",
                                              intro_text,
                                              br(),
                                              # start!
                                              div(align="center",
                                                  actionButton("glide_next1", "Next")
                                              )
                                          )
                                   )
                      ),
                      
                      tabPanelBody(value = "glide2",
                                   div(align = "center",
                                       div(style="display: inline-block; text-align: left;",
                                           h5("Input participant information"), br(),
                                           textInput("name", "Enter a Name"),
                                           textInput("notes", "Enter any notes"),
                                           fileInput("file1", "Upload previous results", accept = ".csv"),
                                           div(align = "center",
                                               actionButton("glide_back1", "Back"),
                                               actionButton("glide_next2", "Next")
                                           )
                                           
                                           
                                           
                                       )
                                   )
                      ),
                      
                      tabPanelBody(value = "glide3",
                                   div(align = "center",
                                       div(style="display: inline-block; text-align: left;",
                                           h5("These are example inputs"), br(),
                                           ### Use this to set how many items to run.
                                           radioButtons(inputId = "stim",
                                                        label = "Select stimulus",
                                                        c("Broken Window" = 'broken_window',
                                                          "Cat Rescue" = 'cat_rescue',
                                                          "Refused Umbrella" = 'refused_umbrella',
                                                          "Cinderella" = 'cinderella',
                                                          "Sandwich" = 'sandwich'),
                                                        selected = "broken_window", 
                                                        inline = T),
                                           textAreaInput("transcr",
                                                         "Enter transcript (separate utterances with a period)",
                                                         height = "260px",
                                                         width = "100%",
                                                         value = transcriptDefault
                                                       ),
                                           numericInput("time",
                                                         "Enter Duration (seconds)",
                                                        value = 60,
                                                        min = 10,
                                                        max = 720
                                                         ),
                                           checkboxInput(inputId = "adj",
                                                           label = "Possessive ['s] (Cinderella)", 
                                                           value = FALSE
                                                        
                                           ),
                                           
                                           div(align = "center",
                                               actionButton("glide_back2", "Back"),
                                               actionButton("start",
                                                            "Get started")
                                           )
                                          
                                       )
                                   )
                      )
          )
              
  )



