#source("~/Desktop/bryannaSimulations/fitFunctions.R")
#source("fitFunctions.R")

##############################
# define simulation parameters
##############################

nSub = 5
nTrials = 500

# parent distribution means and sds (from F, Vick, Bowman, 2018)
G = 3.91 # gamma
G.sd = 0.70
A = 0.92 # alpha
A.sd = 0.17
H = 0.32 # theta
H.sd = 0.05

#matrices
rmse_mat = matrix(NA, 200, 3+(3*nSub))
mb_mat = matrix(NA, 200, 3+(3*nSub))

for (x in 1:200){
  
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
  #predictions = matrix(0, nrow=nSub, ncol=3)
  
  # now do the fits (one per subject)
  
  #hierarchical model fit
  
  fit.h = optim(waldinit.h(rts), nll.wald.h, dat=rts)
  
  # now lets compare the predictions (fits) to the targets
  #will need to do
  par <- exp(fit.h$par)
  
  gamma_group_mean  <- par[1]
  gamma_group_sd  <- par[2]
  alpha_group_mean  <- par[3]
  alpha_group_sd <- par[4]
  theta_group_mean <- par[5]
  theta_group_sd <- par[6]
  gamma_ind <- par[6 + 1:nSub]
  alpha_ind <- par[6 + nSub + 1:nSub]
  theta_ind <- par[6 + 2*nSub + 1:nSub]
  
  #g level error
  gg_rmse = sqrt((G- gamma_group_mean)^2)
  ga_rmse = sqrt((A- alpha_group_mean)^2)
  gh_rmse = sqrt((H- theta_group_mean)^2)
  
  #i level error
  ig_rmse = sqrt((targets[,1]-gamma_ind)^2)
  ia_rmse = sqrt((targets[,2]-alpha_ind)^2)
  ih_rmse = sqrt((targets[,3]-theta_ind)^2)
  
  rmse_mat[x,] = c(gg_rmse,ga_rmse, gh_rmse, ig_rmse, ia_rmse, ih_rmse)
  
  # mean of parameter estimates
  #apply(predictions, 2, mean)
  
  # RMSD 
  #apply(predictions-targets, 2, rmse)
  
  # mean bias
  #apply(predictions-targets, 2, mean)
  
  
  #g level mb
  gg_mb = -1*(G- gamma_group_mean)
  ga_mb = -1*(A- alpha_group_mean)
  gh_mb = -1*(H- theta_group_mean)
  
  #i level mb
  ig_mb = -1*(targets[,1]-gamma_ind)
  ia_mb = -1*(targets[,2]-alpha_ind)
  ih_mb = -1*(targets[,3]-theta_ind)
  
  mb_mat[x,] = c(gg_mb,ga_mb, gh_mb, ig_mb, ia_mb, ih_mb)
  
  # correlation
  #diag(cor(predictions,targets))
}

write.csv(rmse_mat, file= "hrmse.csv")
write.csv(mb_mat, file= "hmb.csv")





