function [str_func_value,epsilon]=tt_functions_structures(VEL_OUT,freq)

%% Number of orders and steps
beta=2;
step=20;
order=5;
file='.\TEST\';%define the working folder.

%% function Structure (orders=2,3,4,5)
r=(mean(VEL_OUT.x)*(1/freq));
K = 1:1:step;
for p=2:4; %orders
    P=strcat('order',num2str(p));
    vel_step_order = zeros(1,step);    
    for k=1:step
        vel_step_order(k) = mean((abs(VEL_OUT.x(1:k:end-k)-VEL_OUT.x(1+k:k:end))).^p);    
    end
    str_func_value.(P) = vel_step_order;
    epsilon.(P) = (vel_step_order./(beta*(r.*K).^(p/3))).^(3/p);
end
Epsilon=mean([epsilon.order2(1:4),epsilon.order3(1:4),epsilon.order4(1:4)]);%Nomes amb 2on i 3er ordre (pasos 1:4)

%% figures
figure;% epsilon f(r)
plot(r.*(1:1:step),epsilon.order2,'b');
hold on
plot(r.*(1:1:step),epsilon.order3,'r');
hold on
plot(r.*(1:1:step),epsilon.order4,'g');
hold off

figure; % str funct f(r)
loglog(r.*(1:1:step),str_func_value.order2,'b');
hold off

figure;
plot(r.*(1:1:step),(str_func_value.order4./(str_func_value.order2.^2)));
hold off

figure;
plot(r.*(1:1:step),(str_func_value.order3./(str_func_value.order2.^(3/2))));
hold off

%% probes..
prob = tt_prob_vars(VEL_OUT);
TKE=mean(prob.std.x.^2+prob.std.y.^2+prob.std.z.^2)./2;
NU=1.5*10e-6.*Epsilon^0.25;
REL=TKE^2/(Epsilon*1.5*10e-6);
L=NU/(REL^(-3/4));
EK=0.76*beta*epsilon.order2.^(2/3).*(2*pi./(r.*(1:1:20))).^(-5/3);

%L=TKE^(3/2)/Epsilon;
%EK=0.76*beta*(Epsilon^(2/3)).*((2*pi./(r.*(1:1:20))).^(-5/3));

figure;
loglog(2*pi./(r.*(1:1:20)),(EK));
hold on
loglog([(2*pi)/NU],0.001,'r.','MarkerSize',9)
hold on
loglog([(2*pi)/L],0.001,'k.','MarkerSize',9)
hold off


end