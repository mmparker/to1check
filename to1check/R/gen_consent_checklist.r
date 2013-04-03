


# This function generates a checklist that can be used to verify signatures
# and dates on consent forms.


gen_consent_checklist <- function(cleanlist,
                                  enroll_start = as.Date("2012-01-01"),
                                  enroll_end = Sys.Date()) {


    require(reshape2)


    # In order to know which documents are required, we need to know the
    # participant's age and whether the interview was interpreted
    ages <- cleanlist$preenrollment[ , c("StudyId", "AgeAtEnrollment")]

    # I'm also using the questionnaire's visit date to exclude participants
    langs <- cleanlist$master[cleanlist$master$VisitDate >= enroll_start &
                             cleanlist$master$VisitDate <= enroll_end, 
                             c("StudyId", "InterpreterNeeded", 
                               "InterpreterLanguage", "InterpreterType",
                               "VisitDate")
    ]


    # Rename a bit for ease of use
    names(ages)[names(ages) %in% "AgeAtEnrollment"] <- "age"
    names(langs)[names(langs) %in% "InterpreterNeeded"] <- "interp.needed"
    names(langs)[names(langs) %in% "InterpreterLanguage"] <- "interp.lang"
    names(langs)[names(langs) %in% "InterpreterType"] <- "interp.type"


    # Merge, using all.x = TRUE to subset to just those who completed
    # their questionnaires (and completed them during the timeframe of interest
    consentfacts <- merge(x = langs,
                          y = ages,
                          by = "StudyId",
                          all.x = TRUE)


    # Assign age-group status
    consentfacts$age_status <- NA

    consentfacts$age_status[consentfacts$age < 15] <- "Pediatric"

    consentfacts$age_status[consentfacts$age > 14 &
                            consentfacts$age < 18] <- "Minor"

    consentfacts$age_status[consentfacts$age > 17] <- "Adult"





    # Set up the checklist variables - long format right now to make it easier
    # to indicate which are required for a particular participant
    checklist <- expand.grid(form = c("Consent", "Assent", "Permission"), 
                             formlang = c("English", "Foreign"), 
                             signer = c("Staff", "Participant", 
                                        "Interpreter", "Parent"),
                             stringsAsFactors = FALSE
    )


    # Merge the checklist onto the participants
    checkpts <- merge(x = consentfacts,
                      y = checklist,
                      all.x = TRUE)


    # Pre-fill based on interpreter info from Sec A and age group
    checkpts$sig.needed <- NA


    # Participants never sign permissions - their parents do
    checkpts$sig.needed[checkpts$form %in% "Permission" &
                        checkpts$signer %in% "Participant"] <- "-"


    # Parents never sign consents or assents
    checkpts$sig.needed[checkpts$form %in% c("Consent", "Assent") &
                        checkpts$signer %in% "Parent"] <- "-"


    # If they spoke English, no flang or interp sigs needed
    checkpts$sig.needed[checkpts$interp.needed %in% 0 &
                        (checkpts$formlang %in% "Foreign" | 
                         checkpts$signer %in% "Interpreter")] <- "-"


    # Consents never require parental signatures
    checkpts$sig.needed[checkpts$form %in% "Consent" &
                        checkpts$signer %in% "Parent"] <- "-"


    # Adults don't need any assents or permissions
    checkpts$sig.needed[checkpts$age_status %in% "Adult" &
                        checkpts$form %in% c("Assent", "Permission")] <- "-"


    # Minors need assents and permissions, but not consents
    checkpts$sig.needed[checkpts$age_status %in% "Minor" &
                        checkpts$form %in% "Consent"] <- "-"


    checkpts$sig.needed[checkpts$age_status %in% "Minor" &
                        checkpts$form %in% "Permission" &
                        checkpts$signer %in% "Participant"] <- "-"


    # Children need only parental permissions
    checkpts$sig.needed[checkpts$age_status %in% "Pediatric" &
                        checkpts$form %in% c("Consent", "Assent")] <- "-"


    checkpts$sig.needed[checkpts$age_status %in% "Pediatric" &
                        checkpts$signer %in% "Participant"] <- "-"


    # Participants who used interpreters don't need signatures on English forms
    checkpts$sig.needed[checkpts$interp.needed %in% 1 &
                        checkpts$formlang %in% "English" &
                        checkpts$signer %in% c("Participant", "Parent")] <- "-"


    # People who used telephone or in-person interpreters don't need 
    # a staff sig on any foreign language form
    checkpts$sig.needed[checkpts$interp.type %in% c(1, 2) &
                        checkpts$formlang %in% "Foreign" &
                        checkpts$signer %in% "Staff"] <- "-"


    # If study staff are translating, no interpreter sig is needed
    checkpts$sig.needed[checkpts$interp.type %in% 3 &
                        checkpts$signer %in% "Interpreter"] <- "-"

    # If study staff are translating, participant sig is needed
    # checkpts$sig.needed[checkpts$interp.type %in% 3 &
    #                     checkpts$signer %in% "Participant"] <- NA







    # What signatures to adults need?
    # count comes from the plyr package
    # count(subset(checkpts, age_status %in% "Adult" & is.na(sig.needed)), 
    #       vars = c("age_status", "interp.type", 
    #                "form", "formlang", "signer", "sig.needed"))



    # What signatures to minors need?
    # count(subset(checkpts, age_status %in% "Minor" & is.na(sig.needed)), 
    #       vars = c("age_status", "interp.type", 
    #                "form", "formlang", "signer", "sig.needed"))




    # What signatures to pediatric participants need?
    # count(subset(checkpts, age_status %in% "Pediatric" & is.na(sig.needed)), 
    #       vars = c("age_status", "interp.type", 
    #                "form", "formlang", "signer", "sig.needed"))



    # Throw the checklist wide into a grid
    checkgrid <- dcast(checkpts,
        StudyId + VisitDate + interp.lang + 
        age_status + form + formlang ~ signer,
        value.var = "sig.needed")


    # Drop any rows with no required signatures
    # I probably should have used a better coding scheme than 
    # "NA means you should sign it!!!"  Sheeeiiit...
    checkgrid.out <- subset(checkgrid, 
                            is.na(Interpreter) |
                            is.na(Parent) |
                            is.na(Participant) |
                            is.na(Staff)
    )


}
