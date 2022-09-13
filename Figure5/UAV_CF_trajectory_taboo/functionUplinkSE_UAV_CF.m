function [SE] = functionUplinkSE_UAV_CF(R,Q,HMean,L,pu,kappa,noiseVariance,tauc,taue,taup)

sigma2=noiseVariance;
p=pu;
a=ones(1,L)./L;

test1=zeros(1,L);
test2=zeros(1,L);
test3=zeros(1,L);

for l=1:L
    test1(l) = a(l)*(trace(Q(:,:,l))+norm(HMean(:,l))^2);

    test2(l) = abs(a(l))^2*(trace(R(:,:,l)*Q(:,:,l)) ...
                +HMean(:,l)'*Q(:,:,l)*HMean(:,l)+HMean(:,l)'*R(:,:,l)*HMean(:,l) );    
    test3(l) = abs(a(l))^2*(trace(Q(:,:,l))+norm(HMean(:,l))^2);
end


%% analytical整理后的

term1 = kappa*p*abs(sum(test1(:)))^2;
term2 =  p*sum(test2(:));
term3 = (1-kappa)*p*sum(test1(:))^2;
term4 = sigma2*sum(test3(:));
SE = ((tauc-taue-taup)/(tauc))*real(log2(1+term1/(term2+term3+term4))); 




