function [df_dx,df_du] = ilqr_getABMatrix(Xin,Uin)
global arg
syms sym_x sym_y sym_phi sym_v sym_a sym_delta
beta = atan((arg.lr / (arg.lr + arg.lf)) * tan(sym_delta));
xout = sym_x + sym_v * cos(sym_phi * beta) * arg.dt;
yout = sym_y + sym_v * sin(sym_phi * beta) * arg.dt;
phiout = sym_phi + (sym_v / arg.lf) * sin(beta) * arg.dt;
vout = sym_v + sym_a * arg.dt;
f = [xout; yout; phiout; vout];
X = [sym_x,sym_y,sym_phi,sym_v];
U = [sym_a,sym_delta];
df_dx_sym = jacobian(f, X);
df_du_sym = jacobian(f, U);

df_dx = zeros(arg.N,arg.num_states,arg.num_states);
df_du = zeros(arg.N,arg.num_states,arg.num_ctrl);
for i=1:arg.N
    vars = [sym_x sym_y sym_phi sym_v sym_a sym_delta];
    values = [Xin(i,1) Xin(i,2) Xin(i,3) Xin(i,4) Uin(i,1) Uin(i,2)];
    df_dx(i,:,:) = double(subs(df_dx_sym, vars, values));
    df_du(i,:,:) = double(subs(df_du_sym, vars, values));
end

end