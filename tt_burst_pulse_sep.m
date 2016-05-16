function [v_avg_pul_dur,v_avg_mean_pul_dur,v_max_pul_dur,v_max_mean_pul_dur,percent_pul_dur,v_quad_pul_dur]=ttt_burst_pulse_sep(pul,v_avg_pul,v_max_pul,quad_pul)
    %% PULSE SEPARATION
    %This function allows us to separate by size pulse duration the results of
    %velocities. Frequency is 25 so each step pulse is 0.04 seconds. The result
    %is an structure of sizes pulses. If D12=12*0.04=0.48 seconds.

    vavg=[v_avg_pul.x,v_avg_pul.y,v_avg_pul.z]; 
    vmax=[v_max_pul.x,v_max_pul.y,v_max_pul.z];
    percent_pul_dur=zeros(max(pul),1);
    v_avg_mean_pul_dur=zeros(max(pul),3); %Vector of mean velocity in each pulse duration
    v_max_mean_pul_dur=zeros(max(pul),3); %Vector of maximum velocity in each pulse duration
    for k=1:max(pul)
        D=strcat('D',num2str(k));
        if isempty(vavg(pul==k))~=1
            v_avg_pul_dur.(D)=vavg(pul==k,:); %Structure of average velocities primes by pulse duration
            v_max_pul_dur.(D)=vmax(pul==k,:); %Structure of maximum velocities primes by pulse duration
            v_quad_pul_dur.(D)=quad_pul(pul==k,:);%Structure of QUADRANTS by pulse duration
            v_avg_mean_pul_dur(k,:)=[mean(v_avg_pul.x(pul==k)),mean(v_avg_pul.y(pul==k)),mean(v_avg_pul.x(pul==k))];
            v_max_mean_pul_dur(k,:)=[max(v_max_pul.x(pul==k)),max(v_max_pul.y(pul==k)),max(v_max_pul.z(pul==k))];            
            percent_pul_dur(k,1)=(length(v_avg_pul_dur.(D))*k*0.04)/(sum(pul)*0.04); %percent_dur_pul= Percentage of total time of each pulse duration        
        end
    end
        
end