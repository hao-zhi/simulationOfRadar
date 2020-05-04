function [y] = myRect(x)
%MYRECT 矩阵函数
%   值小于等于1 返回1
if length(size(x))>2
    error('the size of x must less than 3')
end
y=zeros(size(x));
y(abs(x)<1)=1;
end

