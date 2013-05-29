
#' Converts raw DMS extract variables to appropriate data types.
#' 
#' This function converts variables from the DMS extracts into appropriate
#' R data types; currently, that means converting 
#' character dates and datetimes to Dates and POSIXct.
#' 
#' Currently, this function just converts character dates and datetimes to
#' Date and POSIXct where appropriate. 
#' This function expects the variable names generated by 
#' the \code{\link{rename}} function, and is only meant to be used internally
#' by \code{\link{clean_to1}}
#' 
#' @param renamed The output of the \code{\link{rename}} function.

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


    
    # Convert all LocalIDs to character 
    converted$master$LocalID1 <- as.character(converted$master$LocalID1)
    converted$master$LocalID2 <- as.character(converted$master$LocalID2)
    converted$master$LocalID3 <- as.character(converted$master$LocalID3)

    # Convert blanks to NA
    converted$master$LocalID1[converted$master$LocalID %in% ""] <- NA
    converted$master$LocalID1[converted$master$LocalID %in% ""] <- NA
    converted$master$LocalID1[converted$master$LocalID %in% ""] <- NA


    converted

}
