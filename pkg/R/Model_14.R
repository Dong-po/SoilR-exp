#
# vim:set ff=unix expandtab ts=2 sw=2:
#setMethod(
#   f= "getAccumulatedRelease14",
#      ### This function integrates the release Flux over time
#      signature= "Model_14",
#      definition=function(object){
#      times=object@times
#      R=getReleaseFlux14(object)
#      n=ncol(R)
#      #transform the array to a list of functions of time by
#      #intepolating it with splines
#      if (n==1) {
#          Rfuns=list(splinefun(times,R))
#      }
#      else{
#        Rfuns=list(splinefun(times,R[,1]))
#        for (i in 2:n){
#            Rf=splinefun(times,R[,i])
#            Rfuns=append(Rfuns,Rf)
#        }
#      }
#      #test=Rfuns[[1]]
#      #now we can construct the derivative of the respiration as function of time
#      #as needed by the ode solver
#      rdot=function(y,t0){
#           # the simples possible case for an ode solver is that the ode is
#           # just an integral and does not depend on the value but only on t
#           # This is the case here
#           rv=matrix(nrow=n,ncol=1)
#           for (i in 1:n){
#               #print(Rfuns[i])
#               rv[i,1]=Rfuns[[i]](t0)
#           }
#           return(rv)
#      }
#      sVmat=matrix(0,nrow=n,ncol=1)
#      Y=solver(object@times,rdot,sVmat,object@solverfunc)
#      #### A matrix. Every column represents a pool and every row a point in time
#      return(Y)
#   }
#)

correctnessOfModel14=function#check for unreasonable input parameters to constructor
### The parameters used by the function \code{\link{GeneralModel_14}} in SoilR have a physical meaning, 
### and can therefore not be arbitrary.
### This functions tests some of the obvious constraints 14C specific issues.
(object ##<< the object to be tested
)
{
# check only the Model14 specific issues since initialize calls validObject which in turn calls the validity methods of the parent classes
t_min=min(object@times)
t_max=max(object@times)
atm_c14 <- object@c14Fraction
tA_min=getTimeRange(atm_c14)["t_min"]
tA_max=getTimeRange(atm_c14)["t_max"]
    if (t_min<tA_min) {
        stop(simpleError(sprintf("You ordered a timeinterval that starts earlier (t_min=%s) than the interval your atmospheric 14C fraction is defined for (tA_min=%s). \n Have look at the object or the data it is created from",t_min,tA_min)))
    }
    if (t_max>tA_max) {
        stop(simpleError(sprintf("You ordered a timeinterval that ends later (tmax=%s) than the interval your  your atmospheric 14C fraction is defined for (tA_max=%s). \n Have look at the object or the data it is created from",t_max,tA_max)))
    }
}

