function y = Jac(ynew, yold, unew, uold)
    tol = 1e-4;
    if(abs(unew-uold)<tol)
        y = 1;
    else
        y = (ynew-yold)/(unew-uold);
    end
    
end