
# This function coordinates the data cleaning, which is split across several
# functions for ease of navigation



clean_to1 <- function(extractdir, outdir) {


    # Load the most recent TO 1 data into a list
    extracts <- list.files(extractdir,
                           pattern = "*.csv",
                           full.names = TRUE)
    
    originals <- lapply(extracts, read.csv)
    
    
    # Rename the entries in originals for ease of reference
    names(originals) <- tolower(gsub(x = basename(extracts),
                                     pattern = "^\\w*_V(\\w*).*\\.csv",
                                     replace = "\\1")
    )
    
    
    # Check that all of the table extracts are present
    expectedtables <- c("followupfortb", "ltbi", "ltbifollowup", 
                        "master", "medicalhistory", "preenrollment", 
                        "qft", "riskfactor", "skintest", "tbdisease", "tspot")
    
    missingtables <- expectedtables[!expectedtables %in% names(originals)]
    
    if(length(missingtables) > 0) {
        stop(paste(
            "The following tables are missing or didn't import correctly: ",
            "\n",
            paste(missingtables, collapse = "\n"),
            sep = ""),
            call. = FALSE
        )
    }
    
    
    
    
    
    # Rename the many, many variables to something readable
    renamed <- rename(originals)
    
    # Convert variables to the correct type - e.g., char datetimes to POSIXct
    converted <- convert(renamed)
    
    # Recode variables as needed
    recoded <- recode(converted)
    
    # Add StudyId to every table.  As a general rule, though, 
    # StudyId is for display and PatientID remains the table key of record
    # (because that's how the DB is set up)
    mixed <- mix(recoded)
    
    
    
    # Create a final "cleaned" dataset (preserves a consistent name
    # if something comes in after mixed
    to1clean <- mixed
    
    
    # Write the end result out for ease of reference
    save(to1clean, file = file.path(outdir, "to1clean.rdata"))

    # And finally, return it to the current session
    to1clean

}
