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
% %��������
% net=newff(minmax(P),[8,6,1],{'tansig','tansig','purelin'},'trainlm');
% 
% net.trainParam.epochs = 5000;%����ѵ������
% net.trainParam.goal=0.0000001;%�����������
% net.trainParam.lr = 0.1;%ѧϰ��
% net.trainparam.show = 500;%��ʾ�м���������
% 
% %ѵ������
% [net,tr]=train(net,p1,t1);
% trainlm, Epoch 0/5000, MSE 0.533351/1e-007, Gradient 18.9079/1e-010
% TRAINLM, Epoch 24/5000, MSE 8.81926e-008/1e-007, Gradient 0.0022922/1e-010
% TRAINLM, Performance goal met.
%  
% %��������
% a=[3.0;9.3;3.3;2.05;100;2.8;11.2;50];
% %���������ݹ�һ��
% a=premnmx(a);
% %���뵽�����������
% b=sim(net,a);
% %���õ������ݷ���һ���õ�Ԥ������
% c=postmnmx(b,mint,maxt);








% close all 
% clear 
% %echo on
% clc; 
% % NEWFF��������һ���µ�ǰ�������� 
% % TRAIN������ BP ���������ѵ�� 
% % SIM������ BP ��������з��� 
% %pause        
% %  ���������ʼ 
% %clc 
% %  ����ѵ������ 
% % P Ϊ����ʸ�� 
% P=[-1,  -2,    3,    1;       -1,    1,    5,  -3];
% % T ΪĿ��ʸ�� 
% T=[-1, -1, 1, 1]; 
% %pause; 
% %clc 
% %  ����һ���µ�ǰ�������� 
% net=newff(minmax(P),[3,1],{'tansig','purelin'},'traingdm')
% %  ��ǰ�����Ȩֵ����ֵ 
% inputWeights=net.IW{1,1} 
% inputbias=net.b{1} 
% %  ��ǰ�����Ȩֵ����ֵ 
% layerWeights=net.LW{2,1} 
% layerbias=net.b{2} 
% %pause 
% %clc 
% %  ����ѵ������ 
% net.trainParam.show = 50; 
% net.trainParam.lr = 0.05; 
% net.trainParam.mc = 0.9; 
% net.trainParam.epochs = 1000; 
% net.trainParam.goal = 1e-3; 
% %pause 
% %clc 
% %  ���� TRAINGDM �㷨ѵ�� BP ���� 
% [net,tr]=train(net,P,T); 
% %pause
% %clc 
% %  �� BP ������з��� 
% A = sim(net,P) 
% %  ���������� 
% E = T - A 
% MSE=mse(E) 
% %pause 
% %clc 
% echo off 











% %�����������������
% clear
% clc
% ms=4;%����4��ģʽ
% a=[0 0;0 1;1 0;1 1];%��������ģʽ����
% y=[0,1,1,0];%�����������
% n=2;%�������ĸ���
% m=3;%�������ĸ���
% k=1;%�����ĸ���
% w=rand(2,3);%Ϊ����㵽�����Ȩֵ����ֵ
% v=rand(3,1);%Ϊ���㵽������Ȩֵ��Ȩֵ
% yyuzhi=rand(1,m);%Ϊ����㵽�������ֵ����ֵ
% scyuzhi=rand(1,1);%Ϊ���㵽��������ֵ��Ȩֵ
% maxcount=10000;%�������ļ���
% precision=0.00001;%���þ���
% speed=0.2;%����ѵ����
% count=1;%���ü������ĳ�ʼֵ
% 
% while(count<=maxcount)
%     cc=1;
%     while(cc<=ms)
%     %�����������������
%         for l=1:k
%             o(l)=y(cc);
%         end
%         %������������
%         for i=1:n
%             x(i)=a(cc,i);
%         end
%         %����������������
%         for j=1:m
%             s=0;
%             for i=1:n
%                 s=s+w(i,j)*x(i);
%             end
%             s=s-yyuzhi(j);
%             b(j)=1/(1+(exp(-s)));
%         end
%         
%         %�����������������
%         %for t=1:k �˴�kΪ1������ѭ����д
%         ll=0;
%         for j=1:m
%             ll=ll+v(j)*b(j);
%         end
%         ll=ll-scyuzhi;
%         %c(t)=l/(1+exp(-l))����kΪ1������ֱ������ʽ
%         c=l/(1+exp(-ll));
%         %�������
%         errort=(1/2)*((o(l)-c)^2);
%         errortt(cc)=errort;
%         %������������Ԫ��һ�㻯���
%         scyiban=(o(l)-c)*c*(1-c);
%         %���������һ�㻯���
%         for j=1:m
%             e(j)=scyiban*v(j)*b(j)*(1-b(j));
%         end
% 
%         %�������㵽���������Ȩֵ����������ֵ
%         for j=1:m
%             v(j)=v(j)+speed*scyiban*b(j);
%         end
%         scyuzhi=scyuzhi+speed*scyiban;
%         %��������㵽�м���Ȩֵ����ֵ
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
%     %����countһ�κ�����
%     tmp=0;
%     for i=1:ms
%         tmp=tmp+errortt(i)*errortt(i);
%     end
%     tmp=tmp/ms;
% 	error(count)=sqrt(tmp);
% 
%     %�ж��Ƿ�С������
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

