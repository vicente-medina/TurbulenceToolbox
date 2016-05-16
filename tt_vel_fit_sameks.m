function [F,u]=tt_vel_fit_sameks(vars,y,velocities,K)
%% Variables
% Alpha and shear velocity constant in all profile
%vars(1)=ks;
%vars(2)=ucorte;

%% Function
[~,j]=size(y);
for k=1:j    
    z=y(:,k);  
    [num,~]=find(z==max(z));
    Z=z(1:num);
    for i=1:length(Z)
        u(i,:)=(1/K)*log((30*Z(i))/vars(1,1))*vars(k,2);
    end
    vel=velocities(1:num,k);
    f(1,k)=(sum((vel-u).^2));
    clear u z Z vel
end
F=sum(f);

end