
hold on; box on;

%SE_CF_setup1_or = sort(SE_CF_setup_or(:,:),2);
plot(rho,SE_CF_setup1_or(:,0.5*nbrOfSetups),'r-o','LineWidth',2);

%SE_CF_setup1_kappa = sort(SE_CF_setup_kappa(:,:),2);
plot(rho,SE_CF_setup1_kappa(:,0.5*nbrOfSetups),'b--o','LineWidth',2);

%SE_CF_setup1_L = sort(SE_CF_setup_L(:,:),2);
plot(rho,SE_CF_setup1_L(:,0.5*nbrOfSetups),'k-.o','LineWidth',2);

xlabel('rho','Interpreter','latex');
ylabel('Median SE','Interpreter','latex');
legend('$L=20, N=2, \kappa=1, ASD=10$','$L=20, N=2, \kappa=0.9, ASD=10$','$L=30, N=2, \kappa=1, ASD=10$','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
%axis([0 8 0 1]);
grid on;

%%

 or = SE_CF_setup1_or(:,0.5*nbrOfSetups);
 kappa = SE_CF_setup1_kappa(:,0.5*nbrOfSetups);
 L = SE_CF_setup1_L(:,0.5*nbrOfSetups);

%%

hold on; box on;

plot(rho,or,'r-o','LineWidth',2);
plot(rho,kappa,'b--o','LineWidth',2);
plot(rho,L,'k-.o','LineWidth',2);

xlabel('Time-splitting factor $\rho$','Interpreter','latex');
ylabel('Median uplink SE (bit/s/Hz)','Interpreter','latex');
legend('$L=20, \kappa=1$','$L=20, \kappa=0.9$','$L=30, \kappa=1$','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
%axis([0 8 0 1]);
grid on;