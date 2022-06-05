clc;clear;
close all;
load referans.mat referans Ts time 
r = referans;
t = time;
n = 0.01;

%%
d1=r(1);
w11(1) = -1.7502; w12(1) = -0.8314; w13(1) = -1.1564;
w21(1) = -0.2857; w22(1) = -0.9792; w23(1) = -0.5336;
w31(1) = -2.0026; w32(1) = 0.9642; w33(1) = 0.5201;

u(1) = 0;
y(1) = 0;
y(2) = 0;
e(1) = d1-y(1);
x1 = w11*r(1)+w21*y(1);
x2 = w12*r(1)+w22*y(1);
x3 = w13*r(1)+w23*y(1);
v1 = Act(x1);
v2 = Act(x2);
v3 = Act(x3);
val = 0.2 %parameter to change for preventing instability
deltaw11 = n*e(1)*Jac(y(2),y(1),u(1),0)*w31(1)*dAct(x1)*r(1)*val;
deltaw12 = n*e(1)*Jac(y(2),y(1),u(1),0)*w32(1)*dAct(x2)*r(1)*val;
deltaw13 = n*e(1)*Jac(y(2),y(1),u(1),0)*w33(1)*dAct(x3)*r(1)*val;
deltaw21 = n*e(1)*Jac(y(2),y(1),u(1),0)*w31(1)*dAct(x1)*y(1)*val;
deltaw22 = n*e(1)*Jac(y(2),y(1),u(1),0)*w32(1)*dAct(x2)*y(1)*val;
deltaw23 = n*e(1)*Jac(y(2),y(1),u(1),0)*w33(1)*dAct(x3)*y(1)*val;
deltaw31 = n*e(1)*Jac(y(2),y(1),u(1),0)*v1*val;
deltaw32 = n*e(1)*Jac(y(2),y(1),u(1),0)*v2*val;
deltaw33 = n*e(1)*Jac(y(2),y(1),u(1),0)*v3*val;
    
w11(2) = w11(1)+ deltaw11; w12(2) = w12(1)+ deltaw12; w13(2) = w13(1) + deltaw13;
w21(2) = w21(1)+ deltaw21; w22(2) = w22(1)+ deltaw22; w23(2) = w23(1) + deltaw23;
w31(2) = w31(1)+ deltaw31; w32(2) = w32(1)+ deltaw32; w33(2) = w33(1) + deltaw33;
b = 1e-5;
%%

for k = 2:length(t)
    %%
    x1 = w11*r(k)+w21*y(k);
    x2 = w12*r(k)+w22*y(k);
    x3 = w13*r(k)+w23*y(k);
    v1 = Act(x1(k));
    v2 = Act(x2(k));
    v3 = Act(x3(k));
    u(k) = v1*w31(k)+v2*w32(k)+v3*w33(k) + b; %b yi değiş gerekirse
    e(k)=r(k)-y(k);
    y(k+1) = (1.2*(1-0.8*exp(-0.1*k))*y(k))/(1+(y(k))^2)+u(k);
    
    
     %% delta
    deltaw11 = n*e(k)*Jac(y(k+1),y(k),u(k),u(k-1))*w31(k)*dAct(x1(k))*r(k);
    deltaw12 = n*e(k)*Jac(y(k+1),y(k),u(k),u(k-1))*w32(k)*dAct(x2(k))*r(k);
    deltaw13 = n*e(k)*Jac(y(k+1),y(k),u(k),u(k-1))*w33(k)*dAct(x3(k))*r(k);
    deltaw21 = n*e(k)*Jac(y(k+1),y(k),u(k),u(k-1))*w31(k)*dAct(x1(k))*y(k);
    deltaw22 = n*e(k)*Jac(y(k+1),y(k),u(k),u(k-1))*w32(k)*dAct(x2(k))*y(k);
    deltaw23 = n*e(k)*Jac(y(k+1),y(k),u(k),u(k-1))*w33(k)*dAct(x3(k))*y(k);
    deltaw31 = n*e(k)*Jac(y(k+1),y(k),u(k),u(k-1))*v1;
    deltaw32 = n*e(k)*Jac(y(k+1),y(k),u(k),u(k-1))*v2;
    deltaw33 = n*e(k)*Jac(y(k+1),y(k),u(k),u(k-1))*v3;
    w11(k+1) = w11(k) + deltaw11;
    w12(k+1) = w12(k) + deltaw12;
    w13(k+1) = w13(k) + deltaw13;
    w21(k+1) = w21(k) + deltaw21;
    w22(k+1) = w22(k) + deltaw22;
    w23(k+1) = w23(k) + deltaw23;
    w31(k+1) = w31(k) + deltaw31;
    w32(k+1) = w32(k) + deltaw32;
    w33(k+1) = w33(k) + deltaw33;
end
figure(1)
hold on; grid on
plot(t,r, 'blue','Linewidth',2)
plot(t,y(1:end-1), 'red','Linewidth',2)
xlim([0 t(end)])
legend('input','output')
title('input and ouput signals with respect to time')
%%
figure(2)
subplot(3,3,1)
hold on; grid on
plot(t,w11(1:end-1), 'blue','Linewidth',2)
xlim([0 t(end)])
title('w11')
subplot(3,3,2)
hold on; grid on
plot(t,w12(1:end-1), 'blue','Linewidth',2)
xlim([0 t(end)])
title('w12')
subplot(3,3,3)
hold on; grid on
plot(t,w13(1:end-1), 'blue','Linewidth',2)
xlim([0 t(end)])
title('w13')
subplot(3,3,4)
hold on; grid on
plot(t,w21(1:end-1), 'blue','Linewidth',2)
xlim([0 t(end)])
title('w21')
subplot(3,3,5)
hold on; grid on
plot(t,w22(1:end-1), 'blue','Linewidth',2)
xlim([0 t(end)])
title('w22')
subplot(3,3,6)
hold on; grid on
plot(t,w23(1:end-1), 'blue','Linewidth',2)
xlim([0 t(end)])
title('w23')
subplot(3,3,7)
hold on; grid on
plot(t,w31(1:end-1), 'blue','Linewidth',2)
xlim([0 t(end)])
title('w31')
subplot(3,3,8)
hold on; grid on
plot(t,w32(1:end-1), 'blue','Linewidth',2)
xlim([0 t(end)])
title('w32')
subplot(3,3,9)
hold on; grid on
plot(t,w33(1:end-1), 'blue','Linewidth',2)
xlim([0 t(end)])
title('w33')
sgtitle('Weights')
%%
figure(3)
hold on; grid on
plot(t,u, 'black','Linewidth',2)
xlim([0 t(end)])
legend('control signal')
title('Control signal with respect to time')

