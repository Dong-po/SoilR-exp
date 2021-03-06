\name{fT.Arrhenius}
\alias{fT.Arrhenius}
\usage{fT.Arrhenius(Temp,
A=1000,
Ea=75000,
Re=8.3144621)}
\arguments{
\item{Temp}{A scalar or vector containing values of temperature (in degrees Kelvin) for which the effects on decomposition rates are calculated.}
\item{A}{A scalar defining the pre-exponential factor.}
\item{Ea}{A scalar defining the activation energy in units of J mol^-1.}
\item{Re}{A scalar defining the universal gas contant in units of J K^-1 mol^-1.}
}
\description{Calculates the effects of temperature on decomposition rates according to the Arrhenius equation.}
\title{Effects of temperature on decomposition rates according the Arrhenius equation}
\value{A scalar or a vector containing the effects of temperature on decomposition rates (unitless).}
