
#' Checks for follow-ups that occurred outside the eligibility period.
#' 
#' This function generates a data.frame of semiannual follow-ups
#' that occurred outside of the appropriate eligibility period.
#' 
#' 
#' @return
#' This function returns a data.frame of semiannual follow-ups
#' that occurred outside of the appropriate eligibility period,
#' including study ID, original visit date, the date the person
#' became eligible for this follow-up period, the end date of the eligibility
#' period, the number of days until the end of the follow-up period, and
#' and indicator of whether the follow-up has been completed.
#' The data.frame is ordered by days left to complete the interview.
#' 
#' 
#' @param cleanlist The list of cleaned TO1 data generated by 
#'   \code{\link{clean_to1}}
#'
#' @seealso \code{\link{calc_fu}} for identifying participants who are
#'     currently eligible for follow-up.
#' 
#' @export

check_fu <- function(cleanlist) {

    require(lubridate)

    # Calculate the eligibility period for each participant
    fu.check <- cleanlist$followupfortb[ , c("StudyID", "EnrollDate",
                                             "VisitInterval", "VisitDate")]


    # TEMP: FIX IN clean_to1
    fu.check$VisitDate <- as.Date(fu.check$VisitDate, format = "%m/%d/%Y")
    fu.check$EnrollDate <- as.Date(fu.check$EnrollDate, format = "%m/%d/%Y")


    # Calculate the period start and end
    fu.check$period.start <- with(fu.check, 
                                  EnrollDate %m+% months(VisitInterval) - 14
    )

    fu.check$period.end <- with(fu.check, 
                                EnrollDate %m+% months(VisitInterval) + 30
    )


    # Flag follow-ups that occurred outside the time period
    fu.check$oob <- with(fu.check,
                         VisitDate < period.start |
                         VisitDate > period.end)


    # Return the out-of-bounds follow-ups
    oob <- fu.check[which(fu.check$oob), ]

    oob[order(oob$EnrollDate), !names(oob) %in% "oob"]


}




