
# This script:
# - converts character datetimes to POSIXct
# - creates strictly numeric QFT and TSPOT result variables

convert <- function(renamed) {

    # Keep the originals for comparison
    converted <- renamed


    # Convert dates to Dates
    converted$preenrollment$VisitDate <- 
        as.Date(converted$preenrollment$VisitDate, format = "%m/%d/%Y")

    converted$master$BirthDate <- as.Date(converted$master$BirthDate, 
                                          format = "%m/%d/%Y")

    converted$master$VisitDate <- as.Date(converted$master$VisitDate, 
                                          format = "%m/%d/%Y")


    # Convert datetimes to POSIXct
    converted$skintest$dt_placed <- 
        as.POSIXct(converted$skintest$dt_placed, format = "%m/%d/%Y %H:%M")

    converted$skintest$dt_read <- 
        as.POSIXct(converted$skintest$dt_read, format = "%m/%d/%Y %H:%M")

    converted$qft$dt_placed <- 
        as.POSIXct(converted$qft$dt_placed, format = "%m/%d/%Y %H:%M")

    converted$tspot$dt_placed <- 
        as.POSIXct(converted$tspot$dt_placed, format = "%m/%d/%Y %H:%M")


    converted


}
