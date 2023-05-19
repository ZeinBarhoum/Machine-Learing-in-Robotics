close all; clear all; clc
dt = 0.001;
PopSize = 25;
MaxGenerations = 10;
s = tf('s');
G = 1/(s*(s*s+s+1));
options =  optimoptions(@ga,'PopulationSize',PopSize,'MaxGenerations',MaxGenerations);
[x,fval] = ga(@(K)pidtest(G,dt,K),3,-eye(3),zeros(3,1))
function J = pidtest(G,dt,parms)
    s = tf('s');
    K = parms(1) + parms(2)/s + parms(3)*s/(1+.001*s);
    Loop = series(K,G);
    ClosedLoop = feedback(Loop,1);
    t = 0:dt:20;
    [y,t] = step(ClosedLoop,t);
    CTRLtf = K/(1+K*G);
    u = lsim(CTRLtf,1-y,t);
    Q = 1;
    R = .001;
    J = dt*sum(Q*(1-y(:)).^2+R*u(:).^2)
    [y,t] = step(ClosedLoop,t);
    plot(t,y,'LineWidth',2,'color','r')
    drawnow
end