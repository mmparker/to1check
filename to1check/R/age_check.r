

# This function checks that:
# - The pre-enrollment age and the Enrollment Date - DOB are the same
# - That pediatric patients filled out pediatric packets


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



    ########################################################################### 
    # Compare pre-enrollment and Enrollment Date - DOB ages
    ########################################################################### 

    # Calculate age at enrollment
    ages$calc_age <- floor(new_interval(ages$BirthDate, ages$VisitDate) / 
                           duration(num = 1, units = "years"))


    # Nice names for printing
    names(ages) <- c("StudyId", "Visit Date", "Pre-Enroll Age",
                     "Birthdate", "Calculated Age")

    # Identify participants with different pre-enroll and questionnaire ages
    subset(ages, 
           subset = `Pre-Enroll Age` != `Calculated Age`,
           select = c("StudyId", "Birthdate", "Visit Date",
                      "Pre-Enroll Age", "Calculated Age")
    )



}
