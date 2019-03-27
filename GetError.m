function E= GetError(Class_Testing,LABEL)

error=zeros(1,length(Class_Testing));
for i=1:length(Class_Testing)
    if(Class_Testing(i)~=LABEL(i))
        error(i)=1;
    end
end

E=100*sum(error)/length(Class_Testing);
fprintf('El error de clasificación es : %d \n',E);

for i=1:length(LABEL)
    clas1=LABEL(LABEL==1);
    clas2=LABEL(LABEL==0);
    real1=Class_Testing(Class_Testing==1);
    real2=Class_Testing(Class_Testing==0);
end

ec1=100*abs((sum(real1)-sum(clas1)))/length(real1);
ec2=100*abs((sum(real2)-sum(clas2)))/length(real2);

fprintf('El error de clasificación para presencia de apnea (1) es: %d \n',ec1);
fprintf('El error de clasificación para ausencia de apnea (0) es %d \n',ec2);

end