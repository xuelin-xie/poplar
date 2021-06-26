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
corrplot(res, tl.col ="black",order = "hclust",method="number", col="#096395",cl.pos = "n",
         p.mat=corr$p,insig = "blank")
corrplot(corr = cor(data[,2:15]),add=TRUE, type="upper", method="number",
         order="hclust", col="#096395",diag=FALSE,tl.pos="n", cl.pos="n",
         p.mat=corr$p,insig = "blank")

#Figure 4
#Figure 4(a) 对样本聚类热图
library(pheatmap)
a<-read.csv("C:/Users/X_X-lin/Desktop/修改/AVG.csv",header = T,row.names=1)
df<-scale(a)
b<-read.csv("C:/Users/X_X-lin/Desktop/修改/1.csv",header = T,row.names=1)
c<-read.csv("C:/Users/X_X-lin/Desktop/修改/2.csv",header = T,row.names=1)
anno_colors<-list(Fcluster=c(F1="#DC143C",F2="#FF8C00",F3="#FFD700"),
                  Stype=c(A="#911934",B="#3651A1",C="#51449A"))
pheatmap(df,annotation_row = b,annotation_col = c,main="a)",angle_col=90,
         cutree_rows=3,cutree_cols=3,
         color<-colorRampPalette(c("#28df99","#99f3bd","#d2f6c5","#f6f7d4"
                                   ,"#ffaaa7","#ff9292","#f25287"))(50),
         annotation_colors = anno_colors)

#Figure 4(b) 对特征进行聚类
library(ggtree)
library(ggplot2)
a<-read.csv("C:/Users/X_X-lin/Desktop/修改/AVG.csv",header = T,row.names=1)
df<-scale(a)
b<-t(df)
rownames(df)<-paste(data$锘縁eatures)
hc<-hclust(dist(b),method="complete")
ggtree(hc,layout="dendrogram",size=0.5)+
  geom_tiplab(offset=-0.75,size=4,font=3,angle=90)+
  #geom_text(aes(label=node))+
  geom_highlight(node = 1,fill="#DC143C")+
  geom_highlight(node=2,fill="#FF8C00")+  
  geom_highlight(node=8,fill="#FFD700")+
  geom_cladelabel(node=1,label="F1",fontsize = 5,
                  offset=-1.03,barsize = 1,
                  offset.text=-0.3,color="#DC143C")+
  geom_cladelabel(node=2,label="F2",fontsize = 5,
                  offset=-1.05,barsize = 1,
                  offset.text=-0.3,hjust=0,color="#FF8C00")+
  geom_cladelabel(node=8,label="F3",fontsize = 5,
                  offset=-3.8,barsize = 1,
                  offset.text=-0.3,color="#FFD700")
labs(title = "b)",vjust=6)

#Figure 4(c) 样本聚类
#install.packages("BiocManager")
#BiocManager::install("ggtree")
library(ggtree)
library(ggplot2)
data<-read.csv("C:/Users/X_X-lin/Desktop/修改/AVG.csv",header = T,row.names=NULL)
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
                  offset=-2.92,barsize = 2,offset.text=-0.3,
                  color="#911934")+
  geom_cladelabel(node=24,label="B",fontsize = 5,
                  offset=-2,barsize = 2,offset.text=-0.3,
                  color="#3651A1")+
  geom_cladelabel(node=25,label="C",fontsize = 5,
                  offset=-3.1,barsize = 2,offset.text=-0.3,
                  color="#51449A")+
  labs(title = "c)")

#Figure 5
#install.packages("leaps")
library(leaps)
library(viridis)
a<-read.csv("C:/Users/X_X-lin/Desktop/修改/AVG.csv",header = T,row.names=NULL) 
data<-a[1:7,]
leaps<-regsubsets(Zscore~VpdL+PARo+Ci.Ca+RHsfc+AHs.Cs,data=data,nbest=15)
color<-colorRampPalette(c("#0278ae"))(100)
plot(leaps,scale="adjr2",col = color,main="Plot of All-subsets Features Regression")

#Figure 7
#Figure 7(a)
a <- c(0.8573,0.8596,0.8738,0.8541)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "Values",
        col=c("#7b113a","#150e56","#FE817D","#81B8DF"),ylim=c(0,1))
title(main="R^2 of Four SVR methods on the training set")
#Figure 7(b)
a <- c(0.0573,0.0550,0.0396,0.0609)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "MSE",
        col=c("#7b113a","#150e56","#FE817D","#81B8DF"),ylim=c(0,0.07))
title(main="MSE of Four SVR methods on the training set")
#Figure 7(c)
a <- c(0.0885,0.0832,0.0585,0.0933)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "MRE",
        col=c("#7b113a","#150e56","#FE817D","#81B8DF"),ylim=c(0,0.1))
title(main="MRE of Four SVR methods on the training set")

#Figure 8
#Figure 8(a)
a <- c(0.8472,0.8492,0.8581,0.7844)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "Values",
        col=c("#7b113a","#150e56","#FE817D","#81B8DF"),ylim=c(0,1))
title(main="R^2 of Four SVR methods on the test set")
#Figure 8(b)
a <- c(0.0354,0.0341,0.0104,0.0668)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "MSE",
        col=c("#7b113a","#150e56","#FE817D","#81B8DF"),ylim=c(0,0.08))
title(main="MSE of Four SVR methods on the test set")
#Figure 8(c)
a <- c(0.1049,0.0985,0.0978,0.1012)
b<-c("Hclust","Lasso","Stepwise","All-subsets")
barplot(a,names.arg=b,xlab="Methods",ylab = "MRE",
        col=c("#7b113a","#150e56","#FE817D","#81B8DF"),ylim=c(0,0.12))
title(main="MRE of Four SVR methods on the test set")

#Lasso
#install.packages("tidyverse")
#install.packages("broom")
#install.packages("glmnet")
library("tidyverse")
library("broom")
library("glmnet")
data<-read.csv("C:/Users/X_X-lin/Desktop/修改/AVG.csv",header = T,row.names=NULL)
data<-as.matrix(data[,2:7])
x<-data[1:7,-6]
y<-data[1:7,6]
cvfit=cv.glmnet(x,y,type.measure="mse",nfolds=6,alpha=1)
cvfit$lambda.min
lasso<-glmnet(x,y,family="gaussian",alpha=1)
ridge.coef<-predict(lasso,s=0.04,type="coefficients")
ridge.coef

#Stepwise
#install.packages("MASS")
library(MASS)
data<-read.csv("C:/Users/X_X-lin/Desktop/修改/AVG.csv",header = T,row.names=NULL) 
fit<-lm(data[,7]~data[,2]+data[,3]+data[,4]+data[,5]+data[,6])
stepAIC(fit,direction="backward")