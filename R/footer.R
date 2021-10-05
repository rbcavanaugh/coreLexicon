
#' footer div
#'
#' @export
footer_div <- function(){
  tagList(
      column(10, offset = 1, align = "center", 
             p(style = "margin-top:.8rem; margin-bottom:.8rem;",
               actionButton(
                 inputId='source',
                 label="Source Code",
                 icon = icon("github"),
                 onclick ="window.open('https://github.com/aphasia-apps/corelexicon', '_blank')",
                 style = "background:transparent; border:none;"
                 
               ),
               actionButton(
                 inputId = "faq",
                 label = "FAQ",
                 icon = icon("info-circle"),
                 style = "background:transparent; border:none;"
               ),
               actionButton(
                 inputId = "bio",
                 label = "About Us",
                 icon = icon("user-friends"),
                 style = "background:transparent; border:none;"
               ),
               actionButton(
                 inputId = "references",
                 label = "References",
                 icon = icon("book"),
                 style = "background:transparent; border:none;"
               )
            )
      )
    )
}