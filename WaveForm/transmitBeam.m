function [X1t,X2t,f] = transmitBeam(t,Fc,B,Tp)
%TRANSMITBEAM 发射波形函数
%   双发双收返回发射信号,时间t，载波频率Fc，带宽B,脉宽Tp
% M = 2;
% N = 2;
j = sqrt(-1);
% Fc = 1.e9; %载波频率
% Fs = 300e7; %采样率
% T = 1/Fs; %采样周期
% B  = 70e6;  % 带宽70MHz
% Tp  = 2e-6;  % 脉宽20us
fdelta = 5*B; %发射信号间最小频率差
mu = B/Tp ; %调频斜率
% n=round(Tp*Fs); %采样点个数，round是取整
%syms t;
% t = (0:n-1)*T;

theta =  pi*mu*t.^2; %信号弧度
%theta = pi/3;
f = mu*t; %信号频率

Ut = (1/sqrt(Tp))*myRect(t/Tp).*(exp(j*pi*mu*t.^2));

X1t = Ut.*exp(j*2*pi*Fc*t).*(exp(j*theta));
X2t = Ut.*exp(j*2*pi*(Fc+fdelta)*t).*(exp(j*theta));

end

