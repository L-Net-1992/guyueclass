% ����դ���ͼ�Ļ�����·���滮�㷨
% ��3�ڣ�Floyd�㷨
clc
clear
close all

%% դ����桢��������
% ����������
rows = 10;
cols = 20;
[field,cmap] = defColorMap(rows, cols);

% ��㡢�յ㡢�ϰ�������
startPos = 2;
goalPos = rows*cols-2;
field(startPos) = 4;
field(goalPos) = 5;

%% �㷨��ʼ��
n = rows*cols;      % դ��ڵ��ܸ���
map = inf(n,n);     % ���нڵ��ľ���map
path = cell(n, n);  % ��Ŷ�Ӧ��·��
for startNode = 1:n
    if field(startNode) ~= 2
        neighborNodes = getNeighborNodes(rows, cols, startNode, field);
        for i = 1:8
            if ~(isinf(neighborNodes(i,1)) || isinf(neighborNodes(i,2)))
                neighborNode = neighborNodes(i,1);
                map(startNode, neighborNode) = neighborNodes(i,2);
                path{startNode, neighborNode} = [startNode, neighborNode];
            end
        end
    end
end
           
%% ����������ѭ��
for i = 1:n
    for j =  1:n
        if j ~= i
            for k =  1:n
                if k ~= i && k ~= j
                    if map(j,i) +  map(i,k) < map(j,k)
                        map(j,k) = map(j,i) +  map(i,k);
                        path{j,k} = [path{j,i}, path{i,k}(2:end)];
                    end
                end
            end
        end
    end
end


%% ��դ�����
% �ҳ�Ŀ������·��
path_target = path{startPos,goalPos};
field(path_target(2:end-1)) = 6;

% ��դ��ͼ
image(1.5,1.5,field);
grid on;
set(gca,'gridline','-','gridcolor','k','linewidth',2,'GridAlpha',0.5);
set(gca,'xtick',1:cols+1,'ytick',1:rows+1);
axis image;