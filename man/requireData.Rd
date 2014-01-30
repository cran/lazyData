\name{requireData}
\alias{requireData}
\title{
  Attach packages as required and expose non-LazyData data sets as promises.
}
\description{
  This function provides \code{LazyData} functionality for packages
  which do not provide it.  It acts as an enhanced substitute for the
  base packges \code{require} function.
}
\usage{
requireData(package = stop("you must specify a package"),
            lib.loc = NULL, quietly = TRUE, character.only = FALSE,
            warn.conflicts = TRUE, reallyQuietly = TRUE, ...)
}
\arguments{
  \item{package}{
    The name of the package whose attachment to the search path is
    required.  May me a name or a literal character string.
  }
  \item{lib.loc}{
    The path to the library holding the package.  As for
    \code{\link{require}}.
  }
  \item{quietly}{
    Logical: should the stanandard loading message be suppressed?
    Ignored if \code{reallyQuiet} is \code{TRUE}.
  }
  \item{character.only}{
    Logical: should the \code{package} argument be treated as a
    character string even if not literal?
  }
  \item{warn.conflicts}{
    Should objects masked by the attachment of the package be flagged?
    As for \code{\link{require}}.
    Ignored if \code{reallyQuiet} is \code{TRUE}.
  }
  \item{reallyQuietly}{
    Logical: should the \code{package} be loaded using
    \code{suppressPackageStartupMessages}?  If \code{TRUE}, the default,
    this will make the loading
    as quietly as possible, but will suppress potentially useful
    messages, such as masking information.
  }
  \item{\dots}{
    Additional arguments currently ignored.
}
}
\details{
  The only function this package provides, \code{requireData}, is a
  substitute for the base function \code{require}.  If the package is
  not already on the search path, it attaches it.  In addition, if the
  package a) has data sets and b) does NOT use the LazyData facility,
  then an additonal entry is made on the search path.  This is an
  unlocked environment initially populated by `promises'
  (using \code{delayedAssign}) to load a copy of the data set into
  memory if and when it is needed.

  This is done recursively for all packages attached to the search path
  via dependencies.

  If the package appears on the search path as \code{package:<pkg>} at
  positon \code{p}, then any exposed data set objects appear at postion
  \code{p+1} as \code{datasets:<pkg>}.  The package environment is
  locked, but the datasets environment is not.  If a data set object is
  needed at any stage, it is brought silently into memory at position
  \code{p+1} on the search path.

  Any further call to \code{requireData(<pkg>)} will reinstate the
  datasets as promises, thus potentially freeing memory.

  The intended effect is to make data sets more conveniently available
  to users, to make the use of the \code{data} function largely
  unnecessary, and to avoid cluttering the global environment with
  copies of passive data set objects.
}
\value{
  \code{TRUE} if the package was successfully attached and \code{FALSE}
  otherwise.
}
\references{
  Null
}
\author{
Bill Venables
}

\seealso{
  \code{\link{require}}, \code{\link[utils]{data}}
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

\keyword{ data }
