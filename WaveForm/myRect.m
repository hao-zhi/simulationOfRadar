function [y] = myRect(x)
%MYRECT ������
%   ֵС�ڵ���1 ����1
if length(size(x))>2
    error('the size of x must less than 3')
end
y=zeros(size(x));
y(abs(x)<1)=1;
end

