\name{biomvRseg}
\alias{biomvRseg}
\title{
	Homogenous segmentation of multi-sample genomic data
}
\description{
 The function will perform a two stage segmention on multi-sample genomic data from array experment or high throughput sequencing data.
}
\usage{
biomvRseg(x, maxk=NULL, maxbp=NULL, maxseg=NULL, xPos=NULL, xRange=NULL, usePos='start', family='norm', penalty='BIC', twoStep=TRUE, segDisp=FALSE, useMC=FALSE, useSum=TRUE, comVar=TRUE, maxgap=Inf, tol=1e-06, grp=NULL, clusterm=NULL, na.rm=TRUE)
}

\arguments{
  \item{x}{
	input data matrix, or a \code{GRanges} object with input stored in the meta \code{DataFrame}
}
  \item{maxk}{
	maximum length of stay for the sojourn distribution 
}
  \item{maxbp}{
	maximum length of stay in bp for the sojourn distribution, given positional information specfied in \code{xPos} / \code{xRange}
}
  \item{maxseg}{
	maximum number of segment the function will try
}

 \item{xPos}{
	a vecter of positons for each \code{x} row
}
  \item{xRange}{
	a \code{IRanges}/\code{GRanges} obejct, same length as \code{x} rows
}
  \item{usePos}{
	character value to indicate whether the 'start', 'end' or 'mid' point position should be used to estimate the sojourn distribution
}
  \item{family}{
	family of \code{x} distribution, only the following types are supported: 'norm', 'nbinom', 'pois'
}
  \item{penalty}{
  	 penalty method used for determining the optimal number of segment using likelihood, possible values are 'none','AIC','AICc','BIC','SIC','HQIC'
}
  \item{twoStep}{
	TRUE if a second stage merging will be performed after the initial group segmentation
}
  \item{segDisp}{
	TRUE if a segment-wise estimation of dispersion parameter rather than using a overall estimation
}
  \item{useMC}{
	TRUE if \code{\link{mclapply}} should be used to speed up the calculation for nbinom dispersion estimation
}
  \item{useSum}{
	TRUE if using grand sum across sample / x columns, like in the \code{tilingArray} solution
}
  \item{comVar}{
	TRUE if assuming common variance across samples (x columns)
}
  \item{maxgap}{
	max distance between neighbouring feature to consider a split
}
  \item{tol}{
	tolerance level of the likelihood change to determining the termination of the EM run
}
  \item{grp}{
	vector of group assignment for each sample, with a length the same as columns in the data matrix, samples within each group would be processed simutaneously if a multivariate emission distribution is avaliable
}
  \item{clusterm}{
	clusting method for prior grouping, possible values are 'ward','single','complete','average','mcquitty','median','centroid'
}
  \item{na.rm}{
	\code{TRUE} if \code{NA} value should be ignored 
}
}
\details{
	A homogeneous segmentation algorithm, using dynamic programming like in \code{tilingArray}; however capable of handling count data from sequencing.
}
\value{
	A \code{\link{biomvRCNS}} object:
    \item{\code{x}:}{Object of class \code{"GRanges"}, with range information either from real positional data or just indices, with input data matrix stored in the meta columns.} 
    \item{\code{res}:}{Object of class \code{"GRanges"} , each range represent one continous segment identified, with sample name slot 'SAMPLE' and segment mean slot 'MEAN' stored in the meta columns  }
    \item{\code{param}:}{Object of class \code{"list"}, list of all parameters used in the model run. }
}
\references{
	Piegorsch, W. W. (1990). Maximum likelihood estimation for the negative binomial dispersion parameter. Biometrics, 863-867.	
}

\seealso{
\code{\link{biomvRhsmm}}
}
\examples{
	data(coriell)
	xgr<-GRanges(seqnames=paste('chr', coriell[,2], sep=''), IRanges(start=coriell[,3], width=1, names=coriell[,1]))
	values(xgr)<-DataFrame(coriell[,4:5], row.names=NULL)
	xgr<-xgr[order(xgr)]
	resseg<-biomvRseg(x=xgr, mabp=1E5, maxseg=3, family='norm', grp=c(1,2))
}