function [C,d,responsabilities,pi,Sigma] = emgm_estimate(x,y,modes,emMaxIter,maxErr,colors)

    % $y=-C_k^T x-d_k$

    %% Initialize estimated parameters
    indexpts1=randi([1 size(x,2)-1],1,3);
    C=(y(:,indexpts1+1)-y(:,indexpts1))./(x(:,indexpts1+1)-x(:,indexpts1));
    d=y(:,indexpts1)-C.*x(:,indexpts1);
    C=C+rand(1,modes);
    d=d+rand(1,modes);

    pi=repmat(1/modes,1,modes);
    eps=10;
    Sigma(:,:,1:modes)=repmat(eps*eye(1),1,1,modes);


    OldclusterSize=zeros(1,modes);
    for emInd=1:emMaxIter
        responsabilities=calculate_responsabilities(x,y,C,d,Sigma,pi);

        figure(1)
        subplot(2,1,2)
        cla
        plot_responsibles(x, y, responsabilities,C,d,Sigma,pi,colors);
        title(['EM Gaussian Mixture iter=' num2str(emInd) ])

        [C,d,pi]=update_parameters(x, y, responsabilities);
        [~,z_hat]=max(responsabilities,[],1);

        for i=1:modes
            z_i=find(z_hat==i);
            clusterSize(i)=size(z_i,2);
            if OldclusterSize(i)==clusterSize(i)
                Sigma(:,:,i)=Sigma(:,:,i)*.9;
            else
                Sigma(:,:,i)=Sigma(:,:,i)*1.;
            end
        end
        if sum(Sigma < maxErr)==3
            break;
        end
        OldclusterSize=clusterSize;
    end
end
