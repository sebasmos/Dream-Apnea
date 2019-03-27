%% PROCESAMIENTO DE SEÑALES RESPIRATORIAS
m=30000;

rsigc=FullrespC(1,(12001:m));
rsiga=FullrespA(1,(12001:m));
t3m=(0:length(rsigc)-1)/fs;
drsigc=detrend(rsigc);
drsiga=detrend(rsiga);
subplot(2,1,1), plot(t3m,drsiga),grid on, axis tight
subplot(2,1,2), plot(t3m,drsigc),grid on, axis tight