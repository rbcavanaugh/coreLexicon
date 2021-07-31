

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  #establishes plot loading 
  w <- Waiter$new(id = "table_cl",
                  html = spin_loader(), 
                  color = "white")
  
  #establishes plot loading 
  x <- Waiter$new(id = "plot_cl",
                  html = spin_loader(), 
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
  
  
  ######## core lexicon stuff ######
  
  # core lexicon table output
  
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
      df[["Correct"]][i] <- as.character(shinyWidgets::awesomeCheckbox(paste0(get_cor_id(), i),
                                                                       label="",
                                                                       #width = "20px",
                                                                       value = df$produced[i],
                                                                       status = "primary"#,
                                                                       #bigger = T,
                                                                       #icon = icon("check")
      ))
    }
    df %>% dplyr::select(-produced)
  })
  
  ####core lex table #####
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
  callback = JS(
    "table.rows().every(function(i, tab, row) {
        var $this = $(this.node());
        $this.attr('id', this.data()[0]);
        $this.addClass('shiny-input-container');
      });
      Shiny.unbindAll(table.table().node());
      Shiny.bindAll(table.table().node());")
  )
  
  
  
  score_num_data <- reactive({
    accuracy = unlist(sapply(1:nrow(data()), function(i) input[[paste0(get_cor_id(), i)]]))
    
    return(sum(as.numeric(accuracy)))
    
  })
  
  output$sel = renderTable({
    score_num()
  })
  
  
  
  # core lexicon results plot 
  output$plot_cl <- renderPlot({
    x$show()
    prod <- selectedData()[[2]] %>%
      mutate(Cohort = ifelse(dist == 'dist1' | dist == 'dist3', 'control', 'aphasia'),
             met = factor(ifelse(dist == 'dist1' | dist == 'dist2', 'Production', 'Efficiency'),
                          levels = c('Production', 'Efficiency'))
      ) %>%
      dplyr::filter(met == "Production") %>%
      ggplot(aes(x = val, color = Cohort, fill = Cohort)) +
      geom_density(alpha = .3, adjust = 3) +
      geom_vline(data = data.frame(xint=selectedData()[[3]][[1]],met="Production"), 
                 aes(xintercept = xint), linetype = "dashed", size = 1) +
      theme_grey(base_size = 14) +
      theme(#panel.background = element_rect(fill = "transparent"),
        legend.position = 'bottom',
        axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5)) +
      labs(title = "Core words")
    
    eff <- selectedData()[[2]] %>%
      mutate(Cohort = ifelse(dist == 'dist1' | dist == 'dist3', 'control', 'aphasia'),
             met = factor(ifelse(dist == 'dist1' | dist == 'dist2', 'Production', 'Efficiency'),
                          levels = c('Production', 'Efficiency'))
      ) %>%
      dplyr::filter(met == "Efficiency") %>%
      ggplot(aes(x = val, color = Cohort, fill = Cohort)) +
      geom_density(alpha = .3, adjust = 3) +
      geom_vline(data = data.frame(xint=selectedData()[[3]][[2]],met="Efficiency"), 
                 aes(xintercept = xint), linetype = "dashed", size = 1) +
      theme_grey(base_size = 14) +
      theme(#panel.background = element_rect(fill = "transparent"),
        legend.position = 'bottom',
        axis.title.y=element_blank(),
        axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5)) +
      labs(title = "Core words / min")
    
    prod + eff + plot_layout(guides = 'collect') & theme(legend.position = 'bottom')
    
  })
  
  #### value boxes ####   
  
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

  
  observeEvent(input$stim,{
    if(input$stim != "cinderella"){
      shinyjs::disable("adj")
    } else {
      shinyjs::enable("adj")
    }
  })
  
  
  
  
  
  #########################################################
  
  # this makes the table for scoring....
  # reactive data
  selectedData2 <- reactive({
    task = case_when(
      input$stim == 'broken_window' ~ 1,
      input$stim == 'refused_umbrella' ~ 2,
      input$stim == 'cat_rescue' ~ 3,
      input$stim == 'cinderella' ~ 4,
      input$stim == 'sandwich' ~ 5,
      input$stim == 'gdc' ~ 6,
      input$stim == 'picnic' ~ 7
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
    
    task = case_when(
      input$stim == 'broken_window' ~ 1,
      input$stim == 'refused_umbrella' ~ 2,
      input$stim == 'cat_rescue' ~ 3,
      input$stim == 'cinderella' ~ 4,
      input$stim == 'sandwich' ~ 5,
      input$stim == 'gdc' ~ 6,
      input$stim == 'picnic' ~ 7
    )
    
    #df <- core_lex(input$transcr, task, input$age)
    #matches <- df$match
    score_num = score_num_data() + input$adj #sum(matches$produced) +
    score_eff = score_num/(input$time/60)
    
    # Norn data ####
    
    # ACCURACY #
    norm_mean = case_when(
      input$stim == 'broken_window' ~ list(c(19, 2.9, 12, 23)),
      input$stim == 'refused_umbrella' ~ list(c(26.5, 3.1, 17, 33)),
      input$stim == 'cat_rescue' ~ list(c(26.3, 3.3, 16, 33)),
      input$stim == 'cinderella' ~ list(c(69.8, 15.5, 6, 90)),
      input$stim == 'sandwich' ~ list(c(19, 2.7, 14, 23))
    )
    
    aphasia_mean = case_when(
      input$stim == 'broken_window' ~ list(c(12, 4.9, 0, 22)),
      input$stim == 'refused_umbrella' ~ list(c(17.3, 7.7, 0, 34)),
      input$stim == 'cat_rescue' ~ list(c(16.8, 7.0, 0, 31)),
      input$stim == 'cinderella' ~ list(c(37.5, 19.4, 1, 82)),
      input$stim == 'sandwich' ~ list(c(11.3, 5.4, 0, 23))
    )
    
    # EFFICIENCY 
    
    norm_mean_eff = case_when(
      input$stim == 'broken_window' ~ list(c(34.8, 13.5, 6.7, 72.9)),
      input$stim == 'refused_umbrella' ~ list(c(41.3, 14.5, 16.6, 98.2)),
      input$stim == 'cat_rescue' ~ list(c(39.8, 14.3, 13.3, 100)),
      input$stim == 'cinderella' ~ list(c(24.7, 10.0,3.4, 72.0)),
      input$stim == 'sandwich' ~ list(c(40.5, 16.6, 8.6, 114.0))
    )
    
    aphasia_mean_eff = case_when(
      input$stim == 'broken_window' ~ list(c(18.5, 13.3, 0, 84.0)),
      input$stim == 'refused_umbrella' ~ list(c(19.7, 13.4, 0, 67.5)),
      input$stim == 'cat_rescue' ~ list(c(16.9, 12.3, 0, 93.8)),
      input$stim == 'cinderella' ~ list(c(14.1, 9.1, 0.4, 62.5)),
      input$stim == 'sandwich' ~ list(c(24.1,20.1, 0, 156.0))
    )
    
    # Max 
    max_val = case_when(
      input$stim == 'broken_window' ~ 24,
      input$stim == 'refused_umbrella' ~ 35,
      input$stim == 'cat_rescue' ~ 34,
      input$stim == 'cinderella' ~ 94,
      input$stim == 'sandwich' ~ 25
    )
    
    dist1 = truncnorm::rtruncnorm(500,
                                  mean = norm_mean[[1]][[1]],
                                  sd = norm_mean[[1]][[2]],
                                  a = norm_mean[[1]][[3]],
                                  b = norm_mean[[1]][[4]])
    percentile1 = label_percent()(ecdf(dist1)(score_num))
    
    dist2 = truncnorm::rtruncnorm(500,
                                  mean = aphasia_mean[[1]][[1]],
                                  sd = aphasia_mean[[1]][[2]],
                                  a = aphasia_mean[[1]][[3]],
                                  b = aphasia_mean[[1]][[4]])
    percentile2 = label_percent()(ecdf(dist2)(score_num))
    
    dist3 = truncnorm::rtruncnorm(500,
                                  mean = norm_mean_eff[[1]][[1]],
                                  sd = norm_mean_eff[[1]][[2]],
                                  a = norm_mean_eff[[1]][[3]],
                                  b = norm_mean_eff[[1]][[4]])
    percentile3 = label_percent()(ecdf(dist3)(score_eff))
    
    dist4 = truncnorm::rtruncnorm(500,
                                  mean = aphasia_mean_eff[[1]][[1]],
                                  sd = aphasia_mean_eff[[1]][[2]],
                                  a = aphasia_mean_eff[[1]][[3]],
                                  b = aphasia_mean_eff[[1]][[4]])
    percentile4 = label_percent()(ecdf(dist4)(score_eff))
    
    
    #####
    
    
    score = tibble(
      Metric = c('Production', 'Efficiency'),
      Score = c(paste0(round(score_num,0),' core words'),
                paste0(round(score_eff, 1), ' core words/min')),
      ControlPercentile =  c(percentile1, percentile3),
      AphasiaPercentile = c(percentile2, percentile4)
    )
    
    score <- score %>%
      mutate(
        ControlPercentile = ifelse(Metric != 'Production', ControlPercentile,
                                   ifelse(score_num > max_val,
                                          'exceeded max score',
                                          ControlPercentile)
        ),
        AphasiaPercentile = ifelse(Metric != 'Production', AphasiaPercentile,
                                   ifelse(score_num > max_val,
                                          'exceeded max score',
                                          AphasiaPercentile)
                                   
        )
      )
    
    colnames(score) <- c('Metric', 'Score', 'Control Percentile', 'Aphasia Percentile')
    
    dists <- tibble(
      dist1 = dist1,
      dist2 = dist2, 
      dist3 = dist3,
      dist4 = dist4
    ) %>%
      pivot_longer(cols = 1:4, names_to = 'dist', values_to = 'val')
    
    core_lex_data <- list()
    core_lex_data[["score"]] = score
    core_lex_data[["dist"]] = dists
    core_lex_data[["scores"]] = c(score_num, score_eff)
    
    return(core_lex_data) # make this a list with the data for the histograms too. 
    
  })
  
  
  ################################## FOOTER MODAL ################################
  # ------------------------------------------------------------------------------
  ################################################################################
  # More information modal
  observeEvent(input$faq, {
    showModal(modalDialog(
      shiny::includeMarkdown(here("app", "www", "faq.md")),
      easyClose = TRUE,
      footer = NULL,
      size = "l"
    ))
  })
  # readme modal. probabily will be deleted
  observeEvent(input$bio, {
    showModal(modalDialog(
      shiny::includeMarkdown(here("app", "www", "bio.md")),
      size = "l",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  

})
