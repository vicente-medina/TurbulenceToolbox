function [v_max_pul]=tt_burst_vel_max_pul(VEL_OUT,ind_pul)
    u = tt_prime_velocities(VEL_OUT);
    %% Auxiliar vector that contains the magnitud of a vector.
    % The target is generate a vector with the maxim norm of the vector
    % u'w' to find the maximum value in each pulse or interval    
    N=length(u.x);   
    for i=1:N
       norm(i,:)=sqrt(u.x(i).^2+u.z(i).^2);
    end
    clear i N 
    %% %% Maximum Velocities primes in each duration pulse
    %Create Structure with the maximum values of u(x,y,z) where the 
    %magnitude of u'w' is maximum (furthest from the source) to each pulse
    %v_max_pul= Structure of u'maximum and w'maximum for each pulse (where
    %the norm is maximum in the range)
    n=length(ind_pul);      
    i=1;    
    for i=1:n    
        if i<n
            j=i+1;
            for m=ind_pul(i):ind_pul(j)-1 %search range
                if norm(m)==max(norm(ind_pul(i):ind_pul(j)-1)) 
                    v_max_pul.x(i,:)=u.x(m); %u.x value where the norm is maximum in the range
                    v_max_pul.y(i,:)=u.y(m); %u.y value where the norm is maximum in the range
                    v_max_pul.z(i,:)=u.z(m); %u.z value where the norm is maximum in the range
                end
            end
        elseif i==n
            N=length(u.x); 
            for m=ind_pul(i):N
                if norm(m)==max(norm(ind_pul(i):N))
                    v_max_pul.x(i,:)=u.x(m);
                    v_max_pul.y(i,:)=u.y(m);
                    v_max_pul.z(i,:)=u.z(m);
                end
            end
        end
    end       
    clear i n N
      
end 
