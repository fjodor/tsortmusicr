# Tests relating to https://tsort.info

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


# Tests relating to https://chart2000.com

test_that("ch2k_get_version() is a character vector length one", {
  expect_vector(ch2k_get_version(), ptype = "character", size = 1)
})

test_that("ch2k_read_songs() returns data", {
  expect_true(is.data.frame(ch2k_read_songs()))
})

test_that("ch2k_read_albums() returns data", {
  expect_true(is.data.frame(ch2k_read_albums()))
})
