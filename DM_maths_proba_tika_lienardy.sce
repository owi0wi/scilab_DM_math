
function nombres=genererNombreLoiUniformeSur_0_1(N)
    //Matrice colonne contenant nos N nombres de la loi uniforme
    nombres=grand(1,N,"unf",0,1)
endfunction

function nombres=genererRandUniform(N)
    nombres=rand(1,N)
endfunction

function representerGraphiquementLaLoiUniform()
    X1=genererNombreLoiUniformeSur_0_1(10)
    X2=genererNombreLoiUniformeSur_0_1(100)
    X3=genererNombreLoiUniformeSur_0_1(1000)
    X4=genererNombreLoiUniformeSur_0_1(10000)
    
    subplot(221)
    plot(X1)
    subplot(222)
    plot(X2)
    subplot(223)
    plot(X3)
    subplot(224)
    plot(X4)
endfunction

function representerHistogrammeLoiUniform()
    X1=genererNombreLoiUniformeSur_0_1(10)
    X2=genererNombreLoiUniformeSur_0_1(100)
    X3=genererNombreLoiUniformeSur_0_1(1000)
    X4=genererNombreLoiUniformeSur_0_1(10000)

    subplot(221)
    histplot([0:0.1:1],X1);
    subplot(222)
    histplot([0:0.1:1],X2);
    subplot(223)
    histplot([0:0.1:1],X3);
    subplot(224)
    histplot([0:0.1:1],X4);
endfunction



function boolean=testChi2(nombres, borneInf, borneSup, nbClasses)
    //p doit avoir 'nbClasses' colonnes ou 1 si équiproba
    //borneInf et borneSup representent l'intervalle des nombres aléatoire
    //nbClasses est le nombre de classes que l'on souhaite avoir. Le decoupage se fait de maniere automatique
    
    //contient les valeurs  du chi2 pour un seuil a 5% (de 1 a 14)
    resultChi2_5=[3.841 5.991 7.815 9.488 11.07 12.592 14.067 15.507 16.919 18.307 19.675 21.026 22.362 23.685]
    classes=zeros(1,nbClasses)
    pas=(borneSup-borneInf)/nbClasses;
    
    for i=1:size(nombres,2)
        for b=0:nbClasses-1
            if b~=nbClasses-1 then
               if nombres(1,i)>=borneInf+b*pas & nombres(1,i)<borneInf+(b+1)*pas then
                   classes(1,b+1)=classes(1,b+1)+1;
                    break
                end
            else 
                if nombres(1,i)>=borneInf+b*pas & nombres(1,i)<=borneInf+(b+1)*pas then
                    classes(1,b+1)=classes(1,b+1)+1;
                    break
                end
            end
        end
    end
    disp(classes)
    
    //calcul de la distance D²
    D2 = 0;
    p=1/nbClasses;
    
    for i=1:nbClasses
        D2=D2+((classes(1,i)-size(nombres,2)*p)^2) / (size(nombres,2)*p)
    end
    
    disp('D2 : ',D2)
    disp('Valeur du seuil : ',resultChi2_5(nbClasses-1))
    
    if D2<resultChi2_5(nbClasses-1) then
        boolean='true';
    else
        boolean='false';
    end
endfunction

