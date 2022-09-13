function [Hhat,Q,C,Psi] = functionChannelEstimates(R,HMean,H,HMeanx,L,N,nbrOfRealizations,p,kappa,noiseVariance)

sigma2=noiseVariance;
eyeN = eye(N);
Psi=zeros(N,N,L);

%Generate realizations of normalized noise
Np = sqrt(0.5*sigma2)*(randn(N,nbrOfRealizations,L) + 1i*randn(N,nbrOfRealizations,L));
Eta = sqrt(0.5*(1-kappa)*p)*(randn(1,nbrOfRealizations) + 1i*randn(1,nbrOfRealizations));
Etax=reshape(repmat(Eta,N,L),N,nbrOfRealizations,L);

% prepare to save

Hhat=zeros(N,nbrOfRealizations,L);
z=zeros(N,nbrOfRealizations,L);
zbar=zeros(N,nbrOfRealizations,L);
Q=zeros(N,N,L);
C=zeros(N,N,L);

    for l=1:L
        z(:,:,l) = sqrt(kappa*p)*H(:,:,l)+Etax(:,:,l).*H(:,:,l)+Np(:,:,l);
        %z(:,:,l) = sqrt(kappa*p)*HMeanx(:,:,l)+sqrt(kappa*p)*H_Rayleigh(:,:,l) ...
                 %+Etax(:,:,l).*HMeanx(:,:,l)+Etax(:,:,l).*H_Rayleigh(:,:,l)+Np(:,:,l);
        zbar(:,:,l) = sqrt(kappa*p)*HMeanx(:,:,l);
        Psi(:,:,l) = (p*R(:,:,l)+(1-kappa)*p*HMean(:,l)*HMean(:,l)'+sigma2*eyeN)^(-1);
        Hhat(:,:,l) = HMeanx(:,:,l)+sqrt(kappa*p)*R(:,:,l)*Psi(:,:,l)*(z(:,:,l)-zbar(:,:,l));
        Q(:,:,l) = kappa*p*R(:,:,l)*Psi(:,:,l)*R(:,:,l);
        C(:,:,l) = R(:,:,l)-Q(:,:,l);
    end

%     for l=1:L
%         z(:,:,l) = sqrt(p)*H(:,:,l)+Np(:,:,l);
%         %z(:,:,l) = sqrt(kappa*p)*HMeanx(:,:,l)+sqrt(kappa*p)*H_Rayleigh(:,:,l) ...
%                  %+Etax(:,:,l).*HMeanx(:,:,l)+Etax(:,:,l).*H_Rayleigh(:,:,l)+Np(:,:,l);
%         zbar(:,:,l) = sqrt(p)*HMeanx(:,:,l);
%         Psi(:,:,l) = (p*R(:,:,l)+sigma2*eyeN)^(-1);
%         Hhat(:,:,l) = HMeanx(:,:,l)+sqrt(p)*R(:,:,l)*Psi(:,:,l)*(z(:,:,l)-zbar(:,:,l));
%         Q(:,:,l) = p*R(:,:,l)*Psi(:,:,l)*R(:,:,l);
%         C(:,:,l) = R(:,:,l)-Q(:,:,l);
%     end




% Hhat=zeros(N,nbrOfRealizations,L);
% z=zeros(N,nbrOfRealizations,L);
% zbar=zeros(N,L);
% Q=zeros(N,N,L);
% C=zeros(N,N,L);
%     
%     for l=1:L
%         for n=1:nbrOfRealizations
%             z(:,n,l) = sqrt(kappa*p)*HMean(:,l)+sqrt(kappa*p)*H_Rayleigh(:,n,l) ...
%                  +Eta(n)*HMean(:,l)+Eta(n)*H_Rayleigh(:,n,l)+Np(:,n,l);
%             zbar(:,l) = sqrt(kappa*p)*HMean(:,l);
%             Psi(:,:,l) = (p*R(:,:,l)+(1-kappa)*p*HMean(:,l)*HMean(:,l)'+sigma2*eyeN)^(-1);
%             Hhat(:,n,l) = HMean(:,l)+sqrt(kappa*p)*R(:,:,l)*Psi(:,:,l)*(z(:,n,l)-zbar(:,l));
%             Q(:,:,l) = kappa*p*R(:,:,l)*Psi(:,:,l)*R(:,:,l);
%             C(:,:,l) = R(:,:,l)-Q(:,:,l);
%              
%             
%         end
%     end







