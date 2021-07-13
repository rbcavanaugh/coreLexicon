##### results tab

results_div <-
  column(width = 8, offset = 2,
         
         fluidRow(
                    textOutput("words_results"),
                    
                    br(), br(),
                    
                    textOutput("eff_results")
         ),
         
         br(),
         
         fluidRow(
           
           plotOutput("plot_cl", height = '350px')
           
        ),
        
        br(),
        
        fluidRow(
          
          column(width = 8, align = "center",
          
            actionButton("start_over", "Start Over", icon = icon("undo"))
            
          )
        )
  )


