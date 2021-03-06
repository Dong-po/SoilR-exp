\description{This class  extends \code{\linkS4class{Model}}, 
to represent \eqn{^{14}C}{14C} decay. 
\enumerate{
\item 
\itemize{
\item As \code{\linkS4class{Model}} it contains all the components 
that are needed to solve the
initial value problem for the pool contents \eqn{\vec{C}}{C=(C_1,...C_n)^t}. 
\item It adds the components that are needed to solve the
additional initial value problem for the \eqn{^{14}C}{14C} contents of the pools
\eqn{\vec{^{14}C}}{14C=(14C_1,...,14C_n)^t}. 
} 
\item 
\itemize{
\item 
It provides the single argument for all the functions 
that are available for an argument of class \code{\linkS4class{Model}}.
\item 
and for additional functions 
that are available to compute various results from the solution of the additional 
initial value problem for \eqn{^{14}C}{14C}. 
See subsection \code{Methods} and the examples.)
}
}}
\details{The original initial value problem for \eqn{\vec{C}}{(C_1,...,C_n)^t)} as decribed in the docomentation of the superclass \code{\linkS4class{Model}}
was given by:
\itemize{
\item
\eqn{ \frac{d \mathbf{C}(t)}{dt} = \mathbf{I}(t) + \mathbf{A}(t) \mathbf{C}(t)}{dC(t)/dt = I(t) + A(t)C(t) } 
\item
the initial Values \eqn{\vec{C}_0=\vec{C}(t_0)}{C_0=C(t_0)} 
\item 
for the times \eqn{\{t_0,....t_m\}}{{t_0,....,t_m}}.
}
The additional initial value problem for \eqn{^{14}C}{14C} is represented by additional parameters:
\itemize{
\item
a second ordinary differential equation:
\deqn{\frac{d ^{14} \mathbf{C}(t)}{dt} = F(t) \mathbf{I}(t) + \mathbf{A}(t) ^{14} \mathbf{C}(t)-k_{14}\; ^{14}\mathbf{C}(t) }{d 14C/dt = F(t) I(t) + A(t)C(t)-k_14 C(t)} 
with initial values \eqn{^{14}\mathbf{C}_0=F_0 \mathbf{C}_0}{14C_0=F_0 C_0} with:
\item
the time dependent \eqn{^{14}C}{14C} fraction \eqn{F(t)}{F(t)}, 
\item
the constant \eqn{^{14}C}{14C} fraction of the initial pool contents \eqn{F_0}{F_0},
\item
the \eqn{^{14}C}{14C} decay rate \eqn{k_{14}}{k_14}.
}
In an object of class \code{\linkS4class{Model_14}}  the components are represented as follows:
\itemize{
\item
The time-dependent matrix valued function \eqn{\vec{A}(t)}{A(t)} is represented by an object 
of a subclass of \code{\linkS4class{DecompOp}} (for decomposition operator). 
Such objects can be created in different ways from functions, matrices or data. 
(see the subclasses of \code{\linkS4class{DecompOp}} and especially their \code{Constructors} sections.  
and the \code{examples} section of this help page.
\item 
The vector-valued time-dependent function \eqn{\vec{I}(t)}{I(t)} is in SoilR represented by an object of a subclass of class \code{\linkS4class{InFlux}}. 
Such objects can also be created from functions, constant vectors and data. 
(see the subclasses of \code{\linkS4class{InFlux}} and especially their \code{Constructors} sections.  
\item 
The initial values for \eqn{\mathbf{C}_0}{C} are represented by a numeric vector 
\item 
The value for the \eqn{^{14}\mathbf{C}}{14C} fraction of the initial \eqn{\mathbf{C}}{C} 
is represented as an object of class \linkS4class{ConstFc} which is
a subclass of \code{\linkS4class{Fc}} representing the \eqn{^{14}C}{14C} fraction \eqn{F}{F} and its unit. 
(Either "Delta14C" or "afn" for Absolute Fraction Normal)
\item 
The value for the \eqn{^{14}\mathbf{C}}{14C} fraction of the input \eqn{\mathbf{I}(t)}{I(t)} is also represented
as an object of a subclass of \code{\linkS4class{Fc}}. It can be time dependent or constant.
}}
\name{Model_14-class}
\alias{Model_14-class}
\docType{class}
\section{Methods}{Exported methods directly defined for class Model_14:

  \describe{
    \item{getC14}{\code{signature(object = "Model_14")}: ... } \code{\link{getC14,Model_14-method}}
    \item{getF14C}{\code{signature(object = "Model_14")}: ... } \code{\link{getF14C,Model_14-method}}
    \item{getF14R}{\code{signature(object = "Model_14")}: ... } \code{\link{getF14R,Model_14-method}}
    \item{getF14}{\code{signature(object = "Model_14")}: ... } \code{\link{getF14,Model_14-method}}
    \item{getReleaseFlux14}{\code{signature(object = "Model_14")}: ... } \code{\link{getReleaseFlux14,Model_14-method}}
	 }

Methods inherited from superclasses:

from class Model:

  \describe{
    \item{[}{\code{signature(x = "Model", i = "character", j = "missing", drop = "missing")}: ... } \code{\link{[,Model,character,missing,missing-method}}
    \item{getAccumulatedRelease}{\code{signature(object = "Model")}: ... } \code{\link{getAccumulatedRelease,Model-method}}
    \item{getC}{\code{signature(object = "Model")}: ... } \code{\link{getC,Model-method}}
    \item{getReleaseFlux}{\code{signature(object = "Model")}: ... } \code{\link{getReleaseFlux,Model-method}}
    \item{getTimes}{\code{signature(object = "Model")}: ... } \code{\link{getTimes,Model-method}}
	 }}
\title{Model_14}
\section{Superclasses}{\code{\link{Model-class}}\cr}
\section{Constructors}{	\code{\link{Model_14}}\cr}
