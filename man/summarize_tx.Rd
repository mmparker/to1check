\name{summarize_tx}
\alias{summarize_tx}
\title{Summarizes each participant's treatment information.}
\usage{
summarize_tx(cleanlist)
}
\arguments{
  \item{cleanlist}{The list of cleaned TO1 data generated
  by \code{\link{clean_to1}}}
}
\value{
This function generates a data.frame summarizing each
participant's treatment information into a single record,
including offer, acceptance, start date, status, end date,
initial regimen, latest regimen, etc.
}
\description{
Combines information from the LTBI Treatment, LTBI
Follow-up, and LTBI Closing forms to provide a
one-record-per-participant overview of participants'
treatment records.
}

