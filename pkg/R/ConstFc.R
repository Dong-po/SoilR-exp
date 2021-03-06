#
# vim:set ff=unix expandtab ts=2 sw=2:

setClass(
   Class="ConstFc",
   contains="Fc",
   slots=c(values="numeric")
)

setMethod(
    f="getValues",
    signature="ConstFc",
    definition=function# extract the format string
			(object ##<< object containing information aboutn the format that could be Delta14C or AFM (Absolute Fraction Modern) for instance
			){
       ### the function just yields the format as a string
        return(object@values)
    }
)
setMethod(
   f= "Delta14C",
      signature("ConstFc"),
      definition=function# convert to Absolute Fraction Normal values  
	(F##<< object containing the values in any format
	){
	### convert a ConstFc object containing values in any supported format to the appropriate Absolute Fraction Modern values.
	f=F@format
        targetFormat="Delta14C"
        if (f==targetFormat){
	   # do nothing
	   return(F)
	}
	if (f=="AbsoluteFractionModern"){
	 f_afn=F@values
	 f_d14C=Delta14C_from_AbsoluteFractionModern(f_afn)
	 D14C=F
	 D14C@values=f_d14C
	 D14C@format=targetFormat
	 return(D14C)
	} 
      stop("conversion not implemented for this format")
      }	 
)

setMethod(
   f= "AbsoluteFractionModern",
      signature("ConstFc"),
      definition=function# convert to Absolute Fraction Normal values  
	(F ##<< object containing the values in any format
	){
	### convert a ConstFc object containing values in any supported format to the appropriate Absolute Fraction Modern values.
	f=F@format
        targetFormat="AbsoluteFractionModern"
        if (f==targetFormat){
	   # do nothing
	   return(F)
	}
	if (f=="Delta14C"){
	 f_d14C=F@values
         f_afn=AbsoluteFractionModern_from_Delta14C(f_d14C)
	 AFM_tm=F
	 AFM_tm@values=f_afn
	 AFM_tm@format=targetFormat
	 return(AFM_tm)
	} 
      stop("conversion not implemented for this format")
      }	 
)

 ConstFc <- function # creates an object containing the initial values for the 14C fraction needed to create models in SoilR
     ### The function returns an object of class ConstFc which is a building block for any 14C model in SoilR.
     ### The building blocks of a model have to keep iformation about the formats their data are in, because the high level function dealing wiht the models have to know. This function is actually a convienient wrapper for a call to R's standard constructor new, to hide its complexity from the user.
     (
     values=c(0),  ##<< a numeric vector
     format="Delta14C"   ##<< a character string describing the format e.g. "Delta14C"
     )
     {
     
 	F0=new(Class="ConstFc",values=values,format=format)
 	return(F0)
 	### An object of class ConstFc that contains data and a format description that can later be used to convert the data into other formats if the conversion is implemented.
 }
