function [T1] = BCRB(x)
%BRCB ��Ҷ˹�������޽�
%   ������q��Ŀ��λ�ù��ƾ��ȵ�RCRB
sigmaw = -174; % �����������ܶ�
global ft 
global fr
global mu
global A
global B
global C

[xt,yt] = size(ft);
[xr,yr] = size(fr);
pk = x';

M = xt;
N = xr; 
% Aq = ones(N); % ABC�״��Ŀ��λ����صĲ���,AB��ʾ���ն˺�Ŀ��λ�õĹ�ϵ��C��ʾ�������Ŀ��λ�õĹ�ϵ
% Bq = mu*ones(N);
% Cq = mu*ones(M);
% Aq = randn(N); % ABC�״��Ŀ��λ����صĲ���
% Bq = randn(N);
% Cq = randn(M);
Hq = A'*(fr*fr')*B - C'*(ft*ft')*C; % λ�ò���
Vq = fr'*(A+B);

T1 = sqrt((sigmaw^2)/(8*pi^2)) * ((Vq*pk)/(pk'*Hq*pk));% ��Ҷ˹�������޽�

end

