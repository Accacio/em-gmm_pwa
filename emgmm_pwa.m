clear; close all
%% Generate data

PI=pi;
emMaxIter=200;

colorsgt={[ 0 0.447058823529412 0.741176470588235 ],[0.850980392156863   0.325490196078431   0.098039215686275],[0.929411764705882   0.694117647058824   0.125490196078431]};
colors={[ .5 0.447058823529412 0.741176470588235 ],[0.850980392156863   0.825490196078431   0.098039215686275],[0.929411764705882   0.694117647058824   0.625490196078431]};
part=[-4 0 4 9];
m=[0 5 15];
n=[0 0 -40];
theta=[m; n]';

M=length(part)-1;
f=@(C,d,x) C'*x+d;

N=200;
x = part(1)+(part(end)-part(1))*rand(1,N);
x=sort(x);

y = pwa(part,theta,x);
figure(1)
subplot(2,1,1)
cla
plot_pwa(part,x,y,colorsgt);
title('Ground truth');

pi=repmat(1/M,1,M);
eps=10;
Sigma(:,:,1:M)=repmat(eps*eye(1),1,1,M);

%% Initialize estimated parameters


pi_hat=repmat(1/M,1,M);
% $y=-C_k^T x-d_k$
% C=m;
% d=n;
indexpts1=randi([1 N-1],1,3);
C=(y(:,indexpts1+1)-y(:,indexpts1))./(x(:,indexpts1+1)-x(:,indexpts1));
d=y(:,indexpts1)-C.*x(:,indexpts1);
C=C+rand(1,M);
d=d+rand(1,M);
% C=rand();
% d=rand();
% C=m+rand();
% d=n+rand();


% [C_new,d_new,pi_new]=update_parameters(x, y, responsabilities);

% return
OldclusterSize=zeros(1,M);
%% EM Algo
for emInd=1:emMaxIter
    responsabilities=calculate_responsabilities(x,y,C,d,Sigma,pi_hat);

    figure(1)
    subplot(2,1,2)
    cla
    plot_responsibles(x, y, responsabilities,C,d,Sigma,pi_hat,colors);
    title("EM")

    [C,d,~]=update_parameters(x, y, responsabilities);
    [~,z_hat]=max(responsabilities,[],1);

  for i=1:3
    z_i=find(z_hat==i);
    clusterSize(i)=size(z_i,2);
    if OldclusterSize(i)==clusterSize(i)
        Sigma(:,:,i)=Sigma(:,:,i)*.9;
    else
        Sigma(:,:,i)=Sigma(:,:,i)*1.;
    end
  end
  if sum(Sigma < 1e-4)==3
      break;
  end
  OldclusterSize=clusterSize;
end
