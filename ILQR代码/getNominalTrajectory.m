function[Xnominal,U] = getNominalTrajectory(Xin)
global arg

Xnominal = zeros(arg.N+1,arg.num_states);
Xnominal(1,:) = Xin(:);
defaultU = zeros(arg.N,arg.num_ctrl) * 2;


for i=1:arg.N
    u = purePursuit(Xin);
    defaultU(i,2) = u;
    Xout = updateState(Xin,defaultU(i,:));
    Xnominal(i+1,:) = Xout(:);
    Xin = Xout;
end
U = defaultU;
end