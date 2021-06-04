clear;
clc;
x1=xlsread('AVG.xlsx','B2:B21');
x2=xlsread('AVG.xlsx','D2:D21');
x3=xlsread('AVG.xlsx','E2:E21');
x4=xlsread('AVG.xlsx','F2:F21');
x5=xlsread('AVG.xlsx','H2:H21');
x6=xlsread('AVG.xlsx','I2:I21');
x7=xlsread('AVG.xlsx','J2:J21');
x8=xlsread('AVG.xlsx','L2:L21');
x9=xlsread('AVG.xlsx','M2:M21');
x10=xlsread('AVG.xlsx','N2:N21');
Y=xlsread('AVG.xlsx','O2:O21');
%Hclust SVR
HX=[x1(1:16),x2(1:16),x4(1:16),x8(1:16),x9(1:16),x10(1:16)];
testHX=[x1(17:20),x2(17:20),x4(17:20),x8(17:20),x9(17:20),x10(17:20)];
model1=svmtrain(Y(1:16),HX,'-s 3 -t 2 -c 198 -g 0.0015 -p 0.001 ');
[py1,mse1]=svmpredict(Y(1:16),HX,model1);
[ptesty1,tmse1]=svmpredict(Y(17:20),testHX,model1);
Hmse1=sum((Y(1:16)-py1).*(Y(1:16)-py1)) /16;
Hmse2=sum((Y(17:20)-ptesty1).*(Y(17:20)-ptesty1)) /4;
%LASSO SVR
LX=[x4(1:16),x5(1:16),x8(1:16)];
testLX=[x4(17:20),x5(17:20),x8(17:20)];
model2=svmtrain(Y(1:16),LX,'-s 3 -t 2 -c 228  -g 0.0015 -p 0.01 ');
[py2,mse2]=svmpredict(Y(1:16),LX,model2);
[ptesty2,tmse2]=svmpredict(Y(17:20),testLX,model2);
Lmse1=sum((Y(1:16)-py2).*(Y(1:16)-py2)) /16;
Lmse2=sum((Y(17:20)-ptesty2).*(Y(17:20)-ptesty2)) /4;
%Stepwise SVR
SX=[x1(1:16),x2(1:16),x3(1:16),x5(1:16),x6(1:16),x7(1:16),x9(1:16)];
testSX=[x1(17:20),x2(17:20),x3(17:20),x5(17:20),x6(17:20),x7(17:20),x9(17:20)];
model3=svmtrain(Y(1:16),SX,'-s 3 -t 2 -c 19  -g 0.4 -p 0.001 ');
[py3,mse3]=svmpredict(Y(1:16),SX,model3);
[ptesty3,tmse3]=svmpredict(Y(17:20),testSX,model3);
Smse1=sum((Y(1:16)-py3).*(Y(1:16)-py3)) /16;
Smse2=sum((Y(17:20)-ptesty3).*(Y(17:20)-ptesty3)) /4;
%All-subsets SVR
RX=[x3(1:16),x5(1:16),x9(1:16)];
testRX=[x3(17:20),x5(17:20),x9(17:20)];
model4=svmtrain(Y(1:16),RX,'-s 3 -t 2 -c 1.5  -g 5.9 -p 0.001 ');
[py4,mse4]=svmpredict(Y(1:16),RX,model4);
[ptesty4,tmse4]=svmpredict(Y(17:20),testRX,model4);
Rmse1=sum((Y(1:16)-py4).*(Y(1:16)-py4)) /16;
Rmse2=sum((Y(17:20)-ptesty4).*(Y(17:20)-ptesty4)) /4;

%Figure 6(a)
figure(1)
subplot(2,2,1)
plot(Y(1:16),'r*-','linewidth',2.5,'MarkerSize',9)
hold on
plot(py1,'b+--','linewidth',2.5,'MarkerSize',9)
hold on
legend('Actual','Predicted')
title('Hclust SVR','FontSize',13)
xlabel('Poplar samples')
ylabel('Values')
subplot(2,2,2)
plot(Y(1:16),'r*-','linewidth',2.5,'MarkerSize',9)
hold on
plot(py2,'b+--','linewidth',2.5,'MarkerSize',9)
hold on
legend('Actual','Predicted')
title('LASSO SVR','FontSize',13)
xlabel('Poplar samples')
ylabel('Values')
subplot(2,2,3)
plot(Y(1:16),'r*-','linewidth',2.5,'MarkerSize',9)
hold on
plot(py3,'b+--','linewidth',2.5,'MarkerSize',9)
hold on
legend('Actual','Predicted')
title('Stepwise SVR','FontSize',13)
xlabel('Poplar samples')
ylabel('Values')
subplot(2,2,4)
plot(Y(1:16),'r*-','linewidth',2.5,'MarkerSize',9)
hold on
plot(py4,'b+--','linewidth',2.5,'MarkerSize',9)
hold on
legend('Actual','Predicted')
title('All-subsets SVR','FontSize',13)
xlabel('Poplar samples')
ylabel('Values')
 
