function [PFA] = PFA(eta2,eta1,N,w)
%PFA 计算全局恒虚警概率
%   此处显示详细说明
T = eta2>eta1;
% syms m0;
% syms k;
% z = eta2 - m0*eta1;
% P = z > 0
% FG = P.*(1 - exp(-z/w).*symsum((power(z,k)/(power(w,k)*factorial(k))),k,0,m0-1));
% %Pfa = symsum( (T.*Pm0(m0,N,eta1,w)*GammaCDF(z,w,m0)),m0,1,N);
% Pfa = symsum( (T.*Pm0(m0,N,eta1,w).*(1-FG)),m0,1,N);
% PFA = Pfa +~T.*(1-Pm0(0,N,eta1,w)) ;
sum2 = 0;
for m0=1:N
    z = eta2-m0*eta1;
    sum1 = 0;
    for k=0:m0-1
        sum1 = sum1 + power(z,k)/(power(w,k)*factorial(k));
    end
    FG = (z>0).*(1-exp(-z/w).*sum1);
    sum2 = sum2 + T.*Pm0(m0,N,eta1,w).*(1-FG);
end
PFA = sum2 + ~T.*(1-Pm0(0,N,eta1,w));
end

