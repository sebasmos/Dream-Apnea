%% ESTA FUNCIÓN HACE LA PREPARACIÓN DE LOS DATOS DE TESTING EN UN PRDATASET
function [DatasetTotal]=Data_Testing(feature_testing,class_testing)
        lista_feasures = char('vrms','Ar1','Ar2','Ar3','Ar4','MAV','zrc','SpO2');
        DatasetTotal = prdataset(feature_testing, class_testing,'featlab',lista_feasures);
end