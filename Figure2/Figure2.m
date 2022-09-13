
clear;

load figure2.mat;
ss = 0.03*10^(-6);
P_EH_CF_setup_in = P_EH_CF_setup_in + ss;
P_EH_SC_setup_in = P_EH_SC_setup_in + ss;
P_EH_Cellular_setup_in = P_EH_Cellular_setup_in + ss;

hold on; box on;

x=10^(-6)*[1 1.5 2 2.5 3 3.5 4 4.5 5 ...
           0.5 0.7 0.9 1.1 1.3 1.5 1.7 1.9 ...
           0.5 1 1.5 2 2.5 3 3.5 4 4.5 5];
y=[0.003 0.024 0.073 0.15 0.27 0.41 0.58 0.78 1 ...
   0.029 0.15 0.37 0.64 0.85 0.96 0.99 1 ...
   0.42 0.68 0.81 0.87 0.91 0.94 0.96 0.98 0.992 1];

plot(sort(reshape(P_EH_CF_setup(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'r-','LineWidth',2);
plot(sort(reshape(P_EH_SC_setup(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'b--','LineWidth',2);
plot(sort(reshape(P_EH_Cellular_setup(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'m-.','LineWidth',2);
plot(x,y,'ko','LineWidth',1);
plot(sort(reshape(P_EH_CF_setup_in(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'k:','LineWidth',2);
plot(sort(reshape(P_EH_SC_setup_in(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'k:','LineWidth',2);
plot(sort(reshape(P_EH_Cellular_setup_in(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'k:','LineWidth',2);

xlabel('Downlink HE of UAV (W)','Interpreter','latex');
ylabel('CDF','Interpreter','latex');
legend('CF','SC','Cellular','Simulation','With terrestrial UE','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',13);
axis([0 5.5*10^(-6) 0 1]);
grid on;

%%
magnify;

