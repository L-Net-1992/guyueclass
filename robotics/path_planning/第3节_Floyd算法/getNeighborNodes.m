function neighborNodes = getNeighborNodes(rows, cols, lineIndex, field)
[row, col] = ind2sub([rows,cols], lineIndex);
neighborNodes = inf(8,2);

%% ���ҵ�ǰ���ڵ��ٽ�����Χ8���ӽڵ�
% ���Ͻڵ�
if row-1 > 0 && col-1 > 0
    child_node_sub = [row-1, col-1];
    child_node_line = sub2ind([rows,cols], child_node_sub(1), child_node_sub(2));
    neighborNodes(1,1) = child_node_line;
    if field(child_node_sub(1), child_node_sub(2)) ~= 2
        cost = norm(child_node_sub - [row, col]);
        neighborNodes(1,2) = cost;
    end
end

% �Ͻڵ�
if row-1 > 0
    child_node_sub = [row-1, col];
    child_node_line = sub2ind([rows,cols], child_node_sub(1), child_node_sub(2));
    neighborNodes(2,1) = child_node_line;
    if field(child_node_sub(1), child_node_sub(2)) ~= 2
        cost = norm(child_node_sub - [row, col]);
        neighborNodes(2,2) = cost;
    end
end

% ���Ͻڵ�
if row-1 > 0 && col+1 <= cols
    child_node_sub = [row-1, col+1];
    child_node_line = sub2ind([rows,cols], child_node_sub(1), child_node_sub(2));
    neighborNodes(3,1) = child_node_line;
    if field(child_node_sub(1), child_node_sub(2)) ~= 2
        cost = norm(child_node_sub - [row, col]);
        neighborNodes(3,2) = cost;
    end
end

% ��ڵ�
if  col-1 > 0
    child_node_sub = [row, col-1];
    child_node_line = sub2ind([rows,cols], child_node_sub(1), child_node_sub(2));
    neighborNodes(4,1) = child_node_line;
    if field(child_node_sub(1), child_node_sub(2)) ~= 2
        cost = norm(child_node_sub - [row, col]);
        neighborNodes(4,2) = cost;
    end
end

% �ҽڵ�
if  col+1 <= cols
    child_node_sub = [row, col+1];
    child_node_line = sub2ind([rows,cols], child_node_sub(1), child_node_sub(2));
    neighborNodes(5,1) = child_node_line;
    if field(child_node_sub(1), child_node_sub(2)) ~= 2
        cost = norm(child_node_sub - [row, col]);
        neighborNodes(5,2) = cost;
    end
end

% ���½ڵ�
if row+1 <= rows && col-1 > 0
    child_node_sub = [row+1, col-1];
    child_node_line = sub2ind([rows,cols], child_node_sub(1), child_node_sub(2));
    neighborNodes(6,1) = child_node_line;
    if field(child_node_sub(1), child_node_sub(2)) ~= 2
        cost = norm(child_node_sub - [row, col]);
        neighborNodes(6,2) = cost;
    end
end

% 7.�½ڵ�
if row+1 <= rows
    child_node_sub = [row+1, col];
    child_node_line = sub2ind([rows,cols], child_node_sub(1), child_node_sub(2));
    neighborNodes(7,1) = child_node_line;
    if field(child_node_sub(1), child_node_sub(2)) ~= 2
        cost = norm(child_node_sub - [row, col]);
        neighborNodes(7,2) = cost;
    end
end

% 8.���½ڵ�
if row+1 <= rows && col+1 <= cols
    child_node_sub = [row+1, col+1];
    child_node_line = sub2ind([rows,cols], child_node_sub(1), child_node_sub(2));
    neighborNodes(8,1) = child_node_line;
    if field(child_node_sub(1), child_node_sub(2)) ~= 2
        cost = norm(child_node_sub - [row, col]);
        neighborNodes(8,2) = cost;
    end
end