%Figure 6(b)
figure(2)
subplot(2,2,1)
plot(Y(17:20),'r*-','linewidth',2.5,'MarkerSize',9)
hold on
plot(ptesty1,'b+--','linewidth',2.5,'MarkerSize',9)
hold on
legend('Actual','Predicted')
title('Hclust SVR','FontSize',13)
xlabel('Poplar samples')
ylabel('Values')
subplot(2,2,2)
plot(Y(17:20),'r*-','linewidth',2.5,'MarkerSize',9)
hold on
plot(ptesty2,'b+--','linewidth',2.5,'MarkerSize',9)
hold on
legend('Actual','Predicted')
title('LASSO SVR','FontSize',13)
xlabel('Poplar samples')
ylabel('Values')
subplot(2,2,3)
plot(Y(17:20),'r*-','linewidth',2.5,'MarkerSize',9)
hold on
plot(ptesty3,'b+--','linewidth',2.5,'MarkerSize',9)
hold on
legend('Actual','Predicted')
title('Stepwise SVR','FontSize',13)
xlabel('Poplar samples')
ylabel('Values')
subplot(2,2,4)
plot(Y(17:20),'r*-','linewidth',2.5,'MarkerSize',9)
hold on
plot(ptesty4,'b+--','linewidth',2.5,'MarkerSize',9)
hold on
legend('Actual','Predicted')
title('All-subsets SVR','FontSize',13)
xlabel('Poplar samples')
ylabel('Values')
%Figure 6(c)
figure(3)
subplot(1,2,1)
plot(Y(1:16),'r*-','linewidth',2.5,'MarkerSize',9)
hold on;
plot(py1,'b+--','linewidth',2.5,'MarkerSize',9)
hold on;
plot(py2,'go-.','linewidth',2.5,'MarkerSize',9)
hold on;
plot(py3,'kx:','linewidth',2.5,'MarkerSize',9)
plot(py4,'b+--','linewidth',2.5,'MarkerSize',9)
hold on
legend('Actual','Hclust','Lasso','Stepwise','All-subsets')
title('Three MLP methods','FontSize',14)
xlabel('Poplar samples')
ylabel('Values')
subplot(1,2,2)
plot(Y(17:20),'r*-','linewidth',2.5,'MarkerSize',9)
hold on;
plot(ptesty1,'b+--','linewidth',2.5,'MarkerSize',9)
hold on;
plot(ptesty2,'go-.','linewidth',2.5,'MarkerSize',9)
hold on;
plot(ptesty3,'kx:','linewidth',2.5,'MarkerSize',9)
plot(ptesty4,'b+--','linewidth',2.5,'MarkerSize',9)
hold on
legend('Actual','Hclust','Lasso','Stepwise','All-subsets')
title('Three MLP methods','FontSize',14)
xlabel('Poplar samples')
ylabel('Values')

%Training set MSE
Hmse1,Lmse1,Smse1,Rmse1
%Test set MSE
Hmse2,Lmse2,Smse2,Rmse2

%OverallR^2
HR2=1-sum((Y(1:20) -ty1).*(Y(1:20)-ty1)) /sum((ty1-mean(Y(1:20))).*(ty1-mean(Y(1:20))))
LR2=1-sum((Y(1:20) -ty2).*(Y(1:20)-ty2)) /sum((ty2-mean(Y(1:20))).*(ty2-mean(Y(1:20))))
SR2=1-sum((Y(1:20) -ty3).*(Y(1:20)-ty3)) /sum((ty3-mean(Y(1:20))).*(ty3-mean(Y(1:20))))
RR2=1-sum((Y(1:20) -ty4).*(Y(1:20)-ty4)) /sum((ty4-mean(Y(1:20))).*(ty4-mean(Y(1:20))))

%Overall MSE
HX1=[x1(1:20),x2(1:20),x4(1:20),x8(1:20),x9(1:20),x10(1:20)];
LX1=[x4(1:20),x5(1:20),x8(1:20)];
SX1=[x1(1:20),x2(1:20),x3(1:20),x5(1:20),x6(1:20),x7(1:20),x9(1:20)];
RX1=[x3(1:20),x5(1:20),x9(1:20)];
[ty1,amse1]=svmpredict(Y(1:20),HX1,model1);
[ty2,amse2]=svmpredict(Y(1:20),LX1,model2);
[ty3,amse3]=svmpredict(Y(1:20),SX1,model3);
[ty4,amse4]=svmpredict(Y(1:20),RX1,model4);
Hmse3=sum((Y(1:20)-ty1).*(Y(1:20)-ty1)) /20;
Lmse3=sum((Y(1:20)-ty2).*(Y(1:20)-ty2)) /20;
Smse3=sum((Y(1:20)-ty3).*(Y(1:20)-ty3)) /20;
Rmse3=sum((Y(1:20)-ty4).*(Y(1:20)-ty4)) /20;
Hmse3,Lmse3,Smse3,Rmse3

%Overall MRE
Hmre=sum(abs((Y(1:20)-ty1)./Y(1:20))) /20
Lmre=sum(abs((Y(1:20)-ty2)./Y(1:20))) /20
Smre=sum(abs((Y(1:20)-ty3)./Y(1:20))) /20
Rmre=sum(abs((Y(1:20)-ty4)./Y(1:20))) /20
