function demo
clc
close all


global arg
%载入参数
arguments();

%状态变量 x y phi v
index = 1;
X = [arg.xcoord(index);arg.ycoord(index);arg.theta(index); arg.startSpeed;];

% X = [arg.xcoord(index);arg.ycoord(index); heading ; arg.startSpeed;];
Xlog = zeros(arg.num_states,arg.tf/arg.dt);

%控制变量 a 加速度 delta 前轮转角
U = zeros(arg.num_ctrl);

for i=1:arg.tf/arg.dt
    hold on;
    axis equal;
    fprintf('---------- 仿真第%d步 ------------\n ',i);
    [Xnew,Unew] = ilqr(X);
    % i
    % Xnew(1,4)
    % Unew(1,2)
    X = updateState(Xnew(1,:),Unew(1,:));
    Xlog(1:2,i) = X(1:2);
    % scatter(arg.xcoord,arg.ycoord);
    scatter(arg.xcoord, arg.ycoord, 30, [0.678, 0.847, 0.902], 'filled');
    scatter(Xlog(1,1:i),Xlog(2,1:i),3,'red');
    fprintf('------------速度V=%f\n------------前轮转角=%f\n',X(4),rad2deg(Unew(1,2)));
    scatter(Xnew(:,1),Xnew(:,2),3,"green");
    % scatter(arg.Xnominal(:,1),arg.Xnominal(:,2),0.5,"green")
    scatter(X(1),X(2),10,"yellow");
    rectangle('Position', [300, 0, 5, 2], 'EdgeColor', 'r', 'FaceColor', 'r', 'LineWidth', 1);
    
    drawnow;
    hold off;
end


