\docType{methods}
\name{getC,Model-method}
\title{getC,Model-method}
\alias{getC,Model-method}
\usage{\S4method{getC}{Model}(object)}
\arguments{
\item{object}{: of class Model}
}
\description{This function computes the value for C for each time and pool. }
\details{This function takes a Model object, which represents a system of ODEs of the form 
\deqn{\frac{d \mathbf{C}(t)}{dt} = \mathbf{I}(t) + \mathbf{A}(t) \mathbf{C}(t)}{dC(t)/dt = I(t) + A(t)C(t)} 
and solves the system for \eqn{\mathbf{C}(t)}{C(t)}. The numerical solver used can be specified in the constructor of the Model class
e.g. \code{\link{Model}}, \code{\link{GeneralModel}}.}
\seealso{See examples in \code{\link{GeneralModel}}, \code{\link{GeneralModel_14}}, \code{\link{TwopParallelModel}}, 
\code{\link{TwopSeriesModel}}, \code{\link{TwopFeedbackModel}}, etc.}
\value{A matrix with m columns representing the number of pools, and n rows representing the times as specified by the argument
\code{t} in \code{\link{Model}},\code{\link{GeneralModel}} or another model creating function.}
