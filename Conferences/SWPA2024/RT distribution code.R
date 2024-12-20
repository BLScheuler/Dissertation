#install.packages("moments")

# Set seed for reproducibility
set.seed(123)

# Define minimum and maximum response times
min_time <- 150
max_time <- 900

# Generate response times following an ex-Gaussian distribution
mu <- 300  # Mean of the normal component
sigma <- 50  # Standard deviation of the normal component
tau <- 100  # Mean of the exponential component
response_times <- rnorm(1000, mean = mu, sd = sigma) + rexp(1000, rate = 1/tau)

# Truncate response times to ensure they fall within the range
response_times <- pmax(pmin(response_times, max_time), min_time)

# Plot histogram with proper breaks
hist(response_times, breaks = seq(min_time, max_time, length.out = 30), freq = FALSE, main = "Histogram of Response Times", xlab = "Response Time", ylab = "Density", col = "lightblue")

# Fit with normal curve
muN <- mean(response_times)
sigmaN <- sd(response_times)
curve(dnorm(x, mean = muN, sd = sigmaN), col = "red", lwd = 2, add = TRUE)

#Density function for shifted-Wald
dsw = function(x, alpha, gamma){
  return((alpha/(sqrt(2*pi*x^3)))*exp(-(alpha-gamma*x)^2/(2*x)))
}

dsw_density <- function(x, alpha, gamma) {
  return(dsw(x, alpha, gamma))
}

#Negative log-likelihood for shifted-Wald
nll.sw = function(data, pars){
  alpha = pars[1] # response threshold
  gamma = pars[2] # drift rate
  return(-sum(log(dsw(data,alpha,gamma))))
}

#Create function to guess initial parameters
init.sw = function(x) {
  theta = min(x)   #shift
  gamma = 0.1
  alpha = 200 
  return(c(alpha,gamma, theta))	
}

#SHIFTED-WALD
#Set initial parameters for swMod
initParsw1 = init.sw(response_times)

#Perform optimization for swMod1
swMod = optim(par = initParsw1,
               fn = nll.sw,
               data = response_times)

# extract parameters
alpha1 = swMod$par[1]
gamma1 = swMod$par[2]
theta1 = swMod$par[3]

hist(response_times, breaks = seq(min_time, max_time, length.out = 30), freq = FALSE, main = "Response Time Distributions", xlab = "Response Time (ms)", ylab = "Density", col = "lightblue")

# Fit with normal curve
muN <- mean(response_times)
sigmaN <- sd(response_times)
curve(dnorm(x, mean = muN, sd = sigmaN), col = "red", lwd = 2, add = TRUE)
#Fit the sWald curve
curve(dsw_density(x, alpha1, gamma1), from = min_time, to = max_time, col = "blue", lwd = 2, add = TRUE, args = list(alpha = alpha1, gamma = gamma1))
legend("topright", legend = c("Normal Curve", "Shifted Wald Curve"), col = c("red", "blue"), lwd = 2)
