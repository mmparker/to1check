# This function checks that the TSTs were:
#  - placed after the phlebotomy
#  - read within 48-72 hours of placement



tst_win_check <- function(cleanlist) {

    tsts <- cleanlist$skintest


    ########################################################################### 
    # Were TSTs read within 48-72 hours?
    ########################################################################### 

    tsts$hrs_to_read <- round(as.numeric(
       difftime(tsts$dt_read, tsts$dt_placed, units = "hours")), 1)
        


    # Report any outside of the 48-72 hour bounds (which are actually 44-76)
    subset(tsts,
           subset = hrs_to_read > 76 |
                    hrs_to_read < 44,
           select = c("StudyId", "dt_placed", "TstPlacedBy",
                      "dt_read", "TstReadBy", "hrs_to_read")
    )



}
