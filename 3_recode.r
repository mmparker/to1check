


################################################################################
# Convert test results from numeric to text
################################################################################

cleaned$skintest$result[cleaned$skintest$result %in% 1] <- "Positive"
cleaned$skintest$result[cleaned$skintest$result %in% 2] <- "Negative"


cleaned$qft$result[cleaned$qft$result %in% 1] <- "Positive"
cleaned$qft$result[cleaned$qft$result %in% 2] <- "Negative"
cleaned$qft$result[cleaned$qft$result %in% 3] <- "Indeterminate"
cleaned$qft$result[cleaned$qft$result %in% 2] <- "Failed"

cleaned$tspot$result[cleaned$tspot$result %in% 1] <- "Positive"
cleaned$tspot$result[cleaned$tspot$result %in% 2] <- "Negative"
cleaned$tspot$result[cleaned$tspot$result %in% 3] <- "Borderline"
cleaned$tspot$result[cleaned$tspot$result %in% 4] <- "Invalid"
cleaned$tspot$result[cleaned$tspot$result %in% 5] <- "Test Not Performed"
cleaned$tspot$result[cleaned$tspot$result %in% 6] <- "Test Not Performed"


# Reruns, too
cleaned$qft$rerun_result[cleaned$qft$rerun_result %in% 1] <- "Positive"
cleaned$qft$rerun_result[cleaned$qft$rerun_result %in% 2] <- "Negative"
cleaned$qft$rerun_result[cleaned$qft$rerun_result %in% 3] <- "Indeterminate"
cleaned$qft$rerun_result[cleaned$qft$rerun_result %in% 2] <- "Failed"




################################################################################
# Create strictly-numeric recodes of the QFT and TSPOT results
################################################################################

resultToNumeric <- function(x) {
    as.numeric(gsub(x = x, pattern = ">", replace = ""))
}


# QFTs
cleaned$qft$nil.num <- resultToNumeric(cleaned$qft$nil)
cleaned$qft$tb.num <- resultToNumeric(cleaned$qft$tb)
cleaned$qft$mito.num <- resultToNumeric(cleaned$qft$mito)
cleaned$qft$tbnil.num <- resultToNumeric(cleaned$qft$tbnil)
cleaned$qft$mitnil.num <- resultToNumeric(cleaned$qft$mitnil)

with(cleaned$qft, unique(data.frame(old = nil, new = nil.num)))
with(cleaned$qft, unique(data.frame(old = tb, new = tb.num)))
with(cleaned$qft, unique(data.frame(old = mito, new = mito.num)))
with(cleaned$qft, unique(data.frame(old = tbnil, new = tbnil.num)))
with(cleaned$qft, unique(data.frame(old = mitnil, new = mitnil.num)))



# TSPOTs
cleaned$tspot$nil.num <- resultToNumeric(cleaned$tspot$nil)
cleaned$tspot$mito.num <- resultToNumeric(cleaned$tspot$mito)
cleaned$tspot$panel_a.num <- resultToNumeric(cleaned$tspot$panel_a)
cleaned$tspot$panel_b.num <- resultToNumeric(cleaned$tspot$panel_b)

with(cleaned$tspot, unique(data.frame(old = nil, new = nil.num)))
with(cleaned$tspot, unique(data.frame(old = mito, new = mito.num)))
with(cleaned$tspot, unique(data.frame(old = panel_a, new = panel_a.num)))
with(cleaned$tspot, unique(data.frame(old = panel_b, new = panel_b.num)))



# Rerun QFTs
cleaned$qft$rerun_nil.num <- resultToNumeric(cleaned$qft$rerun_nil)
cleaned$qft$rerun_tb.num <- resultToNumeric(cleaned$qft$rerun_tb)
cleaned$qft$rerun_mito.num <- resultToNumeric(cleaned$qft$rerun_mito)
cleaned$qft$rerun_tbnil.num <- resultToNumeric(cleaned$qft$rerun_tbnil)
cleaned$qft$rerun_mitnil.num <- resultToNumeric(cleaned$qft$rerun_mitnil)

with(cleaned$qft, unique(data.frame(old = rerun_nil, new = rerun_nil.num)))
with(cleaned$qft, unique(data.frame(old = rerun_tb, new = rerun_tb.num)))
with(cleaned$qft, unique(data.frame(old = rerun_mito, new = rerun_mito.num)))
with(cleaned$qft, unique(data.frame(old = rerun_tbnil, new = rerun_tbnil.num)))
with(cleaned$qft, unique(data.frame(old = rerun_mitnil, 
                                    new = rerun_mitnil.num)))



# Participant status
cleaned$master$status[cleaned$master$status %in% 1] <- "Triple Negative"
cleaned$master$status[cleaned$master$status %in% 2] <- "Not eligible"
cleaned$master$status[cleaned$master$status %in% 3] <- "FU Completed or Lost"
cleaned$master$status[cleaned$master$status %in% 4] <- "Developed TB Disease"
cleaned$master$status[cleaned$master$status %in% 5] <- "Died"
cleaned$master$status[cleaned$master$status %in% 6] <- "Withdrew"
cleaned$master$status[cleaned$master$status %in% 7] <- "Didn't complete enrollment"
cleaned$master$status[cleaned$master$status %in% NA] <- "Open"



