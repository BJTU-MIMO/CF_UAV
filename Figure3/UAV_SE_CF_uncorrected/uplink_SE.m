
clear;

%% Define simulation setup

nbrOfRealizations = 1000;

nbrOfSetups = 5000;

L=20;

N=2;

ASD=10;

kappa=0.98;

p=0.001;
pd=1;

taup = 1;
tauc = 201;
rho = [0:0.05:0.95 0.999999];

P_EH_CF_setup=zeros(length(rho),nbrOfSetups);
SE_CF_setup=zeros(length(rho),nbrOfSetups);

%Communication bandwidth
B = 20e6;
%Noise figure (in dB)
noiseFigure = 9;
%Compute noise power
noiseVariancedBm = -174 + 10*log10(B) + noiseFigure;
noiseVariance = db2pow(noiseVariancedBm)/1000; % W


%%
for n=1:nbrOfSetups
    disp(['Setup------------------- ' num2str(n) ' out of ' num2str(nbrOfSetups)]);
        
    for s = 1:length(rho)
        disp(['rho---------- ' num2str(s) ' out of ' num2str(length(rho))]);
        
        partial = 1/((1-rho(s))*tauc+rho(s)*taup);
        taue = rho(s)*(tauc-taup);
        
        [R,HMean,H,HMeanx,H_Rayleigh,channelGain] = functionSetup(L,N,ASD,nbrOfRealizations);
        
        [Hhat0,Q0,C0,Psi0] = functionChannelEstimates(R,HMean,H,HMeanx,L,N,nbrOfRealizations,p,kappa,noiseVariance);
        
        [P_EH_CF0] = functionDownlinkEH_UAV_CF(R,Q0,HMean,L,pd,kappa,tauc,taue);
        
        [Hhat,Q,C,Psi] = functionChannelEstimates(R,HMean,H,HMeanx,L,N,nbrOfRealizations,((tauc/taup)*partial*P_EH_CF0),kappa,noiseVariance);
        
        [P_EH_CF] = functionDownlinkEH_UAV_CF(R,Q,HMean,L,pd,kappa,tauc,taue);
        
        P_EH_CF_setup(s,n) = P_EH_CF;
        
        [SE_CF] = functionUplinkSE_UAV_CF(R,Q,HMean,L,(tauc/(tauc-taup-taue))*(1-partial)*P_EH_CF,kappa,noiseVariance,tauc,taue,taup);
        
        SE_CF_setup(s,n) = SE_CF;
        
    end
    
end

%%
hold on; box on;

SE_CF_setup1 = sort(SE_CF_setup(:,:),2);
plot(rho,SE_CF_setup1(:,0.5*nbrOfSetups),'b-','LineWidth',2);

xlabel('rho','Interpreter','latex');
ylabel('Average SE','Interpreter','latex');
legend('CF','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
%axis([0 8 0 1]);
grid on;



