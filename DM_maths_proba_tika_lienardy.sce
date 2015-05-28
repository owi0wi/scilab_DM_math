
function nombres=genererNombreLoiUniforme(N,graine,init)
    //Matrice colonne contenant nos N nombres de la loi uniforme
    nombres=zeros(1,N);
    nombres(1,1)=init;
    if graine ==0 then
        graine=123456;
    end
    m=(2^31)-1;
    
    for i=1:(N-1)
        nombres(1,i+1)=modulo(graine*nombres(1,i),m);
    end
    
    for i=1:N
        nombres(1,i)=nombres(1,i)/max(nombres);
    end
endfunction



function boolean=testChi2(nombres, p, borneInf, borneSup, nbClasses)
    //p doit avoir 'nbClasses' colonnes ou 1 si équiproba
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
    
    //calcul de la distance D²
    D2 = 0;
    if size(p,2)==1 then
        p=ones(1,nbClasses)*p;
    end
    
    for i=1:nbClasses
        D2=D2+(classes(1,i)-size(nombres,2)*p(1,i))^2 / (size(nombres,2)*p(1,i))
    end
    
    //a ecrire en dur
    seuil=123;
    if D2<seuil then
        boolean='true';
    else
        boolean='false';
    end
endfunction


 //Boussa
