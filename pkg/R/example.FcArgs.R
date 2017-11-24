
# vim:set ff=unix ts=2 sw=2:
example.FcArgs<- function(){
### We present all possibilities to define  \code{\linkS4class{Fc}} objects.
	possibleArgs <- list(

    # a constant 
  	FC_number_afm 			=  ConstFc(5,format='afn'),
  	FC_number_Delta14C	=  ConstFc(5,format='Delta14C'),
		# a function
  	FC_func_afm					=	UnBoundFc(function(t){0.2*(sin(t)+2)},format='afn'),
  	FC_func_Delta14C		=	UnBoundFc(function(t){0.2*(sin(t)+2)},format='Delta14C'),
		# time series data provided as lists
		# of either vector and 3Darray
  	FC_list_times_Array	 =example.Time3DArrayList(),
		# or vector an list of matrices
  	FC_list_times_Matrice=example.nestedTime2DMatrixList(),
		
		# internally GeneralDecompOp will convert all its arguments into 
		# classes provided by SoilR
		# You can also do that directly.
		# This is sometimes necessary for non-standard applications or for debugging.
  	FC_TimeMap           =TimeMap(example.Time3DArrayList()),
  	FC_ConstlinDecompOp  =example.ConstlinDecompOpFromMatrix(),
  	FC_BoundLinDecompOp  =example.2DBoundLinDecompOpFromFunction(),
  	FC_UnBoundLinDecompOp=example.2DUnBoundLinDecompOpFromFunction()
	)
	return(possibleArgs)
}
