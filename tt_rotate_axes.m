%% Function to rotate the axes to obtain 0 velocities in Y and Z direction.
%
%   Use the yaw (alpha), pitch (beta), roll (gamma) rotation angles.
%   Assume that the roll is 0.
%   Use the rotation matrix for yaw & pitch (sin(alpha)=sa, cos(alpha)=ca, sin(beta)=sinb, cos(beta)=cb)
%
%       [ca·cb	-sa	 ca·sb]
%       [sa·cb	 ca	 sa·sb]
%       [-sb	 0	 cb   ]
%
function VEL_OUT = tt_rotate_axes(VEL_IN)

%Create velocity matrix
VEL_MATRIX = [VEL_IN.x VEL_IN.y VEL_IN.z ];

%Compute average values
vel_mean = mean(VEL_MATRIX);

%optimize yaw and pitch to define the rotation matrix A
A = tt_rotation_solver(vel_mean);
       
%Apply the
VEL_MATRIX_= VEL_MATRIX * (A');

%Convert to structure
VEL_OUT.x = VEL_MATRIX(:,1);
VEL_OUT.y = VEL_MATRIX(:,2);
VEL_OUT.z = VEL_MATRIX(:,3);

end