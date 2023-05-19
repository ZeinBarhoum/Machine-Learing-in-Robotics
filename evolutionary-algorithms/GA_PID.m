clear;
clc;
delete history.mat
clear history_func

dt = 0.001;
PopSize = 30;
MaxGenerations = 15;

s = tf('s');
G = 1/(s^3+s^2+s);
% G = 1/(s^2+10*s+1);

options = optimoptions('ga','MaxGenerations', MaxGenerations, 'PopulationSize',PopSize, 'OutputFcn',@history_func);

[x,fval] = ga(@(K)PID_func(G,dt,K),3,-eye(3),zeros(3,1),[],[],[],[],[],options);

PID_func(G,dt,x);

