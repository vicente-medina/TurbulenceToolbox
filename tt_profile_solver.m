% logarithmic velocity law

function [x,u]=tt_profile_solver(d,z)
% loading data
file='.\TEST\';%define the working folder.
load .\TEST\Profile_vectors\PROFILE_VARS.mat;
load TEST\Profile_vectors\height.mat;

%% Variables
vel=VEL_PROFILE;
y=height;
k=0.41;

%% Optimization
%Valores iniciales (alpha,ucorte)
x0=[1*10^(-5)  1*10^(-5)];

%Create a handle to control function parameters
f_handle = @(vars) tt_vel_fit(vars,y,vel,k); 

%Optimization options 
options=optimset('TolX',1*10^(-4),'TolFun',1*10^(-7), 'Display', 'iter');

%Call optimization
x=fminsearchbnd(f_handle,x0,[0 0],[],options);
ks=x(1);
u_shear_fit=x(2);
alpha=ks/d;

%% obtaining value of velocity 
for i=2:length(z)
    v(i,:)=(1/k)*log(30*z(i)/ks)*u_shear_fit;
    if v(i,:)<=0
        u(i,:)=0;
    else
        u(i,:)=v(i,:);
    end
end

%% Results
velocity_fitted=u;
vel_mean_fit=trapz(z,u)/(z(end)-z(1));
C_adim_fit=vel_mean_fit/u_shear_fit;
save(strcat(file,'Profile_vectors\','FITTING_VARS','.mat'),'velocity_fitted','alpha','u_shear_fit','vel_mean_fit','C_adim_fit');

return
