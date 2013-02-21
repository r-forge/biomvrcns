\name{sojournAnno}
\alias{sojournAnno}
\title{
	Estimation sojourn distribution parameters from posterior annoation data distribution
}
\description{
	Using prior information from previous studies or annoation data  to determine sojourn distribution parameters
}
\usage{
sojournAnno(xAnno, soj.type = "gamma", pbdist = NULL)
}

\arguments{
  \item{xAnno}{
	a \code{GRanges} / \code{GRangesList} /  \code{TranscriptDb} object, with its first meta column to represent the possible type of the range
}
  \item{soj.type}{
	type of the sojourn distribution, following types are supported: 'gamma', 'pois', 'nbinom'
}
  \item{pbdist}{
	average distance between neighbouring features
}
}
\details{
	Be default, the hidden-semi markov model implemented in this package uses a uniform prior for the initial sojourn distribution. However user can provide custom data from related studies to learn the prior of the sojourn distribution. The number of possible state will also be estimated from the unique level of feature type in the first meta column of \code{xAnno}.
}
\value{
	a list object containing the sojourn distribution parameter
\item{\code{type}}{type of the sojourn distribution}
\item{\code{fttypes}}{unique levels of the types stored in the first meta column of \code{xAnno}, alphabetically sorted}
\item{\code{J}}{number of possible states}
\item{\\code{...}}{distribution parameters, 'lambda' and 'shift' for 'pois'; 'size', 'mu' and 'shift' for 'nbinom'; 'scale' and 'shape' for 'gamma'}
}

\author{
	Yang Du
}

\examples{
	library(TxDb.Hsapiens.UCSC.hg19.knownGene)
	txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
	soj<-sojournAnno(txdb, soj.type='pois')
}