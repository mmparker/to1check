\name{check_fu}
\alias{check_fu}
\title{Checks for follow-ups that occurred outside the eligibility period.}
\usage{
check_fu(cleanlist)
}
\arguments{
  \item{cleanlist}{The list of cleaned TO1 data generated
  by \code{\link{clean_to1}}}
}
\value{
This function returns a data.frame of semiannual follow-ups
that occurred outside of the appropriate eligibility
period, including study ID, original visit date, the date
the person became eligible for this follow-up period, the
end date of the eligibility period, the number of days
until the end of the follow-up period, and and indicator of
whether the follow-up has been completed. The data.frame is
ordered by days left to complete the interview.
}
\description{
This function generates a data.frame of semiannual
follow-ups that occurred outside of the appropriate
eligibility period.
}
\seealso{
\code{\link{calc_fu}} for identifying participants who are
currently eligible for follow-up.
}

