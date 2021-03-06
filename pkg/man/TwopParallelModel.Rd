\name{TwopParallelModel}
\alias{TwopParallelModel}
\usage{TwopParallelModel(t,
ks,
C0,
In,
gam,
xi=1,
solver=deSolve.lsoda.wrapper,
pass=FALSE)}
\examples{t_start=0 
t_end=10 
tn=50
timestep=(t_end-t_start)/tn 
t=seq(t_start,t_end,timestep) 
Ex=TwopParallelModel(t,ks=c(k1=0.5,k2=0.2),C0=c(c10=100, c20=150),In=10,gam=0.7,xi=0.5)
Ct=getC(Ex)
plot(t,rowSums(Ct),type="l",lwd=2,
ylab="Carbon stocks (arbitrary units)",xlab="Time",ylim=c(0,sum(Ct[1,]))) 
lines(t,Ct[,1],col=2)
lines(t,Ct[,2],col=4)
legend("topright",c("Total C","C in pool 1", "C in pool 2"),
lty=c(1,1,1),col=c(1,2,4),lwd=c(2,1,1),bty="n")

Rt=getReleaseFlux(Ex)
plot(t,rowSums(Rt),type="l",ylab="Carbon released (arbitrary units)",
xlab="Time",lwd=2,ylim=c(0,sum(Rt[1,]))) 
lines(t,Rt[,1],col=2)
lines(t,Rt[,2],col=4) 
legend("topleft",c("Total C release","C release from pool 1", "C release from pool 2"),
lty=c(1,1,1),col=c(1,2,4),lwd=c(2,1,1),bty="n")}
\arguments{
\item{t}{A vector containing the points in time where the solution is sought.}
\item{ks}{A vector of length 2 containing the decomposition rates for the 2 pools.}
\item{C0}{A vector of length 2 containing the initial amount of carbon for the 2 pools.}
\item{In}{A scalar or a data.frame object specifying the amount of litter inputs by time.}
\item{gam}{A scalar representing the partitioning coefficient, i.e. the proportion from the total amount of inputs that goes to pool 1.}
\item{xi}{A scalar or a data.frame specifying the external (environmental and/or edaphic) effects on decomposition rates.}
\item{solver}{A function that solves the system of ODEs. This can be \code{\link{euler}} or \code{\link{deSolve.lsoda.wrapper}} or any other user provided function with the same interface.}
\item{pass}{Forces the constructor to create the model even if it is invalid}
}
\description{This function creates a model for two independent (parallel) pools. 
It is a wrapper for the more general function \code{\link{ParallelModel}} that can handle an arbitrary number of pools.}
\references{Sierra, C.A., M. Mueller, S.E. Trumbore. 2012. Models of soil organic matter decomposition: the SoilR package version 1.0. Geoscientific Model Development 5, 1045-1060.}
\seealso{There are other \code{\link{predefinedModels}} and also more general functions like \code{\link{Model}}.}
\title{Implementation of a linear two pool model with parallel structure}
\value{A Model Object that can be further queried }
