clear;close all;clc
%N=600;%快拍数
M=16;%阵元数
%N=600;
alpha=360/M;%阵元夹角
c=340%光速
f=2000;
r=0.15;%圆阵半径
tic
%%
x1  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m1.xlsx','B20002:B20602');
x2  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m2.xlsx','B20002:B20602');
x3  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m3.xlsx','B20002:B20602');
x4  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m4.xlsx','B20002:B20602');
x5  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m5.xlsx','B20002:B20602');
x6  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m6.xlsx','B20002:B20602');
x7  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m7.xlsx','B20002:B20602');
x8  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m8.xlsx','B20002:B20602');
x9  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m9.xlsx','B20002:B20602');
x10  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m10.xlsx','B20002:B20602');
x11  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m11.xlsx','B20002:B20602');
x12  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m12.xlsx','B20002:B20602');
x13  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m13.xlsx','B20002:B20602');
x14  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m14.xlsx','B20002:B20602');
x15  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m15.xlsx','B20002:B20602');
x16  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m16.xlsx','B20002:B20602');

% xmax=max(x1);
% xmin=min(x1);
% y=2*(xmax-x1)/(xmax-xmin)-1;%线性归一化
% 
% figure(1)
% subplot(2,1,1);
% plot(x1);
% subplot(2,1,2);
% plot(y);
% dt=0.00005;
% fs=1/dt%采样率，相邻两点之间间隔的倒数
% N=length(x1)%采样点数
% X=fft(x1,N);
%
% plot(abs(fftshift(X)));
% title('初始信号频谱');
% xlabel('Frequency');
% ylabel('幅度');
% grid on

N=length(x1);%采样点数
%%

%CBF_UCA_验证
imag=sqrt(-1);

dw=0.85;  % 半径波长比 (注意更改半径后还要改这里)



X=[x1';x2';x3';x4';x5';x6';x7';x8';x9';x10';x11';x12';x13';x14';x15';x16'];

%X=awgn(X,10);
Pmax=zeros(1,3);
R=X*X'/N;                   % 8*8

for i=1:16%去除对角线影响
    R(i,i)=0;
end
%R(logical(eye(size(R))))=0;

for azi=1:1:180
    for ele=1:1:90
        for m=1:M
            AQ1(m,1)=exp(-1i*2*pi*dw*cos(2*pi*(m-1)/M-azi*pi/180)*sin(ele*pi/180));%8行1
            %disp(AQ1);
        end
        % disp(AQ1);
        Power=AQ1'*R*AQ1;
        
%         SP=diag(abs(Power));
%         SP=SP/max(SP);
%         SP=20*log10(abs(SP));
        % disp(Power);
        P(ele,azi)=abs(Power);   %90*180
        if Pmax(1)<Power
            Pmax(1)=Power;
            Pmax(2)=azi;
            Pmax(3)=ele;
        end
    end
end
[ele1,azi1]=meshgrid(1:1:90,1:1:180);


figure('Name','CBF_noise','Numbertitle','off')
% Pmax=max(max(P)) ;  %找出P的最大值zmax
% [Pmax,xi_max]=max(P);
% [Pmax,yi_max]=max(Pmax);
%mesh(P);       %三维网格曲面




% contourf(P);
plot3(P)

colorbar %添加色标
colormap('jet');
xlabel('azimuth');ylabel('elevation');
grid;

ele_c=Pmax(3)
azi_c= Pmax(2)
toc
