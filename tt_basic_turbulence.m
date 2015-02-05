function [prob,tau_re,ti,turb] = tt_basic_turbulence(vel, freq)

%% Water properties
water_kin_visc = 10e-6;

%% Probability Functions %% 
% Obtains average, standar deviation and skewness of the three components
% of filtered velocity  

prob = tt_prob_vars(vel);

%% Reynolds Stresses
tau_re = tt_ReynoldsStresses(vel);

%% Turbulence Percentages
ti = tt_turb_int(vel,prob.avg);

%% Turbulence Properties
% Kinetic energy
turb.tke=(prob.std.x.^2+prob.std.y.^2+prob.std.z.^2)./2;

% Viscous energy rate disipation
delta_x = prob.avg.x * 1 / freq;
turb.epsilon = 15*water_kin_visc*mean(gradient(vel.x,delta_x).^2);

%% Kolmogorov scales
turb.nu = (water_kin_visc^3/turb.epsilon)^0.25;
turb.tau = (water_kin_visc/turb.epsilon)^0.5;
turb.u_nu = (water_kin_visc*turb.epsilon)^0.25;

end