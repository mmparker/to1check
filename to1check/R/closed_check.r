
# This function that individuals who had a negative TST, QFT, and TSPOT
# were closed, and that closed individuals have sufficient documentation of
# why they're closed (which I think is just trip-neg and completion of two
# of FU


closed_check <- function(cleanlist, outdir) {

    # Get study IDs and status
    parts <- subset(cleanlist$master, select = c("StudyId", "CloseReason"))


    ########################################################################### 
    # Identify the triple-negatives
    ########################################################################### 

    # Participants can have multiple tests, so I'll need to expand this
    # to accommodate that...
    parts$tst_neg <- parts$StudyId %in% 
        cleanlist$skintest$StudyId[cleanlist$skintest$result %in% "Negative"]

    parts$qft_neg <- parts$StudyId %in% 
        cleanlist$qft$StudyId[cleanlist$qft$result %in% 
                              c("Negative", "Indeterminate")]

    parts$tspot_neg <- parts$StudyId %in% 
        cleanlist$tspot$StudyId[cleanlist$tspot$result %in% 
                                c("Negative", "Borderline", "Invalid")]

    parts$trip_neg <- with(parts, tst_neg & qft_neg & tspot_neg)



    ########################################################################### 
    # Return any triple-negative participants who aren't closed
    ########################################################################### 

    subset(parts, trip_neg %in% TRUE & CloseReason %in% "Open")


}
