function P = tt_prob_vars(velocity)

vel_aux=[velocity.x velocity.y velocity.z];
avg_aux=mean(vel_aux);
P.avg.x=avg_aux(1);
P.avg.y=avg_aux(2);
P.avg.z=avg_aux(3);


std_aux=std(vel_aux);
P.std.x=std_aux(1);
P.std.y=std_aux(2);
P.std.z=std_aux(3);
clear std_aux

skew_aux=skewness(vel_aux);
P.skew.x=skew_aux(1);
P.skew.y=skew_aux(2);
P.skew.z=skew_aux(3);
clear skew_aux

kurt_aux=kurtosis(vel_aux);
P.kurt.x=kurt_aux(1);
P.kurt.y=kurt_aux(2);
P.kurt.z=kurt_aux(3);
clear kurt_aux

