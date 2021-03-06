\name{fW.Daycent1}
\alias{fW.Daycent1}
\usage{fW.Daycent1(swc,
a=0.6,
b=1.27,
c=0.0012,
d=2.84,
partd=2.65,
bulkd=1,
width=1)}
\arguments{
\item{swc}{A scalar or vector with soil water content of a soil layer (cm).}
\item{a}{Empirical coefficient. For fine textured soils a = 0.6. For coarse textured soils a = 0.55.}
\item{b}{Empirical coefficient. For fine textured soils b = 1.27. For coarse textured soils b = 1.70.}
\item{c}{Empirical coefficient. For fine textured soils c = 0.0012. For coarse textured soils c = -0.007.}
\item{d}{Empirical coefficient. For fine textured soils d = 2.84. For coarse textured soils d = 3.22.}
\item{partd}{Particle density of soil layer.}
\item{bulkd}{Bulk density of soil layer (g/cm^3).}
\item{width}{Thickness of a soil layer (cm).}
}
\description{Calculates the effects of Soil Water Content on decomposition rates according to the Daycent Model.}
\references{Kelly, R. H., W. J. Parton, M. D. Hartman, L. K. Stretch, D. S. Ojima, and D. S. Schimel (2000), 
Intra-annual and interannual variability of ecosystem processes in shortgrass steppe, J. Geophys. Res., 105.}
\title{Effects of moisture on decomposition rates according to the DAYCENT model}
\value{A data frame with values of water filled pore space (wfps) and effects of soil water content on decomposition rates. Both vectors are unitless. }
