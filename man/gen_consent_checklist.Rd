\name{gen_consent_checklist}
\alias{gen_consent_checklist}
\title{Generate a checklist for reviewing consent documents}
\usage{
  gen_consent_checklist(cleanlist,
    enroll_start = as.Date("2012-01-01"),
    enroll_end = Sys.Date())
}
\arguments{
  \item{cleanlist}{The list of cleaned TO1 data generated
  by \code{\link{clean_to1}}}

  \item{enroll_start}{The first day of enrollments to
  review.}

  \item{enroll_start}{The last day of enrollments to
  review.}
}
\description{
  This function generates a data.frame that can be saved to
  .csv and used as a checklist for reviewing participant
  consent documents.
}
\details{
  Using participant demographics, this function generates a
  data.frame with a record for every document that needs to
  be reviewed, with columns for each expected signature.

  This is the expected use of this function: \enumerate{
  \item Generate the checklist data.frame \item Write the
  checklist to .csv using \code{write.csv(checklist.df,
  file = file.choose(), row.names = FALSE, row.names =
  FALSE, na = "")} \item Open the .csv in Excel and tidy up
  the columsn \item Print the Excel document }

  The \code{na = ""} is essential - it creates the blank
  checkboxes that you'll mark as you review documents. I
  realize this is a crazy mess, but it's the inevitable
  consequence of converting a one-off script into a
  distributed function. Maybe it'll get refactored someday.
}

