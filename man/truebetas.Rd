\name{truebetas}
\alias{truebetas}
\docType{data}
\title{
True betas used to simulate data in the choice data set named datar, which is used in the example.
}
\description{
True betas are effects-coded betas for two variables for 300 units.  The first variable is a four-level categorical and the second variable is a three-level categorical variable.  The latter is constrained to be non-decreasing.  These betas were used to simulate the choice data in the example data set named datar.
}
\usage{data(truebetas)}
\format{
  The format is:
 num [1:300, 1:8] 0.7314 0.0484 0.1874 0.3961 0.5678 ...
 - attr(*, "dimnames")=List of 2
  ..$ : NULL
  ..$ : chr [1:8] "A1B1" "A1B2" "A1B3" "A1B4" ...
}

\source{
The true betas were created using the code in the example.
}
\examples{
data(truebetas)
head(truebetas)
}
\keyword{datasets}
