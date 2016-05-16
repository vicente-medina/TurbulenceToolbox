%% IMPULSE ...
% This function calculates the IMPULSE, WORK and POWER made by each pulse
% in each quadrant.

function [IMPULSE,WORK,POWER]=tt_impulse_pul(VEL_OUT,frec,graphics)
%% Obtaining Useful Variables
[~,pulse,velocities_pulse]=tt_burst_calc_aux(VEL_OUT);
ind_pul=pulse.index;
pul=pulse.duration;
quad_pul=pulse.quadrant;
v_avg_pul=velocities_pulse.average;%mean prime velocity at pulse
[v_avg_pul_tot]=tt_burst_vel_avg_pul_tot(VEL_OUT,ind_pul); 
vel_work_power=v_avg_pul_tot.x;%mean velocity at pulse

file='.\TEST\';%define the working folder.

%% Definig some important concepts.

% The impulse is obtained as Imp= Force*Time_aplication. Here the force is 
% considerate the Reynolds Stresses (force=-1000*u'*w')(produced by each 
%pulse) and the time aplication is the pulse duration, Then Imp=force*time,

% The work is obtained by W=Imp.vel' for the work done by Reynolds Stresses 
% vel= (could be u' if the axis=x, v'w')

% The Power could be obtained by P=W/deltaT=force*vel'.
   
%% First calculate the vector of impulse,work and Power done by each pulse.
[~, tensrey] = tt_ReynoldsStresses(VEL_OUT); %Reynolds Stresses
time_pulse=pul*(1/frec); % Vector duration time pulse
force_inst=-1000*tensrey.xz; % Force Vector (Reynolds St.)Instantaneus
impulse_inst=force_inst.*(1/frec); % Impulse Vector Instantaneus
work_inst=impulse_inst.*VEL_OUT.x; % Work Vector Instantaneus
power_inst=work_inst/(1/frec); % Power Vector Instantaneus

% Vector time line of pulses
n = length(ind_pul);
time_line=zeros(n,1); 
for i=1:n 
    if i==1
        time_line(i,:)=pul(i)*(1/frec);% Vector duration time pulse  
    else
        time_line(i,:)=pul(i)*(1/frec)+time_line(i-1); % Vector duration time pulse        
    end
end
%calculating means Reynolds stress, impulse,  in each pulse. 
i=1;   
    for i=1:n
        if i<n
            j=i+1;
            tensrey_pul(i,:)=-1000*sum(tensrey.xz(ind_pul(i):(ind_pul(j)-1)))/(ind_pul(j)-ind_pul(i));            
            force(i,:)=sum(force_inst(ind_pul(i):(ind_pul(j)-1)))/(ind_pul(j)-ind_pul(i));
            %impulse(i,:)=force(i)*pul(i)*0.04;
            impulse(i,:)=sum(impulse_inst(ind_pul(i):(ind_pul(j)-1)));
            work(i,:)=impulse(i)*vel_work_power(i);
            %work(i,:)=sum(work_inst(ind_pul(i):(ind_pul(j)-1)));
            power(i,:)=tensrey_pul(i)*vel_work_power(i);
            %power(i,:)=sum(power_inst(ind_pul(i):(ind_pul(j)-1)))/(ind_pul(j)-ind_pul(i));
            
        elseif i==n
            N=length(tensrey.xz);
            tensrey_pul(i,:)=-1000*sum(tensrey.xz(ind_pul(i):N))/((N+1)-(ind_pul(i)));  
            force(i,:)=sum(force_inst(ind_pul(i):N))/((N+1)-(ind_pul(i)));  
            impulse(i,:)=sum(impulse_inst(ind_pul(i):N));  
            work(i,:)=sum(work_inst(ind_pul(i):N));  
            power(i,:)=sum(power_inst(ind_pul(i):N))/((N+1)-(ind_pul(i)));  
        end       
    end   
    clear i n N
    
%% Positive and Negative quantity value done by Impulse, Work and Power.

% IMPULSE=vector with values of total impulse,impulse (+/-) and impulse and 
%the serie of impulse(by each pulse)
IMPULSE.total=sum(impulse);%Total Impulse 
IMPULSE.pos_neg=[sum(impulse(impulse>0)) sum(impulse(impulse<0))];%Total Impulse POS/NEG at the measure
IMPULSE.serie=impulse; %impulse by each pulse

%WORK=vector with values of total work,work (+/-) and work and the serie of 
%work(by each pulse)
WORK.total=sum(work);%Total WORK
WORK.pos_neg=[sum(work(work>0)) sum(work(work<0))];%Total WORK POS/NEG at the measure
WORK.serie=work;%work by each pulse

%POWER=vector with values of total power,power (+/-) and power and the serie
% of power(by each pulse)
POWER.total=sum(power);
POWER.pos_neg=[sum(power(power>0)) sum(power(power<0))];
POWER.serie=power;

%% %% Impulse, Work and Power separated by quadrants
j=1;
k=1;
l=1;
m=1;
n=length(pul);
for i=1:n
    if quad_pul(i)==1
        Q1.impulse(j)=impulse(i);
        Q1.work(j)=work(i);
        Q1.power(j)=power(i);
        Q1.time_pulse(j,:)=pul(i); %size vector containing pulses Q1.
        j=j+1;
    elseif quad_pul(i)==2
        Q2.impulse(k)=impulse(i);
        Q2.work(k)=work(i);
        Q2.power(k)=power(i);     
        Q2.time_pulse(k,:)=pul(i);%size vector containing pulses Q2.
        k=k+1;
    elseif quad_pul(i)==3
        Q3.impulse(l)=impulse(i);
        Q3.work(l)=work(i);
        Q3.power(l)=power(i);
        Q3.time_pulse(l,:)=pul(i);%size vector containing pulses Q3.
        l=l+1;
    elseif quad_pul(i)==4
        Q4.impulse(m)=impulse(i);
        Q4.work(m)=work(i);
        Q4.power(m)=power(i);
        Q4.time_pulse(m,:)=pul(i);%size vector containing pulses Q4.
        m=m+1;
    end
end


% Obtaining the vectors of total Impulse and Work Separated by quadrants
IMPULSE.quad=[sum(Q1.impulse),sum(Q2.impulse),sum(Q3.impulse),sum(Q4.impulse)];
IMPULSE.Q1=Q1.impulse; IMPULSE.Q2=Q2.impulse; IMPULSE.Q3=Q3.impulse; IMPULSE.Q4=Q4.impulse;
WORK.quad=[sum(Q1.work),sum(Q2.work),sum(Q3.work),sum(Q4.work)];
WORK.Q1=Q1.work; WORK.Q2=Q2.work; WORK.Q3=Q3.work; WORK.Q4=Q4.work;
POWER.quad=[sum(Q1.power),sum(Q2.power),sum(Q3.power),sum(Q4.power)];
POWER.Q1=Q1.power; POWER.Q2=Q2.power; POWER.Q3=Q3.power; POWER.Q4=Q4.power;

%Obtaining the percentage Of Impulse and Work done by each quadrant, and
%separated by sign (Positive/negative). 

%The impulse defined as -u'*w'*T necessarily means that q1(u'>0,w'>0)=-Imp, 
%q2(u'<0,w'>0)=+Imp, q3(u'<0,w'<0)=-Imp, q1(u'>0,w'<0)=+Imp.
IMPULSE.percent_quad=[sum(Q1.impulse)/sum(impulse(impulse<0)) sum(Q2.impulse)/sum(impulse(impulse>0)) sum(Q3.impulse)/sum(impulse(impulse<0)) sum(Q4.impulse)/sum(impulse(impulse>0))];

%The Work defined as -u'*w'*T*u is the same as Impulse
WORK.percent_quad=[sum(Q1.work)/sum(work(work<0)) sum(Q2.work)/sum(work(work>0)) sum(Q3.work)/sum(work(work<0)) sum(Q4.work)/sum(work(work>0))];

%The power defined as work/time is the same as work
POWER.percent_quad=[sum(Q1.power)/sum(power(power<0)) sum(Q2.power)/sum(power(power>0)) sum(Q3.power)/sum(power(power<0)) sum(Q4.power)/sum(power(power>0))];

%% Impulse an Work searated by pulse duration 
%% Here we can see which duration pulse brings more Impulse and work.
for k=1:max(pul)
    j=1; 
    for i=1:length(pul)
        if sum(pul==k)~=0
            if pul(i)==k
                q=strcat('q',num2str(k));
                imp_npul.(q)(j,:)=impulse(i);
                work_npul.(q)(j,:)=work(i);
                power_npul.(q)(j,:)=power(i);
                j=j+1;
            end  
        end
    end
    %
    impulse_pul(k,:)=sum(imp_npul.(q))/numel(imp_npul.(q)); % Average vector of value impulse by pulse duration
    impul_per_pul(k,:)=sum(imp_npul.(q))/sum(impulse); % Percentage of impulse by a pulse duration of the total impulse
    work_pul(k,:)=sum(work_npul.(q))/numel(work_npul.(q));% Average vector of value work by pulse duration
    work_per_pul(k,:)=sum(work_npul.(q))/sum(work); % Percentage of work by a pulse duration of the total work
    power_pul(k,:)=sum(power_npul.(q))/numel(power_npul.(q));% Average vector of value power by pulse duration
    power_per_pul(k,:)=sum(power_npul.(q))/sum(power); % Percentage of power by a pulse duration of the total power
end

% saving the vectors of Impulse, work and power separated by pulse duration
IMPULSE.avg_pul=impulse_pul; 
IMPULSE.percent_pul=impul_per_pul;
WORK.avg_pul=work_pul;
WORK.percent_pul=work_per_pul;
POWER.avg_pul=power_pul;
POWER.percent_pul=power_per_pul;

save(strcat(file,'IPW\','IMPULSE_PUL','.mat'),'IMPULSE')
save(strcat(file,'IPW\','WORK_PUL','.mat'),'WORK')
save(strcat(file,'IPW\','POWER_PUL','.mat'),'POWER')
%% GRAPHICS
%Drawing several graphics of the results obtained
 if graphics==1
%% IMPULSE WORK AND POWER BY PULSE DURATION 

%Drawing Average Impulse, Work and Power by pulse duration
%Impulse
figure(1)
subplot(3,1,1)
bar((1/frec:1/frec:max(pul)*1/frec),impulse_pul)
xlabel('${seconds}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold')
ylabel('$\frac{N*s}{m2}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)
title('Average Impulso by pulse duration');
hold on
%Work
subplot(3,1,2)
bar((1/frec:1/frec:max(pul)*1/frec),work_pul)
xlabel('${seconds}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold')
ylabel('$\frac{N}{m}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)
title('Average Work by pulse duration');
hold on
%Power
subplot(3,1,3)
bar((1/frec:1/frec:max(pul)*1/frec),power_pul)
xlabel('${seconds}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold')
ylabel('$\frac{N}{m*s}$','Interpreter','LaTex','FontSize',14,'FontWeight','bold','Rotation',0)
title('Average Power by pulse duration');
hold off


%Drawing Percentage Impulse,Work and Power by pulse duration
%Impulse
figure(2)
subplot(3,1,1)
bar((1/frec:1/frec:max(pul)*1/frec),impul_per_pul)
xlabel('${seconds}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold')
ylabel('${Percentage}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Percentage Impulse by pulse duration');
hold on
%Work
subplot(3,1,2)
bar((1/frec:1/frec:max(pul)*1/frec),work_per_pul)
xlabel('${seconds}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold')
ylabel('${Percentage}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Percentage Work by pulse duration')
hold on
%Power, p=F*V=W/dt..vatios=kg*m2/s2=j/s))
subplot(3,1,3)
bar((1/frec:1/frec:max(pul)*1/frec),power_per_pul)
xlabel('${seconds}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold')
ylabel('${Percentage}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Percentage Power by pulse duration')
hold off


%% PULSE STATISTICS

%Graphic (Impulse vs pulse duration/Quadrant)
figure(3);
plot(Q1.time_pulse*1/frec,Q1.impulse,'b.','MarkerSize',8);
hold on
plot(Q2.time_pulse*1/frec,Q2.impulse,'r.','MarkerSize',8);
plot(Q3.time_pulse*1/frec,Q3.impulse,'k.','MarkerSize',8);
plot(Q4.time_pulse*1/frec,Q4.impulse,'g.','MarkerSize',8);
hold off

%Graphic (pulse duration/Quadrant/time characteristic)
figure(4);
x_out=1:max(Q1.time_pulse);
numpuls_out=hist(Q1.time_pulse,x_out)/length(Q1.time_pulse);
plot(numpuls_out,'b.','MarkerSize',8)
hold on
x_ej=1:max(Q2.time_pulse);
numpuls_ej=hist(Q2.time_pulse,x_ej)/length(Q2.time_pulse);
plot(numpuls_ej,'r.','MarkerSize',8)
x_in=1:max(Q3.time_pulse);
numpuls_in=hist(Q3.time_pulse,x_ej)/length(Q3.time_pulse);
plot(numpuls_in,'k.','MarkerSize',8)
x_sw=1:max(Q4.time_pulse);
numpuls_sw=hist(Q4.time_pulse,x_ej)/length(Q4.time_pulse);
plot(numpuls_sw,'g.','MarkerSize',8)
[~,~,acorr]=ttt_mix_length(VEL_OUT,100);
plot(pulse.percentage_duration,'m.','MarkerSize',8)
plot(acorr,'y.','MarkerSize',8)
hold off


%% HISTOGRAMS IPW
% The histograms are normalized so that the area is 1 and to be compared
% with other pdf.

% IMPULSE. Histograms of impulse (no distinction is made by quadrants)Positive
% impulse is referred to ejections(Q2) and Sweeps (Q4), and Negative Impulse
% is referred to utward and Inward interactions (Q1 y Q3). Due to the
% definition of force as Reynolds Stress.
figure(5);
xi=horzcat((floor(min(impulse))-0.5:-0.5),(0.5:ceil(max(impulse))+0.5)); 
[hi]=hist(impulse,xi);
%hi_norm=hi/sum(hi.*(xi(2)-xi(1)));% area=1, nomalization
hi_norm=hi/length(pul);%nomalization
bar(xi,hi_norm);
xlabel('$\frac{N*s}{m2}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Impulse Total Histogram');
%hold on
%trapz(xi,hi_norm) 

% PDF
%y=linspace(min(impulse)-std(impulse),max(impulse)+std(impulse),100);
%norm=normpdf(y,mean(impulse),std(impulse));
%norm=PDF('Chisquare',y,2);
%plot(y,norm);
%hold off
%trapz(y,norm) 


% WORK. Histograms of WORK (no distinction is made by quadrants)Positive
% work is referred to Sweeps(Q4) and Inward interactions (Q1) , and 
% Negative work is referred to outward interactions (Q3) and ejections(Q2).
% Due to the % definition of force as Reynolds Stress.
figure(6);
xw=horzcat((floor(min(work))-0.5:-0.5),(0.5:ceil(max(work))+0.5)); 
[hw]=hist(work,xw);
hw_norm=hw/length(pul);% area=1, nomalization
%hw_norm=hw/sum(hw.*(xw(2)-xw(1)));% area=1, nomalization
bar(xw,hw_norm);
xlabel('$\frac{N}{m}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Work Total Histogram');
%hold on
%Normal PDF
%y=linspace(min(work)-std(work),max(work)+std(work),100);
%norm=normpdf(y,mean(work),std(work));
%plot(y,norm)
%hold off

% POWER. Histograms of POWER (no distinction is made by quadrants)Positive
% power is referred to Sweeps(Q4) and Inward interactions (Q1) , and 
% Negative power is referred to outward interactions (Q3) and ejections(Q2).
% Due to the definition of force as Reynolds Stress.
figure(7);
xp=horzcat((round2(floor(min(power)),-10):20:-10),(10:20:round2(ceil(max(power)),10))); 
[hp]=hist(power,xp);
%hp_norm=hp/sum(hp.*(xp(2)-xp(1)));% area=1, nomalization
hp_norm=hp/length(pul);% area=1, nomalization
bar(xp,hp_norm);
xlabel('$\frac{N}{m*s}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Power Total Histogram');
%hold on
%Normal PDF
%y=linspace(min(power)-std(power),max(power)+std(power),100);
%norm=normpdf(y,mean(power),std(power));
%plot(y,norm)
%hold off

%Signal of Impulse, Work and Power.
figure(8);
plot(time_line,power,'k','LineWidth',0.5);
hold on 
plot(time_line,work,'r','LineWidth',3);
hold on
plot(time_line,impulse,'g','LineWidth',2);
title('Impulse,Work and Power(t)');
hold off

%% %%%%%%%%%%%%%%%%%  IMPULSE BY QUADRANTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Impulse Histogram for the first quadrant(Outward Interactions),Normalized
figure(9);
subplot(2,2,2)
[hq1]=hist(Q1.impulse,xi(xi<0));
hq1_norm=hq1/numel(quad_pul(quad_pul==1));% nomalization with negative values
%hq1_norm=hq1/numel(impulse(impulse<0));% nomalization with negative values
bar(xi(xi<0),hq1_norm);
xlabel('$\frac{N*s}{m2}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency Negative}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Outward Impulse Histogram');
hold on

% Impulse Histogram for the second quadrant(Ejections),Normalized
subplot(2,2,1)
[hq2]=hist(Q2.impulse,xi(xi>0));
hq2_norm=hq2/numel(quad_pul(quad_pul==2));% nomalization with positive values
%hq2_norm=hq2/numel(impulse(impulse>0));% nomalization with positive values
bar(xi(xi>0),hq2_norm);
xlabel('$\frac{N*s}{m2}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency Positive}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Ejections Impulse Histogram');
hold on

% Impulse Histogram for the third quadrant(Inward Interactions),Normalized 
subplot(2,2,3)
[hq3]=hist(Q3.impulse,xi(xi<0));
%hq3_norm=hq3/numel(impulse(impulse<0));% nomalization with negative values
hq3_norm=hq3/numel(quad_pul(quad_pul==3));% nomalization with negative values
bar(xi(xi<0),hq3_norm);
xlabel('$\frac{N*s}{m2}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency Negative}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Inward Impulse Histogram');
hold on

% Impulse Histogram for the fourth quadrant(Sweeps),Normalized 
subplot(2,2,4)
[hq4]=hist(Q4.impulse,xi(xi>0));
%hq4_norm=hq4/numel(impulse(impulse>0));% nomalization with positive values
hq4_norm=hq4/numel(quad_pul(quad_pul==4));% nomalization with positive values
bar(xi(xi>0),hq4_norm);
xlabel('$\frac{N*s}{m2}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency Positive}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Sweeps Impulse Histogram');
hold off

%Testing
%sum(hq1_norm)+ sum(hq3_norm);=1
%sum(hq2_norm)+ sum(hq4_norm);=1

%% %%%%%%%%%%%%%%%%%  WORK BY QUADRANTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REMENBER THAT FOR THE WORK (AS POWER) IS IMPORTANT THE AXIS WHERE IS
% BEING EVALUATED, THE FIRST CASE IS ALWAYS u (x). Is possible to change
% the axis at the beggining of the script.

% WORK Histogram for the first quadrant(Outward Interactions),Normalized
figure(10);
subplot(2,2,2)
[hq1]=hist(Q1.work,xw(xw<0));
%hq1_norm=hq1/numel(work(work<0));% nomalization with negative values
hq1_norm=hq1/numel(quad_pul(quad_pul==1));% nomalization with negative values
bar(xw(xw<0),hq1_norm);
xlabel('$\frac{N}{m}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency negative/positive}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Outward Work Histogram');
hold on

% WORK Histogram for the second quadrant(Ejections),Normalized
subplot(2,2,1)
[hq2]=hist(Q2.work,xw(xw>0));
%hq2_norm=hq2/numel(work(work>0));% nomalization with negative values
hq2_norm=hq2/numel(quad_pul(quad_pul==2));% nomalization with negative values
bar(xw(xw>0),hq2_norm);
xlabel('$\frac{N}{m}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency negative/positive}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Ejections Work Histogram');
hold on

% WORK Histogram for the third quadrant(Inward Interactions),Normalized 
subplot(2,2,3)
[hq3]=hist(Q3.work,xw(xw<0));
%hq3_norm=hq3/numel(work(work<0));% nomalization with positive values
hq3_norm=hq3/numel(quad_pul(quad_pul==3));% nomalization with positive values
bar(xw(xw<0),hq3_norm);
xlabel('$\frac{N}{m}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency Pnegative/positive}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Inward Work Histogram');
hold on

% WORK Histogram for the fourth quadrant(Sweeps),Normalized 
subplot(2,2,4)
[hq4]=hist(Q4.work,xw(xw>0));
%hq4_norm=hq4/numel(work(work>0));% nomalization with positive values
hq4_norm=hq4/numel(quad_pul(quad_pul==4));% nomalization with positive values
bar(xw(xw>0),hq4_norm);
xlabel('$\frac{N}{m}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency negative/positive}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Sweeps Work Histogram');
hold off

%% %%%%%%%%%%%%%%%%%  POWER BY QUADRANTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% POWER Histogram for the first quadrant(Outward Interactions),Normalized
figure(11);
subplot(2,2,2)
[hq1]=hist(Q1.power,xp(xp<0));
%hq1_norm=hq1/numel(power(power<0));% nomalization with negative values
hq1_norm=hq1/numel(quad_pul(quad_pul==1));% nomalization with negative values
bar(xp(xp<0),hq1_norm);
xlabel('$\frac{N}{m*s}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency negative/positive}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Outward Power Histogram');
hold on

% POWER Histogram for the second quadrant(Ejections),Normalized
subplot(2,2,1)
[hq2]=hist(Q2.power,xp(xp>0));
%hq2_norm=hq2/numel(power(power>0));% nomalization with negative values
hq2_norm=hq2/numel(quad_pul(quad_pul==2));% nomalization with negative values
bar(xp(xp>0),hq2_norm);
xlabel('$\frac{N}{m*s}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency negative/positive}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Ejections Power Histogram');
hold on

% POWER Histogram for the third quadrant(Inward Interactions),Normalized 
subplot(2,2,3)
[hq3]=hist(Q3.power,xp(xp<0));
%hq3_norm=hq3/numel(power(power<0));% nomalization with positive values
hq3_norm=hq3/numel(quad_pul(quad_pul==3));% nomalization with positive values
bar(xp(xp<0),hq3_norm);
xlabel('$\frac{N}{m*s}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency negative/positive}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Inward Power Histogram');
hold on

% POWER Histogram for the fourth quadrant(Sweeps),Normalized 
subplot(2,2,4)
[hq4]=hist(Q4.power,xp(xp>0));
%hq4_norm=hq4/numel(power(power>0));% nomalization with positive values
hq4_norm=hq4/numel(quad_pul(quad_pul==4));% nomalization with positive values
bar(xp(xp>0),hq4_norm);
xlabel('$\frac{N}{m*s}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold')
ylabel('${Relative Frequency negative/positive}$','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)
title('Sweeps Power Histogram');
hold off
 end
end

