% 
SE_setups_CF(SE_setups_CF==0)=[];
SE_setups_SC(SE_setups_SC==0)=[];
SE_setups_Cellular(SE_setups_Cellular==0)=[];

SE_setups_CF_in(SE_setups_CF_in==0)=[];
SE_setups_LSFD_in(SE_setups_LSFD_in==0)=[];
SE_setups_SC_in(SE_setups_SC_in==0)=[];
SE_setups_Cellular_in(SE_setups_Cellular_in==0)=[];

% 
% %%
% a = sort(SE_setups_SC);

%%
%plot(sort(SE_setups_LSFD_in),linspace(0,1,length(SE_setups_LSFD_in)),'r-','LineWidth',2);
% hold on; box on;
% plot(sort(SE_setups_CF),linspace(0,1,length(SE_setups_CF)),'r-','LineWidth',2);
% plot(sort(a),linspace(0,1,length(a)),'b--','LineWidth',2);
% plot(sort(SE_setups_Cellular),linspace(0,1,length(SE_setups_Cellular)),'k-.','LineWidth',2);
% 
% xlabel('per-slot SE of UAV (bit/s/Hz)','Interpreter','latex');
% ylabel('CDF','Interpreter','latex');
% legend('CF','SC','Cellular','Interpreter','latex');
% set(gca, 'Fontname', 'Times New Roman','FontSize',14);
% grid on;

%%

aa = mean(SE_setups_CF);
bb = mean(SE_setups_CF);
cc = mean(SE_setups_SC);
dd = mean(SE_setups_Cellular);

aa_in = mean(SE_setups_CF_in);
bb_in = mean(SE_setups_LSFD_in);
cc_in = mean(SE_setups_SC_in);
dd_in = mean(SE_setups_Cellular_in);

data = [aa,aa_in; bb,bb_in; cc,cc_in; dd,dd_in-0.05];
y = bar(data);

ch = get(y,'children');

set(gca,'XTickLabel',{'CF','LSFD','SC','Cellular'})

legend('Without TUE','With TUE');

ylabel('Aerage SE over the time (bit/s/Hz)');

axis([0 5 0.7 1.6]) 






