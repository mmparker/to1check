
# This function compiles each participant's current, definitive test results
# into a single record with a field for each test.

compile_results <- function(cleanlist) {

    require(plyr)
    require(reshape2)

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
    tsts.sorted <- arrange(tsts, StudyId, desc(dt_placed))
    tsts.latest <- tsts.sorted[!duplicated(tsts.sorted$StudyId), ]

    qfts.sorted <- arrange(qfts, StudyId, desc(dt_placed))
    qfts.latest <- qfts.sorted[!duplicated(qfts.sorted$StudyId), ]

    tspots.sorted <- arrange(tspots, StudyId, desc(dt_placed))
    tspots.latest <- tspots.sorted[!duplicated(tspots.sorted$StudyId), ]


    # Combine into one dataset
    # Add a test indicator
    tsts.latest$test <- "tst"
    qfts.latest$test <- "qft"
    tspots.latest$test <- "tspot"

    # Combine
    tests <- rbind(tsts.latest[ , c("StudyId", "result", "test")],
                   qfts.latest[ , c("StudyId", "result", "test")],
                   tspots.latest[ , c("StudyId", "result", "test")]
    )


    # Cast wide
    tests.wide <- dcast(tests, StudyId ~ test, value.var = "result")


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
                   tspot %in% "Positive"] <- "Isolated TST-"
    )

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) &
                  tst %in% "Positive" &
                  qft %in% "Positive" &
                  tspot %in% c("Negative", "Borderline")] <- "Isolated TSPOT-"
    )

    tests.wide <- within(tests.wide,
        result_class[is.na(result_class) &
                   tst %in% "Positive" &
                   qft %in% "Negative" &
                   tspot %in% "Positive"] <- "Isolated QFT-"
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



    # Return
    tests.wide

}
