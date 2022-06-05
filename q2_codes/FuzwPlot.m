function optJ = FuzwPlot(grad, lambda, params)
%%
Da1 = 3;
Da2 = 0.5;
Da3 = 1;
d2 = 1;
h = 0.1;
x1(1) = 0.31;
x2(1) = 0.71;
x3(1) = 0.5;
r(1:10/h) = 0.4;
r(10/h+1:20/h) = 0.5;
r(20/h+1:30/h) = 0.6;
r(30/h+1:40/h) = 0.5;
r(40/h+1:50/h+1) = 0.4;
t=0:h:50;
%% Genetic
Ke = params(1);
Kde = params(2);
alpha_n = params(3);
beta_n = params(4);
% Ke=2.5;
% Kde=2.67;
% alpha_n=0.02;
% beta_n=0.04;
%%
u = [-1 -0.7 -0.5 -0.3 0
    -0.7 -0.4 -0.2 0 0.3
    -0.5 -0.2 0 0.2 0.5
    -0.3 0 0.2 0.4 0.7
    0 0.3 0.5 0.7 1];
%%
etr(1) = r(1) - x3(1);
e(1) = Ke*(etr(1));
% e(1) = Ke*(r(1)-x3(1));
de(1) = Kde*(etr(1) - 0)/h;
% de(1) = Kde*(e(1) - 0)/h;
J(1) = 0.5*etr(1)^2;
[row, col, A, B] = fuz2(e(1), de(1));

if(row == 5 && col == 5)
    ufc(1) = A(row)*B(col)*u(row, col);
elseif(col == 5)
    ufc(1) = A(row)*B(col)*u(row, col) + A(row+1)*B(col)*u(row+1, col);

elseif(row == 5)
    ufc(1) = A(row)*B(col)*u(row, col) + A(row)*B(col+1)*u(row, col+1);
else
    ufc(1) = A(row)*B(col)*u(row, col) + A(row+1)*B(col)*u(row+1, col) + A(row)*B(col+1)*u(row, col+1) + A(row+1)*B(col+1)*u(row+1, col+1);

end

ucn(1) = alpha_n*ufc(1) + beta_n*(ufc(1) + 0);
ufPID(1) = 0 + 0;
ufPID(2) = ufPID(1) + ucn(1); %gerekirse değiş
[x1(2), x2(2), x3(2)] = CSTR_runga_kutta_new(x1(1),x2(1),x3(1),Da1,Da2,Da3,d2,ufPID(2),h);
    

%%
for k = 2:length(t)-1
    etr(k) = r(k) - x3(k);
    e(k) = Ke*(etr(k));
%     e(k) = Ke*(r(k)-x3(k));
    de(k) = Kde*(etr(k) - etr(k-1))/h;
%     de(k) = Kde*(e(k)-e(k-1))/h;
    J(k) = J(k-1) + 0.5 * etr(k)^2 + 0.5*lambda*(ufPID(k) - ufPID(k-1))^2;
    [row, col, A, B] = fuz2(e(k), de(k));
    if(row == 5 && col == 5)
        ufc(k) = A(row)*B(col)*u(row, col);
    elseif(col == 5)
        ufc(k) = A(row)*B(col)*u(row, col) + A(row+1)*B(col)*u(row+1, col);
        
    elseif(row == 5)
        ufc(k) = A(row)*B(col)*u(row, col) + A(row)*B(col+1)*u(row, col+1);
    else
        ufc(k) = A(row)*B(col)*u(row, col) + A(row+1)*B(col)*u(row+1, col) + A(row)*B(col+1)*u(row, col+1) + A(row+1)*B(col+1)*u(row+1, col+1);
        
    end
    ucn(k) = alpha_n*ufc(k) + beta_n*(ufc(k) + ufc(k-1));
    ufPID(k+1) = ufPID(k) + ucn(k);
    [x1(k+1), x2(k+1), x3(k+1)] = CSTR_runga_kutta_new(x1(k),x2(k),x3(k),Da1,Da2,Da3,d2,ufPID(k+1),h);
    
end
optJ = J(end);
figure(1)
hold on; grid on
% plot(t,r,'red','Linewidth',2)
plot(t,x3,'Color',[grad/5 grad 1-grad],'Linewidth',2)
xlim([0, t(end)])
figure(2)
hold on; grid on
% plot(t,r,'red','Linewidth',2)
plot(t,ufPID,'Color',[grad grad/5 1-grad],'Linewidth',2)
xlim([0, t(end)])
end
% plot(0:0.1:50,r)




