clear all;
clc;
M = 2;
N = 2;

j=sqrt(-1);

Fc = 1e9; %�ز�Ƶ��
B  = 70e6;  % ����70MHz
%B = 5e6; %����5MHZ
Tp  = 2e-6;  % ����20us
%Tp = 0.5;

Fs = 300e7; %������
%Fs = 5e3;% 5k hz
T = 1/Fs; %��������

n=round(Tp*Fs); %�����������round��ȡ��
u = B/Tp;

% %�����
t = (0:n-1)*T;
[Tt1,Tt2,f] = transmitBeam(t,Fc,B,Tp);

f = Fs*(1:n)/n;

figure;
subplot(2,1,1);plot(t,Tt1);title('s1�ź�ʱ��');xlabel('t');ylabel('��ֵ');%xlim([2e-7,4e-7]);%ʱ���ͼ
subplot(2,1,2);plot(f,abs(fft(Tt1)));title('s1�ź�Ƶ��');xlabel('Ƶ��f(HZ)');ylabel('��ֵ');%xlim([2e7,3e7]);
hold on;
subplot(2,1,1);plot(t,Tt2);title('s2�ź�ʱ��');xlabel('t');ylabel('��ֵ');%xlim([1.8e-6,2e-6]);%ʱ���ͼ
subplot(2,1,2);plot(f,abs(fft(Tt2)));title('s2�ź�Ƶ��');xlabel('Ƶ��f(HZ)');%ylabel('��ֵ');xlim([3e7,4e7]);

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
Tar.x = maxDistance/2;Tar.y = maxDistance/2;
V=[];   
V.x=0.1;V.y = 0.1;%Ŀ����ٶ� 100m/s

% funX1 = @(x)abs( (1/sqrt(Tp)).*myRect(x./Tp).*(exp(j*pi*mu*x.^2)).*exp(j*2*pi*Fc.*x).*(exp(j*pi*mu*x.^2)) ).^2;
% funX2 = @(x)abs( (1/sqrt(Tp)).*myRect(x./Tp).*(exp(j*pi*mu*x.^2)).*exp(j*2*pi*(Fc+fdelta).*x).*(exp(j*pi*mu*x.^2)) ).^2;
% E1 = integral(funX1,0,inf);  
% E2 = integral(funX2,0,inf);  
E =[1,1]; %�����ź�����
[Rt1,Rt2] = receiveBeam(t,T,R,Tar,E,V,RCS,Fc,B,Tp);
figure;
positionX=[T1.x,T2.x,R1.x,R2.x,Tar.x];
positionY=[T1.y,T2.y,R1.y,R2.y,Tar.y];
scatter([T1.x,T2.x],[T1.y,T2.y],'filled','sr');
xlim([0,22]);
ylim([0,22]);
text(T1.x,T1.y,'����վ1');
text(T2.x,T2.y,'����վ2');
xlabel("x(km)");
ylabel("y(km)");
title("λ�ù�ϵ")

hold on;
scatter([R1.x,R2.x],[R1.y,R2.y],'filled','sb');
text(R1.x,R1.y,'����վ1');
text(R2.x,R2.y,'����վ2');
hold on;
scatter(Tar.x,Tar.y,'filled','ok');
text(Tar.x,Tar.y,'Ŀ��ˮƽ����100m/s�ƶ�');
legend('����վ','����վ','Ŀ��');



% xlabel('x(km)');ylabel('y(km)')
figure;
subplot(2,1,1);plot(t,Rt1);title('r1�ź�ʱ��');xlabel('t');ylabel('��ֵ');%xlim([1.8e-6,2e-6]);%ʱ���ͼ
subplot(2,1,2);plot(f,abs(fft(Rt1)));title('r1�ź�Ƶ��');xlabel('Ƶ��f(HZ)');ylabel('��ֵ');%xlim([2e7,5e7]);
figure;
subplot(2,1,1);plot(t,Rt2);title('r2�ź�ʱ��');xlabel('t');ylabel('��ֵ');%xlim([1.8e-6,2e-6]);%ʱ���ͼ
subplot(2,1,2);plot(f,abs(fft(Rt2)));title('r2�ź�Ƶ��');xlabel('Ƶ��f(HZ)');ylabel('��ֵ');%xlim([2e7,5e7]);

