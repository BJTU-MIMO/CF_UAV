function [P_EH_low] = functionDownlinkEH_UAV_CF(R,Q,G_te,HMean,L,pd,kappa,tauc,taue)

p=pd;

test1=zeros(1,L);
test2=zeros(1,L);
test3=zeros(1,L);
test4=zeros(1,L);

for l=1:L
    test1(l) = trace(R(:,:,l)*Q(:,:,l)) ...
        + HMean(:,l)'*Q(:,:,l)*HMean(:,l) ...
        + HMean(:,l)'*R(:,:,l)*HMean(:,l); 
    test2(l) = trace(Q(:,:,l))+norm(HMean(:,l))^2; 
    test3(l) = test1(l)+abs(trace(Q(:,:,l)))^2 ...
        +abs(HMean(:,l)'*HMean(:,l))^2 + 2*real(trace(Q(:,:,l))*HMean(:,l)'*HMean(:,l));
    test4(l) = trace(G_te(:,:,l)*R(:,:,l))+HMean(:,l)'*G_te(:,:,l)*HMean(:,l);
end

% % 信号幅度相加后再平方求能量
% term1=p*sum(test1(:)./test2(:));
% term2=(sqrt(p)*sum(sqrt(test2(:))))^2;
% 
% P_in=term1+term2; 
% P_EH=kappa*P_in;

% 信号幅度平方后再相加求能量
P_in_low=(taue/tauc)*p*sum(test3(:)./test2(:)+test4(:));
P_EH_low=kappa*P_in_low;







