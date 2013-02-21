\name{splitFarNeighbour}
\alias{splitFarNeighbour}
\title{
	Split segments if long gaps exist between feature position
}
\description{
	Split segments if long gaps exist between feature position
}
\usage{
splitFarNeighbour(intStart = NULL, intEnd = NULL, xpos = NULL, xrange = NULL, maxgap = Inf, minrun = 1)
}

\arguments{
  \item{intStart}{
	indices of start for each segment 
}
  \item{intEnd}{
	indices of end for each segment 
}
  \item{xpos}{
	position vecter, the distance of neighbouring features will be counted as point to point
}
  \item{xrange}{
	IRanges / GRanges object for the positions, the the distance of neighbouring features will be counted as end to start.
}
  \item{maxgap}{
	maximum distance between neighbouring features
}
  \item{minrun}{
	when spliting, the minimum length of the features spanning, which half will be ignored if shorter.
}
}

\value{
	a list object containing the start and end indices for new segments
	\item{IS}{the start indices for new segments}
	\item{IE}{the end indices for new segments}
}


\examples{
	set.seed(123)
	pos<-cumsum(rnbinom(20, size=10, prob=0.01))
	splitFarNeighbour(intStart=c(1, 10), intEnd=c(6, 18), xpos=pos, maxgap=1000)
}