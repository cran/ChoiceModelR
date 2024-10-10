\name{ChoiceModelR-package}
\alias{ChoiceModelR-package}
\docType{package}
\title{Choice Modeling in R}
\description{
Estimates coefficients of a Hierarchical Bayes Multinomial Logit Model
}
\details{
\tabular{ll}{
Package: \tab ChoiceModelR\cr
Type: \tab Package\cr
Version: \tab 1.3.1\cr
Date: \tab 2024-10-08\cr
License: \tab GPL (>=3)\cr
LazyLoad: \tab yes\cr
}
The ChoiceModelR package includes the function choicemodelr that implements an MCMC algorithm to estimate a hierarchical multinomial logit model with a normal heterogeneity distribution.  The algorithm uses a hybrid Gibbs Sampler with a random walk metropolis step for the multinomial logit (MNL) coefficients for each unit.  Means of the distribution of heterogeneity can optionally be modeled as a linear function of unit descriptor variables.

The dependent variable can be either discrete or a share.  If the dependent variable y_i is a share (0 to 1 inclusive), instead of discrete (1 ,..., nalt; where nalt is the number of alternatives in choice set), then each choice observation is replicated wgt times with alternative i chosen in wgt*y_i observations.  Independent variables can be continuous or discrete, with order constraints imposed on estimated coefficients.

The basic structure of the code for this algorithm was derived from the rhierMnlRwMixture program of the bayesm package available at cran.r-project.org.  Significant modifications were made to greatly reduce the run time, to allow constraints on estimated parameters, handle varying number of choice observations, handle varying number of choice alternatives within each choice scenario, and to optionally allow the dependent variable to be a share (between 0 and 1) instead of discrete (1 ,..., nalt; where nalt is the number of alternatives in choice set).

Note: Version 1.3.1 fixes a bug in version 1.3.0:
(1) When restart=TRUE, demos were included and no constraints were included, an error prevented estimation.  This bug was fixed.

}
\author{
Ryan Sermas, assisted by John V. Colias Ph.D., at Decision Analyst, Inc.
\email{DecisionAnalystR@decisionanalyst.com}

Maintainer: John V. Colias <jcolias@decisionanalyst.com>}
\references{
Rossi, Peter; Allenby, Greg M.; and McCulloch, Robert (2005), Bayesian Statistics and Marketing, John Wiley and Sons.
}
\keyword{ package }
\keyword{ models }
\keyword{ multivariate }

