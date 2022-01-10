clear; close all
%% Generate data

PI=pi;

colorsgt={[ 0 0.447058823529412 0.741176470588235 ],[0.850980392156863   0.325490196078431   0.098039215686275],[0.929411764705882   0.694117647058824   0.125490196078431]};
colors={[ .5 0.447058823529412 0.741176470588235 ],[0.850980392156863   0.825490196078431   0.098039215686275],[0.929411764705882   0.694117647058824   0.625490196078431]};

% TODO(accacio) generate automatically
part=[-4 0 4 9];
m=[0 5 15];
n=[0 0 -40];
theta=[m; n]';

modes=length(part)-1;

N=100;
x = sort(part(1)+(part(end)-part(1))*rand(1,N));
y = pwa(part,theta,x);

figure(1)
subplot(2,1,1)
cla
plot_pwa(part,x,y,colorsgt);
title('Ground truth');

%% Initialize estimated parameters
emMaxIter=200;
maxErr=1e-4;

%% EM Algo

[C,d,responsabilities,pi,Sigma] = emgm_estimate(x,y,modes,emMaxIter,maxErr,colors);

sort(m)
sort(C)
