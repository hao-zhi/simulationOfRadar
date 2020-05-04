addpath(genpath('C:\Users\83931\Desktop\����\����ɹ�'))
% ���������Ŀ��Ϊֹ�Ĺ������
clear all 
clc
global ft 
global fr
global Ptotal
global mu
global A
global B
global C

M = 2; % ������Ԫ��
N = 2; % ������Ԫ��

ft = ones(1,M)'; % ������Ԫѡȡ
fr = ones(1,N)'; % ������Ԫѡȡ

% λ�ò���ABC
% C��ʾĿ��ͷ�����Ԫ�Ĺ�ϵ
% AB��ʾĿ��ͽ�����Ԫ�Ĺ�ϵ
A = zeros(M);
B = zeros(N);
C = zeros(N);
theta_t = zeros(1,M); %����վm��Ŀ��ĽǶ�
theta_r = zeros(1,N);%����վn��Ŀ��ĽǶ�

%λ�ò���Ӱ������,Ӱ��B
%mu = 1.5;
mu = 1.4;


%λ�ò���
maxDistance = 22; %22km
RCS = 0.5; % m^2
T1 = []; %T��ʾ�����״R��ʾ�����״�,Tar��ʾĿ�꣬��λΪkm
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
V.x=0.1;V.y = 0;%Ŀ����ٶ� 100m/s,ˮƽ�ƶ�



% �Ż�����
Ptotal = 10; %�����ܹ���10kw
K = M+N;
pk = (Ptotal/M).*ones(1,M); % ���书�ʷ���
x0 = pk; % ��ʼֵ
lb = 2*ones(1,M); %pk�½� 
ub = Ptotal*ones(1,M);%pk�Ͻ�

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
title('Ŀ����پ���');
xlabel('ʱ��(s)');
ylabel('���پ���(m)');
%xlim([0,20]);

figure
subplot(2,1,1);
plot(time,pt1,'--ro');
title("����վ1���ʷ���");
xlabel('ʱ��(s)');
ylabel('���ʷ���(kw)');

subplot(2,1,2);
plot(time,pt2,'--ro');
title("����վ2���ʷ���");
xlabel('ʱ��(s)');
ylabel('���ʷ���(kw)');