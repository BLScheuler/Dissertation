#Pull in Data for Gamma
GammaMeans = read.csv("GammaMeans.csv")

#Create Boxplots for Gamma Means
#boxplot(GammaMeans,
 #       col = (c("palegreen1","palegreen1","lightpink","lightpink","paleturquoise2","paleturquoise2","khaki1","khaki1","plum2","plum2")),
#        stapelwex = 0.2,
#        names = c("CMLE Exp1", "HMLE Exp1","CMLE Exp2", "HMLE Exp2","CMLE Exp3", "HMLE Exp3","CMLE Exp4", "HMLE Exp4","CMLE Exp5", "HMLE Exp5"),
#        xlab= "Experiment",
#        ylab= "Means")
#abline(h=3.91, lty=2, lwd=1.5)


#Create Boxplots for Gamma Means #2
#boxplot(GammaMeans,
 #       col = (c("palegreen1","palegreen1","lightpink","lightpink","paleturquoise2","paleturquoise2","khaki1","khaki1","plum2","plum2")),
  #      stapelwex = 0.2,
  #      names = c("CMLE", "HMLE","CMLE", "HMLE","CMLE","HMLE","CMLE","HMLE","CMLE","HMLE"),
  #      xlab= "Experiment",
  #      ylab= "Means")
#abline(h=3.91, lty=2, lwd=1.5)

#Create Boxplots for Gamma Means #3 USE THIS ONE!!!
boxplot(GammaMeans,
        col = (c("palegreen1","palegreen1","lightpink","lightpink","paleturquoise2","paleturquoise2","khaki1","khaki1","plum2","plum2")),
        stapelwex = 0.2,
        names = c("CMLE", "HMLE","CMLE", "HMLE","CMLE","HMLE","CMLE","HMLE","CMLE","HMLE"),
        xlab= "Estimation Method",
        ylab= "Means")
legend("top", title= "Experiment", legend=c("Par=20, Trials=20","Par=20, Trials=80","Par=20, Trials=500","Par=5, Trials=500","Par=80, Trials=20"), 
       fill=c("palegreen1","lightpink","paleturquoise2","khaki1","plum2"))
abline(h=3.91, lty=2, lwd=1.5)

#Create Boxplots for Gamma Means #4
#boxplot(GammaMeans,
#        col = (c("lightpink","paleturquoise2","lightpink","paleturquoise2","lightpink","paleturquoise2","lightpink","paleturquoise2","lightpink","paleturquoise2")),
#        stapelwex = 0.2,
#        names = c("Exp1", "Exp1","Exp2", "Exp2","Exp3", "Exp3","Exp4", "Exp4","Exp5", "Exp5"),
#        xlab= "Experiment",
#        ylab= "Means")
#legend("top", title= "Estimation Method", legend=c("CMLE","HMLE"), 
#       fill=c("lightpink","paleturquoise2"))
#abline(h=3.91, lty=2, lwd=1.5)


#Pull in Data for Alpha
MeansAlpha = read.csv("AlphaMeans.csv")

#Create Boxplots for Alpha Means
boxplot(MeansAlpha,
        col = (c("palegreen1","lightpink","paleturquoise2","khaki1","plum2")),
        stapelwex = 0.2,
        names = c("P=20, N=20","P=20, N=80","P=20, N=500","P=5, N=500","P=80, N=20"),
        xlab= "Experiment",
        ylab= "Means")
abline(h=0.92, lty=2, lwd=1.5)


#Pull in Data for Theta
MeansTheta = read.csv("ThetaMeans.csv")

#Create Boxplots for Theta Means
boxplot(MeansTheta,
        col = (c("palegreen1","lightpink","paleturquoise2","khaki1","plum2")),
        stapelwex = 0.2,
        names = c("P=20, N=20","P=20, N=80","P=20, N=500","P=5, N=500","P=80, N=20"),
        xlab= "Experiment",
        ylab= "Means")
abline(h=0.32, lty=2, lwd= 1.5)

