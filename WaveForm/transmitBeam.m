function [X1t,X2t,f] = transmitBeam(t,Fc,B,Tp)
%TRANSMITBEAM ���䲨�κ���
%   ˫��˫�շ��ط����ź�,ʱ��t���ز�Ƶ��Fc������B,����Tp
% M = 2;
% N = 2;
j = sqrt(-1);
% Fc = 1.e9; %�ز�Ƶ��
% Fs = 300e7; %������
% T = 1/Fs; %��������
% B  = 70e6;  % ����70MHz
% Tp  = 2e-6;  % ����20us
fdelta = 5*B; %�����źż���СƵ�ʲ�
mu = B/Tp ; %��Ƶб��
% n=round(Tp*Fs); %�����������round��ȡ��
%syms t;
% t = (0:n-1)*T;

theta =  pi*mu*t.^2; %�źŻ���
%theta = pi/3;
f = mu*t; %�ź�Ƶ��

Ut = (1/sqrt(Tp))*myRect(t/Tp).*(exp(j*pi*mu*t.^2));

X1t = Ut.*exp(j*2*pi*Fc*t).*(exp(j*theta));
X2t = Ut.*exp(j*2*pi*(Fc+fdelta)*t).*(exp(j*theta));

end

