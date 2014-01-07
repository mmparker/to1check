

#' Renames variables in the raw DMS extract to more manageable strings.
#' 
#' This function renames the raw DMS extracts to be more consistent and
#' easier to type.
#' 
#' This function is only meant to be used internally by \code{\link{clean_to1}}.
#' 
#' @param originals The list of data frames generated interally by 
#' \code{\link{clean_to1}}


# Rename variables to something actually useful

rename <- function(originals) {

    # Keep the originals for comparison
    cleaned <- originals



# For whatever reason, StudyID on master has a lower-case last d. Fix it.
names(cleaned$master)[names(cleaned$master) %in% "StudyId"] <- "StudyID"



################################################################################
# Clarify the various VisitDate variables
################################################################################

# I think a good approach is to preserve VisitDate for the event in the table
# so on followupfortb, VisitDate is the date of the follow-up; on skintest,
# it's the date of the TST, and so on. VisitDate.1 and its ilk should be
# renamed to "EnrollDate".

names(cleaned$skintest)[names(cleaned$skintest) 
                        %in% "VisitDate"] <- "EnrollDate"

names(cleaned$qft)[names(cleaned$qft) 
                   %in% "VisitDate"] <- "EnrollDate"

names(cleaned$tspot)[names(cleaned$tspot) 
                     %in% "VisitDate"] <- "EnrollDate"

names(cleaned$ltbi)[names(cleaned$ltbi) 
                    %in% "VisitDate"] <- "EnrollDate"

names(cleaned$ltbifollowup)[names(cleaned$ltbifollowup) 
                            %in% "VisitDate.1"] <- "EnrollDate"

names(cleaned$followupfortb)[names(cleaned$followupfortb) 
                             %in% "VisitDate.1"] <- "EnrollDate"

# One exception: I'm going to call it EnrollDate on master, too,
# since I use that so extensively. It'll get confusing as hell if I don't.
names(cleaned$master)[names(cleaned$master) %in% "VisitDate"] <- "EnrollDate"


################################################################################
# Rename TST variables
################################################################################

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TstPlacedDateTime"] <- "dt_placed"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TstReadDateTime"] <- "dt_read"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TstResult"] <- "indur_mm"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TstInterpretation"] <- "result"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "SubmitDateTime"] <- "date_submitted"


# Renaming check
data.frame(old = names(originals$skintest),
           new = names(cleaned$skintest))




################################################################################
# Rename QFT variables
################################################################################

names(cleaned$qft)[names(originals$qft) 
                          %in% "BloodDrawDateTime"] <- "dt_placed"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QftResult"] <- "result"

names(cleaned$qft)[names(originals$qft) 
                          %in% "NilControl"] <- "nil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "TbAntigen"] <- "tb"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_Mit"] <- "mito"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_TBNil"] <- "tbnil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_MitNil"] <- "mitnil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QftResult2"] <- "rerun_result"

names(cleaned$qft)[names(originals$qft) 
                          %in% "NilControl2"] <- "rerun_nil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "TbAntigen2"] <- "rerun_tb"

names(cleaned$qft)[names(originals$qft) 
                          %in% "Mitogen2"] <- "rerun_mito"

names(cleaned$qft)[names(originals$qft) 
                          %in% "TbAntigenNil2"] <- "rerun_tbnil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "MitogenNil2"] <- "rerun_mitnil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "SubmitDateTime"] <- "date_submitted"


# Renaming check
data.frame(old = names(originals$qft),
           new = names(cleaned$qft))





################################################################################
# Rename TSPOT variables
################################################################################

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "CollectDateTime"] <- "dt_placed"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "TspotResult"] <- "result"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "NilControl"] <- "nil"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "PosControl"] <- "mito"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "PanelA"] <- "panel_a"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "PanelB"] <- "panel_b"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "TSPOT_Report_Date"] <- "report_date"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "SubmitDateTime"] <- "date_submitted"




################################################################################
# Rename TSPOT variables
################################################################################

# Mislabeled drug variables
names(cleaned$ltbi)[names(cleaned$ltbi) %in% "LT_4a_Freq"] <- "IsoniazidFreq"

names(cleaned$ltbi)[names(cleaned$ltbi) %in% "LT_4b_Freq_Other"] <- 
    "RifampinFreqSpecify"





# Renaming check
# data.frame(old = names(originals$tspot),
#           new = names(cleaned$tspot))


cleaned

}
