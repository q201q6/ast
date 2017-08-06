% p=[0 0 1 1;0 1 0 1];
% t=[0 1 0 1];
% net=newff(minmax(p),[3,1],{'tansig','purelin'},'trainlm');
% net.trainParam.epochs=1000;
% net.trainParam.goal=0.001;
% LP.lr=0.1;
% net.trainParam.show=20;
% net=train(net,p,t);
% out=sim(net,p);
% fprintf('out= ');fprintf('%f ', out');



% 
% P=[ 3.2 3.2 3 3.2 3.2 3.4 3.2 3 3.2 3.2 3.2 3.9 3.1 3.2;
%     9.6 10.3 9 10.3 10.1 10 9.6 9 9.6 9.2 9.5 9 9.5 9.7;
%     3.45 3.75 3.5 3.65 3.5 3.4 3.55 3.5 3.55 3.5 3.4 3.1 3.6 3.45;
%     2.15 2.2 2.2 2.2 2 2.15 2.14 2.1 2.1 2.1 2.15 2 2.1 2.15;
%     140 120 140 150 80 130 130 100 130 140 115 80 90 130;
%     2.8 3.4 3.5 2.8 1.5 3.2 3.5 1.8 3.5 2.5 2.8 2.2 2.7 4.6;
%     11 10.9 11.4 10.8 11.3 11.5 11.8 11.3 11.8 11 11.9 13 11.1 10.85;
%     50 70 50 80 50 60 65 40 65 50 50 50 70 70];
% T=[2.24 2.33 2.24 2.32 2.2 2.27 2.2 2.26 2.2 2.24 2.24 2.2 2.2 2.35];
% [p1,minp,maxp,t1,mint,maxt]=premnmx(P,T);
% %创建网络
% net=newff(minmax(P),[8,6,1],{'tansig','tansig','purelin'},'trainlm');
% 
% net.trainParam.epochs = 5000;%设置训练次数
% net.trainParam.goal=0.0000001;%设置收敛误差
% net.trainParam.lr = 0.1;%学习率
% net.trainparam.show = 500;%显示中间结果的周期
% 
% %训练网络
% [net,tr]=train(net,p1,t1);
% trainlm, Epoch 0/5000, MSE 0.533351/1e-007, Gradient 18.9079/1e-010
% TRAINLM, Epoch 24/5000, MSE 8.81926e-008/1e-007, Gradient 0.0022922/1e-010
% TRAINLM, Performance goal met.
%  
% %输入数据
% a=[3.0;9.3;3.3;2.05;100;2.8;11.2;50];
% %将输入数据归一化
% a=premnmx(a);
% %放入到网络输出数据
% b=sim(net,a);
% %将得到的数据反归一化得到预测数据
% c=postmnmx(b,mint,maxt);








% close all 
% clear 
% %echo on
% clc; 
% % NEWFF——生成一个新的前向神经网络 
% % TRAIN——对 BP 神经网络进行训练 
% % SIM——对 BP 神经网络进行仿真 
% %pause        
% %  敲任意键开始 
% %clc 
% %  定义训练样本 
% % P 为输入矢量 
% P=[-1,  -2,    3,    1;       -1,    1,    5,  -3];
% % T 为目标矢量 
% T=[-1, -1, 1, 1]; 
% %pause; 
% %clc 
% %  创建一个新的前向神经网络 
% net=newff(minmax(P),[3,1],{'tansig','purelin'},'traingdm')
% %  当前输入层权值和阈值 
% inputWeights=net.IW{1,1} 
% inputbias=net.b{1} 
% %  当前网络层权值和阈值 
% layerWeights=net.LW{2,1} 
% layerbias=net.b{2} 
% %pause 
% %clc 
% %  设置训练参数 
% net.trainParam.show = 50; 
% net.trainParam.lr = 0.05; 
% net.trainParam.mc = 0.9; 
% net.trainParam.epochs = 1000; 
% net.trainParam.goal = 1e-3; 
% %pause 
% %clc 
% %  调用 TRAINGDM 算法训练 BP 网络 
% [net,tr]=train(net,P,T); 
% %pause
% %clc 
% %  对 BP 网络进行仿真 
% A = sim(net,P) 
% %  计算仿真误差 
% E = T - A 
% MSE=mse(E) 
% %pause 
% %clc 
% echo off 











% %用神经网络解决异或问题
% clear
% clc
% ms=4;%设置4个模式
% a=[0 0;0 1;1 0;1 1];%设置输入模式向量
% y=[0,1,1,0];%设置输出向量
% n=2;%输入量的个数
% m=3;%隐层量的个数
% k=1;%输出层的个数
% w=rand(2,3);%为输入层到隐层的权值赋初值
% v=rand(3,1);%为隐层到输出层的权值赋权值
% yyuzhi=rand(1,m);%为输入层到隐层的阈值赋初值
% scyuzhi=rand(1,1);%为隐层到输出层的阈值赋权值
% maxcount=10000;%设置最大的计数
% precision=0.00001;%设置精度
% speed=0.2;%设置训练率
% count=1;%设置计数器的初始值
% 
% while(count<=maxcount)
%     cc=1;
%     while(cc<=ms)
%     %计算输出层的期望输出
%         for l=1:k
%             o(l)=y(cc);
%         end
%         %获得输入的向量
%         for i=1:n
%             x(i)=a(cc,i);
%         end
%         %计算隐层的输入输出
%         for j=1:m
%             s=0;
%             for i=1:n
%                 s=s+w(i,j)*x(i);
%             end
%             s=s-yyuzhi(j);
%             b(j)=1/(1+(exp(-s)));
%         end
%         
%         %计算输出层的输入输出
%         %for t=1:k 此处k为1，所以循环不写
%         ll=0;
%         for j=1:m
%             ll=ll+v(j)*b(j);
%         end
%         ll=ll-scyuzhi;
%         %c(t)=l/(1+exp(-l))引文k为1，所以直接用下式
%         c=l/(1+exp(-ll));
%         %计算误差
%         errort=(1/2)*((o(l)-c)^2);
%         errortt(cc)=errort;
%         %计算输出层各单元的一般化误差
%         scyiban=(o(l)-c)*c*(1-c);
%         %计算隐层的一般化误差
%         for j=1:m
%             e(j)=scyiban*v(j)*b(j)*(1-b(j));
%         end
% 
%         %修正隐层到输出层连接权值和输出层各阈值
%         for j=1:m
%             v(j)=v(j)+speed*scyiban*b(j);
%         end
%         scyuzhi=scyuzhi+speed*scyiban;
%         %修正输入层到中间层的权值和阈值
%         for i=1:n
%             for j=1:m
%                 w(i,j)=w(i,j)+speed*e(j)*x(i);
%             end
%         end
%         for j=1:m
%             yyuzhi(j)=yyuzhi(j)-speed*e(j);
%         end
%         cc=cc+1;
%     end
% 
%     %计算count一次后的误差
%     tmp=0;
%     for i=1:ms
%         tmp=tmp+errortt(i)*errortt(i);
%     end
%     tmp=tmp/ms;
% 	error(count)=sqrt(tmp);
% 
%     %判断是否小于误差精度
%     if (error(count)<precision);
%         break;
%     end
%     count=count+1;
% end
% 
% errortt
% count
% p=1:count-1;
% plot(p,error(p))










p = [ 0 0 1 1;
      0 1 0 1];
t = [ 0 1 1 0];
%net = newff(minmax(p), [4 1], {'tansig' 'purelin'}, 'traingdm');
net = newff(minmax(p), [4 1], {'tansig' 'purelin'}, 'traingdm');
net.trainParam.show = 20000; 
net.trainParam.lr = 0.05; 
net.trainParam.mc = 0.9; 
net.trainParam.epochs = 10000; 
net.trainParam.goal = 0.00001; 
[net, tr] = train(net, p, t);
A = sim(net, p);
MSE = mse(t - A);
fprintf('A = ');fprintf('%f ', A'); fprintf('\n');
fprintf('MSE = ');fprintf('%f ', MSE); fprintf('\n');

