

#' Summarizes each participant's treatment information.
#' 
#' Combines information from the LTBI Treatment, LTBI Follow-up, and LTBI
#' Closing forms to provide a one-record-per-participant overview of
#' participants' treatment records. 
#' 
#' 
#' 
#' @return
#' This function generates a data.frame summarizing each participant's
#' treatment information into a single record, including offer,
#' acceptance, start date, status, end date, initial regimen, latest regimen,
#' etc. 
#' 
#' 
#' @param cleanlist The list of cleaned TO1 data generated by 
#'   \code{\link{clean_to1}}
#'
#' 
#' @export

summarize_tx <- function(cleanlist) {

    # Initialize so these don't appear as global vars to R CMD check
    StudyID <- MedDispensed <- VisitDate <- RegimenChange <- NA

    # Get offer and acceptance info
    ltbi.base <- cleanlist$ltbi[c("StudyID", 
                                  "OfferTreatment", 
                                  "OfferDate",
                                  "AcceptTreatment", 
                                  "plan", 
                                  "ScriptPickUpDate",
                                  "TreatmentAdmin", 
                                  "TreatmentComplete",
                                  "ReasonNotComplete")]



    # Flag participants who have had enough time to complete tx,
    # using the CDC's guidelines
    ltbi.base$enough_time <- FALSE

    # 9 months INH: 52 weeks
    ltbi.base$enough_time[ltbi.base$AcceptTreatment &
                          ltbi.base$plan %in% "Daily INH" &
                          (Sys.Date() - ltbi.base$OfferDate > (7 * 52))] <- TRUE

    # 4 months RIF: 26 weeks
    ltbi.base$enough_time[ltbi.base$AcceptTreatment &
                          ltbi.base$plan %in% "Daily RIF" &
                          (Sys.Date() - ltbi.base$OfferDate > (7 * 26))] <- TRUE

    # 12 weeks 3HP: 16 weeks
    ltbi.base$enough_time[ltbi.base$AcceptTreatment &
                          ltbi.base$plan %in% "Weekly INH/Rifapentine" &
                          (Sys.Date() - ltbi.base$OfferDate > (7 * 16))] <- TRUE

    # Twice-weekly INH DOPT: ?
    ltbi.base$enough_time[ltbi.base$AcceptTreatment &
                          ltbi.base$plan %in% "Twice-weekly INH" &
                          (Sys.Date() - ltbi.base$OfferDate > (7 * 52))] <- TRUE



    # Aggregate the subsequent treatments
    ltbi.fu <- ddply(cleanlist$ltbifollowup,
                     .variables = "StudyID",
                     .fun = summarise,

        n_tx = length(StudyID),
        n_complete = sum(MedDispensed),
        latest_tx = max(VisitDate, na.rm = TRUE),
        regimen_change = sum(RegimenChange) > 0

    )


    # Merge them
    ltbi.all <- merge(x = ltbi.base,
                      y = ltbi.fu,
                      by = "StudyID",
                      all.x = TRUE
    )


    # Return it
    ltbi.all



}



