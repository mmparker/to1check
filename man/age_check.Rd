\name{age_check}
\alias{age_check}
\title{Checks that pre-enrollment ages match calculated ages.}
\usage{
age_check(cleanlist)
}
\arguments{
  \item{cleanlist}{The list of cleaned TO1 data generated
  by \code{\link{clean_to1}}}
}
\value{
\code{age_check} returns a data.frame of participants with
incongruent ages with study ID, birth date, visit date,
pre-enrollment age, calculated age, and the difference
between the two ages in years. The data.frame is ordered by
decreasing size of the discrepancy.
}
\description{
This function checks that the ages given on pre-enrollments
match those calculated from reported dates of birth
(Section A) and the particpant's visit date (Section A).
}
\details{
Ages are given in years; calculated ages are rounded down.
}

