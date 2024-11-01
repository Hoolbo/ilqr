function[X,U] = ilqr(Xin)
global arg

% --------------getLocalPlan-------------------------
getLocalPlan(Xin);
% --------------getLocalPlan-------------------------

[Xnominal,U] = getNominalTrajectory(Xin);
arg.Xnominal = Xnominal;
X = Xnominal;


Jold = getTotalCost(Xnominal,U);
arg.lamb = arg.lambInit;

for i=1:arg.max_iter
    
    [k,K] = backward(X,U);
    [Xnew,Unew] = forward(X,U,k,K);
    Jnew = getTotalCost(Xnew,Unew);
    if Jnew <Jold 
        fprintf('迭代第%d次，代价减小%f, lamb为%f\n',i,Jold-Jnew,arg.lamb);
        X = Xnew;
        U = Unew;
        arg.lamb = arg.lamb / arg.lamb_factor;
        if (Jold - Jnew) < arg.tol
            fprintf('迭代第%d次，求解成功\n',i);
            arg.defaultU = U;
            break;
        end
        Jold = Jnew;
    else
        fprintf('迭代第%d次，代价增加,lamb为%f\n',i,arg.lamb);
        arg.lamb = arg.lamb / arg.lamb_factor2  ;
        fprintf('迭代第%d次，求解失败\n',i);
        break;
        % if arg.lamb > arg.lamb_max
        %     fprintf('迭代第%d次，求解失败\n',i);
        %     break;
        % end
        if arg.lamb < 1e-4
            fprintf('迭代第%d次，求解失败\n',i);
            break;
        end
    end
    
end


end
