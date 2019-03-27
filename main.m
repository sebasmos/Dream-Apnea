
clc;
close all;
clear all;

addpath('C:\Program Files\MATLAB\R2018a\prtools')
addpath('C:\MATLAB2018\MATLAB\mcode\BioMedicine\Dream Abnea\BiomedicasFinal\apnea-ecg');
% Tamano
m = 6000;
% Numero de datasets
N = 7;
% Se declara espacio para strings
names=cell(8,1);
for i = 1:4
    dbNames = strcat({'a0'},int2str(i),{'erm.mat'});
    names{i}=dbNames;
end
for i=1:3
    string=strcat({'c0'},int2str(i),{'erm.mat'});
    names{i+4}=string;
end
% SAVE IN PHYSICAL UNITS
for i = 1:N
    signal      =  load(char(names{i}));
    signal      =  signal.val;
    ECG(:,i)    =  (signal(1,:)+30)./200;
    RespA(:,i)  =  (signal(2,:)+1903)./20000;
    RespC(:,i)  =  (signal(3,:)+1903)./20000;
    RespN(:,i)  =  (signal(4,:)+1903)./20000;
    SpO2(:,i)   =  signal(5,:);
end

    % NORMALIZATION MIN MAX
    FullECG   = (ECG-min(ECG))./(max(ECG)-min(ECG));    
    FullRespC = (RespC-min(RespC))./(max(RespC)-min(RespC));
    FullRespA = (RespA-min(RespA))./(max(RespA)-min(RespA));
    FullRespN = (RespN-min(RespN))./(max(RespN)-min(RespN));
    FullSpO2  = (SpO2-min(SpO2))./(max(SpO2)-min(SpO2));

% Sample Frequency
    Fs = 100;
% Squared for easier peak detection
    for k = 1:N
            ECGSquared(:,k) = abs(FullECG((1:m),k)).^2;  
    end
    ECGSquared = ECGSquared';
    
%% Guardamos todos los datasets en datasets individuales
    ECGTotal   = 0;
    RespATotal = 0;
    RespCTotal = 0;
    RespNTotal = 0;
    SpO2Total  = 0;
    
    for i = 1: N
        ECGTotal = [ECGTotal (FullECG(:,i)')];
        RespATotal = [RespATotal FullRespA(:,i)'];
        RespCTotal = [RespCTotal FullRespC(:,i)'];
        RespNTotal = [RespNTotal FullRespN(:,i)'];
        SpO2Total  = [SpO2Total  FullSpO2(:,i)'];
    end
%% PARA PROPOSITOS DE VISUALIZACION
    t     = [0:m-1]/Fs;
    t1m   = (1:6000)/Fs;
    t30s  = [0:3000-1]./Fs;
    t5min = (1:30000)/Fs;
    t30m  = (1:180000)/Fs;
    t1h   = (1:360000)/Fs;
%% 3. EXTRACCION DE CARACTERISTICAS
%   3.1 Extracciï¿½n del rms de la envolvente de la seï¿½al y cruces por cero
mc1=[]; 
mc2=[];
%% EXTRACCIÓN DE CARACTERÍSTICAS
% CARACTERISTICAS:
%1. Valor RMS de la señal
%2. Coeficientes de auto-regresión
%3. Valor absoluto medio
%4. Cruces por cero
%5. Baja en la oxigenacion de la sangre SP02
win_size = 256;
win_inc = 128; % El solapamiento de la ventana es del 50% en entrenamiento
%% MAIN FEATURES EXTRACTION
% Pace 1 by 1
k = 1;
% We design a pace for reading the signal each minute
pace = 6000;
    for j=1:pace:6996000
        temp=ECGTotal((j:j+6000-1));
        [feature1,feature2,feature3,feature4] = extract_feature(temp',win_size,win_inc);
        mc1(k)  = mean(feature1);
        mc2(k,:)= mean(feature2);
        mc3(k)  = mean(feature3);
        mc4(k)  = mean(feature4);
        k       = k + 1;       
    end
mc5 = SPO2Detector(SpO2Total(:,1:6996000));
mc6 = CaractECG(ECGTotal(1:6996000),Fs);
%% ANNOTATIONS

class_training=getTotalclass();


feature_training = [mc1' mc2(:,1) mc2(:,2) mc2(:,3) mc2(:,4) mc3' mc4' mc5' mc6'];


[Data_training,PC_training,Ws_training,W_training,Ap_training] = entrenamiento1(feature_training,class_training);