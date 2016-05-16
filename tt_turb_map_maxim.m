%% MAPS OF BURSTING TURBULENCE
%This function allows us to draw maps of trubulence (u'w') by pulse
%duration.
%Is possible ti draw the raw values of u'w' and overlay the pairs of u'w'
%from each pulse duration. Also is possible to draw this pair by range of
%pulse durations.

function ttt_turb_map_maxim(VEL_OUT)
    %% Obtaining useful variables
  u = tt_prime_velocities(VEL_OUT);
  [~,pulse,velocities_pulse]=ttt_burst_calc_aux(VEL_OUT);

   %% Map of bursting turbulence from the signal (not pulses)
   % Blue points in the map
   h=figure;
   plot(u.x,u.z,'.',[min(u.x) max(u.x)],[0 0],'k-',[0 0],[min(u.z) max(u.z)],'k-','MarkerSize',4),title('Bursting event by pulse-Max value');   
   hold on
    
   %% Drawing burting turbulence of of a particular pulse duration
   % Here is possible t include on the turbulence map the pairs of u'w'
   % corresponding to a particular pulse duration just including before D
   % the number of steps (size) of the pulse we want to draw. That values
   % are contained in  velocities_pulse.average_struct_dur. Wher for each
   % duration there are the serie of velocity values.
   
   %v_max_pul_dur=velocities_pulse.maxim_struct_dur;
   %u=v_max_pul_dur.D4(:,1);
   %v=v_max_pul_dur.D4(:,2);
   %w=v_max_pul_dur.D4(:,3);
   %plot(u,w,'m.',[min(w) max(w)],[0 0],'k-',[0 0],[min(w) max(w)],'k-','MarkerSize',5);
   %hold on
   
   %Is possible to include more than one size of pulse just coping and 
   %pasting (If the pulse duration is present at the signal):       
   %u=v_max_pul_dur.D10(:,1);
   %v=v_max_pul_dur.D10(:,2);
   %w=v_max_pul_dur.D10(:,3);
   %plot(u,w,'m.',[min(w) max(w)],[0 0],'k-',[0 0],[min(w) max(w)],'k-','MarkerSize',5);
   %And so on
   
   %% Drawing by range of duration pulse
   % Is possible to draw at the same map not just a one size/duration pulse
   % but by range of duration pulse. (1-4 steps, 0.04 to 0.16 seconds),
   % (5-8 steps, 0.20 to 0.32 seconds), (9-16 steps, 0.36 to 0.64 seconds),
   % (17-32 steps, 0.68 to 1.28 seconds), for example. In that case we call
   % the next function.
   [uc,co,nd,dt]=ttt_range_pulse_duration(velocities_pulse.maxim,pulse.duration);
   
   %% Drawing range 1 to 4 steps (0.04 a 0.16 sec.) 
   % Magenta Points
   if isstruct(uc)==1
       plot(uc.x,uc.z,'m.',[min(u.x) max(u.x)],[0 0],'k-',[0 0],[min(u.z) max(u.z)],'k-','MarkerSize',4);
       hold on
   end   
   %% Drawing range 5 to 8 steps (0.2 a 0.32 sec.) 
   % Yellow Points   
    if isstruct(co)==1
        plot(co.x,co.z,'y.',[min(u.x) max(u.x)],[0 0],'k-',[0 0],[min(u.z) max(u.z)],'k-','MarkerSize',5); 
        hold on    
    end
    %% Drawing range 8 to 16 steps (0.36 a 0.64 sec.) 
    % Green Points           
    if isstruct(nd)==1
        plot(nd.x,nd.z,'g.',[min(u.x) max(u.x)],[0 0],'k-',[0 0],[min(u.z) max(u.z)],'k-','MarkerSize',5);
        hold on    
    end    
    %% Drawing range 16 to 32 steps (0.68 a 1.28 sec.) 
    % Red Points       
    if isstruct(dt)==1
        plot(dt.x,dt.z,'r.',[min(u.x) max(u.x)],[0 0],'k-',[0 0],[min(u.z) max(u.z)],'k-','MarkerSize',6);
        hold off   
    end
    clear uc co nd dt
end    


