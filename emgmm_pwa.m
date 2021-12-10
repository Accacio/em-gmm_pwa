clear; close all
%% Generate data

N=100;
m=[2 1 3];
n=[0 3 -2];
theta=[m; n]';

part=[-4 0 4 9];

x = part(1)+(part(end)-part(1))*rand(1,N);

y = pwa(part,theta,x);
plot_pwa(part,x,y);

%%
