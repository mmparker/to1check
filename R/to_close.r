

#' Check that triple-negative individuals are closed to follow-up.
#' 
#' This function checks that individuals who had negative TST, QFT, and TSPOT
#' were closed.
#' 
#' @return
#' This function returns a data.frame of participants who are negative
#' on all three tests but have not yet been closed. The data.frame includes
#' study ID, participant status, visit date, and test result indicators.
#' 
#' @param cleanlist The list of cleaned TO1 data generated by 
#'   \code{\link{clean_to1}}
#' 
#' @seealso \code{\link{closed_check}} for participants who were closed
#'   incorrectly.
#' 
#' @export


to_close <- function(cleanlist) {

    # Get study IDs and status
    parts <- cleanlist$master[ , c("StudyID", "CloseReason", "EnrollDate")]



    ########################################################################### 
    # Identify the triple-negatives
    ########################################################################### 

    # They have to be TST-
    parts$tst_neg <- parts$StudyID %in% 
        cleanlist$skintest$StudyID[cleanlist$skintest$result %in% "Negative"]

    # And not TST+ (have to use this approach in case people have multiple tests
    parts$tst_pos <- parts$StudyID %in% 
        cleanlist$skintest$StudyID[cleanlist$skintest$result %in% "Positive"]


    # Same with the IGRAs
    parts$qft_neg <- parts$StudyID %in% 
        cleanlist$qft$StudyID[cleanlist$qft$result %in% 
                              c("Negative", "Indeterminate")]

    parts$qft_pos <- parts$StudyID %in% 
        cleanlist$qft$StudyID[cleanlist$qft$result %in% "Positive"]



    parts$tspot_neg <- parts$StudyID %in% 
        cleanlist$tspot$StudyID[cleanlist$tspot$result %in% 
                                c("Negative", "Borderline", "Invalid")]

    parts$tspot_pos <- parts$StudyID %in% 
        cleanlist$tspot$StudyID[cleanlist$tspot$result %in% "Positive"]



    # Identify the triple-negatives (at least a negative on everything,
    # no positives)
    parts$trip_neg <- with(parts,
                           (tst_neg & qft_neg & tspot_neg) &
                           (!tst_pos & !qft_pos & !tspot_pos)
    )
                   



    ########################################################################### 
    # Return any triple-negative participants who aren't closed
    ########################################################################### 

    parts[parts$trip_neg %in% TRUE & parts$CloseReason %in% "Open", 
          c("StudyID", "CloseReason", "EnrollDate", 
            "tst_neg", "qft_neg", "tspot_neg", "trip_neg")]


}
