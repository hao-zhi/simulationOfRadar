function [P] = Pm0(m0,N,eta1,w)
%PM0 计算随机变量m0的概率
P = nchoosek(N,m0)*power(1-exp(-eta1/w),N-m0)*exp(-m0*eta1/w);
end

