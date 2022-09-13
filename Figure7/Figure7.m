
hold on; box on;
plot(real(initial),imag(initial),'b>','LineWidth',3);
plot(real(destination),imag(destination),'k<','LineWidth',3);
plot(real(APpositions),imag(APpositions),'ro','LineWidth',2);
plot(real(APpositions_Cellular),imag(APpositions_Cellular),'mp','LineWidth',3);
plot([real(initial),real(UAVposition_trajectory_CF(1:time_CF))],[imag(initial),imag(UAVposition_trajectory_CF(1:time_CF))],'r-','LineWidth',2);
plot([real(initial),real(UAVposition_trajectory_SC(1:time_SC))],[imag(initial),imag(UAVposition_trajectory_SC(1:time_SC))],'b--','LineWidth',2);
plot([real(initial),real(UAVposition_trajectory_Cellular(1:time_Cellular))],[imag(initial),imag(UAVposition_trajectory_Cellular(1:time_Cellular))],'k-.','LineWidth',2);

xlabel('X','Interpreter','latex');
ylabel('Y','Interpreter','latex');
legend('Initial position','Destination position','AP positions','BS position','CF','SC','Cellular','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
axis([0 100 0 100]);
grid on;












