function [ele,azi]=CBF(X,M,N)%信号，阵元数，快拍数
R=X*X'/N;
for i=1:16%去除对角线影响
    R(i,i)=0;
end

end