function [v_avg_pul]=ttt_burst_vel_avg_pul_tot(VEL_OUT,ind_pul)
   %% Average Velocities primes in each duration pulse
   %v_avg_pul= Structure of u'average and w'average for each pulse
    u = VEL_OUT;
    n = length(ind_pul);
    i=1;   
    for i=1:n
        if i<n
            j=i+1;
            v_avg_pul.x(i,:)=sum(u.x(ind_pul(i):(ind_pul(j)-1)))/(ind_pul(j)-ind_pul(i));
            v_avg_pul.y(i,:)=sum(u.y(ind_pul(i):(ind_pul(j)-1)))/(ind_pul(j)-ind_pul(i));
            v_avg_pul.z(i,:)=sum(u.z(ind_pul(i):(ind_pul(j)-1)))/(ind_pul(j)-ind_pul(i));            
        elseif i==n
            N=length(u.x);
            v_avg_pul.x(i,:)=sum(u.x(ind_pul(i):N))/((N+1)-(ind_pul(i))); 
            v_avg_pul.y(i,:)=sum(u.y(ind_pul(i):N))/((N+1)-(ind_pul(i))); 
            v_avg_pul.z(i,:)=sum(u.z(ind_pul(i):N))/((N+1)-(ind_pul(i)));            
        end       
    end   
    clear i n N
      
end    