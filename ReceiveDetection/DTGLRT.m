% ˫���޹�����Ȼ���㷨
clear;
clc;
% ��ز���
Nt = 2; % ����վ����
Nr = 2; % ����վ����
N = Nt*Nr; % �ռ�ּ�ͨ����
T = 2.5;  % �״�������ظ�ʱ��
lamda  = 0.3; %�ز�����
L = 8; % �ź�ʸ������
K =16; %�ο���Ԫ��Ŀ
M = eye(L); % Э�������
Phit = [0,pi/6];
phir = [0,pi/6,pi/3,pi/2];
Vx = 30;
Vy = 0;
% Pfa = 1e-4;% ȫ���龯����
w = (K+1)/(K+1-L);

eta1 = [4,6]; % ����1
eta2 = [0:1:40]; % ����2


% 3db  2����ϵ
% 1000 =30db    
% ����ֽ�
% һ��̩��չ�� 
% 10*lg40

%FG error


%����ԭ�� ���� z>0==��eta2<=eta1��ʱ�� ���и���FG ����FG=0

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


%������
pfa = 1e-4;
SCNR = (1:25);
alpha = 0.5;%����ǿɢ���ĸ���Ϊ0.5
Pd = PD(2,2,pfa,SCNR,alpha);
Pd11 = PD(1,1,pfa,SCNR,alpha);
figure;
plot(SCNR,Pd,'--o');
title("������Pd��SCNR�Ĺ�ϵ")
xlabel('SCNR��db)');
c = newline;
xlabel({'SCNR��db)';' \bfP_f_a = 10^-^4,\alpha = 0.5'});
ylabel('������');
hold on;
plot(SCNR,Pd11,'--rs');
legend('\itN_t = 2,\itN_r = 2','\itN_t = 1,\itN_r = 1');