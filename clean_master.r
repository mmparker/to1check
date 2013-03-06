
# This script coordinates the data cleaning, which is split across a few files
# for ease of navigation
# It could all be functionalized, I suppose...



# Strings ain't factors
options(stringsAsFactors = FALSE)



# Load the most recent TO 1 data into a list
extracts <- list.files("..\\originals",
                       pattern = "*.csv",
                       full.names = TRUE)

originals <- lapply(extracts, read.csv)


# Rename the entries in originals for ease of reference
names(originals) <- tolower(gsub(x = basename(extracts),
                                 pattern = "^\\w*_V(\\w*).*\\.csv",
                                 replace = "\\1")
)


# Set up a "cleaned" list to preserve originals for comparisons
cleaned <- originals



# Rename the many, many variables to something readable
source("1_rename.r")

# Convert variables to the correct type - e.g., char datetimes to POSIXct
source("2_convert.r")

# Recode variables as needed
source("3_recode.r")


# Write the end result out for ease of reference
save(cleaned, file = "to1_cleaned.rdata")
