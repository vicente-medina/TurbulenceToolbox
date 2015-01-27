function TP = tt_turb_int(velocity, average)

vel_prime=tt_prime_velocities(velocity);

vel_prime_aux=[vel_prime.x;vel_prime.y;vel_prime.z];
avg_aux = [average.x; average.y; average.z];

TP_aux=mean(abs(vel_prime_aux),2)./avg_aux.*100;

TP.x=TP_aux(1:size(velocity.x,1));
TP.y=TP_aux(size(velocity.x,1)+1:2*size(velocity.x,1));
TP.z=TP_aux(1:size(velocity.x,1));