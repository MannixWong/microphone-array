%%
clc
clear 



fs  = 50000;
N   =  5000;
M   =   16;%��Ԫ��

%% ������
x1  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m1.xlsx','B2:B5001');
x2  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m2.xlsx','B2:B5001');
x3  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m3.xlsx','B2:B5001');
x4  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m4.xlsx','B2:B5001');
x5  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m5.xlsx','B2:B5001');
x6  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m6.xlsx','B2:B5001');
x7  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m7.xlsx','B2:B5001');
x8  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m8.xlsx','B2:B5001');
x9  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m9.xlsx','B2:B5001');
x10  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m10.xlsx','B2:B5001');
x11  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m11.xlsx','B2:B5001');
x12  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m12.xlsx','B2:B5001');
x13  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m13.xlsx','B2:B5001');
x14  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m14.xlsx','B2:B5001');
x15  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m15.xlsx','B2:B5001');
x16  = xlsread('C:\Users\MannixWong\Desktop\�źŵ�����\m16.xlsx','B2:B5001');



%%

%MUSIC_UCA_��֤
imag=sqrt(-1);
dw=0.88;  % �뾶������
sn=1;     % �źŸ���


X=[x1';x2';x3';x4';x5';x6';x7';x8';x9';x10';x11';x12';x13';x14';x15';x16'];
X=awgn(X,10);

R=X*X'/N;                   % 8*8��Э�������
[tzxiangliang,tzzhi]=eig(R);% [V,D]=eig(A)�������A��ȫ������ֵ�����ɶԽ���D������A��������������V��������
%tzxiangliang ��������8*8=64��
%tzzhi  ����ֵ���ɶԽǾ���  8��
Nspace=tzxiangliang(:,1:M-sn);%�����ӿռ��ӦС������ֵ����С�������У�???a(:,:,1)��һ����ά����a(:,:,1)��ʾȡa�����һҳ�������к���
%Nspace  8*8=64��
AQ1=zeros(16,1);
P=zeros(90,180);
for azi=1:1:180
    for ele=1:1:90
        for m=1:M
            AQ1(m,1)=exp(1i*2*pi*dw*cos(azi*pi/180-2*pi*(m-1)/M)*sin(ele*pi/180));%8��1
            %disp(AQ1);
        end
        % disp(AQ1);
        Power=1/(AQ1'*(Nspace*Nspace')*AQ1);
        % disp(Power);
        P(ele,azi)=abs(Power);   %90*180
    end
    
end

% figure;
% % Pmax=max(max(P)) ;  %�ҳ�P�����ֵzmax
% [Pmax,xi_max]=max(P);
% [Pmax,yi_max]=max(Pmax);
%% ��ͼ
figure('Name','MUSIC_noise','Numbertitle','off')
%mesh(P);
%[c,h]=contourf(P,2); %���Ƶȸ���  contour(x,y,z,n) ��x yΪ��Χ������z��n���ȸ��ߣ�n��ʡ
contourf(P);
colormap('jet');
%clabel(c,h) %��ע�ȸ���
colorbar %���ɫ��
% colordef white;

%title('UCA MUSIC��M=8 ��d/lamda=0.85 ');
xlabel('azimuth');ylabel('elevation');
%zlabel('�ռ���/db');
grid on
% figure(2)
% h=pcolor(P);%�ȶ�ͼ
% colormap jet
%axis off
%set(h,'edgecolor','none','facecolor','interp');%ȥ������ƽ���ȶ�ͼ
%saveas(gcf,'C:\Users\MannixWong\Desktop\UCA_MUSIC.jpg')
%imwrite(h, 'a.jpg', 'jpg')
%grid on
