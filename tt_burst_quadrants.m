function [quad,per]=tt_burst_quadrants(VEL_OUT)
    %% Quadrants
    %First we have to find the quadrant that each pair of (u'w') belongs and 
    %the percentage of permanence in each quadrant
    u = tt_prime_velocities(VEL_OUT);%buscamos las u'w'
    Q1=u.x>0 & u.z>0; %logical vector (1 if belong to quadrant 1)
    Q2=u.x<0 & u.z>0; %logical vector (1 if belong to quadrant 2)
    Q3=u.x<0 & u.z<0; %logical vector (1 if belong to quadrant 3)
    Q4=u.x>0 & u.z<0; %logical vector (1 if belong to quadrant 4)
    quad=Q1*1+Q2*2+Q3*3+Q4*4;%Contains the quadrant wich belongs each pair of u'w'
    %% Percentage  of dwell time in each quadrant
    n=length(quad);
    p1=sum(Q1)/n; %percentage of the total that belong to Quadrant 1
    p2=sum(Q2)/n; %percentage of the total that belong to Quadrant 2
    p3=sum(Q3)/n; %percentage of the total that belong to Quadrant 3
    p4=sum(Q4)/n; %percentage of the total that belong to Quadrant 4
    per=[p1, p2, p3, p4]; %Percentage of permanence in each quadrant of total

end
