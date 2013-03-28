
mix <- function(recoded) {

    # Keep the originals for comparison
    mixed <- recoded



    ############################################################################
    # Add StudyId to... pretty much everything
    ############################################################################
    
    # IDs from master
    ids <- mixed$master[ , c("StudyId", "PatientID", "PreEnrollmentID")]
    
    # Pre-Enrollment
    mixed$preenrollment <- merge(x = mixed$preenrollment,
                                   y = ids,
                                   by = "PreEnrollmentID",
                                   all.x = TRUE)
    
    # TSTs, QFTs, TSPOTs
    mixed$skintest <- merge(x = mixed$skintest,
                              y = ids,
                              by = "PatientID",
                              all.x = TRUE)
    
    mixed$qft <- merge(x = mixed$qft,
                         y = ids,
                         by = "PatientID",
                         all.x = TRUE)
    
    mixed$tspot <- merge(x = mixed$tspot,
                           y = ids,
                           by = "PatientID",
                           all.x = TRUE)
    
    
    # Questionnaire sections
    mixed$medicalhistory <- merge(x = mixed$medicalhistory,
                          y = ids,
                          by = "PatientID",
                          all.x = TRUE)
    
    mixed$riskfactor <- merge(x = mixed$riskfactor,
                                  y = ids,
                                  by = "PatientID",
                                  all.x = TRUE)
    
    
    # Follow-up stuff
    mixed$ltbi <- merge(x = mixed$ltbi,
                          y = ids,
                          by = "PatientID",
                          all.x = TRUE)
    
    mixed$ltbifollowup <- merge(x = mixed$ltbifollowup,
                                  y = ids,
                                  by = "PatientID",
                                  all.x = TRUE)
    
    mixed$followupfortb <- merge(x = mixed$followupfortb,
                                   y = ids, 
                                   by = "PatientID",
                                   all.x = TRUE)
    
    
    mixed


}
