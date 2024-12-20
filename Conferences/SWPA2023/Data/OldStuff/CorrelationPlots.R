#CORRELATION PLOTS

#Simulation Script
#source("~/Desktop/bryannaSimulations/fitFunctions.R")
source("\\Users\\bryan\\OneDrive\\Documents\\School\\Thesis\\Data\\fitFunctions.R")

##############################
# define simulation parameters
##############################

nSub = 20
nTrials = 500

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

#Playing with correlations


par(mfrow=c(1,3))

#CORRELATIONS WITH R ON GRAPH

#Correlations plot for Gamma

plot(targets[,1],predictions[,1],
     xlab= expression(paste("True value of ",gamma)),
     ylab= expression(paste("CMLE value of  ",hat(gamma))),
     pch= 21,
     col= "black",
     bg="khaki1",
     main= "Drift Rate when P=5, N=500",
     xlim=c(3,5.5),
     ylim=c(3,5.5),
     text(4.5, 5.45, "Mean r = 0.93")) 
abline(a=0, b=1, lty=2)


#Correlation plot for Alpha

plot(targets[,2],predictions[,2],
     xlab= expression(paste("True value of ",alpha)),
     ylab= expression(paste("CMLE value of  ",hat(alpha))),
     pch= 21,
     col= "black",
     bg="khaki1",
     main= "Response Threshold when P=5, N=500",
     xlim= c(0.6, 1.3),
     ylim= c(0.65, 1.3),
     text(0.8, 1.2, "Mean r = 0.86"))
abline(a=0, b=1, lty=2)


#Correlation plot for Theta

plot(targets[,3],predictions[,3],
     xlab= expression(paste("True value of ",theta)),
     ylab= expression(paste("CMLE value of  ",hat(theta))),
     pch= 21,
     col= "black",
     bg="khaki1",
     main= "Shift when P=5, N=500",
     xlim= c(0.22, 0.45),
     ylim= c(0.22, 0.45),
     text(0.27, 0.42, "Mean r = 0.95"))
abline(a=0, b=1, lty=2)

#CORRELATIONS WITHOUT R LISTED
#Correlations plot for Gamma

plot(targets[,1],predictions[,1],
     xlab= expression(paste("True value of ",gamma)),
     ylab= expression(paste("CMLE value of  ",hat(gamma))),
     pch= 21,
     col= "black",
     bg="plum2",
     main= "Drift Rate when P=80, N=20",
     xlim=c(3,5.5),
     ylim=c(3,5.5),)
abline(a=0, b=1, lty=2)


#Correlation plot for Alpha

plot(targets[,2],predictions[,2],
     xlab= expression(paste("True value of ",alpha)),
     ylab= expression(paste("CMLE value of  ",hat(alpha))),
     pch= 21,
     col= "black",
     bg="plum2",
     main= "Response Threshold when P=80, N=20",
     xlim= c(0.6, 1.3),
     ylim= c(0.6, 1.3))
abline(a=0, b=1, lty=2)


#Correlation plot for Theta

plot(targets[,3],predictions[,3],
     xlab= expression(paste("True value of ",theta)),
     ylab= expression(paste("CMLE value of  ",hat(theta))),
     pch= 21,
     col= "black",
     bg="plum2",
     main= "Shift when P=80, N=20",
     xlim= c(0.22, 0.45),
     ylim= c(0.22, 0.45))
abline(a=0, b=1, lty=2)
