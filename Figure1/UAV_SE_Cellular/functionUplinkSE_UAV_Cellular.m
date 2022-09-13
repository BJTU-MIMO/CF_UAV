function [SE] = functionUplinkSE_UAV_Cellular(Hhat,C,L,N,pu,kappa,noiseVariance,nbrOfRealizations,tauc,taue,taup)

sigma2=noiseVariance;
p=pu;

SINR = zeros(nbrOfRealizations,L);

for i = 1:nbrOfRealizations
    for l=1:L
        SINR(i,l) = kappa*p*abs(Hhat(:,i,l)'*Hhat(:,i,l))^2/((1-kappa)*p*abs(Hhat(:,i,l)'*Hhat(:,i,l))^2+Hhat(:,i,l)'*(p*C(:,:,l)+sigma2*eye(N))*Hhat(:,i,l));
    end    
end

SE = ((tauc-taue-taup)/(tauc))*max(squeeze(mean(real(log2(1+SINR(:,:))),1)));

