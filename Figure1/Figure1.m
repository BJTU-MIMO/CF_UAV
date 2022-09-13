
hold on; box on;

x = [0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9];
y = [0.0013 0.007 0.017 0.039 0.071 0.12 0.18 0.26 0.37 0.48 0.60 0.73 0.85 0.93 0.98 0.99];

plot(sort(reshape(SE_CF_setup(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'r-','LineWidth',2);
plot(sort(reshape(SE_SC_setup(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'b--','LineWidth',2);
plot(sort(reshape(SE_Cellular_setup(:),[nbrOfSetups 1])),linspace(0,1,nbrOfSetups),'k-.','LineWidth',2);
plot(x,y,'ko','LineWidth',1);

xlabel('Uplink SE of UAV (bit/s/Hz)','Interpreter','latex');
ylabel('CDF','Interpreter','latex');
fig1=legend('CF','SC','Cellular','Simulation','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
axis([0 2 0 1]);
grid on;



