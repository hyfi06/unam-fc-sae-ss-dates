library(testthat)
library(lubridate)

test_that("get_delivery_day returns the correct date", {
    start_date <- ymd("2020-07-31")
    expected_result <- ymd("2020-06-26")
    actual_result <- get_delivery_day(start_date)
    expect_equal(actual_result, expected_result)
})

test_that("get_delivery_day supports the change of year", {
    start_date <- ymd("2020-01-01")
    expected_result <- ymd("2019-11-29")
    actual_result <- get_delivery_day(start_date)
    expect_equal(actual_result, expected_result)
})


test_that("get_min_end_day supports months with different number of days", {
    start_date <- ymd("2020-08-29")
    expected_result <- ymd("2021-03-01")
    actual_result <- get_min_end_day(start_date)
    expect_equal(actual_result, expected_result)

    start_date <- ymd("2020-03-31")
    expected_result <- ymd("2020-10-01")
    actual_result <- get_min_end_day(start_date)
    expect_equal(actual_result, expected_result)
})


test_that("get_max_end_day must return one calendar year minus one day", {
    start_date <- ymd("2020-02-01")
    expected_result <- ymd("2021-01-31")
    actual_result <- get_max_end_day(start_date)
    expect_equal(actual_result, expected_result)
})


test_that("get_max_end_day supports months with different number of days", {
    start_date <- ymd("2020-02-29")
    expected_result <- ymd("2021-02-28")
    actual_result <- get_max_end_day(start_date)
    expect_equal(actual_result, expected_result)
})
