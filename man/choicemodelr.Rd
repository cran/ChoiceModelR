% File src/library/choicemodelr/man/choicemodelr.Rd
\name{choicemodelr}
\alias{choicemodelr}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Choice Modeling in R}
\description{
Estimates coefficients of a Hierarchical Bayes Multinomial Logit Model
}
\usage{
choicemodelr(data, xcoding, demos, prior, mcmc, constraints, options)
}
\arguments{
  \item{data}{
Required.  A data frame.  The column variables of the data frame are as follows, where natts is the number of attributes; i.e., independent variables:

	UnitID     Set    Alt    X_1 ... X_natts    y\cr

The first column contains the ID of the unit (e.g. customer or survey respondent).  The second column contains the choice set number for the unit, where each choice set is an observation for the unit.  The third column contains the alternative number within the choice set.  The last column contains the dependent variable.\cr

If the dependent variable y is discrete, then the dependent variable takes a non-zero value only in the first row of the choice set data, and takes a value from 1 to the number of alternatives in the choice set.\cr

For example, the following 2 rows of the data frame data shows 2 choice sets for unitID=103322 , 3 alternatives per choice set, 3 independent variables X1 to X3, and a dependent variable y indicating choice of alternative 2 in the first choice set and alternative 3 in the second choice set.\cr

\tabular{ll}{
\tab 103322  1  1  4  6  1  2\cr
\tab 103322  1  2  1  1  1  0\cr
\tab 103322  2  1  3  6  1  3\cr
\tab 103322  2  2  4  8  1  0}

The next example is identical to the first example, except that the dependent variable is a share, indicating 30 percent and 40 percent for alternatives 1 and 2 of choice set 1.\cr

\tabular{ll}{
\tab 103322  1  1  4  6  1  0.3\cr
\tab 103322  1  2  1  1  1  0.4\cr
\tab 103322  2  1  3  6  1  0.5\cr
\tab 103322  2  2  4  8  1  0.5}

}
  \item{xcoding}{
Required.  A vector that specifies the way in which each attribute will be coded:

0 = categorical (effects coded)\cr
1 = continuous (the program mean centers the variable across the levels appearing in the data)

The order of attributes in xcoding must match the order of the attributes appearing in the data file.

}
  \item{demos}{
An \dQuote{ni by nz} matrix of demographic variables or unit characteristics, where \dQuote{ni} is the number of units and \dQuote{nz} is the number of unit-level demographic or descriptor variables.  

}
  \item{prior}{
list(mubar, Amu, df, v, deltabar, Ad)

mubar = prior mean of the distribution of mu; must be a vector of length equal to the number of attributes (default is a vector of zeros)

Amu  =  precision parameter (default is 0.01)

df = prior degrees of freedom (default is 5, must be \eqn{\ge} 2)

v = prior variance (default is 2, must be  \eqn{\ge} 0)

deltabar = prior mean of the distribution of delta; must be a vector of length equal to the number (nz) of unit descriptor variables in the upper level model (default is a vector of zeros with length nz)

Ad = precision parameter; must be a vector of length equal to natts * nz (default is 0)

}
  \item{mcmc}{
Required.  A list with 3 arguments: list(R, use, s).

R = total number of iterations of the Markov chain Monte Carlo (MCMC chain) to be performed (R is required).

use = the number of iterations to be used in parameter estimation (use is required).

s = a scaling parameter that is used to adjust the standard deviation of random draws of unit-level parameters during the random walk metropolis step of the MCMC chain.  Only specify s if you wish to keep a constant scaling parameter.  (By default, s = 0.1 and is adjusted at each iteration to keep acceptance of random draws of unit parameters at approximately 30 percent.)

}
  \item{constraints}{
A list of matrices containing the values 0, 1, and -1.  If specifying constraints, a constraints matrix must be specified for EVERY attribute. Simply declare a matrix of 0s for an unconstrained attribute.

Each matrix must be square with dimensions equal to the number of levels of the attribute it represents.  For a continuous attribute declare a 1 x 1 matrix containing the appropriate value.  The matrices are interpreted as follows: 

\itemize{
\item c1[i, j] = 1,  beta_i > beta_j
\item c1[i, j] = -1,  beta_i < beta_j
\item c1[i, j] = 0,  no constraint}

The lower-triangular and diagonal portions of the matrix have no meaning and values in these positions are ignored.\cr

For example, for a model with 3 attributes, set constraints = list(c1, c2, c3).

\tabular{ll}{
\tab c1 = matrix(c(0,-1,-1,-1,\cr
\tab 0,0,-1,-1,\cr
\tab 0,0,0,-1,\cr
\tab 0,0,0,0), ncol = 4, byrow = TRUE)}

\tabular{ll}{
\tab c2 = matrix(c(0,1,1,1,1,1,1,1,1,\cr
\tab 0,0,1,1,1,1,1,1,1,\cr
\tab 0,0,0,1,1,1,1,1,1,\cr
\tab 0,0,0,0,1,1,1,1,1,\cr
\tab 0,0,0,0,0,1,1,1,1,\cr
\tab 0,0,0,0,0,0,1,1,1,\cr
\tab 0,0,0,0,0,0,0,1,1,\cr
\tab 0,0,0,0,0,0,0,0,1,\cr
\tab 0,0,0,0,0,0,0,0,0), ncol = 9, byrow = TRUE)}

\tabular{ll}{
\tab c3 = matrix(c(0,1,1,1,\cr
\tab 0,0,1,1,\cr
\tab 0,0,0,1,\cr
\tab 0,0,0,0), ncol = 4, byrow = TRUE)}

}
  \item{options}{
A list with 5 possible arguments:  list(none, save, keep, wgt, restart).\cr

\bold{none}:  set to TRUE to estimate a none parameter, and the data does not include a row for nono (i.e., no choice)  (default is FALSE).

\bold{save}:  set to TRUE to save draws of betas, deltas, mu, rooti, and the log likelihood (default is FALSE).

\bold{keep} = the thinning parameter defining the number of random draws to save (default is 10).

\bold{wgt} = the choice-set weight parameter; possible values are 1 to 10.  This parameter only needs to be specified if estimating a model using a share dependent variable (default is 5).

\bold{restart}:  Set to TRUE if restarting from a previous model estimation.  To use this option, a model estimation must have been completed prior to the current run, and the restart.txt file must be in the working directory.  All iterations from the previous run are treated as burn-in.  When restarting, keep all arguments (except for R and use) identical to those of the previous run to avoid errors.
}
}
\details{
Model:\cr
\tabular{lll}{
\tab Y_ij \tab ~ MNL(beta_i*X_ij) for all  i units and choice sets j\cr
\tab \tab (X_ij is nvar by 1, where nvar is the number of independent variables)\cr
\tab beta_i \tab = Z_i'delta + u_i\cr
\tab \tab (beta_i is 1 by nvar)\cr
\tab Z_i \tab = a column vector (nz by 1) of unit characteristics variables\cr
\tab \tab \cr
\tab delta \tab = a matrix (nz by nvar) of parameters where each column corresponds\cr
\tab \tab to a column of beta_i\cr
\tab u_i \tab ~ N(mu,Sigma), a multivariate normal distribution\cr
\tab mu \tab = a vector of means of the distribution of heterogeneity of length nvar\cr
\tab Sigma \tab = Covariance matrix of the distribution of heterogeneity}

Priors:\cr
\tabular{lll}{
\tab delta \tab ~ N(deltabar, inverse(A_d))\cr
\tab mu \tab ~ N(mubar, inverse(SigmaAmu)\cr
\tab Sigma_j \tab ~ IW(nu,V)\cr
\tab \tab \cr
\tab deltabar \tab = nz by nvar vector of prior means = 0\cr
\tab Ad \tab = prior precision matrix for deltabar = .01I\cr
\tab mubar \tab = nvar by 1 prior mean vector for mu = vector of zeros\cr
\tab nu \tab = nuI is the degrees of freedom parameter for IW prior for Sigma\cr
\tab V \tab = pds location parameter for IW prior for Sigma\cr
\tab Amu \tab = prior precision for normal mean = .01}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
\item{betadraw}{An ni by natt by floor(use/keep) array of MCMC random draws of unit-level multinomial logit model parameter estimates.}
\item{betadraw.c}{An ni by natt by floor(use/keep) array of constrained MCMC random draws of unit-level multinomial logit model parameter estimates.}
\item{deltadraw}{A floor(use/keep) by nz*natt array of MCMC random draws of parameter estimates on covariates to the distribution of heterogeneity.}
\item{compdraw}{A list of floor(use/keep) MCMC random draws of estimates of means and roots for the multivariate normal distribution of heterogeneity.}
\item{loglike}{A floor(use/keep) vector of likelihoods for the MCMC draws of multinomial logit parameters.}
\item{Written to Console During Model Estimation}{During model estimation, the following statistics are written to the screen after each 100 iterations.  The selection of these particular statistics was suggested by Sawtooth Software's technical paper, \dQuote{The CBC/HB System for Hierarchical Bayes Estimation,} Version 5.0 Technical Paper (2009).  Following Sawtooth Software's approach for certain statistics, we use a weighted average with a weight of 0.01 for the last 100 iterations and 0.99 for previous iterations.}
\item{Acceptance}{Percent of MCMC draws accepted in the Metropolis Hastings step.}
\item{RLH}{nth root of the likelihood, where n is the average number of choice tasks (weighted average).}
\item{Percent Certainty}{Percent difference between log likelihood and log likelihood of a chance model (weighted average).}
\item{Average Variance}{Average variance of latest estimates of model coefficients across all units (weighted average).}
\item{RMS}{Root mean squared of latest estimates of model coefficients across all units (weighted average).}
\item{Graphic Output}{During model estimation, estimates of mu (mean of model coefficients from the distribution of heterogeneity) are plotted in the graphics window.}
\item{Written to Disk}{At the end of model estimation, average of MCMC draws of unit-level model coefficients are written to Xbetas.csv.  A log file, documenting run-time output is written to Rlog.txt.  Latest MCMC draws are written to restart.txt.}
}
\references{
Rossi, Peter; Allenby, Greg M.; and McCulloch, Robert (2005), \emph{Bayesian Statistics and Marketing}, John Wiley and Sons.

Sawtooth Software (2009), \dQuote{The CBC/HB System for Hierarchical Bayes Estimation}, Version 5.0 Technical Paper, www.sawtoothsoftware.com.
}
\author{
Ryan Sermas, assisted by John V. Colias Ph.D., at Decision Analyst, Inc.
\email{
DecisionAnalystR@decisionanalyst.com}
}
\note{
For further explanation of model and priors, see rhierMnlRwMixture of the bayesm package, authored by Peter Rossi, Ph.D., Anderson School, UCLA.  For further discussion, see Rossi, Allenby and McCulloch (2005).  The model specification is identical to that in bayesm, except that (a) the step length of the random walk metropolis algorithm was simplified to use increments of covariance (s**2)(Sigma), where \dQuote{s} is a scaling parameter mentioned above and \dQuote{Sigma} is the current draw of the covariance matrix of the distribution of heterogeneity and (b) the distribution of heterogeneity was simplified to a normal vs. a mixture of normals.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\examples{

# EXAMPLE 1: MULTINOMIAL LOGIT

# LOAD ARTIFICIAL (SIMULATED) DATA THAT WAS CREATED 
# BY R CODE FOUND IN datar SECTION OF THE HELP FILES.

data(datar)
data(truebetas)

# USE choicemodelr TO ESTIMATE THE PARAMETERS OF THE CHOICE MODEL.
# FOR CONVERGENCE OF MCMC CHAIN, SET R = 4000 AND use = 2000.

xcoding = c(0, 0)
mcmc = list(R = 10, use = 10)

options = list(none=FALSE, save=TRUE, keep=1)

attlevels = c(5, 3)
constype =  c(0, 1)
constraints = vector("list", 2)

for (i in 1:length(attlevels)) {
	constraints[[i]] = diag(0, attlevels[i])
	if (constype[i] == 1) {
		constraints[[i]][upper.tri(constraints[[i]])] = -1
	}
	else if (constype[i] == 2) {
		constraints[[i]][upper.tri(constraints[[i]])] = 1
	}
}

out = choicemodelr(datar, xcoding, mcmc = mcmc, options = options, constraints = constraints)

# CALCULATE MEAN ABSOLUTE ERROR BETWEEN ESTIMATED AND TRUE BETAS.
estbetas = apply(out$betadraw.c,c(1,2),mean)
estbetas = cbind(estbetas[,1:4],0-apply(estbetas[,1:4],1,sum),estbetas[,5:6],0-apply(estbetas[,5:6],1,sum))
colnames(estbetas) = c("A1B1", "A1B2", "A1B3", "A1B4", "A1B5", "A2B1", "A2B2", "A2B3")

MAE = mean(abs(estbetas - truebetas))
print(MAE)

# CALCULATE MEAN ABSOLUTE ERROR BETWEEN PROBABILITY
# DIFFERENCES USING ESTIMATED AND TRUE BETAS. 

TrueProb = cbind(exp(truebetas[,1:5]) / apply(exp(truebetas[,1:5]),1,sum),
                 exp(truebetas[,6:8]) / apply(exp(truebetas[,6:8]),1,sum))
EstProb = cbind(exp(estbetas[,1:5]) / apply(exp(estbetas[,1:5]),1,sum),
                exp(estbetas[,6:8]) / apply(exp(estbetas[,6:8]),1,sum))
MAEProb = mean(abs(TrueProb - EstProb))

print(MAEProb)


# EXAMPLE 2: FRACTIONAL MULTINOMIAL LOGIT

# LOAD ARTIFICIAL (SIMULATED) FRACTIONAL MULTINOMIAL LOGIT DATA CREATED 
# BY R CODE FOUND IN sharedatar SECTION OF THE HELP FILES.

data(sharedatar)
data(truebetas)

# USE choicemodelr TO ESTIMATE THE PARAMETERS OF THE CHOICE MODEL.
# FOR CONVERGENCE OF MCMC CHAIN, SET R = 2000 AND use = 1000.

xcoding = c(0, 0)
mcmc = list(R = 10, use = 10)

options = list(none=FALSE, save=TRUE, keep=1)

attlevels = c(5, 3)
constype =  c(0, 1)
constraints = vector("list", 2)

for (i in 1:length(attlevels)) {
	constraints[[i]] = diag(0, attlevels[i])
	if (constype[i] == 1) {
		constraints[[i]][upper.tri(constraints[[i]])] = -1
	}
	else if (constype[i] == 2) {
		constraints[[i]][upper.tri(constraints[[i]])] = 1
	}
}

out = choicemodelr(sharedatar, xcoding, mcmc = mcmc, options = options, constraints = constraints)

# CALCULATE MEAN ABSOLUTE ERROR BETWEEN ESTIMATED AND TRUE BETAS.
estbetas = apply(out$betadraw.c,c(1,2),mean)
estbetas = cbind(estbetas[,1:4],0-apply(estbetas[,1:4],1,sum),estbetas[,5:6],0-apply(estbetas[,5:6],1,sum))
colnames(estbetas) = c("A1B1", "A1B2", "A1B3", "A1B4", "A1B5", "A2B1", "A2B2", "A2B3")

MAE = mean(abs(estbetas - truebetas))
print(MAE)

# CALCULATE MEAN ABSOLUTE ERROR BETWEEN PROBABILITY
# DIFFERENCES USING ESTIMATED AND TRUE BETAS. 

TrueProb = cbind(exp(truebetas[,1:5]) / apply(exp(truebetas[,1:5]),1,sum),
                 exp(truebetas[,6:8]) / apply(exp(truebetas[,6:8]),1,sum))
EstProb = cbind(exp(estbetas[,1:5]) / apply(exp(estbetas[,1:5]),1,sum),
                exp(estbetas[,6:8]) / apply(exp(estbetas[,6:8]),1,sum))
MAEProb = mean(abs(TrueProb - EstProb))

print(MAEProb)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ package  }
\keyword{ models }
\keyword{ multivariate }
