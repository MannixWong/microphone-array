function [ele,azi]=CBF(X,M,N)%�źţ���Ԫ����������
R=X*X'/N;
for i=1:16%ȥ���Խ���Ӱ��
    R(i,i)=0;
end

end