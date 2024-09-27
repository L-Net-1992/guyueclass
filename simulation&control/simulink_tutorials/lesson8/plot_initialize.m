function plot_initialize(xlab, ylab, tit)
%�Զ����ͼ�����������ͼ

% ���� figure
figure1 = figure('PaperSize',[20 30]);

% ���� axes
axes1 = axes('Parent',figure1,'FontSize',16,'FontName','Times New Roman');
box(axes1,'on');
hold(axes1,'all');

% ���� xlabel
xlabel({xlab},'FontSize',16);

% ���� ylabel
ylabel({ylab},'FontSize',16);

% ���� title
title({tit},'FontSize',16);
