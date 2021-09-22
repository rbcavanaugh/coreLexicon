#' results text
#'
#' @param dat data
#' @param measure which measure
#' @param time input$time
#'
#' @return text output
#' @export
results_text <- function(dat, measure, time){
  
  if(measure == "acc"){
  txt <- paste0("There were ", dat[["scores"]][1], " core words produced. This score is in the ",
                dat[["score"]][1,4], " percentile for individuals with aphasia and ",
                dat[["score"]][1,3], " percentile for individuals without stroke or aphasia."
  )
  } else {
  
    if(time >0){
      
      txt <- paste0("There were ", round(dat[["scores"]][2],1), " core words per minute produced. This score is in the ",
                    dat[["score"]][2,4], " percentile for individuals with aphasia and ",
                    dat[["score"]][2,3], " percentile for individuals without stroke or aphasia."
      )
    } else {
      txt <- "A duration was not entered; unable to calculate efficiency scores."
    }
  
  }
  
  return(txt)
  
}