#------------------------------------------------------------------------------------
### This class  extends \code{\linkS4class{Model}}, 
### to represent \eqn{^{14}C}{14C} decay. 
### \enumerate{
###  \item 
###  \itemize{
###   \item As \code{\linkS4class{Model}} it contains all the components 
###     that are needed to solve the
###     initial value problem for the pool contents \eqn{\vec{C}}{C=(C_1,...C_n)^t}. 
###   \item It adds the components that are needed to solve the
###   additional initial value problem for the \eqn{^{14}C}{14C} contents of the pools
###   \eqn{\vec{^{14}C}}{14C=(14C_1,...,14C_n)^t}. 
###  } 
###  \item 
###  \itemize{
###   \item 
###   It provides the single argument for all the functions 
###   that are available for an argument of class \code{\linkS4class{Model}}.
###   \item 
###   and for additional functions 
###   that are available to compute various results from the solution of the additional 
###   initial value problem for \eqn{^{14}C}{14C}. 
###   (See subsection \code{Methods} and the examples.)
###  }
###}
setClass(# Model_14
    Class="Model_14",
    contains="Model",
    representation=representation(
        #"Model",                          
        c14Fraction="BoundFc",
        c14DecayRate="numeric",
        initialValF="ConstFc"
    ) , 
    validity=correctnessOfModel14 #set the validating function
    ##details<<
    ##    The original initial value problem for \eqn{\vec{C}}{(C_1,...,C_n)^t)} as decribed in the docomentation of the superclass \code{\linkS4class{Model}}
    ##    was given by:
    ## \itemize{
    ##   \item
    ##    \eqn{ \frac{d \mathbf{C}(t)}{dt} = \mathbf{I}(t) + \mathbf{A}(t) \mathbf{C}(t)}{dC(t)/dt = I(t) + A(t)C(t) } 
    ##   \item
    ##     the initial Values \eqn{\vec{C}_0=\vec{C}(t_0)}{C_0=C(t_0)} 
    ##   \item 
    ##     for the times \eqn{\{t_0,....t_m\}}{{t_0,....,t_m}}.
    ##  }
    ##The additional initial value problem for \eqn{^{14}C}{14C} is represented by additional parameters:
    ## \itemize{
    ##   \item
    ##    a second ordinary differential equation:
    ##    \deqn{\frac{d ^{14} \mathbf{C}(t)}{dt} = F(t) \mathbf{I}(t) + \mathbf{A}(t) ^{14} \mathbf{C}(t)-k_{14}\; ^{14}\mathbf{C}(t) }{d 14C/dt = F(t) I(t) + A(t)C(t)-k_14 C(t)} 
    ##    with initial values \eqn{^{14}\mathbf{C}_0=F_0 \mathbf{C}_0}{14C_0=F_0 C_0} with:
    ##      \item
    ##        the time dependent \eqn{^{14}C}{14C} fraction \eqn{F(t)}{F(t)}, 
    ##      \item
    ##        the constant \eqn{^{14}C}{14C} fraction of the initial pool contents \eqn{F_0}{F_0},
    ##      \item
    ##        the \eqn{^{14}C}{14C} decay rate \eqn{k_{14}}{k_14}.
    ## }
    ## In an object of class \code{\linkS4class{Model_14}}  the components are represented as follows:
    ## \itemize{
    ##   \item
    ##   The time-dependent matrix valued function \eqn{\vec{A}(t)}{A(t)} is represented by an object 
    ##   of a subclass of \code{\linkS4class{DecompOp}} (for decomposition operator). 
    ##   Such objects can be created in different ways from functions, matrices or data. 
    ##   (see the subclasses of \code{\linkS4class{DecompOp}} and especially their \code{Constructors} sections.  
    ##   and the \code{examples} section of this help page.
    ##   \item 
    ##   The vector-valued time-dependent function \eqn{\vec{I}(t)}{I(t)} is in SoilR represented by an object of a subclass of class \code{\linkS4class{InFlux}}. 
    ##   Such objects can also be created from functions, constant vectors and data. 
    ##   (see the subclasses of \code{\linkS4class{InFlux}} and especially their \code{Constructors} sections.  
    ##   \item 
    ##   The initial values for \eqn{\mathbf{C}_0}{C} are represented by a numeric vector 
    ##   \item 
    ##   The value for the \eqn{^{14}\mathbf{C}}{14C} fraction of the initial \eqn{\mathbf{C}}{C} 
    ##   is represented as an object of class \linkS4class{ConstFc} which is
    ##   a subclass of \code{\linkS4class{Fc}} representing the \eqn{^{14}C}{14C} fraction \eqn{F}{F} and its unit. 
    ##   (Either "Delta14C" or "afn" for Absolute Fraction Normal)
    ##   \item 
    ##   The value for the \eqn{^{14}\mathbf{C}}{14C} fraction of the input \eqn{\mathbf{I}(t)}{I(t)} is also represented
    ##   as an object of a subclass of \code{\linkS4class{Fc}}. It can be time dependent or constant.
    ## }
)
#-------------------------------Constructors -----------------------------------------------------
setMethod(
    f="initialize",
    signature=c("Model_14"),
    definition=function #An internal constructor for \code{Model_14} objects not recommended to be used directly in user code.
    ### This method implements R's initialize generic for objects of class \code{Model_14} and is not intended as part of the public interface to SoilR. 
    ### It may change in the future as the classes implementing SoilR may
    ### It is called whenever a new object of this class is created by a call to \code{new} with the first argument \code{Model_14}.
    ### It performs some sanity checks of its arguments and in case those tests pass returns an object of class \code{Model_14} 
    ### The checks can be turned off.( see arguments)

    ##details<<  Due to the mechanism of S4 object initialization (package "methods")
    ## \code{new} always calls \code{initialize}. 
    ## (see the help pages for initialize and initialize-methods for details)  
    
    ## All other constructors of class \code{Model_14} have to call \code{new("Model_14,..) at some point and thus call this method indirectly. 
    ## Accordingly this method is the place to perform those checks \emph{all} objects of class \code{Model_14} should pass.
    ## Some of those checks are explained in the examples below.
    ## In some (rare) circumstances it might be necessary to override the checks and force the object to be created 
    ## although it does not seem meaningfull to the internal sanity checks. 
    ## You can use the "pass" argument to enforce this.
    (
        .Object,              ##<< the Model_14 object itself
        times=c(0,1),         ##<< The points in time where the solution is sought 
        mat=ConstLinDecompOp(matrix(nrow=1,ncol=1,0)),##<< A decomposition Operator of some kind 
        initialValues=numeric()
        ,
        initialValF=ConstFc(values=c(0),format="Delta14C")      ##<< An object of class ConstFc containing a vector with the initial values of the radiocarbon fraction for each pool and a format string describing in which format the values are given.
        ,
        inputFluxes= BoundInFlux(
            function(t){
                return(matrix(nrow=1,ncol=1,1))
            },
            0,
            1
        )
        ,
        c14Fraction=BoundFc(
            function(t){
                return(matrix(nrow=1,ncol=1,1))
            },
            0,
            1
        )   ##<< A BoundFc object consisting of  a function describing the fraction of C_14 in per mille.
        ,
        c14DecayRate=0
        ,
        solverfunc=deSolve.lsoda.wrapper
        ,
        pass=FALSE
     ){
        .Object <- callNextMethod(.Object,times,mat,initialValues,inputFluxes,solverfunc,pass=pass)
        .Object@initialValF=initialValF
        .Object@c14Fraction=c14Fraction
        .Object@c14DecayRate=c14DecayRate
        if (pass==FALSE) validObject(.Object) #call of the ispector if not explicitly disabled (This will automatically call the inspectors of the superclasses and also correctnessOfModel14 since this function is 
        return(.Object)
    }
)
#------------------------------------------------------------------------------------
Model_14 <- function #general  constructor for class Model_14
  ### This method tries to create an object from any combination of arguments 
  ### that can be converted into  the required set of building blocks for the Model_14
  ### for n arbitrarily connected pools.
  
  (t,			##<< A vector containing the points in time where the solution is sought.
   A,			##<< something that can be converted by \link{GeneralDecompOp} to any of the available subclasses of \code{\linkS4class{DecompOp}}. 
   ivList,		##<< A vector containing the initial amount of carbon for the n pools. The length of this vector is equal to the number of pools and thus equal to the length of k. This is checked by an internal  function. 
   initialValF, ##<< An object equal or equivalent to class ConstFc containing a vector with the initial values of the radiocarbon fraction for each pool and a format string describing in which format the values are given.
   inputFluxes, ##<<  something that can be converted by \link{GeneralInFlux} to any of the available subclasses of \linkS4class{InFlux}.
   inputFc,##<< An object describing the fraction of C_14 in per mille (different formats are possible)
   c14DecayRate =-0.0001209681 ,  ##<< the rate at which C_14 decays radioactivly. If you don't provide a value here we assume the following value: k=-0.0001209681 y^-1 . This has the side effect that all your time related data are treated as if the time unit was year. Thus beside time itself it also  affects decay rates the inputrates and the output 
   solverfunc=deSolve.lsoda.wrapper,		##<< The function used by to actually solve the ODE system. This can be \code{\link{deSolve.lsoda.wrapper}} or any other user provided function with the same interface. 
   pass=FALSE  ##<< Forces the constructor to create the model even if it is invalid 
   )
  {
     obj=new(Class="Model_14",t,GeneralDecompOp(A),ivList, initialValF,GeneralInFlux(inputFluxes),inputFc,c14DecayRate=c14DecayRate,solverfunc=solverfunc,pass=pass)
     return(obj)
     ### A model object that can be further queried. 
     ##seealso<< \code{\link{TwopParallelModel}}, \code{\link{TwopSeriesModel}}, \code{\link{TwopFeedbackModel}} 
     
     ##exampleFunctionsFromFiles<< 
     ## inst/tests/requireSoilR/runit.all.possible.Model.arguments.R test.all.possible.Model.arguments
     ## inst/examples/ModelExamples.R CorrectNonautonomousLinearModelExplicit 
  }
