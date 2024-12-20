# various utility functions for parameter recovery routines


# density function for Wald (unshifted)
dwald = function(x,gamma,alpha){
  return((alpha/(sqrt(2*pi*x^3)))*exp(-(alpha-gamma*x)^2/(2*x)))
}

# function to generate random shifted Wald data
# adapted from pp. 79-80, Dagpunar, J. (1988). Principles of Random Variate Generation. Clarendon Press, Oxford.
# code modified from Heathcote (2004)
rwald = function(n, gamma, alpha, theta) {
  y2 = rchisq(n,1)
  y2onm = y2/gamma
  u = runif(n)
  r1 = (2*alpha + y2onm - sqrt(y2onm*(4*alpha+y2onm)))/(2*gamma)
  r2 = (alpha/gamma)^2/r1
  ifelse(u < alpha/(alpha+gamma*r1), theta+r1, theta+r2)
}

# basic function that returns Root Mean Squared Error 
rmse = function(error){
  sqrt(mean(error^2))
}

# negative log likelihood for shifted Wald
nll.wald = function(par,dat){
  return(-sum(log(dwald(dat-par[3], gamma=par[1], alpha=par[2]))))
}

# Hierach. negative log likelihood for shifted Wald
nll.wald.h = function(par,dat){
  n_subjects <- dim(dat)[1]
  n_trials <- dim(dat)[2]
 par <- exp(par) 

gamma_group_mean  <- par[1]
gamma_group_sd  <- par[2]
alpha_group_mean  <- par[3]
alpha_group_sd <- par[4]
theta_group_mean <- par[5]
theta_group_sd <- par[6]
gamma_ind <- par[6 + 1:(n_subjects-1)]
alpha_ind <- par[6 + (n_subjects-1) + 1:(n_subjects-1)]
theta_ind <- par[6 + 2*(n_subjects-1) + 1:(n_subjects-1)]

gamma_ind <- c(gamma_ind, n_subjects*gamma_group_mean - sum(gamma_ind))
alpha_ind <- c(alpha_ind, n_subjects*alpha_group_mean - sum(alpha_ind))
theta_ind <- c(theta_ind, n_subjects*theta_group_mean - sum(theta_ind))

theta_mat<- matrix(rep(theta_ind, each=n_trials), n_subjects, n_trials, byrow=TRUE)
if(any(dat-theta_mat <0)) {return(Inf)}
nll <-  0
  for (s in 1:n_subjects){
    nll <- nll - sum(log(dwald(dat[s,]-theta_ind[s], gamma=gamma_ind[s], alpha=alpha_ind[s])))
}

nll <- nll -sum(dnorm(gamma_ind, mean=gamma_group_mean, sd=gamma_group_sd), log=TRUE)
nll <- nll -sum(dnorm(alpha_ind, mean=alpha_group_mean, sd=alpha_group_sd), log=TRUE)
nll <- nll -sum(dnorm(theta_ind, mean=theta_group_mean, sd=theta_group_sd), log=TRUE)

  return(nll)
}
# Start point estimate for SW, based on first two moments 
# assumes s = p*min(x), where x is a data vector
# from Heathcote (2004)
waldinit = function(x, p = 0.9) {
  theta = p*min(x) 
  x = x - theta	
  gamma = sqrt(mean(x)/var(x))
  alpha = gamma*mean(x) 
  return(c(gamma,alpha,theta))	
}

waldinit.h = function(x, p = 0.9) {
  #input:
  #x: matrix of rt w rows indicating subject and columns indicating trial
 n_subjects  <- dim(x)[1]
 n_trials  <- dim(x)[2]
   theta_ind  <- p*apply(x,1, min) #vector of shift parameters
  theta_group_mean <- mean(theta_ind)   #group mean shift parameter
  theta_group_sd <- sd(theta_ind)   #SD of shift across group
  theta_mat<- matrix(rep(theta_ind, each=n_trials), n_subjects, n_trials, byrow=TRUE)
#diff shift per person > create matrix
  x = x - theta_mat
  

  gamma_ind = sqrt(apply(x, 1, mean) / apply(x,1, var)) #gamma vector
  gamma_group_mean <- mean(gamma_ind)
  gamma_group_sd <- sd(gamma_ind)
  alpha_ind <- gamma_ind *apply(x, 1, mean) #alpha vector
  alpha_group_mean <- mean(alpha_ind) #group mean alpha
  alpha_group_sd  <- sd(alpha_ind)
  
  #to make sure you pull the right parameter, we have to be careful; pull group first
  par <- c(gamma_group_mean, gamma_group_sd,
           alpha_group_mean, alpha_group_sd,
           theta_group_mean, theta_group_sd,
           gamma_ind[-n_subjects], alpha_ind[-n_subjects], theta_ind[-n_subjects])
  return(log(par))
}

