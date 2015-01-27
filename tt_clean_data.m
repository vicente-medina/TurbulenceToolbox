function VEL_OUT = tt_clean_data(VEL_IN,CORR,SNR,AMP)


    %Apply depeaking
    VEL_IN = despiking(VEL_IN);

    %Apply filter (Anna)


    %Apply rotate (Anna)
    
    
    %Result
    VEL_OUT = VEL_IN;

end