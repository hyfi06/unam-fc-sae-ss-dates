library("lubridate")

source("R/generate_dates.R")

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 3) {
    stop("You must provide the start and end date in
    yyyymmdd format and output file name. ")
}

start_date <- ymd(args[1])
end_date <- ymd(args[2])

days <- seq(start_date, end_date, by = "1 day")

dates <- generate_dates(days)

write.table(dates, file = args[3], row.names = FALSE, sep = "\t")
print(paste("Output written to", args[3]))

print(dates)
