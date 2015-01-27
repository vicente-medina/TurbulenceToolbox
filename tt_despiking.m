%-----------------------------------------------------
%Function to apply Nikora & Goring despiking algorithm
% Version 0.10
%-----------------------------------------------------
function VEL_OUT = tt_despiking(VEL_IN)


    %Initial value for VEL
    VEL_OUT = VEL_IN;

    %For three components
    vel_3D    = [VEL_OUT.x'; VEL_OUT.y'; VEL_OUT.z']';
    
    %Filter parameters
    max_iter = 20;

    lambda = sqrt(2*log(size(vel_3D,1)));

    %Loop for 3D components
    for i=1:3,
        
        %Vel average
        v_mean = 0;        

        %Select velocity component
        vel = vel_3D(:,i);

        %Iterations, required to update mean values
        iter = 1;

        while (iter <= max_iter),

            %Update average value
            v_mean = v_mean + nanmean(vel);
        
            %Update turbulent variables
            vel = vel - nanmean(vel);

            % step 1: first and second derivatives
            vel_t  = gradient(vel);
            vel_tt = gradient(vel_t);

            % step 2: estimate angle between f and f_tt axis
            if (iter==1),
                theta = atan2( sum(vel.*vel_tt), sum(vel.^2) );
            end

            % step 3: checking outlier in the 3D phase space
            R = [ cos(theta) 0  sin(theta); 0 1 0 ; -sin(theta) 0 cos(theta)];
            X = vel*R(1,1) + vel_t*R(1,2) + vel_tt*R(1,3);
            Y = vel*R(2,1) + vel_t*R(2,2) + vel_tt*R(2,3);
            Z = vel*R(3,1) + vel_t*R(3,2) + vel_tt*R(3,3);

            %Elipsoid coefficients
            a = lambda*nanstd(X);
            b = lambda*nanstd(Y);
            c = lambda*nanstd(Z);
        
            % point on the ellipsoid
            X1 = a*b*c * X./ sqrt((a*c*Y).^2 + b^2*(c^2*X.^2 + a^2*Z.^2));
            Y1 = a*b*c * Y./ sqrt((a*c*Y).^2 + b^2*(c^2*X.^2 + a^2*Z.^2));
            Zt = c^2 * ( 1 - (X1/a).^2 - (Y1/b).^2 );

            %Apply Z sign
            Z1 = sqrt(Zt) .* sign(Zt); 

            %Check outlier from ellipsoid
            distance = (X1.^2 + Y1.^2 + Z1.^2) - (X.^2 + Y.^2 + Z.^2);
  
            %Wrong numbers
            wrong = (distance < 0);
            vel(wrong) = NaN;

            %Increase iteration number
            iter = iter + 1;

        end
        
        %Update vel values
        vel_3D(:,i) = vel;
        
    end


    %Exclude data in all components
    ind = any(isnan(vel_3D),2);
    bad_data = find(ind);
    good_data = find(~ind);
    
    VEL_OUT.x(bad_data) = NaN;
    VEL_OUT.y(bad_data) = NaN;
    VEL_OUT.z(bad_data) = NaN;



    %% Fill filtered data using interpolation
  
    %X data
    xi = 1:size(vel_3D,1);

    % interpolate NaN data
    VEL_OUT.x(bad_data) = interp1(xi(good_data),VEL_OUT.x(good_data),xi(bad_data),'cubic')';
    VEL_OUT.y(bad_data) = interp1(xi(good_data),VEL_OUT.y(good_data),xi(bad_data),'cubic')';
    VEL_OUT.z(bad_data) = interp1(xi(good_data),VEL_OUT.z(good_data),xi(bad_data),'cubic')';


end
