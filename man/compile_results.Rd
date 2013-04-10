\name{compile_results}
\alias{compile_results}
\title{Compile participants' test results into a single data frame.}
\usage{
  compile_results(cleanlist)
}
\arguments{
  \item{cleanlist}{The list of cleaned TO1 data generated
  by \code{\link{clean_to1}}}
}
\value{
  This function returns a data.frame with a record for each
  participant, which includes their study ID, visit date,
  and TST, QFT, and TSPOT results.
}
\description{
  This function generates a single record for all enrolled
  participants, with variables indicating their most recent
  TST, QFT, and TSPOT results.
}
\details{
  In the event of multiple test results (e.g., rerun QFTs
  or repeated TSPOTs), the most recent result is used.
}

