library("lubridate")

source("R/main.R")

generate_dates <- function(start_dates) {
    if (!is.Date(start_dates)) {
        stop("start_date should be a vector of class Date.")
    }
    min_end_dates <- as_date(sapply(start_dates, get_min_end_day))
    max_end_dates <- as_date(sapply(start_dates, get_max_end_day))
    delivery_dates <- as_date(sapply(start_dates, get_delivery_day))
    return(
        data.frame(
            delivery = delivery_dates,
            start = start_dates,
            min_end = min_end_dates,
            max_end = max_end_dates
        )
    )
}


