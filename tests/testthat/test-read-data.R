test_that("tsm_get_version() is a character vector length one", {
  expect_vector(tsm_get_version(), ptype = "character", size = 1)
})

test_that("tsm_read_chart() returns data", {
  expect_true(is.data.frame(tsm_read_chart()))
})

test_that("tsm_read_songs() returns data", {
  expect_true(is.data.frame(tsm_read_songs()))
})

test_that("tsm_read_albums() returns data", {
  expect_true(is.data.frame(tsm_read_albums()))
})
