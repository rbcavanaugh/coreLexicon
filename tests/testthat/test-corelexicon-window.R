test_that("core-lex-window", {
  
  #########################################################
  # Get app to results page
  #########################################################
  transcript_test = "the young boy appears to be practicing soccer because he is kicking a soccer ball which I assume accidentally goes into a window and breaks the window. there's a gentleman sitting in the living room next to the window. and the ball comes through the broken window and knocks over the lamp. and the man picks up the soccer ball and looks out the window to see if he can tell where the soccer ball came from."
  app <- AppDriver$new(app_dir = here::here(), height = 800, width = 1200, seed = 1)
  
  #app$set_inputs(test = 59)
  app$click("glide_next1")
  
  app$set_inputs(name = "bob")
  app$set_inputs(time = 200)
  app$set_inputs(notes = "This is a note")
  
  app$click("glide_next2")
  
  app$set_inputs(transcr = transcript_test)
  
  app$click("start")

  app$click("go_to_results")
  
  val = app$get_values()
  
  #########################################################
  # TESTS
  #########################################################
  
  # are we on the results page?
  testthat::expect_equal(val$export$current_page, "results")
  # are responses tracked accurately? 
  #testthat::expect_equal(length(app$expect_download("download_results-results_download")), 33)
  
  testthat::expect_equal(sum(val$export$data$produced), 21)
  testthat::expect_equal(val$export$transcript$transcript, transcript_test)
  
  # Make sure file downloaded is greater than 10kb in size
  testthat::expect_gt(
    fs::file_info(app$get_download("downloadReport"))$size,
    fs::fs_bytes(10 * 1000) 
  )
})
