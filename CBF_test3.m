clear all;close all;clc
s.M=16
s.lamda=1;
s.d=1/2*s.lamda;
s.SNR=10;
s.INR=10;
s.Noise=1;
s.SigDOA=[30 45];
s.IntDOA=[0 50 70];
s.Theta=-90:1:90;
s.L=200;
s.fc=100;
s.fs=10000;
s.SigNum=length(s.SigDOA);
s.IntNum=length(s.IntDOA);
s.ds=exp(1i*2*pi*(0:s.SigNum-1)'*s.fc/s.fs*(0:s.L-1));
s.As=exp(-1i*2*pi*s.d/s.lamda*(0:s.M-1)'*sin(s.SigDOA*pi/180));
s.Xs=sqrt(10^(s.SNR/10))*s.As*s.ds;
plot(s.Xs)
