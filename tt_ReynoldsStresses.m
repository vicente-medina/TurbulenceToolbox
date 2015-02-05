%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               FUNCTION OBTAINING REYNOLDS STRESSES                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [meanRS, instantRS] = tt_ReynoldsStresses(velocities)

vel_prime = tt_prime_velocities(velocities);

% Mean (over time) Reynolds Stresses
meanRS.xx=mean(vel_prime.x.^2);
meanRS.xy=mean(vel_prime.x.*vel_prime.y);
meanRS.xz=mean(vel_prime.x.*vel_prime.z);
meanRS.yy=mean(vel_prime.y.^2);
meanRS.yz=mean(vel_prime.y.*vel_prime.z);
meanRS.zz=mean(vel_prime.z.^2);

% Instant Reynolds Stresses
instantRS.xx = vel_prime.x.^2;
instantRS.xy = vel_prime.x.*vel_prime.y;
instantRS.xz = vel_prime.x.*vel_prime.z;
instantRS.yy = vel_prime.y.^2;
instantRS.yz = vel_prime.y.*vel_prime.z;
instantRS.zz = vel_prime.z.^2;

