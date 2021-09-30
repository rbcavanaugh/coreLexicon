#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  
  
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
  
  
  ################################## OBSERVERS ###################################
  # ------------------------------------------------------------------------------
  ################################################################################
  
  # larger observer to disable, hide and show specific things:
  
  observe({
    # disables the navbar buttons
    shinyjs::disable(selector = "#mainpage li a[data-value=results]")
    shinyjs::disable(selector = "#mainpage li a[data-value=scoring]")
    shinyjs::disable(selector = "#mainpage li a[data-value=intro]")
    # shows download report button only on the results page. 
    if(input$mainpage != "results"){
      shinyjs::hide("report")
      shinyjs::hide("downloadData")
    } else {
      shinyjs::show("report")
      shinyjs::show("downloadData")
    }
    
  })
  
  ##### DISABLE #######
  
  observeEvent(input$stim,{
    if(input$stim != "cinderella"){
      shinyjs::hide("adj")
    } else {
      shinyjs::show("adj")
    }
  })
  
  
  
  ################################## START ASSESSMENT ############################
  # start button. sets the i value to 1 corresponding to the first slide
  # switches to the assessment tab
  # initialize values in here so that they reset whever someone hits start. 
  observeEvent(input$start, {
    # got to slides
    values$time = Sys.time()
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
  output$table_cl = DT::renderDT({
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
  callback = htmlwidgets::JS(
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
    get_results_plot(dat = selectedData(), time = input$time)
  })
  
  #### results text ####   
  
  output$words_results <-
    renderText({
      acc = results_text(selectedData(), "acc", input$time)
      eff = results_text(selectedData(), "eff", input$time)
      return(
        paste(acc, eff)
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
    print(accuracy)
    values$score_num_data <- sum(as.numeric(accuracy))
    
  })
  
  # this makes the table for scoring....
  # reactive data
  selectedData2 <- reactive({
    task = dplyr::case_when(
      input$stim == 'broken_window' ~ 1,
      input$stim == 'refused_umbrella' ~ 2,
      input$stim == 'cat_rescue' ~ 3,
      input$stim == 'cinderella' ~ 4,
      input$stim == 'sandwich' ~ 5
    )
    df <- core_lex(input$transcr, task)
    options = list(show = 10)
    table = df$match %>%
      dplyr::rename('Target Lexeme' = target_lemma,
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
  # FAQ information modal
  observeEvent(input$faq, {
    showModal(modalDialog(
      shiny::includeMarkdown(system.file("app/www/faq.md", package = "coreLexicon")),
      easyClose = TRUE,
      footer = NULL,
      size = "l"
    ))
  })
  # BIO modal. 
  observeEvent(input$bio, {
    showModal(modalDialog(
      shiny::includeMarkdown(system.file("app/www/bio.md", package = "coreLexicon")),
      size = "l",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  # references modal. 
  observeEvent(input$references, {
    showModal(modalDialog(
      shiny::includeMarkdown(system.file("app/www/references.md", package = "coreLexicon")),
      size = "l",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  ################################### OTHER MODALS ############################
  #trascription rules
  observeEvent(input$full_transcription, {
    showModal(modalDialog(
      tags$iframe(src = "www/full_transcription.html",
                  frameBorder="0",
                  height = "650px",
                  width = "100%"),
      size = "l",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  
  ################################## DOWNLOADS #################################
  # --------------------------------------------------------------------------
  ############################################################################
  
  ############## Download data ##################################################3
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$stimMC, "_MC_summary.xlsx", sep = "")
    },
    content = function(file) {
      openxlsx::write.xlsx(
        list(
          tibble::tibble(transcript = input$transcr),
          selectedData2(),
          selectedData()$score
        )
        , file
        )
    }
  )
  
  ##################################### REPORT #################################
  
  output$report <- downloadHandler(
    # For PDF output, change this to "report.pdf"
    filename = "report.pdf",
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempReport <- system.file("report.Rmd", package = "coreLexicon")#file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      
      # Set up parameters to pass to Rmd document
      params <- list(
        # params go here...
        #norms: NA 
        results_text = paste(
          results_text(selectedData(), "acc", input$time),
          results_text(selectedData(), "eff", input$time)
        ),
        stim = input$stim,
        name = ifelse(nchar(input$name)>0, input$name, "X"),
        time = input$time,
        data = selectedData(),
        start_time = values$time,
        notes = input$notes)
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    }
  )
  
}
