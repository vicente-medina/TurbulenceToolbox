
function A=tt_rotation_solver(vel_y, vel_z)

%Data to correct
vel =[vel_y, vel_z];

%Initial guess
x0=[0.1; 0.1];

%Optimization options
options=optimset('TolX',1.1*10^(-5),'TolFun',1.1*10^(-7));

%Create a handle to control function parameters
f_handle = @(angles) tt_rotation_matrix(angles,vel); % function of dummy variable angles

%Call optimization
x=fsolve(f_handle,x0,options);

%matriz de cambio de ejes
A=[cos(x(2))*cos(x(1)), -sin(x(2)), -cos(x(2))*sin(x(1));
   sin(x(2))*cos(x(1)), cos(x(2)) , -sin(x(2))*sin(x(1));
   sin(x(1))          , 0         , cos(x(1))];

return