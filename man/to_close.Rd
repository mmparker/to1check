\name{to_close}
\alias{to_close}
\title{Check that triple-negative individuals are closed to follow-up.}
\usage{
  to_close(cleanlist)
}
\arguments{
  \item{cleanlist}{The list of cleaned TO1 data generated
  by \code{\link{clean_to1}}}
}
\value{
  This function returns a data.frame of participants who
  are negative on all three tests but have not yet been
  closed. The data.frame includes study ID, participant
  status, visit date, and test result indicators.
}
\description{
  This function checks that individuals who had negative
  TST, QFT, and TSPOT were closed.
}
\seealso{
  \code{\link{closed_check}} for participants who were
  closed incorrectly.
}

