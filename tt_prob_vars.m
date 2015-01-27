function P = tt_prob_vars(velocity)

vel_aux=[velocity.x;velocity.y;velocity.z];
avg_aux=mean(vel_aux,2);
P.avg.x=avg_aux(1:size(velocity.x,1));
P.avg.y=avg_aux(size(velocity.x,1)+1:2*size(velocity.x,1));
P.avg.z=avg_aux(2*size(velocity.x,1)+1:end);


std_aux=std(vel_aux,1,2);
P.std.x=std_aux(1:size(velocity.x,1));
P.std.y=std_aux(size(velocity.x,1)+1:2*size(velocity.x,1));
P.std.z=std_aux(2*size(velocity.x,1)+1:end);
clear std_aux

skew_aux=skewness(vel_aux,1,2);
P.skew.x=skew_aux(1:size(velocity.x,1));
P.skew.y=skew_aux(size(velocity.x,1)+1:2*size(velocity.x,1));
P.skew.z=skew_aux(2*size(velocity.x,1)+1:end);
clear skew_aux

