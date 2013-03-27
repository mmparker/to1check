

################################################################################
# Rename variables to something actually useful
################################################################################

################################################################################
# Rename MASTER (ie questionnaire) variables
################################################################################

# PC_1 indicates a patient's enrollment status
names(cleaned$master)[names(originals$master) %in% "PC_1"] <- "status"

# ... whereas Status indicates *that form's* status (draft, submitted, etc)
# To me, much more intuitive for PC_1 to be "status" and Status to be
# "form_status"
names(cleaned$master)[names(originals$master) %in% "Status"] <- "form_status"

# Birthdate
names(cleaned$master)[names(originals$master) %in% "SE_B1"] <- "dob"


data.frame(old = names(originals$master),
           new = names(cleaned$master))


################################################################################
# Pre-enrollment
################################################################################
names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_1"] <- "enroll_date"

names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_4_Years"] <- "age_years"

names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_4_Months"] <- "age_months"

names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_4_Reason"] <- "reason_4"

names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_5"] <- "gender"

names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_6_1"] <- "close_contact"

names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_6_2"] <- "foreign_born"

names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_6_3"] <- "local_group"

names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_6_4"] <- "highrisk_30"

names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_6_5"] <- "hivpos"

names(cleaned$preenrollment)[names(cleaned$preenrollment) 
                             %in% "PE_2"] <- "accepted"



data.frame(old = names(originals$preenrollment),
           new = names(cleaned$preenrollment))






################################################################################
# Rename TST variables
################################################################################

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_1_AND_2"] <- "dt_placed"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_2_Reason"] <- "reason_2"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_3"] <- "placed_by"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_3_Reason"] <- "reason_3"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_4"] <- "ppd_mfg"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_5"] <- "ppd_lot"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_6"] <- "date_read"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_7"] <- "time_read"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_6_AND_7"] <- "dt_read"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_6_Reason"] <- "reason_6"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_7_Reason"] <- "reason_7"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_8"] <- "indur_mm"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_9"] <- "result"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_10"] <- "blistering"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_11"] <- "read_by"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "TST_11_Reason"] <- "reason_11"

names(cleaned$skintest)[names(originals$skintest) 
                          %in% "Status"] <- "form_status"



# Renaming check
data.frame(old = names(originals$skintest),
           new = names(cleaned$skintest))




################################################################################
# Rename QFT variables
################################################################################

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_1_AND_2"] <- "dt_placed"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_3"] <- "placed_by"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_4"] <- "nil_lot"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_5"] <- "tb_lot"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_6"] <- "mito_lot"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_7"] <- "assay_lot"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8"] <- "result"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_Nil"] <- "nil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_TB"] <- "tb"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_Mit"] <- "mito"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_TBNil"] <- "tbnil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_8_MitNil"] <- "mitnil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_9"] <- "rerun_nil_lot"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_10"] <- "rerun_tb_lot"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_11"] <- "rerun_mito_lot"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_12"] <- "rerun_assay_lot"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_13"] <- "rerun_result"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_13_Nil"] <- "rerun_nil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_13_TB"] <- "rerun_tb"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_13_Mit"] <- "rerun_mito"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_13_TBNil"] <- "rerun_tbnil"

names(cleaned$qft)[names(originals$qft) 
                          %in% "QFT_13_MitNil"] <- "rerun_mitnil"



names(cleaned$qft)[names(originals$qft) %in% "Status"] <- "form_status"


# Renaming check
data.frame(old = names(originals$qft),
           new = names(cleaned$qft))





################################################################################
# Rename TSPOT variables
################################################################################

names(cleaned$tspot)[names(originals$tspot) %in% "Status"] <- "form_status"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "TSPOT_1_AND_2"] <- "dt_placed"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "TSPOT_3"] <- "result"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "TSPOT_3a"] <- "nil"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "TSPOT_3b"] <- "mito"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "TSPOT_3c"] <- "panel_a"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "TSPOT_3d"] <- "panel_b"

names(cleaned$tspot)[names(originals$tspot) 
                          %in% "TSPOT_Report_Date"] <- "report_date"





# Renaming check
data.frame(old = names(originals$tspot),
           new = names(cleaned$tspot))



