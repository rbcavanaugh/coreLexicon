

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  
  values <- reactiveValues()
  ################# WAITERS #####################
  
  #establishes plot loading 
  w <- waiter::Waiter$new(id = "table_cl",
                  html = waiter::spin_loader(), 
                  color = "white")
  
  #establishes plot loading 
  x <- waiter::Waiter$new(id = "plot_cl",
                  html = waiter::spin_loader(), 
                  color = "white")

  ###########################Intro tab next and back############################
  observeEvent(input$glide_next1,{
    updateTabsetPanel(session, "glide", "glide2")
  })
  
  observeEvent(input$glide_back1,{
    updateTabsetPanel(session, "glide", "glide1")
  })
  
  observeEvent(input$glide_next2,{
    updateTabsetPanel(session, "glide", "glide3")
  })
  
  observeEvent(input$glide_back2,{
    updateTabsetPanel(session, "glide", "glide2")
  })
  
  
  ################################## OBSERVERS ###########################
  
  ##### DISABLE #######
  
  observeEvent(input$stim,{
    if(input$stim != "cinderella"){
      shinyjs::disable("adj")
    } else {
      shinyjs::enable("adj")
    }
  })
  
  
  
  ################################## START ASSESSMENT ############################
  # start button. sets the i value to 1 corresponding to the first slide
  # switches to the assessment tab
  # initialize values in here so that they reset whever someone hits start. 
  observeEvent(input$start, {
    # got to slides
    updateNavbarPage(session, "mainpage", selected = "scoring")
    
  })
  
  observeEvent(input$go_back, {
    # got to slides
    updateNavbarPage(session, "mainpage", selected = "intro")
    
  })
  
  observeEvent(input$go_to_results, {
    # got to slides
    updateNavbarPage(session, "mainpage", selected = "results")
    
  })
  
  #############################START OVER#########################################
  
  observeEvent(input$start_over,{
    
    shinyjs::reset("intro_tab")
    updateTabsetPanel(session, "glide", "glide1")
    
    # immediately navigate back to previous tab
    updateTabsetPanel(session, "mainpage",
                      selected = "intro")
    
  })
  

  
  ################################## OUTPUTS ####################################
 # scoring table
   output$table_cl = DT::renderDataTable({
    w$show()
    data()
    
  },
  escape = FALSE,
  selection = 'none',
  server = FALSE,
  options = list(dom = 't',
                 ordering = TRUE,
                 scrollY = "400px",
                 #scroller = TRUE,
                 fixedColumns = list(heightMatch = 'none'),
                 #scrollCollapse = TRUE,
                 columnDefs = list(list(className = 'dt-center', targets = 0:3)),
                 paging = FALSE
  ),
  callback = DT::JS(
    "table.rows().every(function(i, tab, row) {
        var $this = $(this.node());
        $this.attr('id', this.data()[0]);
        $this.addClass('shiny-input-container');
      });
      Shiny.unbindAll(table.table().node());
      Shiny.bindAll(table.table().node());")
  )
  
  # not sure what this is...
  output$sel = renderTable({
    score_num()
  })
  
  # core lexicon results plot 
  output$plot_cl <- renderPlot({
    x$show()
    get_results_plot(dat = selectedData())
  })
  
  #### results text ####   
  
  output$words_results <-
    renderText({
      paste0("There were ", selectedData()[["scores"]][1], " core words produced. This score is in the ",
             selectedData()[["score"]][1,4], " percentile for individuals with aphasia and ",
             selectedData()[["score"]][1,3], " percentile for individuals without stroke or aphasia."
      )
      
    })
  
  output$eff_results <-
    renderText({
      paste0("There were ", round(selectedData()[["scores"]][2],1), " core words per minute produced. This score is in the ",
             selectedData()[["score"]][2,4], " percentile for individuals with aphasia and ",
             selectedData()[["score"]][2,3], " percentile for individuals without stroke or aphasia."
      )
      
    })


  ################################## REACTIVE VALUES ############################
  
  # core lex counter
  counter2 <- reactiveVal(0)
  get_cor_id <- reactive({
    nrow(selectedData2())
    isolate(counter2(counter2() + 1))
    paste0("cor_check", counter2())
  })
  
  
  data <- reactive({
    df = selectedData2()
    for (i in 1:nrow(df)) {
      df[["Correct"]][i] <- as.character(checkboxInput(paste0(get_cor_id(), i),
                                                                       label="",
                                                                       value = df$produced[i]
      ))
      
    }
    df %>% dplyr::select(-produced)
  })

  
  observe({
    accuracy = unlist(sapply(1:nrow(data()), function(i) input[[paste0(get_cor_id(), i)]]))
    values$score_num_data <- sum(as.numeric(accuracy))
    
  })
  
  # this makes the table for scoring....
  # reactive data
  selectedData2 <- reactive({
    task = case_when(
      input$stim == 'broken_window' ~ 1,
      input$stim == 'refused_umbrella' ~ 2,
      input$stim == 'cat_rescue' ~ 3,
      input$stim == 'cinderella' ~ 4,
      input$stim == 'sandwich' ~ 5
    )
    df <- core_lex(input$transcr, task, input$age)
    options = list(show = 10)
    table = df$match %>%
      rename('Target Lexeme' = target_lemma,
             'Token Produced' = token
      )
    return(table)
  })
  
  # this calculates the scores....
  # Reactive that returns the whole dataset if there is no brush
  selectedData <- reactive({
    
    get_selected_data(stim=input$stim, score_num_data = values$score_num_data, time=input$time, adj = input$adj)
    
  })
  
  
  ################################## FOOTER MODAL ################################
  # ------------------------------------------------------------------------------
  ################################################################################
  # More information modal
  observeEvent(input$faq, {
    showModal(modalDialog(
      shiny::includeMarkdown("www/faq.md"),
      easyClose = TRUE,
      footer = NULL,
      size = "l"
    ))
  })
  # readme modal. probabily will be deleted
  observeEvent(input$bio, {
    showModal(modalDialog(
      shiny::includeMarkdown("www/bio.md"),
      size = "l",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  

})
