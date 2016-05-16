%% QUADRANT/PULSE HISTOGRAMS %%
% The function obtains the histograms of the dwell time in a quadrant and 
% the duration pulse by quadrants.

function [per_dur]=ttt_histograms_quad(VEL_OUT)
%% Obtaining useful Variables
[quadrant,pulse,~]=ttt_burst_calc_aux(VEL_OUT);
per=quadrant.percentage; %Percentage of dwell time in each quadrant of total
quad_pul=pulse.quadrant;%Quadrant belonging to each pulse
pul=pulse.duration; %Pulse duration (by steps, 1 step=0.04 seg)

%% Bar Chart of the general "Percentage of quadrant
figure(1);
bar(per),title('Percentage of quadrant');

%% Dwell Time to each quadrant
% Calculating the pulses by quadrants
N=length(quad_pul);
j=1;
k=1;
l=1;
m=1;
for i=1:N
    if quad_pul(i)==1
        t1(j,:)=pul(i); %size vector containing pulses Q1.        
        j=j+1;
    elseif quad_pul(i)==2
        t2(k,:)=pul(i);%size vector containing pulses Q2.        
        k=k+1;
    elseif quad_pul(i)==3
        t3(l,:)=pul(i);%size vector containing pulses Q3.       
        l=l+1;
    elseif quad_pul(i)==4
        t4(m,:)=pul(i);%size vector containing pulses Q4.
        m=m+1;
    end
end

%% Dwell Time HISTOGRAM to each quadrant
%Drawing the histograms of vectors by dwell time
%percent_pul_dur(k,1)=(length(v_avg_pul_dur.(D))*k*0.04)/(sum(pul)*0.04); %percent_dur_pul= Percentage of total time of each pulse duration        
% Histogram of pulse duration of ejections, quadrant 1.
figure(2)
hold on
subplot(2,2,1);
x_ej=1:max(t2);
numpuls_ej=hist(t2,x_ej);
%h_norm=numpuls/numel(quad_pul); % percentage in pulses
h_norm_ej=numpuls_ej.*x_ej.*0.04/(sum(pul)*0.04); %percentage in time
bar(x_ej*0.04,h_norm_ej,'r');
title('Pulse Histogram of Ejections');

% Histogram of pulse duration of Outward Interactions, quadrant 2.
subplot(2,2,2);
x_out=1:max(t1);
numpuls_out=hist(t1,x_out);
%h_norm=numpuls/numel(quad_pul);%percentage in pulses
h_norm_out=numpuls_out.*x_out.*0.04/(sum(pul)*0.04); %percentage in time
bar(x_out*0.04,h_norm_out,'b');
title('Pulse Histogram of Outward Interactions');

% Histogram of pulse duration of Inward Interactions, quadrant 3.
subplot(2,2,3);
x_in=1:max(t3);
numpuls_in=hist(t3,x_in);
%h_norm=numpuls/numel(quad_pul);%percentage in pulses
h_norm_in=numpuls_in.*x_in.*0.04/(sum(pul)*0.04); %percentage in time
bar(x_in*0.04,h_norm_in,'k');
title('Pulse Histogram of Inward Interactions');

% Histogram of pulse duration of Sweeps, quadrant 4.
subplot(2,2,4);
x_sw=1:max(t4);
numpuls=hist(t4,x_sw);
%h_norm=numpuls/numel(quad_pul);%percentage in pulses
h_norm_sw=numpuls.*x_sw.*0.04/(sum(pul)*0.04); %percentage in time
bar(x_sw*0.04,h_norm_sw,'g');
title('Pulse Histogram of Sweeps');
hold off

figure(3);
plot(x_out*0.04,h_norm_out,'b')
hold on
plot(x_ej*0.04,h_norm_ej,'r')
hold on
plot(x_in*0.04,h_norm_in,'k')
hold on
plot(x_sw*0.04,h_norm_sw,'g')
hold off

per_dur.Q1=[h_norm_out';zeros(1000-length(h_norm_out),1)];%percentage data by duration event Q1
per_dur.Q2=[h_norm_ej';zeros(1000-length(h_norm_ej),1)];%percentage data by duration event Q1
per_dur.Q3=[h_norm_in';zeros(1000-length(h_norm_in),1)];%percentage data by duration event Q1
per_dur.Q4=[h_norm_sw';zeros(1000-length(h_norm_sw),1)];%percentage data by duration event Q1

end




