function res = tt_histogram(velocity)

res = 1;
% Fluctuating velocities

vel_prime = tt_prime_velocities(velocity);


figure('Position',[10 50 1200 400])
subplot(1,3,1)
hist(vel_prime.x,100)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','k')
xlabel('$\frac{cm}{s}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold')
ylabel('V{\prime}_{x}','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)

subplot(1,3,2)
hist(vel_prime.y,100)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','g','EdgeColor','k')
xlabel('$\frac{cm}{s}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold')
ylabel('V{\prime}_{x}','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)

subplot(1,3,3)
hist(vel_prime.z,100)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','k')
xlabel('$\frac{cm}{s}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold')
ylabel('V{\prime}_{x}','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)


% Reynolds Stresses

[ans, tauRe] = tt_ReynoldsStresses(velocity);

tauRe_aux = [tauRe.xx; tauRe.xy; tauRe.xz; tauRe.yy; tauRe.yz; tauRe.zz]';

figure('Position',[10 50 1600 800])
subplot(2,3,1)
hist(tauRe.xx,100)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','k')
xlabel('$\tau_{xx}\left(\frac{cm^{2}}{s^{2}}\right)$','Interpreter','LaTex','FontSize',14,'FontWeight','bold')
ylabel('pdf','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)


subplot(2,3,2)
hist(tauRe.yy,100)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','g','EdgeColor','k')
xlabel('$\tau_{yy}\left(\frac{cm^{2}}{s^{2}}\right)$','Interpreter','LaTex','FontSize',14,'FontWeight','bold')
ylabel('pdf','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)


subplot(2,3,3)
hist(tauRe.zz,100)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','k')
xlabel('$\tau_{zz}\left(\frac{cm^{2}}{s^{2}}\right)$','Interpreter','LaTex','FontSize',14,'FontWeight','bold')
ylabel('pdf','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)


subplot(2,3,4)
hist(tauRe.xy,100)
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[1    0.6  0],'EdgeColor','k')
xlabel('$\tau_{xy}\left(\frac{cm^{2}}{s^{2}}\right)$','Interpreter','LaTex','FontSize',14,'FontWeight','bold')
ylabel('pdf','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)


subplot(2,3,5)
hist(tauRe.xz,100)
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[0    0.5  0],'EdgeColor','k')
xlabel('$\tau_{xz}\left(\frac{cm^{2}}{s^{2}}\right)$','Interpreter','LaTex','FontSize',14,'FontWeight','bold')
ylabel('pdf','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)


subplot(2,3,6)
hist(tauRe.yz,100)
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[0    0    0.8],'EdgeColor','k')
xlabel('$\tau_{yz}\left(\frac{cm^{2}}{s^{2}}\right)$','Interpreter','LaTex','FontSize',14,'FontWeight','bold')
ylabel('pdf','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)

res = 0;
res

