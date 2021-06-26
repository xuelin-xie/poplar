clear;
clc;
x1=xlsread('AVG.xlsx','B2:B21');
x2=xlsread('AVG.xlsx','C2:C21');
x3=xlsread('AVG.xlsx','D2:D21');
x4=xlsread('AVG.xlsx','E2:E21');
x5=xlsread('AVG.xlsx','F2:F21');
Y=xlsread('AVG.xlsx','G2:G21');
 
%基于层次聚类SVR
HX=[x1(1:16),x2(1:16),x4(1:16)];
testHX=[x1(17:20),x2(17:20),x4(17:20)];
model1=svmtrain(Y(1:16),HX,'-s 3 -t 2 -c 15 -g 0.0015 -p 0.001 ');
[py1,mse1]=svmpredict(Y(1:16),HX,model1);
[ptesty1,tmse1]=svmpredict(Y(17:20),testHX,model1);
Hmse1=sum((Y(1:16)-py1).*(Y(1:16)-py1)) /16;
Hmse2=sum((Y(17:20)-ptesty1).*(Y(17:20)-ptesty1)) /4;
 
%基于LASSO特征选择的SVR
LX=[x1(1:16),x2(1:16),x3(1:16)];
testLX=[x1(17:20),x2(17:20),x3(17:20)];
model2=svmtrain(Y(1:16),LX,'-s 3 -t 2 -c 26  -g 0.0015 -p 0.01 ');
[py2,mse2]=svmpredict(Y(1:16),LX,model2);
[ptesty2,tmse2]=svmpredict(Y(17:20),testLX,model2);
Lmse1=sum((Y(1:16)-py2).*(Y(1:16)-py2)) /16;
Lmse2=sum((Y(17:20)-ptesty2).*(Y(17:20)-ptesty2)) /4;
 
%基于stepwise特征选择的SVR
SX=[x2(1:16),x3(1:16)];
testSX=[x2(17:20),x3(17:20)];
model3=svmtrain(Y(1:16),SX,'-s 3 -t 2 -c 2  -g 0.005 -p 0.001 ');
[py3,mse3]=svmpredict(Y(1:16),SX,model3);
[ptesty3,tmse3]=svmpredict(Y(17:20),testSX,model3);
Smse1=sum((Y(1:16)-py3).*(Y(1:16)-py3)) /16;
Smse2=sum((Y(17:20)-ptesty3).*(Y(17:20)-ptesty3)) /4;
 
%基于All-subsets特征选择的SVR
RX=[x1(1:16),x2(1:16),x3(1:16),x4(1:16),x5(1:16)];
testRX=[x1(17:20),x2(17:20),x3(17:20),x4(17:20),x5(17:20)];
model4=svmtrain(Y(1:16),RX,'-s 3 -t 2 -c 12  -g 0.001 -p 0.001 ');
[py4,mse4]=svmpredict(Y(1:16),RX,model4);
[ptesty4,tmse4]=svmpredict(Y(17:20),testRX,model4);
Rmse1=sum((Y(1:16)-py4).*(Y(1:16)-py4)) /16;
Rmse2=sum((Y(17:20)-ptesty4).*(Y(17:20)-ptesty4)) /4;
  
%在训练集上预测值
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
 
%在测试集上预测值
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
 
 
%%训练集预测对比图
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
 
%%测试集预测对比图
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
