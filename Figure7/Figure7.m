
hold on; box on;
plot(real(initial),imag(initial),'b>','LineWidth',3);
plot(real(destination),imag(destination),'k<','LineWidth',3);
plot(real(APpositions),imag(APpositions),'ro','LineWidth',2);
plot(real(UEpositions),imag(UEpositions),'m^','LineWidth',3);
plot(real(APpositions_Cellular),imag(APpositions_Cellular),'rp','LineWidth',3);

%plot([real(initial),real(UAVposition_trajectory_CF(1:time_CF))],[imag(initial),imag(UAVposition_trajectory_CF(1:time_CF))],'r-','LineWidth',2);

plot([real(initial),real(UAVposition_trajectory_SC(1:time_SC))],[imag(initial),imag(UAVposition_trajectory_SC(1:time_SC))],'r-','LineWidth',2);
plot([real(initial),real(UAVposition_trajectory_SC_in(1:time_SC_in))],[imag(initial),imag(UAVposition_trajectory_SC_in(1:time_SC_in))],'b--','LineWidth',2);
plot([real(initial),real(UAVposition_trajectory_Cellular(1:time_Cellular))],[imag(initial),imag(UAVposition_trajectory_Cellular(1:time_Cellular))],'k-.','LineWidth',2);

xlabel('X','Interpreter','latex');
ylabel('Y','Interpreter','latex');
legend('Initial position','Destination position','AP positions','TUE position','BS position','SC','SC (with TUE)','Cellular','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
axis([0 100 0 100]);
grid on;












