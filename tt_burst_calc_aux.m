%% AUXILIARY CALCULATIONS OF BURSTING TURBULENCE
% This function obtains results of velocity series (quadrant belonging,
% dwell time in quadrant, several graphics) and results of pulses (quadrant 
% belonging,dwell time in quadrant, several graphics, maxim and average
% velocity in a pulse etc.

function [quadrant,pulse,velocities_pulse]=ttt_burst_calc_aux(VEL_OUT)
   %% QUADRANTS
   %First we have to find the quadrant that each pair of (u'w') belongs and 
   %the percentage of dwell time in each quadrant
   %quad= Contains the quadrant wich belongs each pair of u'w'
   %per= Percentage of dwell time in each quadrant of total
   [quad,per]=ttt_burst_quadrants(VEL_OUT);

   %% PULSES
   %Here we find the pulses by quadrants
   %pul= Pulse duration (by steps, 1 step=0.04 seg)
   %ind_pul= Index of beggining pulse in the serie 
   %quad_pul= Quadrant belonging to each pulse
   [pul,ind_pul,quad_pul]=ttt_burst_pulse(quad);
   %[pul,ind_pul,quad_pul]=burst_pulse_prova(quad);
            
   %% Average Velocities primes in each duration pulse
   %v_avg_pul= Structure of u'average and w'average for each pulse
   [v_avg_pul]=ttt_burst_vel_avg_pul(VEL_OUT,ind_pul); 
    
   %% Maximum Velocities primes in each duration pulse
   %v_max_pul= Structure of u'maximum and w'maximum for each pulse (where
   %the norm is maximum in the range)
   [v_max_pul]=ttt_burst_vel_max_pul(VEL_OUT,ind_pul);
    
   %% Separating the results (average and maximum velocities) by size pulse
   %v_avg_pul_dur= Structure of average velocities primes by pulse duration
   %v_max_pul_dur= Structure of maximum velocities primes by pulse duration
   %v_avg_mean_pul_dur = Vector of mean velocity in each pulse duration
   %v_max_mean_pul_dur = Vector of maximum velocity in each pulse duration
   %percent_dur_pul= Percentage of total time of each pulse duration
   [v_avg_pul_dur,v_avg_mean_pul_dur,v_max_pul_dur,v_max_mean_pul_dur,percent_pul_dur,v_quad_pul_dur]=ttt_burst_pulse_sep(pul,v_avg_pul,v_max_pul,quad_pul);
         
    %% Summary (Creating Structures of results)
    %Pulse Results
    pulse.duration=pul;%Pulse duration (by steps, 1 step=0.04 seg)
    pulse.index=ind_pul;%Index of beggining pulse in the serie 
    pulse.quadrant=quad_pul;%Quadrant belonging to each pulse
    pulse.percentage_duration=percent_pul_dur; % Percentage of total time of each pulse duration
    
    %Quadrants Results
    quadrant.quadrant=quad; %Contains the quadrant wich belongs each pair of u'w'
    quadrant.percentage=per; %Percentage of dwell time in each quadrant of total
    
    %Primes Velocities/Pulses
    velocities_pulse.average=v_avg_pul; %Vector of u'average and w'average for each pulse
    velocities_pulse.maxim=v_max_pul; %VeVector of u'maximum and w'maximum for each pulse
    velocities_pulse.quad_struct_dur=v_quad_pul_dur;%Structure of QUADRANTS by pulse duration
    velocities_pulse.average_struct_dur=v_avg_pul_dur; %Structure of average velocities primes by pulse duration
    velocities_pulse.maxim_struct_dur=v_max_pul_dur; %Structure of maximum velocities primes by pulse duration
    velocities_pulse.mean_avg_dur=v_avg_mean_pul_dur; %Vector of mean velocity in each pulse duration
    velocities_pulse.mean_max_dur=v_max_mean_pul_dur; %Vector of maximum velocity in each pulse duration
       
end

