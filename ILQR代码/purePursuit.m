function [u] = purePursuit(Xin)
global arg

temp = (Xin(1)-arg.xcoord(:)).^2 + (Xin(2)-arg.ycoord(:)).^2;
mintemp = min(temp);
indexNow = find(mintemp == temp);

indexTarget = indexNow;
L = 0;
Ld = arg.Kv * Xin(4) + arg.Ld0;
while L < Ld
    L = L + (arg.slength(indexTarget+1)-arg.slength(indexTarget));
    indexTarget = indexTarget+1;
end

if indexTarget >= 10000
    indexTarget = 10000;
end
    
alpha = atan2(arg.ycoord(indexTarget)-Xin(2),arg.xcoord(indexTarget)-Xin(1)) - Xin(3);

u = atan2(2*arg.l*sin(alpha),Ld);

end