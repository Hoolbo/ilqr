function[Jnew] = getTotalCost(X,U)
%暂定
Jnew = 0;
global arg
for i=1:arg.N
    [x_r,y_r,theta_r]= findClosestPoint(X(i+1,:));
    ref_state = [x_r; y_r; 0 ; arg.desireSpeed;];
    state_diff = X(i+1,:)' - ref_state;

    cost_state = state_diff' * arg.Q * state_diff;
    cost_ctrl = U(i,:) * arg.R * U(i,:)';
    Jnew = Jnew + cost_state + cost_ctrl; 
end
    getCostDerivatives(X,U);
    Jnew = Jnew + arg.totalBarrierCost;

end