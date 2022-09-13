hold on; box on;

plot(real(initial),imag(initial),'b>','LineWidth',3);
plot(real(destination),imag(destination),'k<','LineWidth',3);
plot(real(APpositions),imag(APpositions),'ro','LineWidth',2);
plot([real(initial),real(UAVposition_trajectory_taboo(1:time_taboo))],[imag(initial),imag(UAVposition_trajectory_taboo(1:time_taboo))],'r-','LineWidth',2);
plot([real(initial),real(UAVposition_trajectory_nearAP(1:time_nearAP))],[imag(initial),imag(UAVposition_trajectory_nearAP(1:time_nearAP))],'b--','LineWidth',2);
plot([real(initial),real(UAVposition_trajectory_line(1:time_line))],[imag(initial),imag(UAVposition_trajectory_line(1:time_line))],'k-.','LineWidth',2);



xlabel('X','Interpreter','latex');
ylabel('Y','Interpreter','latex');
legend('Initial position','Destination position','AP positions','Angle search','AP search','Line path','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',14);
axis([0 100 0 100]);
grid on;











