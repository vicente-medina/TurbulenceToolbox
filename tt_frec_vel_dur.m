function [fvd]=tt_frec_vel_dur(VEL_OUT,VELMOD)%VEL=input('PROD(0)/MOD(1):');

[~,~,velocities_pulse]=tt_burst_calc_aux(VEL_OUT);
v_mean=velocities_pulse.average_struct_dur;
v_quad=velocities_pulse.quad_struct_dur;
FD=(fieldnames(v_mean));  

for k=1:length(FD)
        D=(char(FD(k,1)));        
        for i=1:length(v_mean.(D)(:,1))
             if v_quad.(D)(i,:)==1                
                 v_mean_quad_x.(D)(i,1)=v_mean.(D)(i,1);
                 v_mean_quad_z.(D)(i,1)=v_mean.(D)(i,3);
                 v_mean_quad_x.(D)(i,2)=0;
                 v_mean_quad_z.(D)(i,2)=0;
                 v_mean_quad_x.(D)(i,3)=0;
                 v_mean_quad_z.(D)(i,3)=0;
                 v_mean_quad_x.(D)(i,4)=0;
                 v_mean_quad_z.(D)(i,4)=0;                 
             elseif v_quad.(D)(i,:)==2                
                 v_mean_quad_x.(D)(i,1)=0;
                 v_mean_quad_z.(D)(i,1)=0;
                 v_mean_quad_x.(D)(i,2)=v_mean.(D)(i,1);
                 v_mean_quad_z.(D)(i,2)=v_mean.(D)(i,3);                 
                 v_mean_quad_x.(D)(i,3)=0;
                 v_mean_quad_z.(D)(i,3)=0;
                 v_mean_quad_x.(D)(i,4)=0;
                 v_mean_quad_z.(D)(i,4)=0;                   
             elseif v_quad.(D)(i,:)==3
                 v_mean_quad_x.(D)(i,1)=0;
                 v_mean_quad_z.(D)(i,1)=0;
                 v_mean_quad_x.(D)(i,2)=0;
                 v_mean_quad_z.(D)(i,2)=0;                 
                 v_mean_quad_x.(D)(i,3)=v_mean.(D)(i,1);
                 v_mean_quad_z.(D)(i,3)=v_mean.(D)(i,3);
                 v_mean_quad_x.(D)(i,4)=0;
                 v_mean_quad_z.(D)(i,4)=0;                               
             elseif v_quad.(D)(i,:)==4
                 v_mean_quad_x.(D)(i,1)=0;
                 v_mean_quad_z.(D)(i,1)=0;
                 v_mean_quad_x.(D)(i,2)=0;
                 v_mean_quad_z.(D)(i,2)=0;                 
                 v_mean_quad_x.(D)(i,3)=0;
                 v_mean_quad_z.(D)(i,3)=0;                 
                 v_mean_quad_x.(D)(i,4)=v_mean.(D)(i,1);
                 v_mean_quad_z.(D)(i,4)=v_mean.(D)(i,3);                 
             end
        end
end

%VEL=input('PROD(0)/MOD(1):');

if VELMOD==0    
    for k=1:length(FD)
        D=(char(FD(k,1)));
        for i=1:length(v_mean_quad_x.(D)(:,1))
            vel_q1.(D)(i,1)=abs(v_mean_quad_x.(D)(i,1).*v_mean_quad_z.(D)(i,1)).^0.5;
            vel_q2.(D)(i,1)=abs(v_mean_quad_x.(D)(i,2).*v_mean_quad_z.(D)(i,2)).^0.5;
            vel_q3.(D)(i,1)=abs(v_mean_quad_x.(D)(i,3).*v_mean_quad_z.(D)(i,3)).^0.5;
            vel_q4.(D)(i,1)=abs(v_mean_quad_x.(D)(i,4).*v_mean_quad_z.(D)(i,4)).^0.5;
        end
    end
elseif VELMOD==1
    for k=1:length(FD)
        D=(char(FD(k,1)));
        for i=1:length(v_mean_quad_x.(D)(:,1))
            vel_q1.(D)(i,1)=(v_mean_quad_x.(D)(i,1).^2+v_mean_quad_z.(D)(i,1).^2).^0.5;
            vel_q2.(D)(i,1)=(v_mean_quad_x.(D)(i,2).^2+v_mean_quad_z.(D)(i,2).^2).^0.5;
            vel_q3.(D)(i,1)=(v_mean_quad_x.(D)(i,3).^2+v_mean_quad_z.(D)(i,3).^2).^0.5;
            vel_q4.(D)(i,1)=(v_mean_quad_x.(D)(i,4).^2+v_mean_quad_z.(D)(i,4).^2).^0.5;
        end
    end    
end
  
%vel_bins=(0:0.05:max(v1(:,1)));
vel_bins=(0:0.02:0.5);

%FD2=(fieldnames(vel_q1));  
for k=1:length(FD)
        D=(char(FD(k,1)));
        for i=1:length(vel_q4.(D)(:,1))
            M_q1.(D)=hist(vel_q1.(D)(vel_q1.(D)~=0),vel_bins)*(k)/length(VEL_OUT.x);
            M_q2.(D)=hist(vel_q2.(D)(vel_q2.(D)~=0),vel_bins)*(k)/length(VEL_OUT.x);
            M_q3.(D)=hist(vel_q3.(D)(vel_q3.(D)~=0),vel_bins)*(k)/length(VEL_OUT.x);
            M_q4.(D)=hist(vel_q4.(D)(vel_q4.(D)~=0),vel_bins)*(k)/length(VEL_OUT.x);
        end
end

l=length(vel_bins);
x=reshape((ones(l,1)*(1:1:k)),numel((ones(l,1)*(1:1:k))),1);
y=repmat((ones(l,1)'.*(vel_bins))',length(FD),1);

for k=1:length(FD)
    D=(char(FD(k,1)));    
    z_1(:,k)=M_q1.(D);
    z_2(:,k)=M_q2.(D);
    z_3(:,k)=M_q3.(D);
    z_4(:,k)=M_q4.(D);    
end

z1=reshape(z_1,numel(x),1);
z2=reshape(z_2,numel(x),1);
z3=reshape(z_3,numel(x),1);
z4=reshape(z_4,numel(x),1);

[xq,yq] = meshgrid(1:1:10,vel_bins);
zq1 = griddata(x,y,z1,xq,yq);
zq2 = griddata(x,y,z2,xq,yq);
zq3 = griddata(x,y,z3,xq,yq);
zq4 = griddata(x,y,z4,xq,yq);

[fila,col]=find(zq1==max(max(zq1))); 
fvd= [xq(fila(1),col(1)), yq(fila(1),col(1)),max(max(zq1))];

figure;
subplot(2,2,2);
[clh1,ch1] = contourf(xq,yq,zq1,60);
set(ch1,'edgecolor','none');
title('FREC-VEL-DUR Q1');
subplot(2,2,1);
[clh2,ch2] = contourf(xq,yq,zq2,60);
set(ch2,'edgecolor','none');
title('FREC-VEL-DUR Q2');
subplot(2,2,3);
[clh3,ch3] = contourf(xq,yq,zq3,60);
set(ch3,'edgecolor','none');
title('FREC-VEL-DUR Q3');
subplot(2,2,4);
[clh4,ch4] = contourf(xq,yq,zq4,60);
set(ch4,'edgecolor','none');
title('FREC-VEL-DUR Q4');



%xlabel('$\frac{N*m}{m2*s}$','Interpreter','LaTex','FontSize',12,'FontWeight','bold');
%ylabel('Height from the bottom (cm)','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90);

end
