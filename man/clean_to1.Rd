\name{clean_to1}
\alias{clean_to1}
\title{Prepare the raw TO1 extracts for use.}
\usage{
clean_to1(extractfile)
}
\arguments{
  \item{extractfile}{A zip file containing the ten .csv
  files from the DMS data extract page.}
}
\value{
This function returns a data.frame of participants who are
eligible for follow-up, including study ID, original visit
date, the date the person became eligible for this
follow-up period, the end date of the eligibility period,
the number of days until the end of the follow-up period,
and and indicator of whether the follow-up has been
completed. The data.frame is ordered by days left to
complete the interview.
}
\description{
This function converts the zipped .csv extracts from the
DMS website into a list of data.frames (one for each table)
that have been cleaned up for use in R.
}
\details{
This funciton makes several modifications that greatly
improve the usability of the DMS extracts within R:
\itemize{ \item assigns human-readable variable names \item
converts variables to appropriate data types (e.g., dates
to Date) \item recodes numeric variables with
human-readable values \item adds essential variables to
tables (e.g., StudyID to all tables) }
}

