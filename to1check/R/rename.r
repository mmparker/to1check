

# Rename variables to something actually useful

rename <- function(originals) {

    # Keep the originals for comparison
    cleaned <- originals




################################################################################
# Rename TST variables
################################################################################

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TstPlacedDateTime"] <- "dt_placed"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TstReadDateTime"] <- "dt_read"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TstResult"] <- "indur_mm"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TstInterpretation"] <- "result"


# Renaming check
data.frame(old = names(originals$skintest),
           new = names(cleaned$skintest))




################################################################################
# Rename QFT variables
################################################################################

names(cleaned$qft)[names(originals$qft) 
                          %in% "BloodDrawDateTime"] <- "dt_placed"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QftResult"] <- "result"

names(cleaned$qft)[names(originals$qft) 
                          %in% "NilControl"] <- "nil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "TbAntigen"] <- "tb"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_Mit"] <- "mito"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_TBNil"] <- "tbnil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_MitNil"] <- "mitnil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QftResult2"] <- "rerun_result"

names(cleaned$qft)[names(originals$qft) 
                          %in% "NilControl2"] <- "rerun_nil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "TbAntigen2"] <- "rerun_tb"

names(cleaned$qft)[names(originals$qft) 
                          %in% "Mitogen2"] <- "rerun_mito"

names(cleaned$qft)[names(originals$qft) 
                          %in% "TbAntigenNil2"] <- "rerun_tbnil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "MitogenNil2"] <- "rerun_mitnil"


# Renaming check
data.frame(old = names(originals$qft),
           new = names(cleaned$qft))





################################################################################
# Rename TSPOT variables
################################################################################

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "CollectDateTime"] <- "dt_placed"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "TspotResult"] <- "result"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "NilControl"] <- "nil"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "PosControl"] <- "mito"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "PanelA"] <- "panel_a"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "PanelB"] <- "panel_b"



# Renaming check
# data.frame(old = names(originals$tspot),
#           new = names(cleaned$tspot))


cleaned

}
