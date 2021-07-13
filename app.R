# #Easy:
# 
# # Medium:
# # true corlex norms
# # mca norms and results page
# # download of data - core lex and mca
# 
# # questions:
# # swap sentences and scoring??
# 
# # hard:
# # use slickR or shinyglide for scoring components.
# #learn-r tutorial
# 
# 
# 
# ############### load stuff ################
# library(shiny)
# library(here)
# library(scales)
# library(tidyverse)
# library(patchwork)
# library(textstem)
# library(tidytext)
# library(DT)
# library(truncnorm)
# library(waiter)
# library(shinythemes)
# library(shinydashboard)
# library(shinyWidgets)
# library(htmlwidgets)
# library(shinyjs)
# library(tokenizers)
# 
# ###################### UI ###################
# ui <-
#     tagList(
#         #setup
#         useShinyjs(),
#         use_waiter(),
#         waiter_preloader(html = spin_dots(), color = "#2c3e50"), #html = spin_dots(), color = "#f0f0f0"
#         useShinydashboard(),
#         tags$head(
#             tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
#             tags$title("Core Lexicon")
#         ),
#         #app
#         navbarPage(
#             id = "bigpage",
#             #theme = shinytheme("flatly"),
#             fluid = T,collapsible = T,
#             title = div(tags$a(id = "img-id", target = "_blank",
#                                href = "https://github.com/rbcavanaugh/coreLexicon",
#                                icon("github"), style = "color:black;")),
# 
#             ########### core lex ##########
#             tabPanel("Core Lexicon",
#                      sidebarLayout(
#                          sidebarPanel(width = 3,
#                                       selectInput("stim", "Select Stimulus",
#                                                   c("Broken Window" = 'broken_window',
#                                                     "Cat Rescue" = 'cat_rescue',
#                                                     "Refused Umbrella" = 'refused_umbrella',
#                                                     "Cinderella" = 'cinderella',
#                                                     "Sandwich" = 'sandwich'),
#                                                   selected = "broken_window",
#                                                   # "Good Dog Carl" = 'gdc',
#                                                   #"Picnic" = 'picnic'),
#                                       ),
#                                       textAreaInput("transcr",
#                                                     "Enter Transcript",
#                                                     value = transcriptDefault,
#                                                     height = '300px'),
# 
# 
#                                       numericInput("time", "Time on task (seconds)", value= 120,
#                                                    min = 1, max = 1200, step = 1),
# 
#                                       awesomeCheckbox(inputId = "adj",
#                                                       label = "Possessive ['s] (Cinderella)",
#                                                       value = FALSE, #bigger = T,
#                                                       #icon = icon("check"),
#                                                       status = "primary"
#                                       )
# 
#                                       # sliderInput("adj", "Score Adjustment:", value= 0,
#                                       #             min = -10, max = 10, step = 1)
#                          ),
#                          mainPanel(width = 9,
#                                    fluidRow(
#                                        column(width = 6,
#                                               tabsetPanel(
#                                                   tabPanel("Check Scoring",
#                                                            br(),
#                                                            tags$ol(
#                                                                tags$li("Following Core-lex rules, check that target lexemes match tokens and that target lexemes without a matched token were not missed by the algorithm."),
#                                                                tags$li("Add 1 point for a possessive [ 's ] (Cinderella only)"),
#                                                                tags$li("Count any variation of mom/mother or dad/father.")
#                                                            ),
#                                                            DTOutput("table_cl")),
#                                                   tabPanel("Detailed Instructions", textOutput("scoring_cl"))
#                                               )
#                                        ),
#                                        column(width = 6,
#                                               tabsetPanel(
#                                                   tabPanel("Results",br(),
#                                                            valueBoxOutput("results_cl1", width = NULL),
#                                                            valueBoxOutput("results_cl2", width = NULL),
#                                                            box(width = NULL,
#                                                                plotOutput("plot_cl", height = '300px')
#                                                            )
#                                                   ),
#                                                   tabPanel("References",
#                                                            br(),
#                                                            tags$ol(
#                                                                tags$li("Dalton, S. G., Hubbard, H. I., & Richardson, J. D. (2019). Moving toward non-transcription based discourse analysis in stable and progressive aphasia. In Seminars in speech and language. Thieme Medical Publishers."), br(),
#                                                                tags$li("Dalton, S. G., & Richardson, J. D. (2015). Core-lexicon and main-concept production during picture-sequence description in adults without brain damage and adults with aphasia. American Journal of Speech-Language Pathology, 24(4), S923-S938."),br(),
#                                                                tags$li("Kim, H., & Wright, H. H. (2020, January). A tutorial on core lexicon: development, use, and application. In Seminars in speech and language (Vol. 41, No. 01, pp. 020-031). Thieme Medical Publishers."),br(),
#                                                                tags$li("Silge J, Robinson D (2016). tidytext: Text Mining and Analysis Using Tidy Data Principles in R. JOSS, 1(3). doi: 10.21105/joss.00037")
#                                                            )
#                                                   )
#                                               )
#                                        )
#                                    )
#                          )
# 
#                      )
#             ),
#             tabPanel("About",
#                      box(width = NULL,
#                          tags$a(id = "rc",
#                                 icon("external-link"),
#                                 href = "https://robcavanaugh.com",
#                                 "Rob Cavanaugh")),
#                      box(width = NULL,
#                          tags$a(id = "sg",
#                                 href = "https://www.marquette.edu/speech-pathology-audiology/building-rehabilitation-advances-in-neurscience-lab.php",
#                                 icon("external-link"),
#                                 "Sarah Grace Dalton")),
#                      box(width = NULL,
#                          tags$a(id = "jr",
#                                 href = "https://shs.unm.edu/people/faculty/jessica-richardson.html",
#                                 icon("external-link"),
#                                 "Jessica Richardson")),
#                      box(width = NULL,
#                          actionButton("feedback", "Send Feedback", style = 'float:right;')
#                      )
#             )
# 
#         )
#     )
# 
# ######## server ########
# # Define server logic required to draw a histogram
# server <- function(input, output, session) {
# 
# 
#     ###### stuff that doesn't matter right now.... #####
#     # feedback core lex
#     observeEvent(input$feedback, {
#         showModal(
#             modalDialog(
#                 title = "Feedback",
#                 tags$iframe(src = 'https://docs.google.com/forms/d/e/1FAIpQLSfrae3ucppQC_Hy2udxj5_xZwRqbkHwTzUX6PQEnpUdahAb4g/viewform?usp=sf_link',
#                             width = '100%',
#                             height = 500,
#                             frameborder = 0,
#                             marginheight = 0),
#                 easyClose = TRUE,
#                 size = "l"
#             ))
#     })
# 
# 
#     ######## core lexicon stuff ######
# 
#     # core lexicon table output
# 
#     # core lex counter
#     counter2 <- reactiveVal(0)
#     get_cor_id <- reactive({
#         nrow(selectedData2())
#         isolate(counter2(counter2() + 1))
#         paste0("cor_check", counter2())
#     })
# 
#     data <- reactive({
#         df = selectedData2()
#         for (i in 1:nrow(df)) {
#             df[["Correct"]][i] <- as.character(shinyWidgets::awesomeCheckbox(paste0(get_cor_id(), i),
#                                                                              label="",
#                                                                              #width = "20px",
#                                                                              value = df$produced[i],
#                                                                              status = "primary"#,
#                                                                              #bigger = T,
#                                                                              #icon = icon("check")
#             ))
#         }
#         df %>% dplyr::select(-produced)
#     })
# 
#     ####core lex table #####
#     output$table_cl = DT::renderDataTable(
#         data(),
#         escape = FALSE,
#         selection = 'none',
#         server = FALSE,
#         options = list(dom = 't',
#                        ordering = TRUE,
#                        scrollY = "400px",
#                        #scroller = TRUE,
#                        fixedColumns = list(heightMatch = 'none'),
#                        #scrollCollapse = TRUE,
#                        columnDefs = list(list(className = 'dt-center', targets = 0:3)),
#                        paging = FALSE
#         ),
#         callback = JS(
#             "table.rows().every(function(i, tab, row) {
#         var $this = $(this.node());
#         $this.attr('id', this.data()[0]);
#         $this.addClass('shiny-input-container');
#       });
#       Shiny.unbindAll(table.table().node());
#       Shiny.bindAll(table.table().node());")
#     )
# 
# 
# 
#     score_num_data <- reactive({
#         accuracy = unlist(sapply(1:nrow(data()), function(i) input[[paste0(get_cor_id(), i)]]))
# 
#         return(sum(as.numeric(accuracy)))
# 
#     })
# 
#     output$sel = renderTable({
#         score_num()
#     })
# 
# 
# 
#     # core lexicon results plot
#     output$plot_cl <- renderPlot({
#         prod <- selectedData()[[2]] %>%
#             mutate(Cohort = ifelse(dist == 'dist1' | dist == 'dist3', 'control', 'aphasia'),
#                    met = factor(ifelse(dist == 'dist1' | dist == 'dist2', 'Production', 'Efficiency'),
#                                 levels = c('Production', 'Efficiency'))
#             ) %>%
#             dplyr::filter(met == "Production") %>%
#             ggplot(aes(x = val, color = Cohort, fill = Cohort)) +
#             geom_density(alpha = .3) +
#             geom_vline(data = data.frame(xint=selectedData()[[3]][[1]],met="Production"),
#                        aes(xintercept = xint), linetype = "dashed", size = 1) +
#             theme_grey(base_size = 14) +
#             theme(#panel.background = element_rect(fill = "transparent"),
#                 legend.position = 'bottom',
#                 axis.title.y=element_blank(),
#                 axis.title.x=element_blank(),
#                 axis.text.y=element_blank(),
#                 axis.ticks.y=element_blank(),
#                 legend.title = element_blank(),
#                 plot.title = element_text(hjust = 0.5)) +
#             labs(title = "Core words")
# 
#         eff <- selectedData()[[2]] %>%
#             mutate(Cohort = ifelse(dist == 'dist1' | dist == 'dist3', 'control', 'aphasia'),
#                    met = factor(ifelse(dist == 'dist1' | dist == 'dist2', 'Production', 'Efficiency'),
#                                 levels = c('Production', 'Efficiency'))
#             ) %>%
#             dplyr::filter(met == "Efficiency") %>%
#             ggplot(aes(x = val, color = Cohort, fill = Cohort)) +
#             geom_density(alpha = .3) +
#             geom_vline(data = data.frame(xint=selectedData()[[3]][[2]],met="Efficiency"),
#                        aes(xintercept = xint), linetype = "dashed", size = 1) +
#             theme_grey(base_size = 14) +
#             theme(#panel.background = element_rect(fill = "transparent"),
#                 legend.position = 'bottom',
#                 axis.title.y=element_blank(),
#                 axis.title.x=element_blank(),
#                 axis.text.y=element_blank(),
#                 axis.ticks.y=element_blank(),
#                 legend.title = element_blank(),
#                 plot.title = element_text(hjust = 0.5)) +
#             labs(title = "Core words / min")
# 
#         prod + eff + plot_layout(guides = 'collect') & theme(legend.position = 'bottom')
# 
#     })
# 
#     #### value boxes ####
# 
#     #core lex value box production
#     output$results_cl1 <- renderValueBox({
#         valueBox(
#             value = paste0(selectedData()[["scores"]][1], " core words"),
#             subtitle = paste0("Aphasia Percentile: ", selectedData()[["score"]][1,4], " | Control Percentile: ", selectedData()[["score"]][1,3]),
#             icon = icon("list-ol"),
#             color = "blue"
#         )
#     })
# 
#     # core lex value box efficiency
#     output$results_cl2 <- renderValueBox({
#         valueBox(
#             paste0(round(selectedData()[["scores"]][2],1), " core words/min"),
#             subtitle = paste0("Aphasia Percentile: ", selectedData()[["score"]][2,4], " | Control Percentile: ", selectedData()[["score"]][2,3]),
#             icon = icon("tachometer"),
#             color = "blue"
#         )
#     })
# 
#     observeEvent(input$stim,{
#         if(input$stim != "cinderella"){
#             shinyjs::disable("adj")
#         } else {
#             shinyjs::enable("adj")
#         }
#     })
# 
# 
# 
# 
# 
#     #########################################################
# 
#     # this makes the table for scoring....
#     # reactive data
#     selectedData2 <- reactive({
#         task = case_when(
#             input$stim == 'broken_window' ~ 1,
#             input$stim == 'refused_umbrella' ~ 2,
#             input$stim == 'cat_rescue' ~ 3,
#             input$stim == 'cinderella' ~ 4,
#             input$stim == 'sandwich' ~ 5,
#             input$stim == 'gdc' ~ 6,
#             input$stim == 'picnic' ~ 7
#         )
#         df <- core_lex(input$transcr, task, input$age)
#         options = list(show = 10)
#         table = df$match %>%
#             rename('Target Lexeme' = target_lemma,
#                    'Token Produced' = token
#             )
#         return(table)
#     })
# 
#     # this calculates the scores....
#     # Reactive that returns the whole dataset if there is no brush
#     selectedData <- reactive({
# 
#         task = case_when(
#             input$stim == 'broken_window' ~ 1,
#             input$stim == 'refused_umbrella' ~ 2,
#             input$stim == 'cat_rescue' ~ 3,
#             input$stim == 'cinderella' ~ 4,
#             input$stim == 'sandwich' ~ 5,
#             input$stim == 'gdc' ~ 6,
#             input$stim == 'picnic' ~ 7
#         )
# 
#         #df <- core_lex(input$transcr, task, input$age)
#         #matches <- df$match
#         score_num = score_num_data() + input$adj #sum(matches$produced) +
#         score_eff = score_num/(input$time/60)
# 
#         # Norn data ####
# 
#         # ACCURACY #
#         norm_mean = case_when(
#             input$stim == 'broken_window' ~ list(c(19, 2.9, 12, 23)),
#             input$stim == 'refused_umbrella' ~ list(c(26.5, 3.1, 17, 33)),
#             input$stim == 'cat_rescue' ~ list(c(26.3, 3.3, 16, 33)),
#             input$stim == 'cinderella' ~ list(c(69.8, 15.5, 6, 90)),
#             input$stim == 'sandwich' ~ list(c(19, 2.7, 14, 23))
#         )
# 
#         aphasia_mean = case_when(
#             input$stim == 'broken_window' ~ list(c(12, 4.9, 0, 22)),
#             input$stim == 'refused_umbrella' ~ list(c(17.3, 7.7, 0, 34)),
#             input$stim == 'cat_rescue' ~ list(c(16.8, 7.0, 0, 31)),
#             input$stim == 'cinderella' ~ list(c(37.5, 19.4, 1, 82)),
#             input$stim == 'sandwich' ~ list(c(11.3, 5.4, 0, 23))
#         )
# 
#         # EFFICIENCY
# 
#         norm_mean_eff = case_when(
#             input$stim == 'broken_window' ~ list(c(34.8, 13.5, 6.7, 72.9)),
#             input$stim == 'refused_umbrella' ~ list(c(41.3, 14.5, 16.6, 98.2)),
#             input$stim == 'cat_rescue' ~ list(c(39.8, 14.3, 13.3, 100)),
#             input$stim == 'cinderella' ~ list(c(24.7, 10.0,3.4, 72.0)),
#             input$stim == 'sandwich' ~ list(c(40.5, 16.6, 8.6, 114.0))
#         )
# 
#         aphasia_mean_eff = case_when(
#             input$stim == 'broken_window' ~ list(c(18.5, 13.3, 0, 84.0)),
#             input$stim == 'refused_umbrella' ~ list(c(19.7, 13.4, 0, 67.5)),
#             input$stim == 'cat_rescue' ~ list(c(16.9, 12.3, 0, 93.8)),
#             input$stim == 'cinderella' ~ list(c(14.1, 9.1, 0.4, 62.5)),
#             input$stim == 'sandwich' ~ list(c(24.1,20.1, 0, 156.0))
#         )
# 
#         # Max
#         max_val = case_when(
#             input$stim == 'broken_window' ~ 24,
#             input$stim == 'refused_umbrella' ~ 35,
#             input$stim == 'cat_rescue' ~ 34,
#             input$stim == 'cinderella' ~ 94,
#             input$stim == 'sandwich' ~ 25
#         )
# 
#         dist1 = truncnorm::rtruncnorm(10000,
#                                       mean = norm_mean[[1]][[1]],
#                                       sd = norm_mean[[1]][[2]],
#                                       a = norm_mean[[1]][[3]],
#                                       b = norm_mean[[1]][[4]])
#         percentile1 = label_percent()(ecdf(dist1)(22))
# 
#         dist2 = truncnorm::rtruncnorm(10000,
#                                       mean = aphasia_mean[[1]][[1]],
#                                       sd = aphasia_mean[[1]][[2]],
#                                       a = aphasia_mean[[1]][[3]],
#                                       b = aphasia_mean[[1]][[4]])
#         percentile2 = label_percent()(ecdf(dist2)(score_num))
# 
#         dist3 = truncnorm::rtruncnorm(10000,
#                                       mean = norm_mean_eff[[1]][[1]],
#                                       sd = norm_mean_eff[[1]][[2]],
#                                       a = norm_mean_eff[[1]][[3]],
#                                       b = norm_mean_eff[[1]][[4]])
#         percentile3 = label_percent()(ecdf(dist3)(score_eff))
# 
#         dist4 = truncnorm::rtruncnorm(10000,
#                                       mean = aphasia_mean_eff[[1]][[1]],
#                                       sd = aphasia_mean_eff[[1]][[2]],
#                                       a = aphasia_mean_eff[[1]][[3]],
#                                       b = aphasia_mean_eff[[1]][[4]])
#         percentile4 = label_percent()(ecdf(dist4)(score_eff))
# 
# 
#         #####
# 
# 
#         score = tibble(
#             Metric = c('Production', 'Efficiency'),
#             Score = c(paste0(round(score_num,0),' core words'),
#                       paste0(round(score_eff, 1), ' core words/min')),
#             ControlPercentile =  c(percentile1, percentile3),
#             AphasiaPercentile = c(percentile2, percentile4)
#         )
# 
#         score <- score %>%
#             mutate(
#                 ControlPercentile = ifelse(Metric != 'Production', ControlPercentile,
#                                            ifelse(score_num > max_val,
#                                                   'exceeded max score',
#                                                   ControlPercentile)
#                 ),
#                 AphasiaPercentile = ifelse(Metric != 'Production', AphasiaPercentile,
#                                            ifelse(score_num > max_val,
#                                                   'exceeded max score',
#                                                   AphasiaPercentile)
# 
#                 )
#             )
# 
#         colnames(score) <- c('Metric', 'Score', 'Control Percentile', 'Aphasia Percentile')
# 
#         dists <- tibble(
#             dist1 = dist1,
#             dist2 = dist2,
#             dist3 = dist3,
#             dist4 = dist4
#         ) %>%
#             pivot_longer(cols = 1:4, names_to = 'dist', values_to = 'val')
# 
#         core_lex_data <- list()
#         core_lex_data[["score"]] = score
#         core_lex_data[["dist"]] = dists
#         core_lex_data[["scores"]] = c(score_num, score_eff)
# 
#         return(core_lex_data) # make this a list with the data for the histograms too.
# 
#     })
# 
# }
# 
# # Run the application  ###################3
# shinyApp(ui = ui, server = server)
# 
