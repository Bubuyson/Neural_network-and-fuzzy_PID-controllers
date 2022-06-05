function [row, col, A, B] = fuz2(e,de)
% % % % % a1 a2 a3
% % % % % b1 b2 b3

a1 = 0;a2 = 0;a3 = 0; a4 = 0; a5 = 0;b1 = 0;b2 = 0;b3 = 0; b4 = 0; b5 = 0;
%% A
    if(e<=-1)
        a1 = 1;
    elseif(e>-1 && e<=-0.4)
        a1 = (-0.4-e)/0.6;
        a2 = (e+1)/0.6;      
    elseif(e>-0.4 && e<=0)
        a2 = (-e)/0.4;
        a3 = (e+0.4)/0.4;                
    elseif(e>0 && e<=0.4)
        a3 = (-e+0.4)/0.4;
        a4 = e/0.4;      
    elseif(e>0.4 && e<=1)
        a4 = (-e+1)/(0.6);
        a5 = (e-0.4)/0.6;  
    elseif(e>1)
        a5 = 1;     
    end
 %% B
    if(de<=-1)
        b1=1;
    elseif(de>-1 && de<=-0.4)
        b1 = (-0.4-de)/0.6;
        b2 = (de+1)/0.6;
    elseif(de>-0.4 && de<=0)
        b2 = (-de)/0.4;
        b3 = (de+0.4)/0.4;
    elseif(de>0 && de<=0.4)
        b3 = (-de+0.4)/0.4;
        b4 = de/0.4;
    elseif(de>0.4 && de<=1)
        b4 = (-de+1)/(0.6);
        b5 = (de-0.4)/0.6;
    elseif(de>1)
        b5 = 1;
    end
%%
    A = [a1 a2 a3 a4 a5];
    B = [b1 b2 b3 b4 b5];
    if(length(find(A>0))>0)
        Apos = find(A>0);
    else
        Apos = 3;
    end
    
    if(length(find(B>0))>0)
        Bpos = find(B>0);
    else
        Bpos = 3;
    end
%     Apos = find(A>0);
%     Bpos = find(B>0);
    row = Apos(1);
    col = Bpos(1);
    
end