%% TRABAJO FINAL: DETECCION DE EVENTOS DE APNEA OBSTRUCCIVA E HYPOAPNEA
%Se usara la base de datos apnea-ecg, bajamos todas las señales de 
%entrenamiento, las cuales son 8. Estas vienen con toda la informacion, y
%tiene los siguientes canales:
%Respiratorios (A,C,N), cardiacos (ECG), y pulsioximetría(SP02)
clc;
close all;
clear all;

addpath('C:\Program Files\MATLAB\R2018a\prtools')
addpath('C:\MATLAB2018\MATLAB\mcode\BioMedicine\Dream Abnea\BiomedicasFinal\apnea-ecg');
% Tamano para mostrar datos
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

%% ANOTACIONES

class_training=getTotalclass();

%% SELECCION DE CARACTERISTICAS PARA ENTRENAMIENTO

m = 6996000;
Feature_Training = TotalFeaturesTraining(m,ECGTotal,SpO2Total,win_size,win_inc,Fs);


%% ENTRENAMIENTO DE ALGORITMO

[Data_training,PC_training,Ws_training,W_training,Ap_training] = entrenamiento1(Feature_Training,class_training);

%% II PARTE: EXTRACCIÓN DE LOS DATOS DE PRUEBA
%Declaramos el tamaño de la ventana
win_inctesting = 32; % El solapamiento de la ventana es del 82.5% en entrenamiento
%Cargamos los datos de prueba.  
testing = load('a02erm.mat');
testing = testing.val;
%% SELECCION DE CARACTERISTICAS PARA PRUEBA
ECGtesting = testing(1,:);
RespAtesting = testing(2,:);
RespCtesting = testing(3,:);
RespNtesting = testing(4,:);
SPo2testing = testing(5,:);
TestingPace = 966000;
Feature_TESTING = TotalFeatures(TestingPace,ECGtesting,SPo2testing,win_size,win_inc,Fs);
disp('funciona')