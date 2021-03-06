\name{cycling}
\alias{cycling}
\usage{cycling(A)}
\arguments{
\item{A}{A compartmental linear square matrix with cycling rates in the diagonal and transfer rates in the off-diagonal.}
}
\description{Computes the fundamental matrix N, and the expected number of steps from a compartmental matrix A}
\seealso{\code{\link{systemAge}}}
\title{Cycling analysis of compartmental matrices}
\value{A list with 2 objects: the fundamental matrix N, and the expected number of steps Et.}
