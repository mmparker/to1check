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
This function returns a data.frame of participants who are
negative on all three tests but have not yet been closed.
The data.frame includes study ID, participant status, visit
date, and test result indicators.
}
\description{
This function checks that individuals who have had only
negative TST, QFT, and TSPOT results have been closed.
Individuals with multiple results for each test must have
all negative results to be included. Indeterminate,
borderline, and invalid results are considered negative
(for now).
}
\seealso{
\code{\link{closed_check}} for participants who were closed
incorrectly.
}

