function [P_EH_SC] = functionDownlinkEH_UAV_Cellular(R,Q,G_te,HMean,L,pd,kappa,tauc,taue)

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



P_in_SC_l = p*((test1(:)+test2(:).^2)./test2(:)+test4(:));
P_in_SC = (taue/tauc)*max(P_in_SC_l);
P_EH_SC = kappa*P_in_SC;





