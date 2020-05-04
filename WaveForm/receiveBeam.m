function [Rt1,Rt2] = receiveBeam(t,T,R,Tar,E,V,RCS,Fc,B,Tp)
%RECIEVEBEAM �ز��ź�
%   ˫�ջز��ź� ����վλ��T������վλ��R��Ŀ��λ��Tar����������E��Ŀ���ٶ�V��Ŀ��ɢ�������RCS
%   �����ź��ز�Ƶ��Fc,�������B,��������Tp
% �ز��ź�ʵ��
% ̽������22-24km (24,24)
% RCS 0.5 m^2
% maxDistance = 24;
% RCS = 0.5; % m^2
j=sqrt(-1);
c = 3e5;%���� 3*10^5 km/s

M=2;
N=2;


zta = 10*log10(RCS); %Ŀ��RCS����ϵ��

lamda = c/Fc;
Rt1=zeros(size(t));Rt2=zeros(size(t));
% Rt =[Rt1,Rt2]; %�ز��ź�
p = -250;%dbw
[x,y] = size(t);
w = wgn(x,y,p);%��˹������
% w=zeros(size(t));
for n = 1:N
    for m=1:M
        alpha = 1/(((4*pi).^3)*((Distance(T(m),Tar)*Distance(R(n),Tar)*Fc).^2));
        tau = (Distance(T(m),Tar)+Distance(R(n),Tar))/c;

        %�����ź�
        [s1,s2,f] = transmitBeam(mod(abs(t-tau),Tp),Fc,B,Tp);
        %[s1,s2,f] = transmitBeam(t,Fc,B,Tp);
        %[s1,s2,f] = transmitBeam(t,Fc,B,Tp);
        if m == 1
            s = s1;
        else
            s = s2;
        end
 
        f = (V.x/lamda)*( (abs(T(m).x-Tar.x)/Distance(T(m),Tar)) + (abs(R(n).x-Tar.x)/Distance(R(n),Tar)) ) ...
            + (V.y/lamda)*( (abs(T(m).y-Tar.y)/Distance(T(m),Tar)) + (abs(R(n).y-Tar.y)/Distance(R(n),Tar)) );%������Ƶ��
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


