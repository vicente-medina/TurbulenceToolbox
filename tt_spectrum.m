function res = tt_spectrum(VEL_IN,Fs)

    %Number data
    num_data = length(VEL_IN.x);
    
  
    %Number of samples per averaging
    nfft = min(512,num_data);
    
    %Data window
    window = hanning(nfft);
    
    %Overlaping
    noverlap = 50;
    
    %Power spectral density plot
    %psd(VEL_IN.x,nfft,Fs,window,noverlap);
    
    %Power spectral density data
    [Pxx,f] = psd(VEL_IN.x,nfft,Fs,window,noverlap);

    %Fit Kolmogorov
    g = fittype('E*f^n','independent','f','dependent','Pxx','coefficients',{'E','n'});

    %Options
    opts = fitoptions(g);
    opts.StartPoint = [100, -1];
    
    %Fitting
    fitted_line = fit(f(5:end),Pxx(5:end),g,opts)
    
    Coef = coeffvalues(fitted_line);
    
    %Equation
    Eq = strcat('m_{Theory} = -1.6666     m_{Data} =  ',num2str(1/Coef(2)));
    
    %Line
    YY=(f(5:end).^Coef(2))*Coef(1);  
    
    %Theory
    YY2=(f(5:end).^(-3/5))*Coef(1); 
    
    %Plot
    fig = figure;
    set(fig,'Color',[1 1 1]);
    loglog(f(5:end),Pxx(5:end));
    line(f(5:end),YY,'LineWidth',2,'Color','black');   
    line(f(5:end),YY2,'LineWidth',2,'Color','red','LineStyle','--');   
    grid on;
    xlabel('Frequency (s-1)');
    ylabel('Energy (J�s)');
    title(Eq);
    legend('Data','Fitting','Theory');
    
    %Return
    res = 0;
    
end
