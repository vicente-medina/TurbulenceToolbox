%% Separating the velocities by rangse of pulse duration
% To draw in a map of bursting turbulence and compare the velocity of the 
%signal with de velocitiies in the pulse, separated by range of duration.

function [uc,co,nd,dt]=ttt_range_pulse_duration(vel,pul)
    %% Range from 1 to 4. (0.04 sec to 0.16 sec)
    %Finding the velocities form the duration pulse rang from 1 to 4 steps
    %or 0.04 seconds to 0.16 seconds of the pulse duration.
    n=length(pul);   
    i=1;
    j=1;    
    for i=1:n
        for k=1:4
            if sum(pul==k)~=0
                if pul(i)==k
                    uc.x(j,:)=vel.x(i);
                    uc.y(j,:)=vel.y(i);
                    uc.z(j,:)=vel.z(i);
                    j=j+1;
                end
            end
        end
    end
    clear i j     
    if exist('uc','var')==0
        uc=0;       
    end   
                        
    %% Range from 5 to 8. (0.2 sec to 0.32 sec)
    %Finding the velocities form the duration pulse rang from 5 to 8 steps
    %or 0.2 seconds to 0.32 seconds of the pulse duration.    
    n=length(pul);   
    i=1;
    j=1;    
    for i=1:n
        for k=5:8
            if sum(pul==k)~=0
                if pul(i)==k
                    co.x(j,:)=vel.x(i);
                    co.y(j,:)=vel.y(i);
                    co.z(j,:)=vel.z(i);
                    j=j+1;
                end
            end
        end
    end
    clear i j 
    if exist('co','var')==0
        co=0;       
    end   
    %% Range from 9 to 16. (0.36 sec to 0.64 sec)
    %Finding the velocities form the duration pulse rang from 9 to 16 steps
    %or 0.36 seconds to 0.64 seconds of the pulse duration.    
    n=length(pul);   
    i=1;
    j=1;    
    for i=1:n
        for k=9:16
             if sum(pul==k)~=0
                 if pul(i)==k
                    nd.x(j,:)=vel.x(i);
                    nd.y(j,:)=vel.y(i);
                    nd.z(j,:)=vel.z(i);
                    j=j+1;
                 end
            end
        end
    end
    clear i j     
    if exist('nd','var')==0
        nd=0;       
    end  
    %% Range from 17 to 32. (0.68 sec to 0.128 sec)
    %Finding the velocities form the duration pulse rang from 17 to 32steps
    %or 0.68 seconds to 0.128 seconds of the pulse duration. 
    n=length(pul);   
    i=1;
    j=1;    
    for i=1:n
        for k=17:32
            if sum(pul==k)~=0
                if pul(i)==k                
                    dt.x(j,:)=vel.x(i);
                    dt.y(j,:)=vel.y(i);
                    dt.z(j,:)=vel.z(i);
                    j=j+1;
                end
            end
        end
    end  
    if exist('dt','var')==0
        dt=0;       
    end  
    
 end
  