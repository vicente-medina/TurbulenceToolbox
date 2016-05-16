% SNR AND CORR HISTOGRAMS IN EACH POINT


function tt_hist_snr_corr(struct) 

figure;           
x=(5:5:100);              
[hix]=hist(single(struct.x),x);               
hi_normx=hix/sum(hix.*5);% area=1, nomalization            
[hiy]=hist(single(struct.y),x);                
hi_normy=hiy/sum(hiy.*5);% area=1, nomalization            
[hiz]=hist(single(struct.z),x);                
hi_normz=hiz/sum(hiz.*5);% area=1, nomalization                
hi_norm=[hi_normx',hi_normy',hi_normz'];            
bar(x',hi_norm); 
            

            
xlabel('Percentage','Interpreter','LaTex','FontSize',12,'FontWeight','bold')            
ylabel('Percentage sample','Interpreter','LaTex','FontSize',10,'FontWeight','bold','Rotation',90)            
title('Histogram');                   
hold on

%Normal PDF            
xn=linspace(min(single(struct.x))-std(single(struct.x)),max(single(struct.x))+std(single(struct.x)),100);
norm=normpdf(xn,mean(single(struct.x)),std(single(struct.x)));
plot(xn,norm,'b')
hold on
yn=linspace(min(single(struct.y))-std(single(struct.y)),max(single(struct.y))+std(single(struct.y)),100);
norm=normpdf(yn,mean(single(struct.y)),std(single(struct.y)));
plot(yn,norm,'g')
hold on
zn=linspace(min(single(struct.z))-std(single(struct.z)),max(single(struct.z))+std(single(struct.z)),100);
norm=normpdf(yn,mean(single(struct.z)),std(single(struct.z)));
plot(yn,norm,'r')
%saveas(figure(1),strcat(file,'resultsADV\','Correlation_',profile_height,'
%.fig'));
hold off

end