figure;
load("history.mat")
[bests_val, bests_ids] = min(cost);

sz = size(cost);
sz = sz(2);
for i= 1:sz
    K = history(bests_ids(i),:,i);
    PID_func(G,dt,K);
    hold on
    ylim([0,2])  
end
 
figure;
plot(min(cost))