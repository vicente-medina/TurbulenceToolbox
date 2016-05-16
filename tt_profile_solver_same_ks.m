%logarithmic law velocity 2

function [x,u]=tt_profile_solver_sameks(d,aprox)

file='.\prova_ks\';%define the working folder.
[velocities,~,~]=xlsread('prova_ks\vel_height_d2.xlsx',1);
[height,~,~]=xlsread('prova_ks\vel_height_d2.xlsx',2);

%% Variables
vel=velocities;
[~,n]=size(velocities);
y=height;
K=0.41;

%% Optimization
%Valores iniciales (alpha,ucorte)
x0=ones(n,2)*1*10^(-5);

%Create a handle to control function parameters
f_handle = @(vars) tt_vel_fit_sameks(vars,y,vel,K); 

%Optimization options 
options=optimset('TolX',1*10^(-4),'TolFun',1*10^(-7), 'Display', 'iter');

%Call optimization
x=fminsearchbnd(f_handle,x0,[ones(n,1)*aprox, zeros(n,1)],[ones(n,1)*aprox, ones(n,1)],options);
%x=fminsearchbnd(f_handle,x0,zeros(n,2),[],options);
ks=x(:,1);
alpha=ks/d;
u_shear_fit=x(:,2);


%% obtaining value of velocity fitted
for k=1:n    
    z=(0:0.001:max(y(:,k)));  
    for i=2:length(z)
        v(i,k)=(1/K)*log(30*z(i)/ks(k))*u_shear_fit(k);
        if v(i,k)<=0
            u(i,k)=0;
        else
            u(i,k)=v(i,k);
        end
    end
end

%% Results
for k=1:n    
    z=(0:0.001:max(y(:,k))); 
    vel_fit=u(1:length(z),k);
    vel_mean_fit(k)=trapz(z,vel_fit)/(z(end)-z(1));
    C_adim_fit(k)=vel_mean_fit(k)/u_shear_fit(k);  
    figure;
    profile=num2str(k);
    plot(vel(:,k),height(:,k),'b');
    hold on 
    plot(vel_fit,z,'r')
    saveas(gcf,strcat(file,'vel',profile,'.fig'));
    close gcf      
end
vel_mean_fitted=vel_mean_fit';
save(strcat(file,'KS_CTE','.mat'),'alpha','u_shear_fit','vel_mean_fitted','C_adim_fit');

end