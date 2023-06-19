library("lubridate")

source("R/main.R")

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 1) {
    stop("You must provide the start date in yyyymmdd format.")
}

start_date <- ymd(args[1])
min_end_date <- get_min_end_day(start_date)
max_end_date <- get_max_end_day(start_date)
delivery_date <- get_delivery_day(start_date)

print(paste("Deliver documents:", delivery_date))
print(paste("Start:", start_date))
print(paste("Min end:", min_end_date))
print(paste("Max end:", max_end_date))
