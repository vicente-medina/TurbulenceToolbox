%% Perform a three steps filter on ADV data.
% 1) The first step use the despiking filter defined by Goring and Nikora
% (2002)
% 
% 2) The second step uses the correlation, signal-to-noise and amplitude 
% data from the sensor
%
% 3) Rotate the axes until the vertical and transversal velocities are 0.
% Only useful when the data corresponds to a straight channel with
% negligible secondary currents.
%
%% Function prototype
%
% Input parameters:
%
% _VEL_IN_ corresponds to a structure containing the velocity time series in
% the form:
%   _VEL_IN_._x_
%   _VEL_IN_._y_
%   _VEL_IN_._z_
%
% _CORR_ corresponds to a structure containing the correlation time series in
% the form:
%   _CORR_._x_
%   _CORR_._y_
%   _CORR_._z_
%
% _SNR_ corresponds to a structure containing the signal to noise time 
% series in the form:
%   _SNR_._x_
%   _SNR_._y_
%   _SNR_._z_
%
% _AMP_ corresponds to a structure containing the amplitude time 
% series in the form:
%   _AMP_._x_
%   _AMP_._y_
%   _AMP_._z_
%
% Output parameters:
%
% VEL_OUT filtered veolities
%
function VEL_OUT = tt_clean_data(VEL_IN,CORR,SNR,AMP,apply_rotation,SNR_threshold,CORR_threshold,AMP_threshold)

%% Parameters defined by the user
% Rotation and thresholds for SNR and CORR
%apply_rotation = 1;
%SNR_threshold = 15;
%CORR_threshold = 40;
%AMP_threshold = 1;

%% Apply despiking
% Call the function implementing Goring & Nikora algorithm
VEL_IN = tt_despiking(VEL_IN);

%% Apply quality data filters
% Filters the signal using simple thresholds for correlation, amplitude and
% SNR
VEL_IN = tt_filter(VEL_IN, CORR, SNR, AMP, SNR_threshold, CORR_threshold, AMP_threshold);

%% Apply rotate
% Rotate axes using the roll-yaw-pitch definiton, but neglecting roll (just
% Y, Z rotation)
%%
% 
% <<709px-Yaw_Axis_Corrected.png>>
% 

if (apply_rotation == 1),
    VEL_IN = tt_rotate_axes(VEL_IN);
end

%% Result
VEL_OUT = VEL_IN;

end