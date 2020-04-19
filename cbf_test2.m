clear 
close all 
clc
r=0.2;
ra=3;
M=16;
c=340;
ele=10;
azi=40;
f=2000;
t=0:0.000001:0.02;
y=cos(2*pi*f*t);
for i=1:M
    tau(i,1)=r*sin(ele)*(cos(azi)-cos(((i-1)*2*pi/M)-azi))/c;%第i个阵元的延时
     A(i,1)=exp(-1i*2*pi*f*tau(i));%方向向量
     rm(i,1)=sqrt(ra^2+r^2-2*ra*r*sin(ele)*cos((i-1)*2*pi/M-azi));
     X(i,:)=cos(2*pi*f*t-2*pi*f*(rm(i)-rm(1))/c);
end


 R=X*X';

P=A'*R*A;