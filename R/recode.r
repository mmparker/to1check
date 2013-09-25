

#' Recodes DMS extract variables for ease of use.
#' 
#' This function recodes DMS extract variables for ease of use; that includes
#' \itemize{
#'   \item Converting numeric codes into human-readable values;
#'   \item Creating strictly-numeric versions of QFT and 
#'     TSPOT quantitative results
#'   \item Creating strictly-numeric versions of QFT and 
#' }
#' 
#' The input of this function should generally be the output of
#' the \code{\link{convert}} function, and is only meant to be used internally
#' by \code{\link{clean_to1}}
#' 
#' @param converted The output of the \code{\link{convert}} function.

recode <- function(converted) {

    # Keep the originals for comparison
    recoded <- converted


    ############################################################################
    # Convert test results from numeric to text
    ############################################################################

    recoded$skintest$result[recoded$skintest$result %in% 1] <- "Positive"
    recoded$skintest$result[recoded$skintest$result %in% 2] <- "Negative"


    recoded$qft$result[recoded$qft$result %in% 1] <- "Positive"
    recoded$qft$result[recoded$qft$result %in% 2] <- "Negative"
    recoded$qft$result[recoded$qft$result %in% 3] <- "Indeterminate"
    recoded$qft$result[recoded$qft$result %in% 2] <- "Failed"

    recoded$tspot$result[recoded$tspot$result %in% 1] <- "Positive"
    recoded$tspot$result[recoded$tspot$result %in% 2] <- "Negative"
    recoded$tspot$result[recoded$tspot$result %in% 3] <- "Borderline"
    recoded$tspot$result[recoded$tspot$result %in% 4] <- "Invalid"
    recoded$tspot$result[recoded$tspot$result %in% 5] <- "Test Not Performed"
    recoded$tspot$result[recoded$tspot$result %in% 6] <- "Test Not Performed"


    # Reruns, too
    recoded$qft$rerun_result[recoded$qft$rerun_result %in% 1] <- "Positive"
    recoded$qft$rerun_result[recoded$qft$rerun_result %in% 2] <- "Negative"
    recoded$qft$rerun_result[recoded$qft$rerun_result %in% 3] <- "Indeterminate"
    recoded$qft$rerun_result[recoded$qft$rerun_result %in% 2] <- "Failed"




    ############################################################################
    # Create strictly-numeric recodes of the QFT and TSPOT results
    ############################################################################

    resultToNumeric <- function(x) {
        as.numeric(gsub(x = x, pattern = ">", replacement = ""))
    }


    # QFTs
    recoded$qft$nil.num <- resultToNumeric(recoded$qft$nil)
    recoded$qft$tb.num <- resultToNumeric(recoded$qft$tb)
    recoded$qft$mito.num <- resultToNumeric(recoded$qft$mito)
    recoded$qft$tbnil.num <- resultToNumeric(recoded$qft$tbnil)
    recoded$qft$mitnil.num <- resultToNumeric(recoded$qft$mitnil)




    # TSPOTs
    recoded$tspot$nil.num <- resultToNumeric(recoded$tspot$nil)
    recoded$tspot$mito.num <- resultToNumeric(recoded$tspot$mito)
    recoded$tspot$panel_a.num <- resultToNumeric(recoded$tspot$panel_a)
    recoded$tspot$panel_b.num <- resultToNumeric(recoded$tspot$panel_b)

    # Calculate TB - Nil for TSPOT
    recoded$tspot$tbnil.a <- recoded$tspot$panel_a.num - recoded$tspot$nil.num
    recoded$tspot$tbnil.b <- recoded$tspot$panel_b.num - recoded$tspot$nil.num
    recoded$tspot$tbnil.max <- pmax(recoded$tspot$tbnil.a,
                                    recoded$tspot$tbnil.b)




    # Rerun QFTs
    recoded$qft$rerun_nil.num <- resultToNumeric(recoded$qft$rerun_nil)
    recoded$qft$rerun_tb.num <- resultToNumeric(recoded$qft$rerun_tb)
    recoded$qft$rerun_mito.num <- resultToNumeric(recoded$qft$rerun_mito)
    recoded$qft$rerun_tbnil.num <- resultToNumeric(recoded$qft$rerun_tbnil)
    recoded$qft$rerun_mitnil.num <- resultToNumeric(recoded$qft$rerun_mitnil)


    ############################################################################
    # Participant CloseReason
    ############################################################################

    recoded$master$CloseReason[recoded$master$CloseReason %in% 1] <- 
        "Triple Negative"

    recoded$master$CloseReason[recoded$master$CloseReason %in% 2] <- 
        "Not eligible"

    recoded$master$CloseReason[recoded$master$CloseReason %in% 3] <- 
        "FU Completed or Lost"

    recoded$master$CloseReason[recoded$master$CloseReason %in% 4] <- 
        "Developed TB Disease"

    recoded$master$CloseReason[recoded$master$CloseReason %in% 5] <- 
        "Died"

    recoded$master$CloseReason[recoded$master$CloseReason %in% 6] <- 
        "Withdrew"

    recoded$master$CloseReason[recoded$master$CloseReason %in% 7] <- 
        "Didn't complete enrollment"

    recoded$master$CloseReason[recoded$master$CloseReason %in% NA] <- 
        "Open"



    ############################################################################
    # Convert country of birth codes from ISO 3166-1 alpha-3 to, you know,
    # something humans can actually read
    ############################################################################

    # Use factor() to relabel BirthCountry, then convert back to character
    # Uses the to1check package's internal abbreviation -> name dictionary,
    # country_codes
    recoded$master$BirthCountry <- as.character(
        factor(recoded$master$BirthCountry,
               levels = country_codes$code,
               labels = country_codes$name)
    )




    ############################################################################
    # Recode BCG status
    ############################################################################

    recoded$medicalhistory$BcgVaccine[recoded$medicalhistory$BcgVaccine 
                                      %in% 1] <- "Yes"

    recoded$medicalhistory$BcgVaccine[recoded$medicalhistory$BcgVaccine 
                                      %in% 0] <- "No"

    recoded$medicalhistory$BcgVaccine[recoded$medicalhistory$BcgVaccine 
                                      %in% 99] <- "Don't Know/Refused"





    ############################################################################
    # Return the recoded results
    ############################################################################

    recoded

}
