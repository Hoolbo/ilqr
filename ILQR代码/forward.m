function[Xnew,Unew] = forward(X,U,k,K)
global arg
JoldForward = getTotalCost(X,U);
alpha = 1;
Xnew = zeros(arg.N+1,arg.num_states);
Xnew(1,:) = X(1,:);
Unew = zeros(arg.N,arg.num_ctrl);

for j=1:100
    for i=1:arg.N
    Unew(i,:) = U(i,:)' + alpha * k(i,:)' + squeeze(K(i,:,:)) * (Xnew(i,:) - X(i,:))';
    Xnew(i+1,:) = updateState(Xnew(i,:),Unew(i,:));
    end
    JnewForward = getTotalCost(Xnew,Unew);

    if JnewForward <= JoldForward
        break; 
    else
        alpha = alpha * 0.5;
    end

end





end