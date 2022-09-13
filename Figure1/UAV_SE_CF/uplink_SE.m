
clear;

%% Define simulation setup

nbrOfRealizations = 1000;

nbrOfSetups = 5000; %5000

L=20;

N=2;

ASD=10;

kappa=0.98;

p=0.001;
pd=1;
pt=0.001;


P_EH_CF_setup=zeros(1,nbrOfSetups);
SE_CF_setup=zeros(1,nbrOfSetups);

%Communication bandwidth
B = 20e6;
%Noise figure (in dB)
noiseFigure = 9;
%Compute noise power
noiseVariancedBm = -174 + 10*log10(B) + noiseFigure;
noiseVariance = db2pow(noiseVariancedBm)/1000; % W

taup = 1;
tauc = 201;
rho = 0.5;
partial = 1/((1-rho)*tauc+rho*taup);
taue = rho*(tauc-taup);

%%
for n=1:nbrOfSetups  
     disp(['Setup------------------- ' num2str(n) ' out of ' num2str(nbrOfSetups)]); 

     [R,R_te,HMean,H,HMeanx,H_Rayleigh,channelGain] = functionSetup(L,N,ASD,nbrOfRealizations);

     [Hhat0,Q0,C0,Psi0,G_te0] = functionChannelEstimates(R,R_te,HMean,H,HMeanx,L,N,nbrOfRealizations,p,kappa,noiseVariance,pt);

     [P_EH_CF0] = functionDownlinkEH_UAV_CF(R,Q0,G_te0,HMean,L,pd,kappa,tauc,taue);
     
     [Hhat,Q,C,Psi,G_te] = functionChannelEstimates(R,R_te,HMean,H,HMeanx,L,N,nbrOfRealizations,((tauc/taup)*partial*P_EH_CF0),kappa,noiseVariance,pt);
     
     [P_EH_CF] = functionDownlinkEH_UAV_CF(R,Q,G_te,HMean,L,pd,kappa,tauc,taue);

     P_EH_CF_setup(n) = P_EH_CF;
     
     [SE_CF] = functionUplinkSE_UAV_CF(R,Q,R_te,HMean,L,(tauc/(tauc-taup-taue))*(1-partial)*P_EH_CF,kappa,noiseVariance,tauc,taue,taup,pt);
     
     SE_CF_setup(n) = SE_CF;
   
end

%%
hold on; box on;
%figure;
plot(sort(reshape(P_EH_CF_setup(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'r-','LineWidth',2);
grid on;
figure;
plot(sort(reshape(SE_CF_setup(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'b-','LineWidth',2);
grid on;

xlabel('Per-User Uplink SE (bit/s/Hz)','Interpreter','latex');
ylabel('CDF','Interpreter','latex');
fig1=legend('analytical','SC','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
%axis([0 8 0 1]);
grid on;



