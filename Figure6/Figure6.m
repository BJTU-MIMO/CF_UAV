hold on; box on;

plot(sort(SE_setups_taboo(2:times_taboo)),linspace(0,1,times_taboo-1),'r-','LineWidth',2);
plot(sort(SE_setups_nearAP(2:times_nearAP)),linspace(0,1,times_nearAP-1),'b--','LineWidth',2);
plot(sort(SE_setups_line(2:times_line)),linspace(0,1,times_line-1),'k-.','LineWidth',2);

xlabel('per-slot SE of UAV (bit/s/Hz)','Interpreter','latex');
ylabel('CDF','Interpreter','latex');
legend('Angle search','AP search','Line path','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
grid on;

%%

SE_setups_taboo(SE_setups_taboo==0)=[];
SE_setups_nearAP(SE_setups_nearAP==0)=[];
SE_setups_line(SE_setups_line==0)=[];


%%

hold on; box on;
plot(sort(SE_setups_taboo),linspace(0,1,length(SE_setups_taboo)),'r-','LineWidth',2);
plot(sort(SE_setups_nearAP),linspace(0,1,length(SE_setups_nearAP)),'b--','LineWidth',2);
plot(sort(SE_setups_line),linspace(0,1,length(SE_setups_line)),'k-.','LineWidth',2);

xlabel('per-slot SE of UAV (bit/s/Hz)','Interpreter','latex');
ylabel('CDF','Interpreter','latex');
legend('Angle search','AP search','Line path','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
%axis([0 2 0 1]);
grid on;



