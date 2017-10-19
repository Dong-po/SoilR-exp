
# vim:set ff=unix ts=2 sw=2:
### Create a 2-dimensionsonal example of a BoundInflux object
example.2DBoundInFluxFromFunction <- function
# 2D BoundInflu examplex
(){
	BoundInFlux(
		function(t){
			c(
				(1+sin(t)),
				(2+sin(2*t))
			)
		},
		0,
		10
	)
}
