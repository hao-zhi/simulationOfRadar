addpath(genpath('C:\Users\83931\Desktop\毕设\仿真成果'))
% 用来计算多目标为止的估计误差
clear all 
clc
global ft 
global fr
global Ptotal
global mu
global A
global B
global C

M = 2; % 发射阵元数
N = 2; % 接收阵元数

ft = ones(1,M)'; % 发射阵元选取
fr = ones(1,N)'; % 接收阵元选取

% 位置参数ABC
% C表示目标和发射阵元的关系
% AB表示目标和接收阵元的关系
A = zeros(M);
B = zeros(N);
C = zeros(N);
theta_t = zeros(1,M); %发射站m和目标的角度
theta_r = zeros(1,N);%接收站n和目标的角度

%位置参数影响因子,影响B
%mu = 1.5;
mu = 1.4;


%位置参数
maxDistance = 22; %22km
RCS = 0.5; % m^2
T1 = []; %T表示发射雷达，R表示接收雷达,Tar表示目标，单位为km
T2 = [];
T1.x=0;T1.y=0;
T2.x=0;T2.y=maxDistance;
T =[T1,T2];

R1 = [];
R2 = [];
R1.x = 0;R1.y = 1;
R2.x = 0;R2.y=maxDistance-1;
R = [R1,R2];


Tar = [];
Tar.x = maxDistance-2;Tar.y = maxDistance-2;
V=[];
V.x=0.1;V.y = 0;%目标的速度 100m/s,水平移动



% 优化参数
Ptotal = 10; %发射总功率10kw
K = M+N;
pk = (Ptotal/M).*ones(1,M); % 发射功率分配
x0 = pk; % 初始值
lb = 2*ones(1,M); %pk下界 
ub = Ptotal*ones(1,M);%pk上界

positionValue = zeros(1,4);
time = 0:20;
pt1 = zeros(size(time));
pt2 = zeros(size(time));

nonlcon = @nonlinearconstraint;
for t= time
    Tar.x = Tar.x + V.x;
    Tar.y = Tar.y + V.y;
    if Tar.x >maxDistance || Tar.y > maxDistance
        mu = 0;
    end
    for m = 1:M
        theta_t(m) = atan(abs(T(m).y - Tar.y)/abs(T(m).x - Tar.x) );
        C(1,m) = cos(theta_r(m));
        C(2,m) = sin(theta_r(m));
    end
    for n = 1:N
        theta_r(n) = atan(abs(R(n).y - Tar.y)/abs(R(n).x - Tar.x) );
        A(1,n) = cos(theta_r(n));
        A(2,n) = sin(theta_r(n));
        B(1,n) = mu*cos(theta_r(n));
        B(2,n) = mu*sin(theta_r(n));
    end
    fun = @ BCRB;
    [x,fval,maxfval] = fmincon(fun,x0,[],[],[],[],lb,ub,nonlcon);
    positionValue(t+1) = fval;
    if fval <0 
        positionValue(t+1) = 0;
    end
    pt1(t+1) = x(1);
    pt2(t+1) = x(2);
end
figure
plot(time,positionValue,'--o')
title('目标跟踪精度');
xlabel('时间(s)');
ylabel('跟踪精度(m)');
%xlim([0,20]);

figure
subplot(2,1,1);
plot(time,pt1,'--ro');
title("发射站1功率分配");
xlabel('时间(s)');
ylabel('功率分配(kw)');

subplot(2,1,2);
plot(time,pt2,'--ro');
title("发射站2功率分配");
xlabel('时间(s)');
ylabel('功率分配(kw)');