clear;close all;clc
M=16;%阵元数
R=0.15;%半径
theta=0;phi=0;%信号入射方向
c=340;%声速
pm=zeros(M,3);
tau=zeros(M,1);
tau2=zeros(M,1);
for m=1:M
    pm(m,:)=[R*cos(2*pi*m/M) R*sin(2*pi*m/M) 0];%阵元坐标
    tau(m,:)=-1/c*(R*cos(2*pi*m/m)*sin(theta)*cos(phi)+R*sin(2*pi*m/M)*sin(theta)*sin(phi));%距原点的时延
    tau2(m,:)=-R/c*sin(theta)*cos(phi-2*pi*m/M);
    xiang()=-2*pi/lamda*R*sin(theta)*cos(phi-2*pi*m/M)
end
scatter3(pm(:,1),pm(:,2),pm(:,3),'r');
hold on
r=[sin(theta)*cos(phi) sin(theta)*sin(phi) cos(theta)];%信号入射方向的归一化向量
isequal(tau,tau2)

