
function nombres=genLoiUniform(N)
    //Matrice colonne contenant nos N nombres de la loi uniforme
    nombres=grand(1,N,"unf",0,1)
endfunction

function nombres=genLoiPoisson(N,lambda)
    nombres=grand(1,N,"poi",lambda)
endfunction

function nombres=genLoiNormale(N,m,sigma)
    nombres=grand(1,N,"nor",m,sigma)
endfunction

function nombres=genRandLoiUniform(N)
    nombres=rand(1,N)
endfunction

function b=testChi2PourLoiPoisson(N, lambda, nbClasses)
    nombres=genLoiPoisson(N,lambda);
    mini=int(min(nombres));
    maxi=int(max(nombres))+1;
    p=zeros(1,nbClasses);
    moy=mean(nombres)
    for i=0:nbClasses-1
        p(1,i+1)=exp(-moy)*(moy^i)/factorial(i)
    end
    b=testChi2(nombres,p,mini,maxi,nbClasses)
endfunction

function boolean=testChi2(nombres, p, borneInf, borneSup, nbClasses)
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
    disp(p)
    
    //calcul de la distance D²
    D2 = 0;
    if size(p,2)==1 then
        p=ones(1,nbClasses)*p;
    end

    
    for i=1:nbClasses
        D2=D2+((classes(1,i)-size(nombres,2)*p(1,i))^2) / (size(nombres,2)*p(1,i))
    end
    
    disp('D2 : ',D2)
    disp('Valeur du seuil : ',resultChi2_5(nbClasses-1))
    
    if D2<resultChi2_5(nbClasses-1) then
        boolean='true';
    else
        boolean='false';
    end
endfunction


function plotLoiUniform()
    subplot(221)
    plot(genLoiUniform(10))
    subplot(222)
    plot(genLoiUniform(100))
    subplot(223)
    plot(genLoiUniform(1000))
    subplot(224)
    plot(genLoiUniform(10000))
endfunction


function plotLoiPoisson()
    subplot(431)
    plot(genLoiPoisson(10,1))
    subplot(432)
    plot(genLoiPoisson(10,10))
    subplot(433)
    plot(genLoiPoisson(10,100))
    
    subplot(434)
    plot(genLoiPoisson(100,1))
    subplot(435)
    plot(genLoiPoisson(100,10))
    subplot(436)
    plot(genLoiPoisson(100,100))
    
    subplot(437)
    plot(genLoiPoisson(1000,1))
    subplot(438)
    plot(genLoiPoisson(1000,10))
    subplot(439)
    plot(genLoiPoisson(1000,100))
    
    subplot(4,3,10)
    plot(genLoiPoisson(10000,1))
    subplot(4,3,11)
    plot(genLoiPoisson(10000,10))
    subplot(4,3,12)
    plot(genLoiPoisson(10000,100))

endfunction

function plotLoiNormale()
    subplot(441)
    plot(genLoiNormale(10,10,1))
    subplot(442)
    plot(genLoiNormale(10,10,10))
    subplot(443)
    plot(genLoiNormale(10,100,1))
    subplot(444)
    plot(genLoiNormale(10,100,10))
    
    subplot(445)
    plot(genLoiNormale(100,10,1))
    subplot(446)
    plot(genLoiNormale(100,10,10))
    subplot(447)
    plot(genLoiNormale(100,100,1))
    subplot(448)
    plot(genLoiNormale(100,100,10))
    
    subplot(449)
    plot(genLoiNormale(1000,10,1))
    subplot(4,4,10)
    plot(genLoiNormale(1000,10,10))
    subplot(4,4,11)
    plot(genLoiNormale(1000,100,1))
    subplot(4,4,12)
    plot(genLoiNormale(1000,100,10))
    
    subplot(4,4,13)
    plot(genLoiNormale(10000,10,1))
    subplot(4,4,14)
    plot(genLoiNormale(10000,10,10))
    subplot(4,4,15)
    plot(genLoiNormale(10000,100,1))
    subplot(4,4,16)
    plot(genLoiNormale(10000,100,10))

endfunction

function histplotLoiUniform()
    X1=genLoiUniform(10)
    X2=genLoiUniform(100)
    X3=genLoiUniform(1000)
    X4=genLoiUniform(10000)

    subplot(221)
    histplot([0:0.1:1],X1);
    subplot(222)
    histplot([0:0.1:1],X2);
    subplot(223)
    histplot([0:0.1:1],X3);
    subplot(224)
    histplot([0:0.1:1],X4);
endfunction
