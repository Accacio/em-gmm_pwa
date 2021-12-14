clear; close all
%% Generate data

PI=pi;
emMaxIter=1;
N=200;
% N=5;
colors={'b','g','r'};
m=[2 2.5 3];
n=[0 3 -2];
theta=[m; n]';
part=[-4 0 4 9];

M=length(part)-1;
f=@(C,d,x) C'*x+d;

x = part(1)+(part(end)-part(1))*rand(1,N);

y = pwa(part,theta,x);
figure(1)
plot_pwa(part,x,y);

pi=repmat(1/M,1,M);
eps=1e-2;
% eps=1;
Sigma(:,:,1:3)=repmat(eps*eye(1),1,1,3);

%% Initialize estimated parameters


pi_hat=repmat(1/M,1,M);
% $y=-C_k^T x-d_k$
C=m;
d=n;
C=rand(1,M);
d=rand(1,M);
% C=m+rand();
% d=n+rand();

t=min(x):max(x);
hold on
for i=1:M
plot(t,f(C(:,i),d(:,i),t),colors{i})
end
hold off

% responsabilities=calculate_responsabilities(x,y,C,d,Sigma,pi_hat);
% figure
% plot_responsibles(x, y, responsabilities,C,d,Sigma,pi_hat,colors);

% [C_new,d_new,pi_new]=update_parameters(x, y, responsabilities);

% return

%% EM Algo
for emInd=1:emMaxIter

    responsabilities=calculate_responsabilities(x,y,C,d,Sigma,pi_hat);

    figure(2)
    subplot(2,1,2)
    cla
    plot_responsibles(x, y, responsabilities,C,d,Sigma,pi_hat,colors);
    title("EM")

    [C,d,pi]=update_parameters(x, y, responsabilities);

end
