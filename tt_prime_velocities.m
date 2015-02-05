function fluct = tt_prime_velocities (velocities)

v_aux = [velocities.x velocities.y velocities.z];
%% Average velocities
avg = mean(v_aux);

%% Fluctuations
fluct_aux = v_aux-repmat(avg,size(v_aux(:,1)));
fluct.x = fluct_aux(:,1);
fluct.y = fluct_aux(:,2);
fluct.z = fluct_aux(:,3);

