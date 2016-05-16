function tt_resist_coef(d,d84)
%% loading data
file='.\TEST\';%define the working folder.
load .\TEST\Profile_vectors\FITTING_VARS.mat;
[hydr_vars,~,tabl_hyd]=xlsread('\TEST\bed_results.xlsx',1);%load data of hydrodynamics
[phys_vars,~,tabl_phis]=xlsread('\TEST\bed_results.xlsx',3);%load data of hydrodynamics

%% Defining vectors
rh=hydr_vars(:,12);
y=hydr_vars(:,5);
s0=hydr_vars(:,4);
fr=hydr_vars(:,18);
sf=hydr_vars(:,19);
rb=[hydr_vars(:,10)./hydr_vars(:,6)];
x=hydr_vars(:,2);
z=hydr_vars(:,3);
C_adim_u_teor=hydr_vars(:,23);
v=hydr_vars(:,13);
g=9.81;

j=1;
for i=2:15
    X(j,:)=phys_vars(i,2);
    Z(j,:)=phys_vars(i,11);
    j=j+1;
end

%% Caluclatin C chezy Adimensional from various autors

% C_adim Chezy by hydraulics vars
u_shear_hyd=(g.*rh.*sf).^0.5;
C_adim_hyd=v./u_shear_hyd;

%Limerinos
for i=1:length(rh)
    if max(rh/d84)<=68.55 && min(rh/d84)>=0.90
        C_adim_lim(i,:)=5.657*log10(rh(i)/d84)+3.281;
    elseif max(rh/d)<=177 && min(rh/d)>=1.90
        C_adim_lim(i,:)=5.657*log10(rh(i)/d)+0.99;
    else
        disp('Problem_use_Limerinos')
    end
end
    
%Bathurst
for i=1:length(rh)
    if max(y/d84)<=50 && min(y/d84)>=0.3
        C_adim_Bath(i,:)=5.62*log10(y(i)/d84)+4;
    else
        disp('Problem_use_Bathurst')
    end
end

%Fuentes y Aguirre
for i=1:length(rh)
    if max(y/d)<=77 && min(y/d)>=0.3
        C_adim_Agui(i,:)=5.657*log10(y(i)/d)+1.33+0.737*(1/(y(i)/d));
    else
        disp('Problem_use_Aguirre')
    end
end

%García Flores
for i=1:length(rh)
    if fr(i)>1
        if max(y/d84)<=100 && min(y/d84)>=0.3
            C_adim_Flor(i,:)=5.756*log10(y(i)/d84)+3.698;
        elseif max(rb/d)<=200 && min(rb/d)>=0.6
            C_adim_Flor(i,:)=5.756*log10(rb(i)/d)+1.559;
        else
            disp('Problem_use_G_Flores')
        end
    elseif fr(i)<1
        if max(y/d84)<=100 && min(y/d84)>=0.3
            C_adim_Flor(i,:)=5.756*log10(y(i)/d84)+2.2794;
        elseif max(rb/d)<=200 && min(rb/d)>=0.6
            C_adim_Flor(i,:)=5.756*log10(rb(i)/d)+0.2425;
        else
            disp('Problem_use_G_Flores')
        end        
    end
end

%Van Rijn
for i=1:length(rh)
    C_adim_Rijn(i,:)=5.75*log10((12*rb(i))/(3*d84));
end

%Jarret
for i=1:length(rh)
    if max(rh)<=2.1 && min(rh)>=0.15
        n(i)=0.39*sf^0.38/(3.28*rh(i))^0.16;
    else
        disp('Problem_Jarret')
    end
end

%% Calculating n_(Manning)

n_mann=(rh.^(2/3).*sf.^0.5)./v; %with hydraulic variables.
n_flor=0.111.*(rh.^(1/6))./(2*log10(rh./d84)+1.2849);
n_lim=0.1129.*((rh.^0.167)./(1.16+2*log10(rh./d84)));
n_fit=rh(4).^(1/6)./(C_adim_fit*g^0.5);
sf_fit=u_shear_fit^2/(g*rh(4));

n_C_adim_hyd=rh.^(1/6)./(C_adim_hyd*g^0.5);
n_C_adim_lim=(rh.^(1/6))./(C_adim_lim.*g^0.5);
n_C_adim_Bath=(rh.^(1/6))./(C_adim_Bath.*g^0.5);
n_C_adim_Agui=(rh.^(1/6))./(C_adim_Agui.*g^0.5);
n_C_adim_Flor=(rh.^(1/6))./(C_adim_Flor.*g^0.5);
n_C_adim_Rijn=(rh.^(1/6))./(C_adim_Rijn.*g^0.5);

%% Figures
figure;
plot(X,Z,'k');
hold on 
plot(x,y+z,'b')
saveas(gcf,fullfile(file,'Profile\','experiment_long_profile'),'fig');
close gcf

figure;
plot(x,n_mann,x,n_C_adim_lim,x,n_C_adim_Bath,x, n_C_adim_Agui,x,n_C_adim_Flor,x,n_C_adim_Rijn,x,n_lim,x,n_flor);
hold on 
plot(x(4),n_fit,'r.','MarkerSize',10);
legend('n Manning','n Limerinos','n Bathurst','n Aguirre','n Garcia Flores','n Van Rijn','n equation Lim','n equation Flor','n fitted');
saveas(gcf,fullfile(file,'Profile\','Manning_long_profile'),'fig');
close gcf

%% Savind results
save(strcat(file,'Profile\','Ressistance_coefs','.mat'),'n_mann','n_C_adim_lim','n_C_adim_Bath', 'n_C_adim_Agui','n_C_adim_Flor','n_C_adim_Rijn','n_lim','n_flor', 'C_adim_hyd','C_adim_lim','C_adim_Bath','C_adim_Agui','C_adim_Flor','C_adim_Rijn','n_fit','sf_fit'); 


end