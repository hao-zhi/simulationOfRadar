function [T1] = BCRB(x)
%BRCB 贝叶斯克拉美罗界
%   描述第q个目标位置估计精度的RCRB
sigmaw = -174; % 噪声功率谱密度
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
% Aq = ones(N); % ABC雷达和目标位置相关的参数,AB表示接收端和目标位置的关系，C表示发射端与目标位置的关系
% Bq = mu*ones(N);
% Cq = mu*ones(M);
% Aq = randn(N); % ABC雷达和目标位置相关的参数
% Bq = randn(N);
% Cq = randn(M);
Hq = A'*(fr*fr')*B - C'*(ft*ft')*C; % 位置参数
Vq = fr'*(A+B);

T1 = sqrt((sigmaw^2)/(8*pi^2)) * ((Vq*pk)/(pk'*Hq*pk));% 贝叶斯克拉美罗界

end

