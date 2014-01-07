
#' Compile participants' test results into a single data frame.
#' 
#' This function generates a single record for all enrolled participants,
#' with variables indicating their most recent TST, QFT, and TSPOT results.
#' 
#' In the event of multiple test results (e.g., rerun QFTs or repeated 
#' TSPOTs), the most recent result is used.
#' 
#' @return
#' This function returns a data.frame with a record for each participant,
#' which includes their study ID, visit date, and TST, QFT, and TSPOT results.
#' 
#' @param cleanlist The list of cleaned TO1 data generated by 
#'   \code{\link{clean_to1}}
#' 
#' @export

compile_results <- function(cleanlist) {

    # Ensure that these variables are defined within the function's environment
    tst <- qft <- tspot <- NULL


    tsts <- cleanlist$skintest
    qfts <- cleanlist$qft
    tspots <- cleanlist$tspot

    # Input checks


    # For QFTs, a rerun result always supercedes the initial result
    # Rename "result" to "initial_result" to avoid confusion
    names(qfts)[names(qfts) %in% "result"] <- "initial_result"
    qfts$result <- qfts$rerun_result

    # If rerun_result is NA, then result.final = result
    qfts$result[is.na(qfts$result)] <- 
        qfts$initial_result[is.na(qfts$result)]


    # Select only the most recent test for each individual
    tsts.sorted <- tsts[order(tsts$StudyID, tsts$dt_placed, 
                              decreasing = TRUE), ]

    tsts.latest <- tsts.sorted[!duplicated(tsts.sorted$StudyID), ]


    qfts.sorted <- qfts[order(qfts$StudyID, qfts$dt_placed, 
                              decreasing = TRUE), ]

    qfts.latest <- qfts.sorted[!duplicated(qfts.sorted$StudyID), ]


    tspots.sorted <- tspots[order(tspots$StudyID, tspots$dt_placed, 
                                  decreasing = TRUE), ]

    tspots.latest <- tspots.sorted[!duplicated(tspots.sorted$StudyID), ]


    # Combine into one dataset
    # Add a test indicator
    tsts.latest$test <- "tst"
    qfts.latest$test <- "qft"
    tspots.latest$test <- "tspot"

    # Combine
    tests <- rbind(tsts.latest[ , c("StudyID", "result", "test")],
                   qfts.latest[ , c("StudyID", "result", "test")],
                   tspots.latest[ , c("StudyID", "result", "test")]
    )


    # Cast wide
    tests.wide <- dcast(tests, StudyID ~ test, value.var = "result")


    # Add an indicator for any positive test
    tests.wide$anypos <- with(tests.wide,
                              tst %in% "Positive" |
                              qft %in% "Positive" |
                              tspot %in% "Positive")
    

    # Add a general classification
    tests.wide$result_class <- NA

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) &
                   tst %in% "Negative" &
                   qft %in% "Negative" &
                   tspot %in% c("Negative", "Borderline")] <- "Triple Negative"
    )

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) &
                   tst %in% "Positive" &
                   qft %in% "Negative" &
                   tspot %in% c("Negative", "Borderline")] <- "Isolated TST+"
    )

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) &
                   tst %in% "Negative" &
                   qft %in% "Positive" &
                   tspot %in% c("Negative", "Borderline")] <- "Isolated QFT+"
    )

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) &
                   tst %in% "Negative" &
                   qft %in% "Negative" &
                   tspot %in% "Positive"] <- "Isolated TSPOT+"
    )

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) &
                   tst %in% "Negative" &
                   qft %in% "Positive" &
                   tspot %in% "Positive"] <- "Dual Pos, QFT and TSPOT"
    )

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) &
                  tst %in% "Positive" &
                  qft %in% "Positive" &
                  tspot %in% c("Negative", 
                               "Borderline")] <- "Dual Pos, TST and QFT"
    )

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) &
                   tst %in% "Positive" &
                   qft %in% "Negative" &
                   tspot %in% "Positive"] <- "Dual Pos, TST and TSPOT"
    )

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) &
                   tst %in% "Positive" &
                   qft %in% "Positive" &
                   tspot %in% "Positive"] <- "Triple Positive"
    )

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) & (
                   tst %in% NA |
                   qft %in% c(NA, "Indeterminate") |
                   tspot %in% c(NA, "Test Not Performed",
                                "Indeterminate", "Failed"))] <- "Inconclusive"
    )



    # Add visit dates
    tests.dated <- merge(x = tests.wide,
                         y = cleanlist$master[ , c("StudyID", "EnrollDate")],
                         by = "StudyID",
                         all.x = TRUE
    )

    # Return
    tests.dated

}
