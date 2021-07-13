footer_div <- 
  tagList(
    hidden(
      column(12, align = "center", style = "background-color: white; padding-bottom: 15px;", id = "footer_buttons",
               actionButton("prev", label = "Previous", icon = icon('arrow-left'), width = "20%"),
               actionButton("nxt", label = "Next",  icon = icon('arrow-right'), width = "20%")
             )
    ),
      column(10, offset = 1, align = "center", 
             p(style = "margin-top:.8rem; margin-bottom:.8rem;",
               actionButton(
                 inputId='source',
                 label="Source Code",
                 icon = icon("github"),
                 onclick ="window.open('https://github.com/rbcavanaugh/mssg', '_blank')",
                 style = "background:transparent; border:none;"
                 
               ),
               actionButton(
                 inputId = "info",
                 label = "Scoring Info",
                 icon = icon("info-circle"),
                 style = "background:transparent; border:none;"
               ),
               actionButton(
                 inputId = "about",
                 label = "About Us",
                 icon = icon("user-friends"),
                 style = "background:transparent; border:none;"
               )
            )
      )
    )
