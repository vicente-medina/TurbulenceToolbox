function res = tt_spectrum(velocity,fs)

res = 1;
vel_prime = tt_prime_velocities(velocity);

fs = 100;   %Frequency of the measurements
L = length(vel_prime.x);
W = ceil(L/100);
Ovl = W/2 + 0.1*W;
[pxx,f] = pwelch(vel_prime.x,W,Ovl,W,fs);
[pyy] = pwelch(vel_prime.y,W,Ovl,W);
[pzz] = pwelch(vel_prime.z,W,Ovl,W);

figure
plot(log10(f),log10(pxx),'b',log10(f),log10(pyy),'-g',log10(f),log10(pzz),'-r'); hold on
xlabel('Hz'); ylabel('dB');
legend('PSD_{x}','PSD_{y}','PSD_{z}')

res = 0;
res

