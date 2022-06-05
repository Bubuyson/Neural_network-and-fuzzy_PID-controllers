clc;clear;clear all
h = 0.1;
r(1:10/h) = 0.4;
r(10/h+1:20/h) = 0.5;
r(20/h+1:30/h) = 0.6;
r(30/h+1:40/h) = 0.5;
r(40/h+1:50/h+1) = 0.4;
t=0:h:50;

lambda = [0.1,0.5,1,10,100];
opt = zeros(length(lambda),4);

num = 4;
l_lim = [0,0,0,0];
r_lim = [5,5,5,5];
for i =1:length(lambda)
    fun = @(params)Fuz(lambda(i),params);
    opt(i,:) = ga(fun,num,[],[],[],[],l_lim,r_lim);
end
grad = 0:1/(length(lambda)-1):1;
for i=1:length(lambda) 
    FuzwPlot(grad(i),lambda(i),opt(i,:))
end

figure(1);
hold on; grid on; grid minor;
plot(t,r,'red','LineWidth',2)
str = ['output for \lambda='+string(lambda), 'input'];
legend(str)
title('Input and output signals with respect to time')
figure(2);
hold on; grid on; grid minor;
legend('\lambda='+string(lambda))
title('Control signal with respect to time')
