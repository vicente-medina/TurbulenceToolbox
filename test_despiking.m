clear;

load('ADV');

figure;
plot(VEL_IN.x-mean(VEL_IN.x),VEL_IN.z-mean(VEL_IN.z),'b.');
xlabel('vx (cm/s)');
ylabel('vz (cm/s)');
grid on;

VEL_OUT = despiking(VEL_IN);
line(VEL_OUT.x-mean(VEL_OUT.x),VEL_OUT.z-mean(VEL_OUT.z),'Color','black','LineStyle','.');


