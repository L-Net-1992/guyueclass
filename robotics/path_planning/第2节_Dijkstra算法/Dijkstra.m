% ����դ���ͼ�Ļ�����·���滮�㷨
% ��2�ڣ�Dijkstra�㷨
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
% S/U�ĵ�һ�б�ʾդ��ڵ������������
% ����S���ڶ��б�ʾ��Դ�ڵ㵽���ڵ�����õ���С���룬���ٱ����
% ����U���ڶ��б�ʾ��Դ�ڵ㵽���ڵ���ʱ��õ���С���룬���ܻ���
U(:,1) = (1: rows*cols)';
U(:,2) = inf;
S = [startPos, 0];
U(startPos,:) = [];

% ���������ڽڵ㼰����
neighborNodes = getNeighborNodes(rows, cols, startPos, field);
for i = 1:8
    childNode = neighborNodes(i,1);
    
    % �жϸ��ӽڵ��Ƿ����
    if ~isinf(childNode)
        idx = find(U(:,1) == childNode);
        U(idx,2) = neighborNodes(i,2);
    end
end



% S���ϵ�����·������
for i = 1:rows*cols
    path{i,1} = i;
end
for i = 1:8
    childNode =  neighborNodes(i,1);
    if ~isinf(neighborNodes(i,2))
        path{childNode,2} = [startPos,neighborNodes(i,1)];
    end
end


%% ѭ������
while ~isempty(U)
    
    % ��U�����ҳ���ǰ��С����ֵ�Ľڵ�,��Ϊ���ڵ㣬���Ƴ��ýڵ���S������
    [dist_min, idx] = min(U(:,2));
    parentNode = U(idx, 1);
    S(end+1,:) = [parentNode, dist_min];
    U(idx,:) = [];
    
    % ��õ�ǰ�ڵ���ٽ��ӽڵ�
    neighborNodes = getNeighborNodes(rows, cols, parentNode, field);

    % ���α����ڽ��ӽڵ㣬�ж��Ƿ���U�����и����ڽڵ�ľ���ֵ
    for i = 1:8
        
        % ��Ҫ�жϵ��ӽڵ�
        childNode = neighborNodes(i,1);
        cost = neighborNodes(i,2);
        if ~isinf(childNode)  && ~ismember(childNode, S)
            
            % �ҳ�U�����нڵ�childNode������ֵ
            idx_U = find(childNode == U(:,1));            
            
            % �ж��Ƿ����
            if dist_min + cost < U(idx_U, 2)
                U(idx_U, 2) = dist_min + cost;
                
                % ��������·��
                path{childNode, 2} = [path{parentNode, 2}, childNode];
            end
        end
    end
end


%% ��դ�����
% �ҳ�Ŀ������·��
path_opt = path{goalPos,2};
field(path_opt(2:end-1)) = 6;

% ��դ��ͼ
image(1.5,1.5,field);
grid on;
set(gca,'gridline','-','gridcolor','k','linewidth',2,'GridAlpha',0.5);
set(gca,'xtick',1:cols+1,'ytick',1:rows+1);
axis image;