

clc
clear 
close all


% fs  = 50000;
% N   =  5000;
M=16;
dt=0.00005;	%ÿ������ʱ���ռ�����
t=0:dt:2.49995
fs=1/dt;%�����ʣ���������֮�����ĵ���������Ƶ�ʣ�ÿ��λʱ���ռ����������
%N=length(x1)%��������,��������
% tic
%%
x1  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m1.xlsx','B20002:B20602');
% x2  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m2.xlsx','B2:B50001');
% x3  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m3.xlsx','B2:B50001');
% x4  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m4.xlsx','B2:B50001');
% x5  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m5.xlsx','B2:B50001');
% x6  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m6.xlsx','B2:B50001');
% x7  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m7.xlsx','B2:B50001');
% x8  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m8.xlsx','B2:B50001');
% x9  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m9.xlsx','B2:B50001');
% x10  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m10.xlsx','B2:B50001');
% x11  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m11.xlsx','B2:B50001');
% x12  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m12.xlsx','B2:B50001');
% x13  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m13.xlsx','B2:B50001');
% x14  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m14.xlsx','B2:B50001');
% x15  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m15.xlsx','B2:B50001');
% x16  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m16.xlsx','B2:B50001');

%X=[x1';x2';x3';x4';x5';x6';x7';x8';x9';x10';x11';x12';x13';x14';x15';x16'];
%Xs=sum(X)/M
%plot(Xs)
% for i=1:M
% r(i,:)=xcorr(X(1,:),X(1,:));
% [u,tau(i,:)]=max(r(i,:))
% ta(i)=tau(i,:)*dt
% end
%stem(lags,c)


% tic
% for i=1:M
%     X(i,:)=2*(max(X(i,:))-X(i,:))/(max(X(i,:))-min(X(i,:)))-1;
% end
% toc
% windowsize=800;%���ڳ���
% window=hanning(windowsize);%������
% nfft=windowsize;%��FFT�任�ĳ��ȣ�Ĭ��Ϊ256�ʹ���ÿ�γ��ȵ���С2����֮������ֵ�����⣬�˲�������ʹ��һ �������⣬������ָ��һ��Ƶ������F
% noverlap=windowsize-1;%ÿһ�ε��ص���������Ĭ��ֵ���ڸ���֮�����50%���ص�
%[S,F,T] = spectrogram(x1,window,noverlap,nfft,fs);
%imagesc(T,F,log10(abs(S)))

xmax=max(x1);
xmin=min(x1);
y=2*(xmax-x1)/(xmax-xmin)-1;%���Թ�һ��
% 

% x11=awgn(x1,30);
% 
% xmax=max(x11);
% xmin=min(x11);
% y11=2*(xmax-x11)/(xmax-xmin)-1;%���Թ�һ��

% figure(1)
% subplot(2,1,1);
% plot(t,x1);
% subplot(2,1,2);
% plot(y);
% figure(2)
% subplot(2,1,1);
% plot(x11);
% 
% subplot(2,1,2);
% plot(y11);

% dt=0.00005;	%ÿ������ʱ���ռ�����
% fs=1/dt;%�����ʣ���������֮�����ĵ���������Ƶ�ʣ�ÿ��λʱ���ռ����������
% %N=length(x1)%��������,��������
% % N=600
% t=(0:N-1)/fs;
% X=fft(x1,N);
% % 
% % f = (0:N-1)*(fs/N); 
% % power = abs(X).^2/N;
% t = 0:1/50:10-1/50; 
% x = sin(2*pi*30*t)
U=fft(y);
% f = (0:length(U)-1)*50/length(U);
% 
N = length(x1);                         
fshift = (-N/2:N/2-1)*(50/N);
yshift = fftshift(U);
figure
plot(fshift,abs(yshift))

% figure
% plot(f,abs(U))

% x1f=fft(x1);
% x2f=fft(x2);
% z=x1f'*x2f;
% phi=atand(imag(z)/real(z))
% tau=phi/

% f=(0:length(x1f)-1)*50/length(x1f);
% ymax=max(abs(x1f));
% figure
% plot(f,abs(x1f));
% figure
% plot(f,abs(x2f));
% n=length(x1);
% fshift=(-n/2:n/2-1)*(50/n);
% yshift=fftshift(x1f);
% figure
% plot(fshift,abs(yshift));



% figure
% %plot(abs(fftshift(X)));
% plot(f,power)
% title('��ʼ�ź�Ƶ��');
% xlabel('Frequency');
% ylabel('����');
% grid on

% %%
% 
% %CBF_UCA_��֤
% imag=sqrt(-1);
% 
% dw=0.85;  % �뾶������ (ע����İ뾶��Ҫ������)
% 
% sn=1;     % �źŸ���
% 
% X=[x1';x2';x3';x4';x5';x6';x7';x8';x9';x10';x11';x12';x13';x14';x15';x16'];
% X=awgn(X,10);
% Pmax=zeros(1,3);
%  R=X*X'/N;                   % 8*8
%  
%  for azi=1:1:360
%      for ele=1:1:90
%        for m=1:M
%            AQ1(m,1)=exp(-1i*2*pi*dw*cos(2*pi*(m-1)/M-azi*pi/180)*sin(ele*pi/180));%8��1
%            %disp(AQ1);
%        end
%      % disp(AQ1);
%      Power=AQ1'*R*AQ1; 
%      % disp(Power);
%       P(ele,azi)=abs(Power);   %90*180
%       if Pmax(1)<Power
%             Pmax(1)=Power;
%             Pmax(2)=azi;
%             Pmax(3)=ele;
%         end
%      end
%     
%  end
% 
% figure(3);
% % Pmax=max(max(P)) ;  %�ҳ�P�����ֵzmax 
% % [Pmax,xi_max]=max(P);
% % [Pmax,yi_max]=max(Pmax);
% mesh(P);       %��ά��������
% 
% 
% 
% %[c,h]=contourf(P,2); %���Ƶȸ���  contour(x,y,z,n) ��x yΪ��Χ������z��n���ȸ��ߣ�n��ʡ
% contourf(P);
% %clabel(c,h) %��ע�ȸ���
% colorbar %���ɫ��
% colormap('jet');
% % colordef white;
% 
%  %title('UCA CBF��M=16 ��d/lamda=0.85');
%  xlabel('azimuth');ylabel('elevation');
%  %zlabel('�ռ���/db');
%  grid;
% ele_c=Pmax(3)
% azi_c= Pmax(2)
% toc
