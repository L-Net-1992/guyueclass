% ����դ���ͼ�Ļ�����·���滮�㷨
% ��1�ڣ�����Matlab���ٻ���դ���ͼ
clc
clear
close all

%% ������ɫMAPͼ
cmap = [1 1 1; ...       % 1-��ɫ-�յ�
    0 0 0; ...           % 2-��ɫ-��̬�ϰ�
    1 0 0; ...           % 3-��ɫ-��̬�ϰ�
    1 1 0;...            % 4-��ɫ-��ʼ�� 
    1 0 1;...            % 5-Ʒ��-Ŀ���
    0 1 0; ...           % 6-��ɫ-��Ŀ���Ĺ滮·��   
    0 1 1];              % 7-��ɫ-��̬�滮��·��

% ������ɫMAPͼ
colormap(cmap);

%% ����դ���ͼ����
% դ������С:����������
rows = 10;
cols = 20; 

% ����դ���ͼȫ�򣬲���ʼ���հ�����
field = ones(rows, cols);

% �ϰ�������
obsRate = 0.3;
obsNum = floor(rows*cols*obsRate);
obsIndex = randi([1,rows*cols],obsNum,1);
field(obsIndex) = 2;

% ��ʼ���Ŀ���
startPos = 2;
goalPos = rows*cols-2;
field(startPos) = 4;
field(goalPos) = 5;

%% ��դ��ͼ
image(1.5,1.5,field);
grid on;
set(gca,'gridline','-','gridcolor','k','linewidth',2,'GridAlpha',0.5);
set(gca,'xtick',1:cols+1,'ytick',1:rows+1);
axis image;