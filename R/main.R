no_working_days_db <- read.table(
    "./data/unam-non-working-days.txt",
    header = TRUE,
    sep = "\t",
    stringsAsFactors = FALSE
)

ss_dates_by_initial <- function(initial, no_working_days = no_working_days_db) {
    
}
