function VEL_OUT = tt_filter(VEL_IN, CORR, SNR, AMP, SNR_threshold, CORR_threshold, AMP_threshold)


%% Create matrix
vel= [VEL_IN.x; VEL_IN.y; VEL_IN.z];
corr= [CORR.x; CORR.y; CORR.z];
snr = [SNR.x; SNR.y; SNR.z];
amp = [AMP.x; AMP.y; AMP.z];


%% Filter using correlation

%Detect values under the threshold
ind = corr < CORR_threshold;

%index data
bad_data = ind;

%delete wrong values
vel(bad_data) = NaN;
    

%% Filter using SNR

%Detect values under the threshold
ind = snr < SNR_threshold;

%index data
bad_data = ind;

%delete wrong values
vel(bad_data) = NaN;

%% Filter using AMP

%Detect values under the threshold
ind = amp < AMP_threshold;

%index data
bad_data = ind;

%delete wrong values
vel(bad_data) = NaN;

%% Fill data

%Exclude data in all components
ind = any(isnan(vel),2);
bad_data = ind;
good_data = ~ind;
    
%X data
xi = 1:size(vel,1);

%interpolate NaN data
vel = interp1(xi(good_data),vel(good_data),xi(bad_data),'cubic')';

VEL_OUT.x = vel(1,:);
VEL_OUT.y = vel(2,:);
VEL_OUT.z = vel(3,:);


end