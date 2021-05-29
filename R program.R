#Figure 2
data<-read.csv("ftest.csv",header = T) 
#install.packages("ggpubr")
library("ggpubr")
p<-ggviolin(data,y="Zscore",color="Zscore",fill="#00AFBB",
            xlab="Poplar samples",ylab="Zscore",draw_quantiles = 0.5,
            title="Violin plot of Zscore",add="jitter",error.plot = "pointrange",
            size=0.3,width=0.7,notch=T,orientation = "horizontal",
            add.params = list(shape=19,size = 3),label.rectangle=T)
p+scale_color_distiller(palette = "Greens")+
  geom_segment(aes(x = 0.6, y =1.998851, xend = 1.4, yend = 1.998851),color="red",size=0.5,linetype="dashed")
summary(data$Zscore[1:80])

#Figure 3
#Figure 3(a)
#install.packages("corrplot")
#library(viridis)
library("corrplot")
data<-read.csv("corr.csv",header = T,row.names=NULL) 
res<-cor(data[,2:43])
corr<-cor.mtest(data[,2:43])
colnames(res) <- c("Photo","Cond","Ci","Trmmol","VpdL","CTleaf","Tair","Tleaf","TBlk",
                   "CO2R","CO2S","H2OR","H2OS","RH_R","RH_S",
                   "Flow","PARi","PARo","Press","CsMch","HsMch","fda","Trans","Tair_K",	
                   "Twall_K","R(W/m2)",	"Tl-Ta","SVTleaf","H2o_i","h20diff","CTair","SVTair",
                   "CndTotal","vp_kPa","VpdA","CndCO2","Ci_Pa","Ci/Ca","RHsfc","C2sfc","AHs/Cs","Zscore")
rownames(res) <- c("Photo","Cond","Ci","Trmmol","VpdL","CTleaf","Tair","Tleaf","TBlk",
                   "CO2R","CO2S","H2OR","H2OS","RH_R","RH_S",
                   "Flow","PARi","PARo","Press","CsMch","HsMch","fda","Trans","Tair_K",	
                   "Twall_K","R(W/m2)",	"Tl-Ta","SVTleaf","H2o_i","h20diff","CTair","SVTair",
                   "CndTotal","vp_kPa","VpdA","CndCO2","Ci_Pa","Ci/Ca","RHsfc","C2sfc","AHs/Cs","Zscore")
color<-colorRampPalette(c("#fcd1d1","#ece2e1","#d3e0dc","#aee1e1"))(100)
corrplot(res, tl.col ="black",order = "hclust",method="square", col=color,
         p.mat=corr$p,insig = "blank")
#Figure 3(b)
#install.packages("corrplot")
library("corrplot")
data<-read.csv("corr13.csv",header = T,row.names=NULL) 
res<-cor(data[,2:15])
corr<-cor.mtest(data[,2:15])
colnames(res) <- c("Cond","Ci","VpdL","RH_S","PARo","H20diff",
                   "CndTotal","VpdA","CndCO2","Ci_Pa","Ci/Ca","RHsfc","AHs/Cs","Zscore")
rownames(res) <- c("Cond","Ci","VpdL","RH_S","PARo","H20diff",
                   "CndTotal","VpdA","CndCO2","Ci_Pa","Ci/Ca","RHsfc","AHs/Cs","Zscore")
color<-colorRampPalette(c("#fcd1d1","#ece2e1","#d3e0dc","#aee1e1"))(100)
corrplot(res, tl.col ="black",order = "hclust",method="square", col=color,
         p.mat=corr$p,insig = "blank")
corrplot(corr = cor(data[,2:15]),add=TRUE, type="upper", method="number",
         order="hclust", col="#096395",diag=FALSE,tl.pos="n", cl.pos="n",
         p.mat=corr$p,insig = "blank")

#Figure 4
#Figure 4(a)
library(pheatmap)
a<-read.csv("AVG.csv",header = T,row.names=1)
df<-scale(a)
b<-read.csv("1.csv",header = T,row.names=1)
c<-read.csv("2.csv",header = T,row.names=1)
anno_colors<-list(Fcluster=c(F1="#DC143C",F2="#FF8C00",F3="#FFD700",
                             F4="#228B22",F5="#00008B",F6="#8A2BE2"),
                  Stype=c(A="#911934",B="#3651A1",C="#51449A"))
pheatmap(df,annotation_row = b,annotation_col = c,main="a)",angle_col=90,
         cutree_rows=3,cutree_cols=6,
         color<-colorRampPalette(c("#28df99","#99f3bd","#d2f6c5","#f6f7d4"
                                   ,"#ffaaa7","#ff9292","#f25287"))(50),
         annotation_colors = anno_colors)
