function [myPos_new,myVel_new,myYaw_new] = updateByPP(refPath,myPos,myVel)
%% ��ز�������
dt = evalin('base','dt');
Ld0 = 1;               % Ld0��Ԥ����������ֵ

% ������ʼ״̬����
myPos = myPos(1:2);
v = norm(myVel(1:2));

%% Ѱ��Ԥ����뷶Χ�����·����
% �ҵ����뵱ǰλ�������һ���ο��켣������
dist = sqrt((refPath(:,1)-myPos(1)).^2 + (refPath(:,2)-myPos(2)).^2 );
[~,idx] = min(dist); 

% �Ӹõ㿪ʼ��켣ǰ���������ҵ���Ԥ������������һ���켣��
L_steps = 0;           % �ο��켣�ϼ������ڵ���ۼƾ���
Ld = v*dt + Ld0;       
sizeOfRefPos = size(refPath,1);
while L_steps < Ld && idx < sizeOfRefPos
    L_steps = L_steps + norm(refPath(idx + 1,:) - refPath(idx,:));
    idx = idx+1;
end
lookaheadPoint = refPath(idx,:);
deltaPos = lookaheadPoint - myPos(1:2);
yaw = atan2(deltaPos(2), deltaPos(1));

%% ����״̬��
myPos_new = zeros(1,3);
myVel_new = zeros(1,3);
myPos_new(1:2) = lookaheadPoint;
myYaw_new = yaw;
myYaw_new = myYaw_new * 180/ pi;

% ���������
if myYaw_new > 180
    myYaw_new = myYaw_new - 360;
end
if myYaw_new < -180
    myYaw_new = myYaw_new + 360;
end