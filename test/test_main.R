library(testthat)
library(lubridate)

test_that("get_delivery_day returns the correct date", {
    start_date <- ymd("2020-07-31")
    expected_result <- ymd("2020-06-26")
    actual_result <- get_delivery_day(start_date)
    expect_equal(actual_result, expected_result)
})
