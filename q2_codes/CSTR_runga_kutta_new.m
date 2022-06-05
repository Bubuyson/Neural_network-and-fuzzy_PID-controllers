% Runge Kutta method for CSTR 
% Da1, Da2, Da3, d2 are CSTR parameters
% v1 is control input.
% h is the sampling time.
% x1, x2, x3 are the states of the system.

function  [x1,x2,x3]=CSTR_runga_kutta_new(x1,x2,x3,Da1,Da2,Da3,d2,v1,h)


k1x1=1-x1-Da1*x1+Da2*x2*x2;
k1x2=-x2+Da1*x1-Da2*x2*x2-Da3*d2*x2*x2+v1;
k1x3=-x3+Da3*d2*x2*x2;



k2x1=1-(x1+h*k1x1/2)-Da1*(x1+h*k1x1/2)+Da2*(x2+h*k1x2/2)*(x2+h*k1x2/2);
k2x2=-(x2+h*k1x2/2)+Da1*(x1+h*k1x1/2)-Da2*(x2+h*k1x2/2)*(x2+h*k1x2/2)-Da3*d2*(x2+h*k1x2/2)*(x2+h*k1x2/2)+v1;
k2x3=-(x3+h*k1x3/2 )+Da3*d2*(x2+h*k1x2/2)*(x2+h*k1x2/2);


k3x1=1-(x1+h*k2x1/2)-Da1*(x1+h*k2x1/2)+Da2*(x2+h*k2x2/2)*(x2+h*k2x2/2);
k3x2=-(x2+h*k2x2/2)+Da1*(x1+h*k2x1/2)-Da2*(x2+h*k2x2/2)*(x2+h*k2x2/2)-Da3*d2*(x2+h*k2x2/2)*(x2+h*k2x2/2)+v1;
k3x3=-(x3+h*k2x3/2)+Da3*d2*(x2+h*k2x2/2)*(x2+h*k2x2/2);



k4x1=1-(x1+h*k3x1)-Da1*(x1+h*k3x1)+Da2*(x2+h*k3x2)*(x2+h*k3x2);
k4x2=-(x2+h*k3x2)+Da1*(x1+h*k3x1)-Da2*(x2+h*k3x2)*(x2+h*k3x2)-Da3*d2*(x2+h*k3x2)*(x2+h*k3x2)+v1;
k4x3=-(x3+h*k3x3)+Da3*d2*(x2+h*k3x2)*(x2+h*k3x2);



x1=x1+(h/6)*(k1x1+2*k2x1+2*k3x1+k4x1);
x2=x2+(h/6)*(k1x2+2*k2x2+2*k3x2+k4x2);
x3=x3+(h/6)*(k1x3+2*k2x3+2*k3x3+k4x3);


