function [pul,ind_pul,quad_pul]=ttt_burst_pulse(quad) 
    %% PULSE CALCULATION 
    %This function allows us to calculate the dwell time in each quadrant or 
    %pulse duration (by steps, 1 step=0.04 seg). 
    %quad= Contains the quadrant wich belongs each pair of u'w'
    i=1;
    n=length(quad);
    k=1;
    while i<n+1 
        j=i+1;
        while j<n+1 && quad(i)==quad(j) % while belonging to the same quadrant
            j=j+1;
        end
        pul(k,:)=j-i; %Pulse duration (by steps, 1 step=0.04 seg)
        ind_pul(k,:)=i;%Index of beggining pulse in the serie 
        quad_pul(k,:)=quad(ind_pul(k));%Quadrant belonging to each pulse
        k=k+1;
        i=j;
    end
    clear i n k j

    %% Graphics
    %h=figure;
    %x=1:max(pul);
    %numpuls=hist(pul,x);
    %h_norm=numpuls/(numel(pul));
    %bar(x*0.04,h_norm);
    %title('Histogram of Pulse Duration');%Percentage histogram of pulse duration.     

end
