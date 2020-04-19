clear;
close all;
clc;
ANGLE_RESOLUTION=500;
speedSound=340;% sound speed in air
numElements=4;
spacing=0.2;
freq=1000;

% w=0.5;
% t=1:100;
% s1=exp(1i*w*t);%这里构造了一个单频信号
% plot(t,s1)
% n=(0:100)'
angle=zeros(ANGLE_RESOLUTION,1);
angleRad=zeros(ANGLE_RESOLUTION,1);
for a=0:1:ANGLE_RESOLUTION
    angle(a+1)=-90+180*a/(ANGLE_RESOLUTION-1);%弧度
    angleRad(a+1)=pi*angle(a+1)/180;%角度
    realSum=0;%实部
    imagSum=0;%虚部
%     for i=0:1:numElements
%         position=i*spacing;%x距参考点距离
%         delay=position*sin(angleRad)/speedSound;%x*sin(θ)/c延迟时间
%         realSum=realSum+cos(2*pi*freq*delay);
%         imagSum=imagSum+sin(2*pi*freq*delay);
%     end
%     output=sqrt(realSum*realSum+imagSum*imagSum)/numElements;
%     logOutput=20*log10(output);
%     if logOutput<-50
%         logOutput=-50;
%     end
%     plot(logOutput);
%     hold on;
    
end

        