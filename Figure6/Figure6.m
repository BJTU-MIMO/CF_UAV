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
SE_setups_allAP(SE_setups_allAP==0)=[];

SE_setups_taboo_in(SE_setups_taboo_in==0)=[];
SE_setups_nearAP_in(SE_setups_nearAP_in==0)=[];
SE_setups_line_in(SE_setups_line_in==0)=[];
SE_setups_allAP_in(SE_setups_allAP_in==0)=[];

% SE_setups(SE_setups==0)=[];
% plot(sort(SE_setups),linspace(0,1,length(SE_setups)),'m-.','LineWidth',2);
% grid on;
%%

subplot(2,1,1);
hold on; box on;
plot(sort(SE_setups_allAP),linspace(0,1,length(SE_setups_allAP)),'r-','LineWidth',2);
plot(sort(SE_setups_taboo),linspace(0,1,length(SE_setups_taboo)),'b--','LineWidth',2);
plot(sort(SE_setups_nearAP),linspace(0,1,length(SE_setups_nearAP)),'m-.','LineWidth',2);
plot(sort(SE_setups_line),linspace(0,1,length(SE_setups_line)),'k:','LineWidth',2);

xlabel('Per-slot SE of UAV (bit/s/Hz)','Interpreter','latex');
ylabel('CDF','Interpreter','latex');
legend('All APs path','Angle search','AP search','Line path','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',12);
axis([0 2 0 1]);
grid on;

%%


% aa = mean(SE_setups_allAP);
% bb = mean(SE_setups_taboo);
% cc = mean(SE_setups_nearAP);
% dd = mean(SE_setups_line);
% 
% aa_in = mean(SE_setups_allAP_in);
% bb_in = mean(SE_setups_taboo_in);
% cc_in = mean(SE_setups_nearAP_in);
% dd_in = mean(SE_setups_line_in);
% 
% data = [aa,aa_in; bb,bb_in; cc,cc_in; dd,dd_in];
% y = bar(data);
% 
% ch = get(y,'children');
% 
% set(gca,'XTickLabel',{'All APs path','Angle search','AP search','Line path'})
% 
% legend('Without terrestrial UE','With terrestrial UE');
% 
% ylabel('Aerage SE over the time');
% 
% axis([0 5 1.2 1.6]) 

%%
subplot(2,1,2);
%hold on; box on;
aa = mean(SE_setups_allAP);
bb = mean(SE_setups_taboo);
cc = mean(SE_setups_nearAP);
dd = mean(SE_setups_line);

data = [aa; bb; cc; dd];
y = bar(data,0.4);

ch = get(y,'children');

set(gca,'XTickLabel',{'All APs path','Angle search','AP search','Line path'})

%legend('Without terrestrial UE','With terrestrial UE');

ylabel('Aerage SE over the time (bit/s/Hz)');

axis([0 5 1.2 1.5]) 
grid on;

