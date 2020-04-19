
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

% �뾶/������=1��Ч�����У������5������
% 2018.09.25
% ele̽�ⷶΧ��12��-90�㣬����11�����¡�70������Ϊ��Բ
% ��MUSIC�㷨��Ƚ϶��ԣ��԰ꡢ�Ӱ�϶࣬����λ����Ҫ��
% ���󲿷���3������
% ���ݹ�һ����Ч������
% 2018.09.26
% ���ڳɹ���
% ��λ��׼��������˷�����̫��
% ���ӵ�16��Ԫ����
% 2018.11.9
% ����M=12
% 2018.11.13

clc
clear 
close all

%%
%����
r=0.17;%Բ��뾶����λm
dw=1;  % �뾶������ (ע����İ뾶��Ҫ������)
M=16;%��Ԫ����
c=340;%����,��λ��m/s
N=10000;%��������
n=(1:N);
fs=50000;
%��Դ�źŵĲ���
f1=2000;%Ƶ�ʣ��ǽ�Ƶ��w��2*pi��֮һ
t=0:0.000001:0.02;
lamda=c/f1;%����,��λ��m
%%
%������Դ�ź�
%real=cos(2*pi*freq*d/c)
%imag=sin(2*pi*freq*d/c)
%s=3*sin(2*pi*f1*t)+cos(2*pi*f2*t);

%��Դ�źż���ͼ
s=3*sin(2*pi*f1*t);
figure(1)
plot(t,s)
grid on;
%��Դλ��
x=0.05;
y=0.05;
z=20;

rc=sqrt(x^2+y^2+z^2)%��Դ���������ĵľ���
%�Ƕ�
ele_d=asind(z/rc)
azi_d=atand(y/x)
%����
ele_r=asin(z/rc);%������,��xoyƽ��н�
azi_r=atan(y/x);%��λ�ǣ���x������н�

%��Ԫλ��
for i=1:M
    %element(i)=(l*cos((i-1)*2*pi/M),l*sin((i-1)*2*pi/M),0);
    e(i,1)=r*cos((i-1)*2*pi/M);%��Ԫx������
    e(i,2)=r*sin((i-1)*2*pi/M);%��Ԫy������
    e(:,3)=0;%��Ԫz������
end
figure(2)
scatter3(x,y,z,20,'gp')%��Դ����
hold on
scatter3(e(:,1),e(:,2),e(:,3),20,'r')%��Ԫ����
hold on
plot3([x,0],[y,0],[z,0])
grid on

%����ʱ��
T_D=rc/c;%delay 

td=zeros(1,M);
for i=1:M
    %rm(1,i)=sqrt(rc^2+r^2-2*r*rc*z/rc*cos(azi_r+2*pi*(i-1)/M));
    td(1,i)=(r*sin(ele_r)*cos((azi_r)-(i-1)*2*pi/M))/c;%��Բο���Ԫ��ʱ��
    %td(1,i)=(r*sin(ele_d)*cos((azi_d)-(i-1)*2*pi/M))/c;%��Բο���Ԫ��ʱ��
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
%���н��յ��ź�
X=zeros(M,N);
for i=1:M
   % x(i,:)=3*sin(2*pi*f1*(n/fs-TD(1,i)));
   X(i,:)=3*sin(2*pi*f1*(n/fs-TD(1,i)));
    %X(i,:)=sin(2*pi*f1*(n/fs-td(1,i)));
    %X(i,:)=sin(2*pi*f1*t-2*pi*f1*(r_m-r1)/c)
end


%%
%CBF_UCA_��֤
Pmax=zeros(1,3);
R=X*X';                   % M*MЭ�������
for azi=1:1:180%azimuthΪ0-180
    for ele=1:1:90%elevationΪ0-90
        for m=1:M
            AQ1(m,1)=exp(-1i*2*pi*dw*cos(azi*pi/180-2*pi*(m-1)/M)*sin(ele*pi/180));%8��1,��CBF��˵��Ȩ�����뵼��������ͬ��Բ��
            %AQ1(m,1)=exp(-1i*2*pi*f1*l*sin(ele)*(cos(azi)-cos((m*2*pi/M)-azi))/c);
            %AQ2(m,1)=r/rm(1,m)*exp(-1i*2*pi*f1*(rm(1,m)-r)/c);
        end
        PowerOut=AQ1'*R*AQ1; %�����γ������������
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
colorbar %���ɫ��
title('UCA CBF');
xlabel('azimuth');
ylabel('elevation');
zlabel('PowerOut');
grid on
ele_c=Pmax(3)
azi_c= Pmax(2)

