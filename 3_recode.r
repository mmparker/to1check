

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
        as.numeric(gsub(x = x, pattern = ">", replace = ""))
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
    
    
    
    
    # Rerun QFTs
    recoded$qft$rerun_nil.num <- resultToNumeric(recoded$qft$rerun_nil)
    recoded$qft$rerun_tb.num <- resultToNumeric(recoded$qft$rerun_tb)
    recoded$qft$rerun_mito.num <- resultToNumeric(recoded$qft$rerun_mito)
    recoded$qft$rerun_tbnil.num <- resultToNumeric(recoded$qft$rerun_tbnil)
    recoded$qft$rerun_mitnil.num <- resultToNumeric(recoded$qft$rerun_mitnil)
    
    
    
    # Participant status
    recoded$master$status[recoded$master$status %in% 1] <- 
        "Triple Negative"

    recoded$master$status[recoded$master$status %in% 2] <- 
        "Not eligible"

    recoded$master$status[recoded$master$status %in% 3] <- 
        "FU Completed or Lost"

    recoded$master$status[recoded$master$status %in% 4] <- 
        "Developed TB Disease"

    recoded$master$status[recoded$master$status %in% 5] <- 
        "Died"

    recoded$master$status[recoded$master$status %in% 6] <- 
        "Withdrew"

    recoded$master$status[recoded$master$status %in% 7] <- 
        "Didn't complete enrollment"

    recoded$master$status[recoded$master$status %in% NA] <- 
        "Open"
    

    recoded

}