#------------------------------------------------------------------------------------
setMethod(
   f= "getC14",
      signature= "Model_14",
      definition=function(object){
      ### This function computes the value for \eqn{^{14}C}{14C} (mass or concentration ) as function of time
      ns=length(object@initialValues)
      #get the coefficient matrix TimeMap 
      Atm=object@mat
      A=getFunctionDefinition(Atm)
      # add the C14 decay to the matrix which is done by a diagonal matrix which does not vary over time
      # as default we assume a half life of th=5730 years
      k=object@c14DecayRate
      m=diag(rep(k,ns),nrow=ns) # Need to specify the dimension of the matrix otherwise doesn't work for n=1.
      A_C14=function(t){
          Aorg=A(t)
          newA=Aorg+m
          return(newA)
      }
      #get the Inputrate TimeMap 
      itm   <- object@inputFluxes
      input <- getFunctionDefinition(itm)
      #get the C14 fraction 
      Fctm  <- object@c14Fraction
      F0    <- object@initialValF
      # To do the computations we have to convert the atmospheric C14 fraction into 
      # a format that ensures that no negative values occur because this is assumed
      # by the algorithms that will blow up the solution if this assumption is not 
      # justified.
      # To this end we convert everything else to the "Absolute Fraction Modern" format
      # that ensures positive values
      Fctm  <- AbsoluteFractionModern(Fctm)
      F0    <- AbsoluteFractionModern(F0)
      
      Fc=getFunctionDefinition(Fctm)
      input_C14=function(t){
          #we compute the C14 fraction of the input
          return(Fc(t)*input(t))
      }
      ydot=NpYdot(A_C14,input_C14)
      #the initial Values have to be adopted also because
      #in the following computation they describe the intial amount of C_14
      #To do so we multiply them with the value of Fc at the begin of the computation 
      inivals=getValues(F0)
      
      sVmat=matrix(inivals*object@initialValues,nrow=ns,ncol=1) # We use here the Hadarmard (entry-wise) product instead of matrix multiplication. It works for both 
      # cases where F0 is a scalar of vector
      Y=solver(object@times,ydot,sVmat,object@solverfunc) 
      ### A matrix. Every column represents a pool and every row a point in time
      return(Y)
   }
)
setMethod(
   f= "getF14",
      signature= "Model_14",
      definition=function #radiocarbon
      ### Calculates the radiocarbon fraction for each pool at each time step.
      ### 
      (
      object ##<< The model 
      ){
      C=getC(object) ### we use the C here
      C14=getC14(object) ### we use the C14 here
      fr=C14/C
      ##<< description  since the result is always in AbsoluteFractionModern we have to convert it to Delta14C
      fr=Delta14C_from_AbsoluteFractionModern(fr)
      return(fr)
      ### A matrix of dimension n x m; i.e. n time steps as rows and m pools as columns.
   }
)
setMethod(
   f= "getReleaseFlux14",
      signature= "Model_14",
      definition=function # 14C respiration rate for all pools 
      ### 
      ### The function computes the \eqn{^{14}C}{14C} release flux ( mass per time ) for all pools.
      ### Note that the respiration coefficients for \eqn{^{14}C}{14C} 
      ### do not change in comparison to the total C case.
      ### The fraction of \eqn{^{14}C}{14C} lost by respiration 
      ### is not greater for \eqn{^{14}C}{14C} 
      ### although the decay is faster due to the contribution of radioactivity.
      (
        object ##<< the model.
      )
      {
      C14=getC14(object) ### we use the C14 here
      times=object@times
      Atm=object@mat
      A=getFunctionDefinition(Atm)
      n=length(object@initialValues)
      #print(n)
      rfunc=RespirationCoefficients(A)
      #rfunc is vector valued function of time
      if (n==1) { r=matrix(ncol=n,sapply(times,rfunc))}
      else {r=t(sapply(times,rfunc))}
      #print("dim(r)=")
      #print(dim(r))
      R=r*C14
      # now compute the sum of every row
      

      ### A matrix. Every column represents a pool and every row a point in time
      return(R)
   }
)


