function [prob,tau_re,ti,turb] = tt_basic_turbulence(vel)

%% Probability Functions %% 
% Obtains average, standar deviation and skewness of the three components
% of filtered velocity  

prob = tt_prob_vars(vel);

%% Reynolds Stresses

tau_re = tt_ReynoldsStresses(vel);

%% Turbulence Percentages

ti = tt_turb_int(vel,prob.avg);

%% Turbulence Properties
turb.tke=(prob.std.x.^2+prob.std.y.^2+prob.std.z.^2)./2;
% turb.epsilon=;
% turb.nu=;
% trub.tau=;

end