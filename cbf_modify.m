
 %                           Y
 %                           |
 %                           |
 %
 %                           3        
 %                   2       *        4
 %                      *    *     *
 %                        *  *  *
 %    X<----     1 * * * * * * * * * * * 5
 %                        *  *  *
 %                     *     *     *
 %                   8       *       6
 %                           7
 %                UCA micphone array figure                  
 %                      2018.08.10

% 半径/波长比=1，效果还行，误差在5°以内
% 2018.09.25
% ele探测范围是12°-90°，其中11°以下、70°以上为半圆
% 与MUSIC算法相比较而言，旁瓣、杂瓣较多，但定位精度要好
% 误差大部分在3°以内
% 数据归一化后效果不好
% 2018.09.26
% 终于成功了
% 定位不准是由于麦克风阵列太少
% 增加到16阵元即可
% 2018.11.9
% 最少M=12
% 2018.11.13

clc
clear 
close all

%%
%参数
r=0.17;%圆阵半径，单位m
dw=1;  % 半径波长比 (注意更改半径后还要改这里)
M=16;%阵元个数
c=340;%声速,单位：m/s
N=10000;%采样点数
n=(1:N);
fs=50000;
%声源信号的参数
f1=2000;%频率，是角频率w的2*pi分之一
t=0:0.000001:0.02;
lamda=c/f1;%波长,单位：m
%%
%构造声源信号
%real=cos(2*pi*freq*d/c)
%imag=sin(2*pi*freq*d/c)
%s=3*sin(2*pi*f1*t)+cos(2*pi*f2*t);

%声源信号及绘图
s=3*sin(2*pi*f1*t);
figure(1)
plot(t,s)
grid on;
%声源位置
x=0.05;
y=0.05;
z=20;

rc=sqrt(x^2+y^2+z^2)%声源到阵列中心的距离
%角度
ele_d=asind(z/rc)
azi_d=atand(y/x)
%弧度
ele_r=asin(z/rc);%俯仰角,与xoy平面夹角
azi_r=atan(y/x);%方位角，与x正半轴夹角

%阵元位置
for i=1:M
    %element(i)=(l*cos((i-1)*2*pi/M),l*sin((i-1)*2*pi/M),0);
    e(i,1)=r*cos((i-1)*2*pi/M);%阵元x轴坐标
    e(i,2)=r*sin((i-1)*2*pi/M);%阵元y轴坐标
    e(:,3)=0;%阵元z轴坐标
end
figure(2)
scatter3(x,y,z,20,'gp')%声源坐标
hold on
scatter3(e(:,1),e(:,2),e(:,3),20,'r')%阵元坐标
hold on
plot3([x,0],[y,0],[z,0])
grid on

%到达时间
T_D=rc/c;%delay 

td=zeros(1,M);
for i=1:M
    %rm(1,i)=sqrt(rc^2+r^2-2*r*rc*z/rc*cos(azi_r+2*pi*(i-1)/M));
    td(1,i)=(r*sin(ele_r)*cos((azi_r)-(i-1)*2*pi/M))/c;%相对参考阵元的时延
    %td(1,i)=(r*sin(ele_d)*cos((azi_d)-(i-1)*2*pi/M))/c;%相对参考阵元的时延
%   td(1,i)=(l*sin(ele_r)*(cos(azi_r)-cos((i-1)/M*2*pi-azi_r)))/c;
end

TD=zeros(1,M);
for i=1:M
    TD(1,i)=td(1,i)+T_D;
end

% for i=1:M
%     TD(1,i)=r*sin(ele_r)*(cos(azi_r)-cos(((i-1)*2*pi/M)-azi_r))/c;
% end
%%
%阵列接收的信号
X=zeros(M,N);
for i=1:M
   % x(i,:)=3*sin(2*pi*f1*(n/fs-TD(1,i)));
   X(i,:)=3*sin(2*pi*f1*(n/fs-TD(1,i)));
    %X(i,:)=sin(2*pi*f1*(n/fs-td(1,i)));
    %X(i,:)=sin(2*pi*f1*t-2*pi*f1*(r_m-r1)/c)
end


%%
%CBF_UCA_验证
Pmax=zeros(1,3);
R=X*X';                   % M*M协方差矩阵
for azi=1:1:180%azimuth为0-180
    for ele=1:1:90%elevation为0-90
        for m=1:M
            AQ1(m,1)=exp(-1i*2*pi*dw*cos(azi*pi/180-2*pi*(m-1)/M)*sin(ele*pi/180));%8行1,对CBF来说加权向量与导向向量相同，圆阵
            %AQ1(m,1)=exp(-1i*2*pi*f1*l*sin(ele)*(cos(azi)-cos((m*2*pi/M)-azi))/c);
            %AQ2(m,1)=r/rm(1,m)*exp(-1i*2*pi*f1*(rm(1,m)-r)/c);
        end
        PowerOut=AQ1'*R*AQ1; %波束形成器的输出功率
        PowerOutD=abs(PowerOut);
        %x1=max(PowerOutD);
        if Pmax(1)<PowerOutD
            Pmax(1)=PowerOutD;
            Pmax(2)=azi;
            Pmax(3)=ele;
        end
        P(ele,azi)=abs(PowerOut);   %90*180
        
        
    end
end
% azimuth=(1:90);
% elevation=(1:90);
% r=r*ones(90);
% [x,y,z]=sph2cart(azimuth,elevation,r)

% P1=shiftdim(P,90)

figure(3)
contourf(P)
colorbar %添加色标
title('UCA CBF');
xlabel('azimuth');
ylabel('elevation');
zlabel('PowerOut');
grid on
ele_c=Pmax(3)
azi_c= Pmax(2)

