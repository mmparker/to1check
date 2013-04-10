\name{mix}
\alias{mix}
\title{Distributes variables from some DMS tables to others for ease of use.}
\usage{
  mix(recoded)
}
\arguments{
  \item{recoded}{The output of the \code{\link(recode)}
  function.}
}
\description{
  This function merges variables from some tables onto
  others for ease of use.
}
\details{
  This function expects the output of \code{\link(recode)}
  as its input. It's only intended to be used internally by
  \code{\link(clean_to1)}.
}

