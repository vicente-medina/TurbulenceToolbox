function [d_VEL_OUT,ind_d_VEL_OUT,m_fit,p_poi]=tt_burst_Poincare(VEL_OUT,frec,steps)
    [quad,~]=ttt_burst_quadrants(VEL_OUT);
    n=length(VEL_OUT.x);      
    a=1;b=1;c=1; d=1; e=1; f=1; g=1;h=1;l=1;m=1;o=1;p=1;q=1;r=1;s=1;t=1;
    for i=1:n-1
        k=i;
        j=i+1;
        d_VEL_OUT.x(k,:)=(VEL_OUT.x(j,:)-VEL_OUT.x(i,:))*frec;
        d_VEL_OUT.y(k,:)=(VEL_OUT.y(j,:)-VEL_OUT.y(i,:))*frec;
        d_VEL_OUT.z(k,:)=(VEL_OUT.z(j,:)-VEL_OUT.z(i,:))*frec;
                
        if quad(i)==quad(j);
            if quad(i)==1;
                ind_d_VEL_OUT(k,:)=11;
                ind_11(a,:)=k;
                a=a+1;
            elseif quad(i)==2;
                ind_d_VEL_OUT(k,:)=22;
                ind_22(b,:)=k;
                b=b+1;
            elseif quad(i)==3
                ind_d_VEL_OUT(k,:)=33;
                ind_33(c,:)=k;
                c=c+1;                
            elseif quad(i)==4;
                ind_d_VEL_OUT(k,:)=44;
                ind_44(d,:)=k;
                d=d+1;
            end
        elseif quad(i)~=quad(j);
            if quad(i)==1 &&  quad(j)==2;
                ind_d_VEL_OUT(k,:)=12;
                ind_12(e,:)=k;
                e=e+1;
            elseif quad(i)==1 &&  quad(j)==3;
                ind_d_VEL_OUT(k,:)=13;
                ind_13(f,:)=k;
                f=f+1;
            elseif quad(i)==1 &&  quad(j)==4;
                ind_d_VEL_OUT(k,:)=14;
                ind_14(g,:)=k;
                g=g+1;
            elseif quad(i)==2 &&  quad(j)==1;
                ind_d_VEL_OUT(k,:)=21;
                ind_21(h,:)=k;
                h=h+1;
            elseif quad(i)==2 &&  quad(j)==3;
                ind_d_VEL_OUT(k,:)=23;
                ind_23(l,:)=k;
                l=l+1;
            elseif quad(i)==2 &&  quad(j)==4;
                ind_d_VEL_OUT(k,:)=24;
                ind_24(m,:)=k;
                m=m+1;
            elseif quad(i)==3 &&  quad(j)==1;
                ind_d_VEL_OUT(k,:)=31;
                ind_31(o,:)=k;
                o=o+1;
            elseif quad(i)==3 &&  quad(j)==2;
                ind_d_VEL_OUT(k,:)=32;
                ind_32(p,:)=k;
                p=p+1;
            elseif quad(i)==3 &&  quad(j)==4;
                ind_d_VEL_OUT(k,:)=34;
                ind_34(q,:)=k;
                q=q+1;
            elseif quad(i)==4 &&  quad(j)==1;
                ind_d_VEL_OUT(k,:)=41;    
                ind_41(r,:)=k;
                r=r+1;
            elseif quad(i)==4 &&  quad(j)==2;
                ind_d_VEL_OUT(k,:)=42;
                ind_42(s,:)=k;
                s=s+1;
            elseif quad(i)==4 &&  quad(j)==3;
                ind_d_VEL_OUT(k,:)=43;   
                ind_43(t,:)=k;
                t=t+1;
            end
        end
        i=i+1;
    end
    vel=VEL_OUT.x(2:n); 
    d_vel=d_VEL_OUT.x;

clear a b c d f g h i j k l m o p q r s t


