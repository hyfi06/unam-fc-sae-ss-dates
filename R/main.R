library("lubridate")


no_working_days_db <- read.table(
    "./data/unam-non-working-days.txt",
    header = TRUE,
    sep = "\t",
    stringsAsFactors = FALSE
)
no_working_days_db$day <- ymd(no_working_days_db$day)


get_delivery_day <- function(
    start_date,
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

get_suggested_min_end_day <- function(
    start_date,
    no_working_days = no_working_days_db$day[no_working_days_db$holiday == 1]) {
    if (!is.Date(start_date)) {
        stop("start_date should be class Date.")
    }

    end_date <- start_date + months(6)
    while (is.na(end_date)) {
        start_date <- start_date + days(1)
        end_date <- start_date + months(6)
    }

    while (end_date %in% no_working_days ||
        wday(end_date) %in% c(1, 7)
    ) {
        end_date <- end_date + days(1)
    }

    return(end_date)
}

get_min_end_unam_day <- function(
    start_date,
    no_working_days = no_working_days_db$day) {
    if (!is.Date(start_date)) {
        stop("start_date should be class Date.")
    }
    no_working_days[no_working_days]
    end_date <- start_date + months(6)
    while (is.na(end_date)) {
        start_date <- start_date + days(1)
        end_date <- start_date + months(6)
    }
    count_days <- length(
        no_working_days[no_working_days < end_date & no_working_days > start_date]
    )
    while (count_days > 0) {
        end_date <- end_date + days(1)
        if (
            !(end_date %in% no_working_days) &&
                !(wday(end_date) %in% c(1, 7))
        ) {
            count_days <- count_days - 1
        }
    }
    return(end_date)
}

get_max_end_unam_day <- function(
    start_date,
    no_working_days = no_working_days_db$day) {
    if (!is.Date(start_date)) {
        stop("start_date should be class Date.")
    }
    end_date <- start_date + years(1) - days(1)
    while (is.na(end_date)) {
        start_date <- start_date - days(1)
        end_date <- start_date + years(1)
        if (end_date %in% no_working_days ||
            wday(end_date) %in% c(1, 7)) {
            end_date <- NA
        }
    }
    return(end_date)
}
