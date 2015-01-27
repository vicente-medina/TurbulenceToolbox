%Clear
clear;

%Load data
load('ADV');

%Compute spectrum
res = spectrum(VEL_IN);

%Filter
VEL_FILT = despiking(VEL_IN);

%Re-compute spectrum
res = spectrum(VEL_FILT);
