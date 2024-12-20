#Pull in Data for Gamma
MeansGamma = read.csv("\\Users\\bryan\\OneDrive\\Documents\\School\\Thesis\\Data\\MeansGamma.csv")

#Create Boxplots for Gamma Means
boxplot(MeansGamma,
        col = (c("palegreen1","lightpink","paleturquoise2","khaki1","plum2")),
        stapelwex = 0.2,
        names = c("P=20, N=20","P=20, N=80","P=20, N=500","P=5, N=500","P=80, N=20"),
        xlab= "Experiment",
        ylab= "Means")
abline(h=3.91, lty=2, lwd=1.5)


#Pull in Data for Alpha
MeansAlpha = read.csv("\\Users\\bryan\\OneDrive\\Documents\\School\\Thesis\\Data\\MeansAlpha.csv")

#Create Boxplots for Alpha Means
boxplot(MeansAlpha,
        col = (c("palegreen1","lightpink","paleturquoise2","khaki1","plum2")),
        stapelwex = 0.2,
        names = c("P=20, N=20","P=20, N=80","P=20, N=500","P=5, N=500","P=80, N=20"),
        xlab= "Experiment",
        ylab= "Means")
abline(h=0.92, lty=2, lwd=1.5)


#Pull in Data for Theta
MeansTheta = read.csv("\\Users\\bryan\\OneDrive\\Documents\\School\\Thesis\\Data\\MeansTheta.csv")

#Create Boxplots for Theta Means
boxplot(MeansTheta,
        col = (c("palegreen1","lightpink","paleturquoise2","khaki1","plum2")),
        stapelwex = 0.2,
        names = c("P=20, N=20","P=20, N=80","P=20, N=500","P=5, N=500","P=80, N=20"),
        xlab= "Experiment",
        ylab= "Means")
abline(h=0.32, lty=2, lwd= 1.5)

