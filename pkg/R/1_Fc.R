#
# vim:set ff=unix expandtab ts=2 sw=2:

    ### The \eqn{^{14}C}{14C} fraction is a necessary ingredient of any \code{\linkS4class{Model_14}} object.
    ### In the most general case it is a real valued function of time, accompanied     
    ### by a string describing the unit or format (i.e. "Delta14C" or "afn" for Absolute Fraction Modern) .
    ### In the most simple case it is constant real number plus format.
setClass( 
    Class="Fc",
    ,
    contains="VIRTUAL"
)
#-------------------------------------------------------------------------
setMethod(
  f="check",
  signature="Fc",
  definition= function#check for unreasonable parameters or unsupported formats
  ###  The atmospheric C14 data can be represented in more than one format 
  ###  The function checks if the user required format is supported at the moment
  (object ##<< the object to be tested
  )
  {
     res=TRUE
     supported_formats=supported14CFractionFormats()
     f=object@format
  #   print(paste("format=",f))
     if (!any(grepl(f,supported_formats))){
        err_str=cat("The required format:",f," describing the atmospheric c_14 fraction is not supported.\n 
     	     The supported formats are: ",supported_formats,". \n",sep="")
        stop(simpleError(err_str))
        return(res)
     }
  }
)
