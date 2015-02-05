function F=tt_rotation_matrix(angles, vel);


%Compute the rotation matrix for Y, Z velocity components
A=[sin(angles(2))*cos(angles(1)), cos(angles(2)), -sin(angles(2))*sin(angles(1));
   sin(angles(1))               , 0             , cos(angles(1))                 ];

%Apply rotation on averaged velocity
F=A*vel;

end