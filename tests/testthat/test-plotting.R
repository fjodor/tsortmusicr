test_that("tsm_ggbox() returns a ggplot2 object", {
  expect_true("ggplot" %in% class(tsm_ggbox(albums)))
})

test_that("tsm_ggbox_plotly() returns a plotly object", {
  expect_true("plotly" %in% class(tsm_ggbox_plotly(tsm_ggbox(albums))))
})
