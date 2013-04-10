\name{htwt_check}
\alias{htwt_check}
\title{Check for data entry errors in participant heights and weights.}
\usage{
  htwt_check(cleanlist)
}
\arguments{
  \item{cleanlist}{The list of cleaned TO1 data generated
  by \code{\link{clean_to1}}}
}
\value{
  A list containing three elements: \code{plot},
  \code{outlierdf}, and \code{missingdf}, each
  corresponding to the elements listed above.
}
\description{
  This function generates a list containing a plot of
  particpant heights vs. weights; a data.frame of the most
  extreme height/weight observations; and a data.frame of
  participants missing height and/or weight.
}
\details{
  This function generates a list with three elements:
  \enumerate{ \item A plot (using ggplot2) of participant
  heights vs.  weights, with the most extreme observations
  labeled with study IDs.  \item A table of the most
  extreme observations.  \item A table of participants
  missing either height or weight }

  "Most extreme" is crudely defined as those points that
  are the furthest from their nearest neighbor. This isn't
  intended as formal outlier detection; it's just a quick
  way to label outlying points.
}

