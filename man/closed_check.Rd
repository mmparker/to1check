\name{closed_check}
\alias{closed_check}
\title{Check that participants were closed correctly.}
\usage{
  closed_check(cleanlist)
}
\arguments{
  \item{cleanlist}{The list of cleaned TO1 data generated
  by \code{\link{clean_to1}}}
}
\value{
  This function returns a data.frame of participants whose
  records aren't consistent with their closing reason. The
  data.frame includes study ID, participant status, visit
  date, and test result indicators.
}
\description{
  This function checks that participants were closed
  correctly (currently, just that those who are closed as
  triple-negatives actually were).
}
\seealso{
  \code{\link{to_close}} for participants who should be
  closed.
}