#Figure 4(b)
library(ggtree)
library(ggplot2)
a<-read.csv("AVG.csv",header = T,row.names=1)
df<-scale(a)
b<-t(df)
rownames(df)<-paste(data$锘縁eatures)
hc<-hclust(dist(b),method="complete")
ggtree(hc,layout="dendrogram",size=0.5)+
  geom_tiplab(offset=-0.75,size=4,font=3,angle=90)+
  #geom_text(aes(label=node))+
  geom_highlight(node = 15,fill="#DC143C")+
  geom_highlight(node=5,fill="#FF8C00")+  
  geom_highlight(node=13,fill="#FFD700")+
  geom_highlight(node = 19,fill="#228B22")+
  geom_highlight(node=22,fill="#00008B")+  
  geom_highlight(node=21,fill="#8A2BE2")+
  geom_cladelabel(node=15,label="F1",fontsize = 5,
                  offset=-1.2,barsize = 1,
                  offset.text=-0.3,color="#DC143C")+
  geom_cladelabel(node=5,label="F2",fontsize = 5,
                  offset=-1.05,barsize = 1,
                  offset.text=-0.3,hjust=0,color="#FF8C00")+
  geom_cladelabel(node=13,label="F3",fontsize = 5,
                  offset=-1.05,barsize = 1,
                  offset.text=-0.3,color="#FFD700")+
  geom_cladelabel(node=19,label="F4",fontsize = 5,
                  offset=-1.55,barsize = 1,
                  offset.text=-0.3,color="#228B22")+
  geom_cladelabel(node=22,label="F5",fontsize = 5,
                  offset=-1.4,barsize = 1,
                  offset.text=-0.3,hjust=0,color="#00008B")+
  geom_cladelabel(node=21,label="F6",fontsize = 5,
                  offset=-1.1,barsize = 1,
                  offset.text=-0.3,color="#8A2BE2")+
  labs(title = "b)",vjust=6)
#Figure 4(c)
#install.packages("BiocManager")
#BiocManager::install("ggtree")
library(ggtree)
library(ggplot2)
data<-read.csv("AVG.csv",header = T,row.names=NULL)
df <- scale(data[,2:14])
rownames(df)<-paste(data$锘縎amples,1:20,sep=" | ")
hc<-hclust(dist(df),method="complete")
ggtree(hc,layout="dendrogram",size=0.5)+
  geom_tiplab(offset=-1,size=2.5,font=3,angle=90)+
  #geom_text(aes(label=node))+
  geom_highlight(node = 22,fill="#911934")+
  geom_highlight(node=24,fill="#3651A1")+  
  geom_highlight(node=25,fill="#51449A")+
  geom_cladelabel(node=22,label="A",fontsize = 5,
                  offset=-3.8,barsize = 2,offset.text=-0.3,
                  color="#911934")+
  geom_cladelabel(node=24,label="B",fontsize = 5,
                  offset=-3.25,barsize = 2,offset.text=-0.3,
                  color="#3651A1")+
  geom_cladelabel(node=25,label="C",fontsize = 5,
                  offset=-3.45,barsize = 2,offset.text=-0.3,
                  color="#51449A")+
  labs(title = "c)")

#Figure 5
#install.packages("leaps")
library(leaps)
library(viridis)
a<-read.csv("AVG.csv",header = T,row.names=NULL) 
data<-a[1:15,]
leaps<-regsubsets(Zscore~Cond+Ci+VpdL+RH_S+PARo+H20diff+CndTotal+VpdA+CndCO2+Ci_Pa
                  +Ci.Ca+RHsfc+AHs.Cs,data=data,nbest=13)
color<-colorRampPalette(c("#0278ae","#51adcf"))(50)
plot(leaps,scale="adjr2",col = color,main="Plot of All Features Regression")

#Figure 7
#Figure 7(a)
a <- c(0.0010,0.0067,0.0365,0.0208)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "Values",
        col=c("darkseagreen","slateblue1","#9fd8df","dodgerblue4"),ylim=c(0,0.04))
title(main="MSE of Four SVR methods on the training set")
#Figure 7(b)
a <- c(0.0212,0.0203,0.0105,0.0307)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "Values",
        col=c("darkseagreen","slateblue1","#9fd8df","dodgerblue4"),ylim=c(0,0.04))
title(main="MSE of Four SVR methods on the test set")

#Figure 8
#Figure 8(a)
a <- c(0.9833,0.9685,0.9009,0.9199)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "Values",
        col=c("#7b113a","#150e56","#FE817D","#81B8DF"),ylim=c(0,1))
title(main="Overall R^2 of Four SVR methods")
#Figure 8(b)
a <- c(0.0051,0.0095,0.0313,0.0228)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "MSE",
        col=c("#7b113a","#150e56","#FE817D","#81B8DF"),ylim=c(0,0.04))
title(main="Overall MSE of Four SVR methods")
#Figure 8(c)
a <- c(0.0816,0.1455,0.2676,0.1940)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "MRE",
        col=c("#7b113a","#150e56","#FE817D","#81B8DF"),ylim=c(0,0.3))
title(main="Overall MRE of Four SVR methods")

#Lasso
#install.packages("tidyverse")
#install.packages("broom")
#install.packages("glmnet")
library("tidyverse")
library("broom")
library("glmnet")
data<-read.csv("AVG.csv",header = T,row.names=NULL)
data<-as.matrix(data[,2:15])
x<-data[1:15,-14]
y<-data[1:15,14]
cvfit=cv.glmnet(x,y,type.measure="mse",nfolds=15,alpha=1)
cvfit$lambda.min
lasso<-glmnet(x,y,family="gaussian",alpha=1)
ridge.coef<-predict(lasso,s=0.04,type="coefficients")
ridge.coef

#Stepwise
#install.packages("MASS")
library(MASS)
data<-read.csv("AVG.csv",header = T,row.names=NULL) 
fit<-lm(data[,15]~data[,2]+data[,3]+data[,4]+data[,5]+data[,6]+data[,7]+data[,8]+data[,9]
        +data[,10]+data[,11]+data[,12]+data[,13]+data[,14])
stepAIC(fit,direction="backward")