#Added by C. Sierra, 28/4/2012
setMethod(
  f= "getF14R",
  signature= "Model_14",
  definition=function # average radiocarbon fraction weighted by carbonrelease 
    ### Calculates the average radiocarbon fraction weighted by the amount of carbon release at each time step. 
    (
     object ##<< an object

     ){
    R=getReleaseFlux(object) ### we use the C14 here
    R14=getReleaseFlux14(object) ### we use the C14 here
    fr=rowSums(R14)/rowSums(R)
    ##description<<  \eqn{\overline{F_R}=\frac{\sum_{i=1}^{n}{^{14}R_i}}{\sum_{i=1}^{n}{R_i}}}{(14R_1(t)+...+14R_n(t)) )/(R_1(t)+...R_n(t)))}
    ##description<< Where \eqn{^{14}R_i(t)}{14R_i(t)} is the time dependent release of \eqn{^{14}C}{14C} of pool \eqn{i} and \eqn{R_i(t)}{R_i(t)} the release of all carbon isotops of pool \eqn{i}.   
    ##description<< Since the result is always in Absolute Fraction Modern format wie have to convert it to Delta14C
    fr=Delta14C_from_AbsoluteFractionModern(fr)
    #print(dim(C))
    return(fr)
    ### A vector  of length n with the value of \eqn{\overline{F_R}}{FR} for each time step.
  }
  )
setMethod(
  f= "getF14C",
  signature= "Model_14",
  definition=function# read access to the models F14C variable 
  ### The model was created with a F14C object to describe the atmospheric 14C content. This method serves to investigate those settings from the model.
  (
  object
  ### a Model_14 object
  ){
    C=getC(object) ### we use the C14 here
    C14=getC14(object) ### we use the C14 here
    fr=rowSums(C14)/rowSums(C)
    fr=Delta14C_from_AbsoluteFractionModern(fr)
    #print(dim(C))
    ### A matrix. Every column represents a pool and every row a point in time
    return(fr)
  }
  )

