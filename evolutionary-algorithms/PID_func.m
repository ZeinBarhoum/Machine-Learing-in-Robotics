function J = PID_func(G,dt,params)

KP = params(1);
KI = params(2);
KD = params(3);
s = tf('s');
N = 400;
K = KP+KI/s+KD*(N*s/(s+N));

forward_sys = series(K,G);
error_sys = feedback(1, forward_sys);% 1/(1+KG)
full_sys = feedback(forward_sys, 1);

t = 0:dt:20;

y = step(full_sys,t);

e = step(error_sys,t);

u = lsim(K, e, t);

R = 0.001;
Q = 1;

J = sum((Q*e.^2+R*u.^2)*dt)


step(full_sys,t);
h = findobj(gcf,'type','line');
set(h,'linewidth',2);
drawnow
end