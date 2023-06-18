library("lubridate")


no_working_days_db <- read.table(
    "./data/unam-non-working-days.txt",
    header = TRUE,
    sep = "\t",
    stringsAsFactors = FALSE
)
no_working_days_db$day <- ymd(no_working_days_db$day)


get_delivery_day <- function(start_date,
                             no_working_days = no_working_days_db$day) {
    if (!is.Date(start_date)) {
        stop("start_date should be class Date.")
    }
    count_business_days <- 0
    delivery_day <- start_date
    while (count_business_days < 10) {
        delivery_day <- delivery_day - days(1)
        if (
            !(delivery_day %in% no_working_days) &&
                !(wday(delivery_day) %in% c(1, 7))
        ) {
            count_business_days <- count_business_days + 1
        }
    }
    return(delivery_day)
}


get_min_end_day <- function(start_date) {
    if (!is.Date(start_date)) {
        stop("start_date should be class Date.")
    }

    end_date <- start_date + months(6)
    while (is.na(end_date)) {
        start_date <- start_date + days(1)
        end_date <- start_date + months(6)
    }

    return(end_date)
}


get_max_end_day <- function(start_date) {
    if (!is.Date(start_date)) {
        stop("start_date should be class Date.")
    }
    end_date <- start_date + years(1) - days(1)
    while (is.na(end_date)) {
        start_date <- start_date - days(1)
        end_date <- start_date + years(1)
    }
    return(end_date)
}
