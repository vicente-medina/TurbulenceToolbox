function res = tt_quadrants(velocity)
res = 1;

vel_prime = tt_prime_velocities(velocity);

figure('Position',[10 50 1200 400])

x_lim=ceil(max(abs(vel_prime.x))/10)*10;
y_lim=ceil(max(abs(vel_prime.y))/10)*10;
z_lim=ceil(max(abs(vel_prime.z))/10)*10;

subplot(1,3,1)
plot(velocity.x,velocity.y,'b.'); hold on
plot([-x_lim,x_lim],[0,0],'k',[0,0],[-y_lim,y_lim],'k'); hold off
axis equal
axis([-x_lim x_lim -y_lim y_lim]);
set(gca,'XTick',-x_lim:20:x_lim,'YTick',-y_lim:20:y_lim)
grid on
xlabel('$V^{\prime}{x}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold');
ylabel('$V^{\prime}_{y}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0);

subplot(1,3,2)
plot(velocity.x,velocity.z,'g.'); hold on
plot([-x_lim,x_lim],[0,0],'k',[0,0],[-z_lim,z_lim],'k'); hold off
axis equal
axis([-x_lim x_lim -z_lim z_lim]);
set(gca,'XTick',-x_lim:20:x_lim,'YTick',-z_lim:20:z_lim)
grid on
xlabel('$V^{\prime}_{x}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold');
ylabel('$V^{\prime}_{z}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0);

subplot(1,3,3)
plot(velocity.y,velocity.z,'r.'); hold on
plot([-y_lim,y_lim],[0,0],'k',[0,0],[-z_lim,z_lim],'k'); hold off
axis equal
axis([-y_lim y_lim -z_lim z_lim]);
set(gca,'XTick',-y_lim:20:y_lim,'YTick',-z_lim:20:z_lim)
grid on
xlabel('$V^{\prime}_{y}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold');
ylabel('$V^{\prime}_{z}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0);

res = 0;
