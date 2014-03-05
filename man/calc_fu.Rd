\name{calc_fu}
\alias{calc_fu}
\title{Generates a report of participants eligible for follow-up.}
\usage{
calc_fu(cleanlist)
}
\arguments{
  \item{cleanlist}{The list of cleaned TO1 data generated
  by \code{\link{clean_to1}}}
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
This function generates a data.frame of participants who
are eligible to complete a 6-, 12-, 18-, or 24-month
follow-up interview.
}
\seealso{
\code{\link{check_fu}} for identifying follow-ups that
occurred outside of an eligibility period.
}

