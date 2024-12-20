#Pull in Data for Exp1 (par= 20, N= 20)
Exp1 = read.csv("\\Users\\bryan\\OneDrive\\Documents\\School\\Thesis\\Data\\Exp1Means.csv")

#Create Boxplots for Exp1
boxplot(Exp1,
        col = (c("plum2","palegreen1","paleturquoise2")),
        stapelwex = 0.2,
        names = c("gamma","alpha","theta"),
        xlab= "Variables",
        ylab= "Means",
        main= "Boxplots for P=20, N=20")
