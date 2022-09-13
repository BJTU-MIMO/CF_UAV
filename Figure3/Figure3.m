
hold on; box on;

%SE_CF_setup1_or = sort(SE_CF_setup_or(:,:),2);
plot(rho,SE_CF_setup1_or(:,0.5*nbrOfSetups),'r-o','LineWidth',2);

%SE_CF_setup1_N = sort(SE_CF_setup_N(:,:),2);
plot(rho,SE_CF_setup1_N(:,0.5*nbrOfSetups),'b--o','LineWidth',2);

% %SE_CF_setup1_un = sort(SE_CF_setup_un(:,:),2);
% plot(rho,SE_CF_setup1_un(:,0.5*nbrOfSetups),'m-.','LineWidth',2);

%SE_CF_setup1_H = sort(SE_CF_setup_H(:,:),2);
plot(rho,SE_CF_setup1_H(:,0.5*nbrOfSetups),'k-.o','LineWidth',2);

xlabel('Time-splitting factor $\rho$','Interpreter','latex');
ylabel('Median uplink SE (bit/s/Hz)','Interpreter','latex');
legend('$N=2, H=20$ m','$N=4, H=20$ m','$N=2, H=15$ m','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
%axis([0 8 0 1]);
grid on;



