%LAW OF THE WALL. Find the fitting logarithmic velocity.

function [F,u]=tt_vel_fit(vars,z,vel,k)
%% Variables
% Alpha and shear velocity constant in all profile
%vars(1)=ks;
%vars(2)=ucorte;

%% Function
for i=1:length(z)
    u(i,:)=(1/k)*log((30*z(i))/vars(1))*vars(2);
end
F=(sum((vel-u).^2));

end