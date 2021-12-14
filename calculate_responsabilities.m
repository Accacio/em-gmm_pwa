function responsabilities = calculate_responsabilities(x, y, C, d, Sigma, pi)
% CALCULATE_RESPONSABILITIES -

  M=size(d,2);
  N=size(x,2);
  respNum=zeros(size(x,2),M);
  for i=1:M
    likelihood=mvnpdf(y',(C(:,i)'*x+d(:,i))',Sigma(:,:,i));
    prior=pi(i);
    respNum(:,i)=prior*likelihood;
  end
  normalizing_constant=sum(respNum,2);
  rate=(respNum./normalizing_constant)';
  % x=rand(3,1);
  % x=x+((1-[1 1 1]*x)*[1;1;1]/norm([1 1 1]')^2)

  responsabilities = rate;
  % responsabilities(isnan(responsabilities)) = x;
end
