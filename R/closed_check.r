
#' Check that participants were closed correctly.
#' 
#' This function checks that participants were closed correctly (currently,
#' just that those who are closed as triple-negatives actually were).
#' 
#' @return
#' This function returns a data.frame of participants whose records aren't
#' consistent with their closing reason. The data.frame includes
#' study ID, participant status, visit date, and test result indicators.
#' 
#' @param cleanlist The list of cleaned TO1 data generated by 
#'   \code{\link{clean_to1}}
#' 
#' @seealso \code{\link{to_close}} for participants who should be closed.
#' 
#' @export


closed_check <- function(cleanlist) {

    # Get study IDs and status
    parts <- cleanlist$master[ , c("StudyId", "CloseReason", "EnrollDate")]


    # Get the most recent test of each type
    # Sort by ID and date, then take the first test for each ID
    sorted_tsts <- with(cleanlist, 
                       skintest[order(skintest$StudyId, 
                                      skintest$dt_placed, 
                                      decreasing = TRUE), ]
    )

    latest_tsts <- sorted_tsts[!duplicated(sorted_tsts[ , "StudyId"]), ]

    sorted_qfts <- with(cleanlist, 
                        qft[order(qft$StudyId, 
                                  qft$dt_placed, 
                                  decreasing = TRUE), ]
    )

    latest_qfts <- sorted_qfts[!duplicated(sorted_qfts[ , "StudyId"]), ]

    sorted_tspots <- with(cleanlist, 
                          tspot[order(tspot$StudyId, 
                                      tspot$dt_placed, 
                                      decreasing = TRUE), ]
    )

    latest_tspots <- sorted_tspots[!duplicated(sorted_tspots[ , "StudyId"]), ]


    ########################################################################### 
    # Identify the triple-negatives
    ########################################################################### 

    parts$tst_neg <- parts$StudyId %in% 
        latest_tsts$StudyId[latest_tsts$result %in% "Negative"]

    parts$qft_neg <- parts$StudyId %in% 
        latest_qfts$StudyId[latest_qfts$result %in% 
                              c("Negative", "Indeterminate")]

    parts$tspot_neg <- parts$StudyId %in% 
        latest_tspots$StudyId[latest_tspots$result %in% 
                                c("Negative", "Borderline", "Invalid")]

    parts$trip_neg <- with(parts, tst_neg & qft_neg & tspot_neg)


    # Identify those who were closed as triple-negative but weren't
    parts$not_trip_neg <- with(parts, 
                               CloseReason %in% 'Triple Negative' &
                               trip_neg %in% FALSE)

    ########################################################################### 
    # Identify individuals with missing results
    ########################################################################### 

    # Check for either an existing record with no result, or absence of a TST
    # record altogether
    parts$tst_missing <- parts$StudyId %in% 
        c(latest_tsts$StudyId[is.na(latest_tsts$result)],
          parts$StudyId[!parts$StudyId %in% latest_tsts$StudyId])

    parts$qft_missing <- parts$StudyId %in% 
        c(latest_qfts$StudyId[is.na(latest_qfts$result)],
          parts$StudyId[!parts$StudyId %in% latest_qfts$StudyId])


    parts$tspot_missing <- parts$StudyId %in% 
        c(latest_tspots$StudyId[is.na(latest_tspots$result)],
          latest_tspots$StudyId[latest_tspots$result %in% "Test Not Performed"],
          parts$StudyId[!parts$StudyId %in% latest_tspots$StudyId])

    parts$any_missing <- with(parts, tst_missing | qft_missing | tspot_missing)


    # Identify those who were closed without all results in
    parts$missing_results <- with(parts, 
                                  CloseReason %in% 'Triple Negative' &
                                  any_missing %in% TRUE)



    ########################################################################### 
    # Provide a nicely-labeled indicator of reason for incorrect closing
    ########################################################################### 

    parts$close_problem <- NA

    parts$close_problem[parts$not_trip_neg] <- "Not Triple-Negative"

    parts$close_problem[parts$missing_results] <- "Missing Test Result"


    ########################################################################### 
    # Return any participants closed for the incorrect reason
    ########################################################################### 

    parts[!is.na(parts$close_problem), 
          c("StudyId", "EnrollDate", "CloseReason", "close_problem")]


}
