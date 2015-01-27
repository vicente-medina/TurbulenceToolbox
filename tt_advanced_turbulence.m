function res = tt_advanced_turbulence(vel,freq)

res =1;
%% Histograms %%

tt_histogram(vel)

%% Quadrants

tt_quadrants(vel)

%% Spectrum

tt_spectrum(vel, freq)


res = 0;

