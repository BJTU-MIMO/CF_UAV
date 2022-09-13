
clear;

%% Define simulation setup

nbrOfRealizations = 1000;

nbrOfSetups = 5000;%5000; 

L=20;

N=2;

ASD=10;

kappa=0.98;

p=0.001;
pd=1;
pt=0.001;


P_EH_SC_setup=zeros(1,nbrOfSetups);
SE_SC_setup=zeros(1,nbrOfSetups);

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

     [P_EH_SC0] = functionDownlinkEH_UAV_SC(R,Q0,G_te0,HMean,L,pd,kappa,tauc,taue);
     
     [Hhat,Q,C,Psi,G_te] = functionChannelEstimates(R,R_te,HMean,H,HMeanx,L,N,nbrOfRealizations,((tauc/taup)*partial*P_EH_SC0),kappa,noiseVariance,pt);

     [P_EH_SC] = functionDownlinkEH_UAV_SC(R,Q,G_te,HMean,L,pd,kappa,tauc,taue);

     P_EH_SC_setup(n) = P_EH_SC;

     [SE_SC] = functionUplinkSE_UAV_SC(Hhat,C,R_te,L,N,(tauc/(tauc-taup-taue))*(1-partial)*P_EH_SC,kappa,noiseVariance,nbrOfRealizations,tauc,taue,taup,pt);
     
     SE_SC_setup(n) = SE_SC;
   
end

%%
hold on; box on;

plot(sort(reshape(P_EH_SC_setup(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'r--','LineWidth',2);
figure;
plot(sort(reshape(SE_SC_setup(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'b-','LineWidth',2);


xlabel('Per-User Uplink SE (bit/s/Hz)','Interpreter','latex');
ylabel('CDF','Interpreter','latex');
fig1=legend('analytical','SC','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
%axis([0 8 0 1]);
grid on;



