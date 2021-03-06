\name{ParallelModel}
\alias{ParallelModel}
\usage{ParallelModel(times,
coeffs_tm,
startvalues,
inputrates,
solverfunc=deSolve.lsoda.wrapper,
pass=FALSE)}
\examples{t_start=0 
t_end=10 
tn=50
timestep=(t_end-t_start)/tn 
t=seq(t_start,t_end,timestep) 
k=TimeMap(
function(times){c(-0.5,-0.2,-0.3)},
t_start,
t_end
)
c0=c(1, 2, 3)
#constant inputrates
inputrates=BoundInFlux(
function(t){matrix(nrow=3,ncol=1,c(1,1,1))},
t_start,
t_end
) 
mod=ParallelModel(t,k,c0,inputrates)
Y=getC(mod)
lt1=1 ;lt2=2 ;lt3=3 
col1=1; col2=2; col3=3
plot(t,Y[,1],type="l",lty=lt1,col=col1,
ylab="C stocks",xlab="Time") 
lines(t,Y[,2],type="l",lty=lt2,col=col2) 
lines(t,Y[,3],type="l",lty=lt3,col=col3) 
legend(
"topleft",
c("C in pool 1",
"C in 2",
"C in pool 3"
),
lty=c(lt1,lt2,lt3),
col=c(col1,col2,col3)
)
Y=getAccumulatedRelease(mod)
plot(t,Y[,1],type="l",lty=lt1,col=col1,ylab="C release",xlab="Time") 
lines(t,Y[,2],lt2,type="l",lty=lt2,col=col2) 
lines(t,Y[,3],type="l",lty=lt3,col=col3) 
legend("topright",c("R1","R2","R3"),lty=c(lt1,lt2,lt3),col=c(col1,col2,col3))}
\arguments{
\item{times}{A vector containing the points in time where the solution is sought.}
\item{coeffs_tm}{A TimeMap object consisting of a vector valued function containing the decay rates for the n pools as function of time and the time range where this function is valid. The length of the vector is equal to the number of pools.}
\item{startvalues}{A vector containing the initial amount of carbon for the n pools.
<<The length of this vector is equal to the number of pools and thus equal to the length of k. This is checked by the function.}
\item{inputrates}{An  object consisting of a vector valued function describing the inputs to the pools as funtions of time \code{\link{TimeMap.new}}}
\item{solverfunc}{The function used to actually solve the ODE system. This can be \code{\link{deSolve.lsoda.wrapper}} or any other user provided function with the same interface.}
\item{pass}{if TRUE forces the constructor to create the model even if it is invalid}
}
\description{This function creates a (linear) numerical model for n independent (parallel) pools that can be queried afterwards. 
It is used by the convinient wrapper functions \code{\link{TwopParallelModel}} and \code{\link{ThreepParallelModel}}
but can also be used independently.}
\title{models for unconnected pools}
