\name{lazyData-package}
\alias{lazyData-package}
\alias{lazyData}
\docType{package}
\title{
 A LazyData Facility
}
\description{
Supplies a \code{LazyData} facility for packages which have data sets
but do not provide \code{LazyData}.  A single function is is included,
\code{requireData}, which is a drop-in replacement for
\code{base::require}, but carrying the additional functionality.
}
\details{
\tabular{ll}{
Package: \tab lazyData\cr
Type: \tab Package\cr
Version: \tab 1.0.3\cr
Date: \tab 2014-01-30\cr
License: \tab GPL-2\cr
}
If a package is attached with \code{requireData}, a check is made to see if a)
the package provides data and b) if the data sets are not made visible to
the user via \code{LazyData}.  If both are the case, the package is attached to
the search path, and in addition a second entry to the search path is
made immediately behind the package containing promises to load the data
sets should they be needed.  This keeps data sets out of the
global environment (unless they are modified), making them visible
without occupying memory (unless they are needed).

Using \code{requireData} a second time on the same package has the
effect of flushing any data sets brought into memory and reinstating
them as promises.
}
\author{
Bill Venables

Maintainer: Bill Venables <bill.venables@gmail.com>
}
\references{
None.
}
\keyword{ data }
\seealso{
  \code{\link{require}}, \code{\link{library}}, \code{\link[utils]{data}}
  \code{\link{delayedAssign}}
}
\examples{
\dontshow{
.Search <- function() {
  srch <- search()
  srch <- paste(format(srch),
                ifelse(grepl("^datasets:", srch), "<<-- data here", ""))
  noquote(as.matrix(srch))
}
}
requireData("mgcv") ## we assume has data sets but no LazyLoad
.Search()           ## show augmented search path

## > ls("datasets:mgcv")
##[1] "columb"       "columb.polys"
}
