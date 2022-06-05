function y = dAct(x)
    y = 1-(exp(x)-exp(-x))/(exp(x)+exp(-x))^2;
end