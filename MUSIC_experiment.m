%%
clc
clear 



fs  = 50000;
N   =  5000;
M   =   16;%阵元数

%% 读数据
x1  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m1.xlsx','B2:B5001');
x2  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m2.xlsx','B2:B5001');
x3  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m3.xlsx','B2:B5001');
x4  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m4.xlsx','B2:B5001');
x5  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m5.xlsx','B2:B5001');
x6  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m6.xlsx','B2:B5001');
x7  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m7.xlsx','B2:B5001');
x8  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m8.xlsx','B2:B5001');
x9  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m9.xlsx','B2:B5001');
x10  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m10.xlsx','B2:B5001');
x11  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m11.xlsx','B2:B5001');
x12  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m12.xlsx','B2:B5001');
x13  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m13.xlsx','B2:B5001');
x14  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m14.xlsx','B2:B5001');
x15  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m15.xlsx','B2:B5001');
x16  = xlsread('C:\Users\MannixWong\Desktop\信号的样本\m16.xlsx','B2:B5001');



%%

%MUSIC_UCA_验证
imag=sqrt(-1);
dw=0.88;  % 半径波长比
sn=1;     % 信号个数


X=[x1';x2';x3';x4';x5';x6';x7';x8';x9';x10';x11';x12';x13';x14';x15';x16'];
X=awgn(X,10);

R=X*X'/N;                   % 8*8求协方差矩阵
[tzxiangliang,tzzhi]=eig(R);% [V,D]=eig(A)：求矩阵A的全部特征值，构成对角阵D，并求A的特征向量构成V的列向量
%tzxiangliang 特征向量8*8=64个
%tzzhi  特征值构成对角矩阵  8个
Nspace=tzxiangliang(:,1:M-sn);%噪声子空间对应小的特征值（从小到大排列）???a(:,:,1)是一个三维矩阵，a(:,:,1)表示取a矩阵第一页的所有行和列
%Nspace  8*8=64个
AQ1=zeros(16,1);
P=zeros(90,180);
for azi=1:1:180
    for ele=1:1:90
        for m=1:M
            AQ1(m,1)=exp(1i*2*pi*dw*cos(azi*pi/180-2*pi*(m-1)/M)*sin(ele*pi/180));%8行1
            %disp(AQ1);
        end
        % disp(AQ1);
        Power=1/(AQ1'*(Nspace*Nspace')*AQ1);
        % disp(Power);
        P(ele,azi)=abs(Power);   %90*180
    end
    
end

% figure;
% % Pmax=max(max(P)) ;  %找出P的最大值zmax
% [Pmax,xi_max]=max(P);
% [Pmax,yi_max]=max(Pmax);
%% 绘图
figure('Name','MUSIC_noise','Numbertitle','off')
%mesh(P);
%[c,h]=contourf(P,2); %绘制等高线  contour(x,y,z,n) 以x y为范围，画出z的n条等高线，n可省
contourf(P);
colormap('jet');
%clabel(c,h) %标注等高线
colorbar %添加色标
% colordef white;

%title('UCA MUSIC：M=8 ；d/lamda=0.85 ');
xlabel('azimuth');ylabel('elevation');
%zlabel('空间谱/db');
grid on
% figure(2)
% h=pcolor(P);%热度图
% colormap jet
%axis off
%set(h,'edgecolor','none','facecolor','interp');%去掉网格，平滑热度图
%saveas(gcf,'C:\Users\MannixWong\Desktop\UCA_MUSIC.jpg')
%imwrite(h, 'a.jpg', 'jpg')
%grid on
