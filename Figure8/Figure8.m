% 
% SE_setups_CF(SE_setups_CF==0)=[];
% SE_setups_SC(SE_setups_SC==0)=[];
% SE_setups_Cellular(SE_setups_Cellular==0)=[];
% 
% %%
% a = sort(SE_setups_SC);

%%

hold on; box on;
plot(sort(SE_setups_CF),linspace(0,1,length(SE_setups_CF)),'r-','LineWidth',2);
plot(sort(a),linspace(0,1,length(a)),'b--','LineWidth',2);
plot(sort(SE_setups_Cellular),linspace(0,1,length(SE_setups_Cellular)),'k-.','LineWidth',2);

xlabel('per-slot SE of UAV (bit/s/Hz)','Interpreter','latex');
ylabel('CDF','Interpreter','latex');
legend('CF','SC','Cellular','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
grid on;








