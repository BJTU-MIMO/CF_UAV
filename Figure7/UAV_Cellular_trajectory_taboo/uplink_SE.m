
clear;

%% Define simulation setup

nbrOfRealizations = 1000;

L=1;

N=40;

ASD=10;

kappa=0.98;

p=0.001;
pd=1;

taup = 1;
tauc = 201;
rho = 0.5;
partial = 1/((1-rho)*tauc+rho*taup);
taue = rho*(tauc-taup);

B = 20e6;  %Communication bandwidth
noiseFigure = 9;  %Noise figure (in dB)
noiseVariancedBm = -174 + 10*log10(B) + noiseFigure;  %Compute noise power
noiseVariance = db2pow(noiseVariancedBm)/1000; % W
squareLength = 100;   %meter

load 'APpositions_Cellular.mat';
%APpositions = (rand(L,1) + 1i*rand(L,1)) * squareLength;   % Random AP locations with uniform distribution

APheigth=0;  % The height of Access Point
UAVheigth = 20;    % The height of UAV Equipment

% initial position and P_EH, SE
initial = 0 + 1i*0;
UAVposition_initial = initial;
[R,HMean,H,HMeanx,H_Rayleigh,channelGain] = functionSetup(L,N,ASD,nbrOfRealizations,APpositions,initial,APheigth,UAVheigth);
[Hhat,Q,C,Psi] = functionChannelEstimates(R,HMean,H,HMeanx,L,N,nbrOfRealizations,p,kappa,noiseVariance);
[P_EH_Cellular0] = functionDownlinkEH_UAV_Cellular(R,Q,HMean,L,pd,kappa,tauc,taue);
[SE_Cellular0] = functionUplinkSE_UAV_Cellular(Hhat,C,L,N,(1-partial)*P_EH_Cellular0,kappa,noiseVariance,nbrOfRealizations,tauc,taue,taup);
P_pilot = partial*P_EH_Cellular0;
destination = (0.85 + 1i*0.85)*100;  % UAV destination

theta =0:(pi/18):pi/2;
%theta =pi/4:pi/4:2*pi;

slot = 5000;   % slot
interval =0.04;   % interval

UAVposition_trajectory =zeros(1,slot);
SE_trajectory = zeros(1,slot);

time = 0;

%%
for n=1:slot
    disp(['slot------------------- ' num2str(n) ' out of ' num2str(slot)]);
    
    if abs(destination-UAVposition_initial) < interval
        break
    end
    
    SE_Cellular_angle = zeros(1,length(theta));
    P_EH_Cellular_angle = zeros(1,length(theta));
    position_Cellular_angle = zeros(1,length(theta));
    
    for s = 1:length(theta)
        disp(['theta---------- ' num2str(s) ' out of ' num2str(length(theta))]);
        
        position = (real(UAVposition_initial)+interval*cos(theta(s))) + 1i*(imag(UAVposition_initial)+interval*sin(theta(s)));
        [R,HMean,H,HMeanx,H_Rayleigh,channelGain] = functionSetup(L,N,ASD,nbrOfRealizations,APpositions,position,APheigth,UAVheigth);
        [Hhat,Q,C,Psi] = functionChannelEstimates(R,HMean,H,HMeanx,L,N,nbrOfRealizations,P_pilot,kappa,noiseVariance);
        [P_EH_Cellular] = functionDownlinkEH_UAV_Cellular(R,Q,HMean,L,pd,kappa,tauc,taue);
        [SE_Cellular] = functionUplinkSE_UAV_Cellular(Hhat,C,L,N,(1-partial)*P_EH_Cellular,kappa,noiseVariance,nbrOfRealizations,tauc,taue,taup);
        
        a = real(destination)-real(position);
        b = imag(destination)-imag(position);
        
        if a<0||b<0
            SE_Cellular_angle(s) = 0;
        else
            SE_Cellular_angle(s) = SE_Cellular;
        end
        position_Cellular_angle(s) = position;
        P_EH_Cellular_angle(s) = P_EH_Cellular;
        
    end
    
    [SE_trajectory(n),index] = max(SE_Cellular_angle);
    P_pilot = partial*P_EH_Cellular_angle(index);
    UAVposition_initial = position_Cellular_angle(index);
    UAVposition_trajectory(n) = UAVposition_initial;
    
    time = time+1;
    
end

%%
figure;
hold on; box on;
plot(real(initial),imag(initial),'m>','LineWidth',3);
plot(real(destination),imag(destination),'k<','LineWidth',3);
plot(real(APpositions),imag(APpositions),'ro','LineWidth',2);
plot([real(initial),real(UAVposition_trajectory(1:time))],[imag(initial),imag(UAVposition_trajectory(1:time))],'b-*','LineWidth',1);

xlabel('X','Interpreter','latex');
ylabel('Y','Interpreter','latex');
legend('initial','destination','AP positions','UAV positions','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
axis([0 100 0 100]);
grid on;

%%
figure;
hold on; box on;

plot(0:time,[SE_Cellular0,SE_trajectory(1:time)],'r-','LineWidth',2);
plot([time, time],[0, SE_trajectory(time)+0.1],'k--');

xlabel('slot','Interpreter','latex');
ylabel('UAV SE','Interpreter','latex');
%legend('analytical','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
%axis([0 8 0 1]);
grid on;

%%
figure;
plot(sort([SE_Cellular0,SE_trajectory(1:time)]),linspace(0,1,time+1),'r-','LineWidth',2);
xlabel('per-slot UAV SE','Interpreter','latex');
ylabel('CDF','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
grid on;












