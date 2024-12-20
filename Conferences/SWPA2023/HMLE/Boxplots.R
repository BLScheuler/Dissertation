#Pull in Data for Gamma
GammaMeans = read.csv("GammaMeans.csv")

#Create Boxplots for Gamma Means 
boxplot(GammaMeans,
        main = "Drift Rate",
        col = (c("palegreen1","palegreen1","lightpink","lightpink","paleturquoise2","paleturquoise2","khaki1","khaki1","plum2","plum2")),
        stapelwex = 0.2,
        names = c("CMLE", "HMLE","CMLE", "HMLE","CMLE","HMLE","CMLE","HMLE","CMLE","HMLE"),
        xlab= "Estimation Method",
        ylab= "Means")
abline(v=6.5, lty=2, lwd=1.5)
legend("top", title= "Experiment", legend=c("Par=20, Trials=20","Par=20, Trials=80","Par=20, Trials=500","Par=5, Trials=500","Par=80, Trials=20"), 
       fill=c("palegreen1","lightpink","paleturquoise2","khaki1","plum2"))
abline(h=3.91, lty=2, lwd=1.5)



#Pull in Data for Alpha
AlphaMeans = read.csv("AlphaMeans.csv")

#Create Boxplots for Alpha Means 
boxplot(AlphaMeans,
        main = "Response Threshold",
        col = (c("palegreen1","palegreen1","lightpink","lightpink","paleturquoise2","paleturquoise2","khaki1","khaki1","plum2","plum2")),
        stapelwex = 0.2,
        names = c("CMLE", "HMLE","CMLE", "HMLE","CMLE","HMLE","CMLE","HMLE","CMLE","HMLE"),
        xlab= "Estimation Method",
        ylab= "Means",
        ylim= c(0.7,2.5))
abline(v=6.5, lty=2, lwd=1.5)
legend("top", title= "Experiment", legend=c("Par=20, Trials=20","Par=20, Trials=80","Par=20, Trials=500","Par=5, Trials=500","Par=80, Trials=20"), 
       fill=c("palegreen1","lightpink","paleturquoise2","khaki1","plum2"))
abline(h=0.92, lty=2, lwd=1.5)


#Pull in Data for Theta
ThetaMeans = read.csv("ThetaMeans.csv")

#Create Boxplots for Theta Means 
boxplot(ThetaMeans,
        main = "Shift",
        col = (c("palegreen1","palegreen1","lightpink","lightpink","paleturquoise2","paleturquoise2","khaki1","khaki1","plum2","plum2")),
        stapelwex = 0.2,
        names = c("CMLE", "HMLE","CMLE", "HMLE","CMLE","HMLE","CMLE","HMLE","CMLE","HMLE"),
        xlab= "Estimation Method",
        ylab= "Means")
abline(v=6.5, lty=2, lwd=1.5)
legend("bottom", title= "Experiment", legend=c("Par=20, Trials=20","Par=20, Trials=80","Par=20, Trials=500","Par=5, Trials=500","Par=80, Trials=20"), 
       fill=c("palegreen1","lightpink","paleturquoise2","khaki1","plum2"))
abline(h=0.32, lty=2, lwd=1.5)

