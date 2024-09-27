% ����դ���ͼ�Ļ�����·���滮�㷨
% A*�㷨
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

%% Ԥ����

% ��ʼ��closeList
parentNode = startPos;
closeList = [startPos,0];

% ��ʼ��openList
openList = struct;
childNodes = getChildNode(field,closeList,parentNode);
for i = 1:length(childNodes)
    [row_startPos,col_startPos] = ind2sub([rows, cols],startPos);
    [row_goalPos,col_goalPos] = ind2sub([rows, cols],goalPos);   
    [row,col] = ind2sub([rows, cols],childNodes(i));

    % ����openList�ṹ��
    openList(i).node = childNodes(i);
    openList(i).g = norm([row_startPos,col_startPos] - [row,col]);
    openList(i).h = abs(row_goalPos - row) + abs(col_goalPos - col);
    openList(i).f = openList(i).g + openList(i).h;
end

% ��ʼ��path
for i = 1:rows*cols
    path{i,1} = i;
end
for i = 1:length(openList)
    node = openList(i).node;
    path{node,2} = [startPos,node];
end 

%% ��ʼ����
% ��openList��ʼ�����ƶ�������С�Ľڵ�
[~, idx_min] = min([openList.f]);
parentNode = openList(idx_min).node;

% ����ѭ��
while true  
    
    % �ҳ����ڵ��8���ӽڵ㣬�ϰ���ڵ���inf��
    childNodes = getChildNode(field, closeList,parentNode);
    
    % �ж���Щ�ӽڵ��Ƿ���openList�У����ڣ���Ƚϸ��£�û����׷�ӵ�openList��
    for i = 1:length(childNodes)
        
        % ��Ҫ�жϵ��ӽڵ�
        childNode = childNodes(i);
        [in_flag,idx] = ismember(childNode, [openList.node]);
           
        % ������ۺ���
        [row_parentNode,col_parentNode] = ind2sub([rows, cols], parentNode);
        [row_childNode,col_childNode] = ind2sub([rows, cols], childNode);
        [row_goalPos,col_goalPos] = ind2sub([rows, cols],goalPos);
        g = openList(idx_min).g + norm( [row_parentNode,col_parentNode] -...
            [row_childNode,col_childNode]);
        h = abs(row_goalPos - row_childNode) + abs(col_goalPos - col_childNode);
        f = g + h;
        
        if in_flag   % ���ڣ��Ƚϸ���g��f        
            if f < openList(idx).f
                openList(idx).g = g;
                openList(idx).h = h;
                openList(idx).f = f;
                path{childNode,2} = [path{parentNode,2}, childNode];
            end
        else         % �����ڣ�׷�ӵ�openList
            openList(end+1).node = childNode;
            openList(end).g = g;
            openList(end).h = h;
            openList(end).f = f;
            path{childNode,2} = [path{parentNode,2}, childNode];
        end
    end
       
    % ��openList�Ƴ��ƶ�������С�Ľڵ㵽closeList
    closeList(end+1,: ) = [openList(idx_min).node, openList(idx_min).f];
    openList(idx_min)= [];
 
    % ������������openList�����ƶ�������С�Ľڵ�
    [~, idx_min] = min([openList.f]);
    parentNode = openList(idx_min).node;
    
    % �ж��Ƿ��������յ�
    if parentNode == goalPos
        closeList(end+1,: ) = [openList(idx_min).node, openList(idx_min).f];
        break
    end
end

%% ��·��
% �ҳ�Ŀ������·��
path_target = path{goalPos,2};
field(path_target(2:end-1)) = 6;

% ��դ��ͼ
image(1.5,1.5,field);
grid on;
set(gca,'gridline','-','gridcolor','k','linewidth',2,'GridAlpha',0.5);
set(gca,'xtick',1:cols+1,'ytick',1:rows+1);
axis image;