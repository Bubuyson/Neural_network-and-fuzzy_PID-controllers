%==========================================================================
close all
clear all
clc 
pause(2)
%=========================================================================

load referans.mat referans Ts time 
plot(time,referans,'linewidth',2)
axis([min(time) max(time) min(referans)-0.5 max(referans)+0.5])
legend('r(t)') 
xlabel('Time(sec)')
