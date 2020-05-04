% 双门限广义似然比算法
clear;
clc;
% 相关参数
Nt = 2; % 发射站个数
Nr = 2; % 接收站个数
N = Nt*Nr; % 空间分集通道数
T = 2.5;  % 雷达脉冲的重复时间
lamda  = 0.3; %载波波长
L = 8; % 信号矢量长度
K =16; %参考单元数目
M = eye(L); % 协方差矩阵
Phit = [0,pi/6];
phir = [0,pi/6,pi/3,pi/2];
Vx = 30;
Vy = 0;
% Pfa = 1e-4;% 全局虚警概率
w = (K+1)/(K+1-L);

eta1 = [4,6]; % 门限1
eta2 = [0:1:40]; % 门限2


% 3db  2倍关系
% 1000 =30db    
% 矩阵分解
% 一阶泰勒展开 
% 10*lg40

%FG error


%错误原因 在于 z>0==》eta2<=eta1的时候 才有概率FG 否则FG=0

Pfa1 = PFA(eta2,eta1(1),N,w);
Pfa2 = PFA(eta2,eta1(2),N,w);
%scatter(eta2,Pfa)
plot(eta2,Pfa1,'--s','MarkerIndices',1:3:length(Pfa1));
xlabel('\eta_2');
ylabel('P_F_A');
xlim([0 40]);
ax = gca;
ax.YScale = 'log';
yticks([1e-5 1e-4 1e-3 1e-2 1e-1 1e0]) 
yticklabels({'10^-^5','10^-^4','10^-^3','10^-^2','10^-^1','10^0'})
hold on;
plot(eta2,Pfa2,'--o','MarkerIndices',1:3:length(Pfa2));
legend('\eta_1=4','\eta_2=6');
hold off;


%检测概率
pfa = 1e-4;
SCNR = (1:25);
alpha = 0.5;%存在强散射点的概率为0.5
Pd = PD(2,2,pfa,SCNR,alpha);
Pd11 = PD(1,1,pfa,SCNR,alpha);
figure;
plot(SCNR,Pd,'--o');
title("检测概率Pd与SCNR的关系")
xlabel('SCNR（db)');
c = newline;
xlabel({'SCNR（db)';' \bfP_f_a = 10^-^4,\alpha = 0.5'});
ylabel('检测概率');
hold on;
plot(SCNR,Pd11,'--rs');
legend('\itN_t = 2,\itN_r = 2','\itN_t = 1,\itN_r = 1');