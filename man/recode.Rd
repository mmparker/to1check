\name{recode}
\alias{recode}
\title{Recodes DMS extract variables for ease of use.}
\usage{
  recode(converted)
}
\arguments{
  \item{converted}{The output of the \code{\link{convert}}
  function.}
}
\description{
  This function recodes DMS extract variables for ease of
  use; that includes \itemize{ \item Converting numeric
  codes into human-readable values; \item Creating
  strictly-numeric versions of QFT and TSPOT quantitative
  results \item Creating strictly-numeric versions of QFT
  and }
}
\details{
  The input of this function should generally be the output
  of the \code{\link{convert}} function, and is only meant
  to be used internally by \code{\link{clean_to1}}
}

