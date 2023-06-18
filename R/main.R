library("lubridate")

no_working_days_db <- read.table(
    "./data/unam-non-working-days.txt",
    header = TRUE,
    sep = "\t",
    stringsAsFactors = FALSE
)
no_working_days_db$day <- ymd(no_working_days_db$day)

class(no_working_days_db$day)

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

get_delivery_day(ymd("20220101"))

get_end_date <- function(start_date) {
    if (!is.Date(start_date)) {
        stop("start_date should be class Date.")
    }

    end_date <- start_date + months(6)
    if (is.na(end_date)) {
        
    }

    return(end_date)
}

get_end_date(ymd("2020-08-29"))
get_end_date(ymd("2020-08-30"))
