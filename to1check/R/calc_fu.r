
# Report out participants who are eligible for follow-ups


calc_fu <- function(cleanlist) {

    require(lubridate)
    require(plyr)

    # Subset to those with 1+ positive tests who completed enrollment
    # This is a crude approximation
    testpos <- subset(cleanlist$master, 
                      subset = CloseReason %in% "Open",
                      select = c("StudyId", "VisitDate"))

    # Use visit date as the date of record - the protocol allows some 
    # variability, but this ought to be close enough.
    fu.months <- c(6, 12, 18, 24)


    # Iterate over each possible month of FU, then bind them all together
    fu.report <- ldply(fu.months, .fun = function(fu.month) {

        # Load the test-positive
        parts <- testpos

        # Mark the start of their follow-up period
        parts$fu_start <- parts$VisitDate + months(fu.month) - days(14)

        # Mark the end of their follow-up period
        parts$fu_end <- parts$VisitDate + months(fu.month) + days(30)

        # If today is inside those dates, they're eligible for FU
        parts$eligible <- Sys.Date() >= parts$fu_start &
                            Sys.Date() <= parts$fu_end

        # Add an indicator for which FU this is
        parts$which_fu <- paste(fu.month, "-month FU", sep = "")
                       
        # Return only those who are eligible
        subset(parts, eligible %in% TRUE)

    })


    # Return
    fu.report

}
