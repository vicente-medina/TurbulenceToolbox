function res = tt_advanced_turbulence(vel,freq)

%Initial value to check process success
res =1;

%% Histograms
tt_histogram(vel)

%% Quadrants
tt_quadrants(vel)

%% Spectrum
tt_spectrum(vel, freq)

%% Ok
res = 0;

end