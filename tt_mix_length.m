 function [length_scale_int,time_char,acorr]=tt_mix_length(VEL_OUT,NumLags)
%% Calculating mix_length
% The Integral scale Length is obtained from the Integral of 
% Autocorrelation. Idea about the size of the periodic larger vortices. 
% Is obtained as LI=Tc*vmed (Tc Carateristic time=Integral of autocor)

acor=autocorr(VEL_OUT.x,NumLags);
[m,n]=size(acor);
acorr=zeros(m,n);
    for i=1:m
        if acor(i,1)>0
            acorr(i,1)=acor(i,1);
            i=i+1;
        else
            break
        end
    end
    
y=0:0.04:NumLags*0.04; 
time_char=trapz(y,acorr);   
length_scale_int=trapz(acorr)*0.04.*nanmean(VEL_OUT.x); 


end