
# vim:set ff=unix ts=2 sw=2:
### An example used in tests and other examples.
example.nestedTime2DMatrixList <- function # create an example nested list that can be 
(){
# We could imagine time series data stored in an array consisting of
	# many stacked matrices, one for each ti`me step.
  # we synthesize such data
	times <- seq(0,10,by=1)
	matFunc <- function(t){matrix(nrow=2,byrow=TRUE,c(-2*(sin(t*pi/2)+3),1,0,-3*(sin(t*pi/2)+3)))}

	matList <- lapply(times,matFunc)
	nestedList <-list(times=times,data=matList) 
  return(nestedList)
}
