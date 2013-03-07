

################################################################################
# Add StudyId to... pretty much everything
################################################################################

# IDs from master
ids <- cleaned$master[ , c("StudyId", "PatientID", "PreEnrollmentID")]

# Pre-Enrollment
cleaned$preenrollment <- merge(x = cleaned$preenrollment,
                               y = ids,
                               by = "PreEnrollmentID",
                               all.x = TRUE)

# TSTs, QFTs, TSPOTs
cleaned$skintest <- merge(x = cleaned$skintest,
                          y = ids,
                          by = "PatientID",
                          all.x = TRUE)

cleaned$qft <- merge(x = cleaned$qft,
                     y = ids,
                     by = "PatientID",
                     all.x = TRUE)

cleaned$tspot <- merge(x = cleaned$tspot,
                       y = ids,
                       by = "PatientID",
                       all.x = TRUE)


# Questionnaire sections
cleaned$medicalhistory <- merge(x = cleaned$medicalhistory,
                      y = ids,
                      by = "PatientID",
                      all.x = TRUE)

cleaned$riskfactor <- merge(x = cleaned$riskfactor,
                              y = ids,
                              by = "PatientID",
                              all.x = TRUE)


# Follow-up stuff
cleaned$ltbi <- merge(x = cleaned$ltbi,
                      y = ids,
                      by = "PatientID",
                      all.x = TRUE)

cleaned$ltbifollowup <- merge(x = cleaned$ltbifollowup,
                              y = ids,
                              by = "PatientID",
                              all.x = TRUE)

cleaned$followupfortb <- merge(x = cleaned$followupfortb,
                               y = ids, 
                               by = "PatientID",
                               all.x = TRUE)



