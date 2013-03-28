

# This function checks that:
# - The pre-enrollment age and the Enrollment Date - DOB are the same
# - That pediatric patients filled out pediatric packets


age_check <- function(cleanlist, outdir) {

    require(lubridate)

    # Get the ages
    ages <- merge(x = subset(cleanlist$preenrollment,
                             select = c("StudyId", "enroll_date", "age_years")),
                  y = subset(cleanlist$master,
                             select = c("StudyId", "dob")),
                  by = "StudyId",
                  all.x = TRUE)


    # Rename age_years to indicate its origin
    names(ages)[names(ages) %in% "age_years"] <- pre_age




    ########################################################################### 
    # Compare pre-enrollment and Enrollment Date - DOB ages
    ########################################################################### 

    # Calculate age at enrollment
    ages$calc_age <- 
        with(ages, difftime(dob, enroll_date, units = "years"))

x <- with(ages, as.interval(x = enroll_date, start = dob))





    ########################################################################### 
    # Write out the problems
    ########################################################################### 

    write.csv(to.close, 
              file = file.path(outdir, "Triple-negative participants not yet closed.csv"),
              row.names = FALSE
    )


    # Need to remove duplicates
    write.csv(not.tripneg,
              file = file.path(outdir, "Patients wrongly closed as triple-negative.csv"),
              row.names = FALSE
    )


}
