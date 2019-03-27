%% function class_training = getclass(registro)
 % n = 166; para 966000 samples
 % n = 240 para 1440000
function class_training = getTotalclass(registro)
% Se unifican las anotaciones tomando hasta la anotación 966,000 y se las
% ubica en un solo array. Si se van a manejar los 1'440,000 entonces 
% simplemente descomentar líneas
        % Anotacion 1
        class_training = ones(1166,1);
        class_training(1:13) = 0;
        %  class_training(227:230) = 0;
        
    	% Anotacion 2
        class_training(14:34) = 0;
        class_training(113:166) = 0; %% Se limita para 166 porque hay 966000
  
    	% Anotacion 3
        class_training(167:179) = 0;
        class_training(313:436) = 0;
        class_training(313:332) = 0;
        
       % Anotacion 4
        class_training(333:366) = 0;
        class_training(507:571) = 0;
        
       % Anotacion 5
        class_training(571:737) = 0;
        
       % Anotacion 6
        class_training(738:904)=0;   %class_training=zeros(240,1);
        class_training(758) = 1; %21
        
       % Anotacion 7
        class_training(905:1071)=0; % class_training=zeros(240,1);
       % Anotacion 8
        class_training(1071:1166)=0;
end    

% ara 1440 000
%     % Anotacion 1
%         class_training = ones(1920,1);
%         class_training(1:13) = 0;
%         %  class_training(227:230) = 0;
%     	
%         % Anotacion 2
%         class_training(231:251) = 0; %(1:21)
%         class_training(360:405) = 0; %130:175
%         % class_training(431:436) = 0; %201:206
%     	
%         % Anotacion 3
%         class_training(437:449) = 0; %1:13
%         class_training(465:509) = 0; %60:104
%         class_training(552:598) = 0;%147:193
%         % class_training(665:675) = 0;%229:239
%         
%         % Anotacion 4
%         class_training(676:709) = 0;%1:34
%         class_training(850:851) = 0; %175:176
%         %  class_training(852:868) = 0; %147:193
%         % class_training(904:914) = 0; %229:239
%         
%         % Anotacion 5
%         %class_training=zeros(240,1);
%         
%         % Anotacion 6
%         class_training(935)=1; %21
%         
%         % Anotacion 7
%         %class_training=zeros(240,1);
%         
%         % Anotacion 8
%         class_training(940)=1; %5
%          class_training(1070)=1; %135
%         class_training(1094:1097)=1; %159:162