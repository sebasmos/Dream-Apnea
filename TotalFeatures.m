%% function results = TotalFeatures(m,ECGTotal,SpO2Total,win_size,win_inc,Fs)
% Esta funcion obtiene las características de la señal ingresada
function results = TotalFeatures(m,ECGTotal,SpO2Total,win_size,win_inc,Fs)
    % Pace 1 by 1
    k = 1;
    % We design a pace for reading the signal each minute
    pace = 6000;
        for j=1:pace:m
            temp=ECGTotal((j:j+pace-1));
            [feature1,feature2,feature3,feature4] = extract_feature(temp',win_size,win_inc);
            mc1(k)  = mean(feature1);
            mc2(k,:)= mean(feature2);
            mc3(k)  = mean(feature3);
            mc4(k)  = mean(feature4);
            k       = k + 1;       
        end
    mc5 = SPO2Detector(SpO2Total(:,1:m));
    mc6 = CaractECG(ECGTotal(1:m),Fs);
    results = [mc1' mc2(:,1) mc2(:,2) mc2(:,3) mc2(:,4) mc3' mc4' mc5' mc6'];
end