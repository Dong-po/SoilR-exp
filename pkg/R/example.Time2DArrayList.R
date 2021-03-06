
# vim:set ff=unix ts=2 sw=2:
### An example used in tests and other examples.
example.Time2DArrayList<- function # create an example TimeMap from 2D array
(){
# We could also imagine time series data stored in an array consisting of
	# many stacked vectors, one for each ti`me step.
	# Let us sythesize such a dataset:

	times <- seq(1,10,by=0.1)
	a <- array(dim=c(2,length(times)))
	a[1,] <- -0.1*(sin(times)+1.1)
	a[2,] <- -0.2*(sin(times)+1.2)
  return(list(times=times,data=a))
}
