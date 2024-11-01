function[] = arguments()
global arg 
%车辆几何参数
arg.lf = 1.597;
arg.lr = 1.133;
arg.l = 2.73;
arg.startSpeed = 50;
arg.desireSpeed = 50;
arg.steer_angle_max = 1;
arg.steer_angle_min = -1;

%仿真参数
arg.dt = 0.1;
arg.tf = 1000;
arg.num_states = 4;
arg.num_ctrl = 2;

%地图参数
load('VIbest0915.mat');
arg.xcoord  = xcoord;
arg.ycoord  = ycoord;
load('NurburgringLengthVsCur3.mat');
arg.slength = slength';
arg.Curv    = Curv';
arg.theta   = theta;

%纯跟踪参数
arg.Kv = 0.05; %前视距离系数
arg.Kp = 0.8; %速度P控制器系数
arg.Ld0 = 1;  %Ld0是预瞄距离的下限值



%ilqr参数
arg.N = 10; %Horizon
arg.tol = 1e-2;
arg.max_iter = 200;
arg.lamb_factor = 2;
arg.lamb_factor2 = 1.5;
arg.lambInit = 5;
arg.lamb_max = 1000;
arg.defaultU = zeros(arg.N,arg.num_ctrl);
arg.totalBarrierCost = 0;

arg.Q = [3, 0, 0, 0;
         0, 3, 0, 0;
         0, 0, 2, 0;
         0, 0, 0, 2 ];

arg.R = [1, 0;
         0, 1 ];

end