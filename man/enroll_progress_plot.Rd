\name{enroll_progress_plot}
\alias{enroll_progress_plot}
\title{Generate a plot of enrollment progress and targets throughout a given period.}
\usage{
  enroll_progress_plot(enroll_dates, target, enroll_start,
    enroll_end)
}
\arguments{
  \item{enroll_dates}{A Date vector of enrollment dates}

  \item{target}{The total enrollment target for the period}

  \item{enroll_start}{The start Date of the enrollment
  period}

  \item{enroll_end}{The end Date of the enrollment period}
}
\value{
  A ggplot2 plot.
}
\description{
  This function generates a plot (using ggplot2) of
  cumulative enrollment progress and enrollment targets
  throughout the given period. The plot currently
  aggregates by week only.
}

