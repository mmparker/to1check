This package is a collection of functions for working with the TBESC2
TO 1 data (specifically, the downloadable extracts from DMS).  The functions
can be broken down into three groups:

### Functions for Cleaning Raw Data: clean\_to1, rename, convert, recode, mix
These functions take the raw .csv extracts from DMS and produce an R list of
data.frames, each corresponding to a raw .csv file.  Those data.frames should 
generally have well-formated variables (character-coded instead of numeric,
dates are Dates, datetimes are POSIX, StudyId is available on every table).

`clean_to1` is the only function you need; it applies the others appropriately.


### Functions for data quality checking
These functions underlie the TO 1 auto-QA report 
(https://github.com/mmparker/to1report); they can definitely
be used alone but their outputs are oriented to that end.


### Standalone functions
These functions provide standalone functionality for study staff. 
For example, `gen_consent_checklist` produces a data.frame with a record
for each theoretically-existing consent document for all enrolled particpants
and open fields for each signature that should be on them.  Write it out to
.csv, tidy up in Excel, and print.
