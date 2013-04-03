

# This function checks that the ages given on pre-enrollments match those
# calculated from birthdates and visit dates


age_check <- function(cleanlist) {

    require(lubridate)

    # Get the ages
    ages <- merge(x = subset(cleanlist$preenrollment,
                             select = c("StudyId", "VisitDate", 
                                        "AgeAtEnrollment")),
                  y = subset(cleanlist$master,
                             select = c("StudyId", "BirthDate")),
                  by = "StudyId",
                  all.x = TRUE)


    # Rename AgeAtEnrollment to be clear about its source
    names(ages)[names(ages) %in% "AgeAtEnrollment"] <- "preenroll_age"


    ########################################################################### 
    # Compare pre-enrollment and Enrollment Date - DOB ages
    ########################################################################### 

    # Calculate age at enrollment
    ages$calc_age <- floor(new_interval(ages$BirthDate, ages$VisitDate) / 
                           duration(num = 1, units = "years"))

    ages$age_diff <- abs(ages$calc_age - ages$preenroll_age)


    # Identify participants with different pre-enroll and questionnaire ages
    subset(ages[order(ages$age_diff, decreasing = TRUE), ], 
           subset = preenroll_age != calc_age,
           select = c("StudyId", "BirthDate", "VisitDate",
                      "preenroll_age", "calc_age", "age_diff")
    )



}
