function [Rt1,Rt2] = receiveBeam(t,T,R,Tar,E,V,RCS,Fc,B,Tp)
%RECIEVEBEAM 回波信号
%   双收回波信号 发射站位置T，接收站位置R，目标位置Tar，发射能量E，目标速度V，目标散射横截面积RCS
%   发射信号载波频率Fc,发射带宽B,发射脉宽Tp
% 回波信号实现
% 探测威力22-24km (24,24)
% RCS 0.5 m^2
% maxDistance = 24;
% RCS = 0.5; % m^2
j=sqrt(-1);
c = 3e5;%光速 3*10^5 km/s

M=2;
N=2;


zta = 10*log10(RCS); %目标RCS反射系数

lamda = c/Fc;
Rt1=zeros(size(t));Rt2=zeros(size(t));
% Rt =[Rt1,Rt2]; %回波信号
p = -250;%dbw
[x,y] = size(t);
w = wgn(x,y,p);%高斯白噪声
% w=zeros(size(t));
for n = 1:N
    for m=1:M
        alpha = 1/(((4*pi).^3)*((Distance(T(m),Tar)*Distance(R(n),Tar)*Fc).^2));
        tau = (Distance(T(m),Tar)+Distance(R(n),Tar))/c;

        %发射信号
        [s1,s2,f] = transmitBeam(mod(abs(t-tau),Tp),Fc,B,Tp);
        %[s1,s2,f] = transmitBeam(t,Fc,B,Tp);
        %[s1,s2,f] = transmitBeam(t,Fc,B,Tp);
        if m == 1
            s = s1;
        else
            s = s2;
        end
 
        f = (V.x/lamda)*( (abs(T(m).x-Tar.x)/Distance(T(m),Tar)) + (abs(R(n).x-Tar.x)/Distance(R(n),Tar)) ) ...
            + (V.y/lamda)*( (abs(T(m).y-Tar.y)/Distance(T(m),Tar)) + (abs(R(n).y-Tar.y)/Distance(R(n),Tar)) );%多普勒频移
        %temp = sqrt(E(m)*alpha) .* zta .* s .* exp(j*2*pi*f*t) + w;
        temp = sqrt(E(m)*alpha) .* zta .* s + w;
        if n == 1
            Rt1 = Rt1 + temp;
        else
            Rt2 = Rt2 + temp;
        end
    end
end
end