%% Obtaining the percentage of each group
p_11=length(vel(ind_11))*100/n; p11=strcat('1-1=',(num2str(p_11)));
p_12=length(vel(ind_12))*100/n; p12=strcat('1-2=',(num2str(p_12)));
p_13=length(vel(ind_13))*100/n; p13=strcat('1-3=',(num2str(p_13)));
p_14=length(vel(ind_14))*100/n; p14=strcat('1-4=',(num2str(p_14)));
p_21=length(vel(ind_21))*100/n; p21=strcat('2-1=',(num2str(p_21)));
p_22=length(vel(ind_22))*100/n; p22=strcat('2-2=',(num2str(p_22)));
p_23=length(vel(ind_23))*100/n; p23=strcat('2-3=',(num2str(p_23)));
p_24=length(vel(ind_24))*100/n; p24=strcat('2-4=',(num2str(p_24)));
p_31=length(vel(ind_31))*100/n; p31=strcat('3-1=',(num2str(p_31)));
p_32=length(vel(ind_32))*100/n; p32=strcat('3-2=',(num2str(p_32)));
p_33=length(vel(ind_33))*100/n; p33=strcat('3-3=',(num2str(p_33)));
p_34=length(vel(ind_34))*100/n; p34=strcat('3-4=',(num2str(p_34)));
p_41=length(vel(ind_41))*100/n; p41=strcat('4-1=',(num2str(p_41)));
p_42=length(vel(ind_42))*100/n; p42=strcat('4-2=',(num2str(p_42)));
p_43=length(vel(ind_43))*100/n; p43=strcat('4-3=',(num2str(p_43)));
p_44=length(vel(ind_44))*100/n; p44=strcat('4-4=',(num2str(p_44)));

p_poi=[p_11,p_12,p_13,p_14,p_21,p_22,p_23,p_24,p_31,p_32,p_33,p_34,p_41,p_42,p_43,p_44];

%% Figure of all map of Poinacaré... by change of quadrant    
figure(1);
plot([min(vel) max(vel)],[0 0],'k-',[mean(vel) mean(vel)],[min(d_vel) max(d_vel)],'k-');
hold on
plot(vel(ind_11),d_vel(ind_11),'b.');
hold on
plot(vel(ind_22),d_vel(ind_22),'r.');
hold on
plot(vel(ind_33),d_vel(ind_33),'k.');
hold on
plot(vel(ind_44),d_vel(ind_44),'y.');
hold on
plot(vel(ind_12),d_vel(ind_12),'cx');
hold on
plot(vel(ind_13),d_vel(ind_13),'c+');
hold on
plot(vel(ind_14),d_vel(ind_14),'c*');
hold on
plot(vel(ind_21),d_vel(ind_21),'mx');
hold on
plot(vel(ind_23),d_vel(ind_23),'m+');
hold on
plot(vel(ind_24),d_vel(ind_24),'m*');
hold on
plot(vel(ind_31),d_vel(ind_31),'kx');
hold on
plot(vel(ind_32),d_vel(ind_32),'k+');
hold on
plot(vel(ind_34),d_vel(ind_34),'k*');
hold on
plot(vel(ind_41),d_vel(ind_41),'gx');
hold on
plot(vel(ind_42),d_vel(ind_42),'g+');
hold on
plot(vel(ind_43),d_vel(ind_43),'g*');
hold on
plot([min(vel) max(vel)],[0 0],'k-',[mean(vel) mean(vel)],[min(d_vel) max(d_vel)],'k-');
legend('','',p11, p22, p33, p44, p12, p13, p14, p21, p23, p24, p31, p32, p34, p41, p42, p43);
hold off


figure(2);
plot(vel(1:n-1),d_vel(1:n-1),'b.');
hold on
plot([min(vel) max(vel)],[0 0],'k-',[mean(vel) mean(vel)],[min(d_vel) max(d_vel)],'k-');
hold off

% Fitting linear equation 
fit_lin= fit(vel(1:n-1),d_vel(1:n-1),'poly1');
m_fit=fit_lin(1)-fit_lin(0);


%% Poicare by steps
if steps==1
    figure(3);
    n=length(d_vel); 
    drawArrow = @(x,y) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0 );
    next1=1;
    for i=1:4:n
        if next1==1
            plot([min(vel) max(vel)],[0 0],'k-',[mean(vel) mean(vel)],[min(d_vel) max(d_vel)],'k-');
            hold on
            drawArrow([vel(i) vel(i+1)],[d_vel(i) d_vel(i+1)]);
            hold on
            drawArrow([vel(i+1),vel(i+2)],[d_vel(i+1),d_vel(i+2)]);
            hold on
            drawArrow([vel(i+2),vel(i+3)],[d_vel(i+2),d_vel(i+3)]);
            hold on
            drawArrow([vel(i+3),vel(i+4)],[d_vel(i+3),d_vel(i+4)]);
            hold off
            next1=input('continuar (si=1, no=0):');
        elseif next1==0
            break
        end
    end       
end
