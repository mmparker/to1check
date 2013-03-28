# This script:
# - converts character datetimes to POSIXct
# - creates strictly numeric QFT and TSPOT result variables

convert <- function(renamed) {

    # Keep the originals for comparison
    converted <- renamed


    # Convert dates to Dates
    converted$preenrollment$enroll_date <- 
        as.Date(converted$preenrollment$enroll_date, format = "%d%b%Y")
    
    converted$master$dob <- as.Date(converted$master$dob, format = "%d%b%Y")

    converted$master$enroll_date <- as.Date(converted$master$enroll_date, format = "%d%b%Y")
    
    
    # Convert datetimes to POSIXct
    converted$skintest$dt_placed <- as.POSIXct(converted$skintest$dt_placed,
                                               format = "%d%B%Y:%H:%M:%S.000")
    
    converted$skintest$dt_read <- as.POSIXct(converted$skintest$dt_read, 
                                             format = "%d%B%Y:%H:%M:%S.000")
    
    converted$qft$dt_placed <- as.POSIXct(converted$qft$dt_placed,
                                          format = "%d%B%Y:%H:%M:%S.000")
    
    converted$tspot$dt_placed <- as.POSIXct(converted$tspot$dt_placed,
                                            format = "%d%B%Y:%H:%M:%S.000")
    
    
    converted


}
