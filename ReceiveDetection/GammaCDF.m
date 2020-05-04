function [FG] = GammaCDF(z,w,m0)
%FG 伽马分布z的累积分布函数
if z <= 0 
    FG = 0;
else
    sum = 0;
    for k = 1:m0-1
        sum = sum + power(z,k)/(power(w,k)*factorial(k));
    end
    FG = 1 - exp(-z/w).*sum;
end
end

