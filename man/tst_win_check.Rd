\name{tst_win_check}
\alias{tst_win_check}
\title{Generate a report of TSTs read outside of the 44-76 hour window.}
\usage{
  tst_win_check(cleanlist)
}
\arguments{
  \item{cleanlist}{The list of cleaned TO1 data generated
  by \code{\link{clean_to1}}}
}
\value{
  This function returns a data.frame of participants whose
  tests fall outside the window, including study ID,
  date/time placed, date/time read, placer and reader
  initials, and the hours from placement to reading.
}
\description{
  This function generates a data.frame of participants
  whose TSTs were read less than 44 or more than 76 hours
  after placement (the window permitted under the study
  protocol).
}

