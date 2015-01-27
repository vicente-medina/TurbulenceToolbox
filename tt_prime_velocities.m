function fluct = tt_prime_velocities (velocities)

v_aux = [velocities.x; velocities.y; velocities.z];
%% Average velocities
avg = mean(v_aux,2);

%% Fluctuations
fluct_aux = v_aux-repmat(avg,1,length(v_aux));
fluct.x = fluct_aux(1:size(v_aux,1)/3,:);
fluct.y = fluct_aux(size(v_aux,1)/3+1:2*size(v_aux,1)/3,:);
fluct.z = fluct_aux(2*size(v_aux,1)/3+1:end,:);

