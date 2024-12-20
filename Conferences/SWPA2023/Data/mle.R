#source("~/Desktop/bryannaSimulations/fitFunctions.R")
source("\\Users\\bryan\\OneDrive\\Documents\\School\\Thesis\\Data\\fitFunctions.R")

##############################
# define simulation parameters
##############################

nSub = 20
nTrials = 20

# parent distribution means and sds (from F, Vick, Bowman, 2018)
G = 3.91 # gamma
G.sd = 0.70
A = 0.92 # alpha
A.sd = 0.17
H = 0.32 # theta
H.sd = 0.05

# each simulation run starts HERE
# build simulated RT matrix
# rows = subjects, columns = trials
rts = matrix(0, nrow=nSub, ncol=nTrials)

# build matrix to store "target" parameters
# rows = subjects, columns = gamma, alpha, theta
targets = matrix(0, nrow=nSub, ncol=3)

# randomly draw target shifted Wald parameters from parent distribution
# (one unique parameter value for each subject)
for (i in 1:nSub){
  targets[i,1] = rnorm(1, mean=G, sd=G.sd) # draw random gamma
  targets[i,2] = rnorm(1, mean=A, sd=A.sd) # draw random alpha
  targets[i,3] = rnorm(1, mean=H, sd=H.sd) # draw random theta
}  
 
# from these target SW values, generate the distribution of observed RTs for each subject

for (i in 1:nSub){
  rts[i,] = rwald(nTrials, 
                  gamma = targets[i,1], 
                  alpha = targets[i,2], 
                  theta = targets[i,3])
}

# now let's use CMLE to fit shifted Wald distribution to each row of observed RTs
# first, we'll store these estimates in a matrix
predictions = matrix(0, nrow=nSub, ncol=3)

# now do the fits (one per subject)
for (i in 1:nSub){
  fit = optim(waldinit(rts[i,]), nll.wald, dat=rts[i,])
  predictions[i,] = fit$par
}

# now lets compare the predictions (fits) to the targets

# mean of parameter estimates
apply(predictions, 2, mean)

# RMSD 
apply(predictions-targets, 2, rmse)

# mean bias
apply(predictions-targets, 2, mean)

# correlation
diag(cor(predictions,targets))







