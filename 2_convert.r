# This script:
# - converts character datetimes to POSIXct
# - creates strictly numeric QFT and TSPOT result variables



# Convert datetimes to POSIXct
cleaned$skintest$dt_placed <- as.POSIXct(cleaned$skintest$dt_placed,
                                         format = "%d%B%Y:%H:%M:%S.000")

cleaned$skintest$dt_read <- as.POSIXct(cleaned$skintest$dt_read, 
                                       format = "%d%B%Y:%H:%M:%S.000")

cleaned$qft$dt_placed <- as.POSIXct(cleaned$qft$dt_placed,
                                    format = "%d%B%Y:%H:%M:%S.000")

cleaned$tspot$dt_placed <- as.POSIXct(cleaned$tspot$dt_placed,
                                      format = "%d%B%Y:%H:%M:%S.000")




