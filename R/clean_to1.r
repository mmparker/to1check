
#' Prepare the raw TO1 extracts for use.
#' 
#' This function converts the zipped .csv extracts from the DMS website into
#' a list of data.frames (one for each table) that have been cleaned up for
#' use in R.
#' 
#' This funciton makes several modifications that greatly improve the usability
#' of the DMS extracts within R:
#' \itemize{
#'     \item assigns human-readable variable names
#'     \item converts variables to appropriate data types (e.g., dates to Date)
#'     \item recodes numeric variables with human-readable values
#'     \item adds essential variables to tables (e.g., StudyId to all tables)
#' }
#' 
#' 
#' 
#' @return
#' This function returns a data.frame of participants who are eligible for
#' follow-up, including study ID, original visit date, the date the person
#' became eligible for this follow-up period, the end date of the eligibility
#' period, the number of days until the end of the follow-up period, and
#' and indicator of whether the follow-up has been completed.
#' The data.frame is ordered by days left to complete the interview.
#' 
#' 
#' @param extractfile A zip file containing the ten .csv
#'   files from the DMS data extract page.
#' 
#' @export


clean_to1 <- function(extractfile) {


    # Get the list of files within the data extract zip
    component_list <- unzip(extractfile, list = TRUE)[ , "Name"]

    # The DMS downloads have a header on two rows - row one is nice names,
    # row two is original questionnaire-number names.
    # This is the best way I can think of to keep the first and drop the
    # second...
    originals <- lapply(component_list, function(filename) {

        # Set up a connection to the CSV file
        conn <- unz(extractfile, filename)

        # Load in the data without headers
        records <- read.csv(conn, skip = 2, stringsAsFactors = FALSE)

        # Reconnect
        conn <- unz(extractfile, filename)

        # Get names from the same files
        headers <- read.csv(conn, nrows = 1)

        names(records) <- names(headers)

        records

        }
    )



    # Rename the entries in originals for ease of reference
    names(originals) <- tolower(gsub(x = as.character(component_list),
                                     pattern = "^v(\\w*).*\\.csv",
                                     replacement = "\\1")
    )


    # Check that all of the table extracts are present
    expectedtables <- c("followupfortb", "ltbi", "ltbifollowup", 
                        "master", "medicalhistory", "preenrollment", 
                        "qft", "riskfactor", "skintest", "tspot")

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





    # Rename some of the variables for ease of use
    renamed <- to1check:::rename(originals)

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


    # Return the cleaned data
    to1clean

}
