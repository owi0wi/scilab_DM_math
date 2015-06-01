funcprot(0)
xdel(winsid());
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//--------------------   DM maths - probabilité   -------------------------
//-----------------   Lienardy Morgan - Tika Jihade   ---------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------

//Ce fichier scilab contient l'ensemble du code pour le DM
disp("- Exercice 1)");
disp("-- Partie 1");
disp("--- 1)");
disp("Test pour N=10");
disp(genLoiUniform(10));
xset("window",0);
plotLoiUniform();
disp("--- 2)");
xset("window",1);
histplotLoiUniform();
disp("--- 3)");
N=genLoiUniform(1000)
b=testChi2(N, 'uni', 0, 1, 10)
disp("Test chi2 pour 1000 nombres de loi uniforme avec 10 classes")
disp(b);
disp("--- 4)");
N=genRandLoiUniform(1000)
b=testChi2(N, 'uni', 0, 1, 10)
disp("Test chi2 pour 1000 nombres de la fonction rand avec 10 classes")
disp(b);
disp("--- 5)");
//

disp("-- Partie 2");
disp("--- 6)");
xset("window",2);
plotLoiPoisson();
xset("window",3);
plotLoiNormale()
disp("--- 7)");
b=testChi2LoiPoisson(1000, 10, 10)
disp("Test chi2 pour 1000 nombres de loi Poisson avec 10 classes")
disp(b);
disp("-- Partie 3");
disp("--- 8)");

disp("- Exercice 2)");
disp("-- Partie 1");
disp("--- 1)");
//Loi Xi
disp("--- 2)");
//Loi X
disp("--- 3)");
xset("window",4);
[X,Z]=marcheAlea2D(1,1,20);
xset("window",5);
[X,Z]=marcheAlea2D(1,1,100);
xset("window",6);
[X,Z]=marcheAlea2D(1,1,1000);
disp("--- 4)");
//Esperance et variance : 
disp("-- Partie 2");
disp("--- 5)");
//pourquoi s²=a.T
disp("--- 6)");
xset("window",7);
marcheAleaRapide(1000);
disp("--- 7");
//mouvement brownien
disp("-- Partie 3");
disp("--- 8)");
xset("window",8);
[X,Z]=marcheAlea2D(s,T,n);



//-------------------------------------------------------------------------
//--------------------------   Fonctions   --------------------------------
//-------------------------------------------------------------------------


//Genere N nombres de loi uniforme entre 0 et 1
function nombres=genLoiUniform(N)
    //Matrice colonne contenant nos N nombres de la loi uniforme
    nombres=grand(1,N,"unf",0,1)
endfunction
//-------------------------------------------------------------------------

//Genere N nombres de loi de Poisson avec comme parametre lambda
function nombres=genLoiPoisson(N,lambda)
    nombres=grand(1,N,"poi",lambda)
endfunction
//-------------------------------------------------------------------------

//Genere N nombres de loi Normale avec comme parametres l'esperance 'm' et l'ecart type 'sigma'
function nombres=genLoiNormale(N,m,sigma)
    nombres=grand(1,N,"nor",m,sigma)
endfunction
//-------------------------------------------------------------------------

//Genere N nombres suivant la fonction scilab 'rand'
function nombres=genRandLoiUniform(N)
    nombres=rand(1,N)
endfunction
//-------------------------------------------------------------------------

//Realise le test du Chi2 pour la loi de Poisson avec N nombres (param lambda))
//nbClasses represente le nombre de classes que l'on souhaite avoir pour le test
//l'intervalle est [ plus petite valeur obtenue ; plus grande valeur obtenue+1 ]
function b=testChi2LoiPoisson(N, lambda, nbClasses)
    nombres=genLoiPoisson(N,lambda);
    mini=int(min(nombres));
    maxi=int(max(nombres))+1;
    b=testChi2(nombres,'poi',mini,maxi,nbClasses)
endfunction
//-------------------------------------------------------------------------

//Realise le test du Chi2 pour la loi Normale avec N nombres (param m, sigma)
//function b=testChi2LoiNormale(N, m, sigma)
//    nombres=genLoiNormale(N,m, sigma);
//    mini=int(min(nombres));
//    maxi=int(max(nombres))+1;
//    b=testChi2(nombres,'nor',mini,maxi,nbClasses)
//endfunction
//-------------------------------------------------------------------------

//Realise le test du Chi2
//nombres : la matrice contenant des nombres que l'on souhaite tester
// loi : La loi que ces nombres suivent
//borneInf et borneSup : les bornes pour le decoupage des classes
//nbClasses : Le nombres de classes que l'on souhaite avoir
function boolean=testChi2(nombres, loi, borneInf, borneSup, nbClasses)
    //p doit avoir 'nbClasses' colonnes
    //borneInf et borneSup representent l'intervalle des nombres aléatoire
    //nbClasses est le nombre de classes que l'on souhaite avoir. Le decoupage se fait de maniere automatique
    
    //contient les valeurs  du chi2 pour un seuil a 5% (de 1 a 14)
    resultChi2_5=[3.841 5.991 7.815 9.488 11.07 12.592 14.067 15.507 16.919 18.307 19.675 21.026 22.362 23.685]
    classes=zeros(1,nbClasses)
    pas=(borneSup-borneInf)/nbClasses;
    
    //ces boucles permettent de decouper les nombres en classes
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
    //Ici on determine 'p' en fonction de la loi
    if loi=='uni' then
        p=ones(1,nbClasses)*(1/nbClasses);
    end
    if loi=='poi' then
        p=zeros(1,nbClasses);
        moy=0;
        for i=1:nbClasses
            moy=moy+classes(1,i)*i
        end
        moy=moy/size(nombres,2);
        disp(moy)
        for k=1:nbClasses
            p(1,k)=exp(-moy)*(moy.^k)/factorial(k);
        end
    end
    if loi=='nor' then
        
    end
    disp(p)

    // On somme les distances de chaque classe
    for i=1:nbClasses
        D2=D2+((classes(1,i)-size(nombres,2)*p(1,i))^2) / (size(nombres,2)*p(1,i))
    end
    
    disp('D2 : ',D2)
    disp('Valeur du seuil : ',resultChi2_5(nbClasses-1))
    
    //on compare D² et la valeur du seuil (rappel : 5%)
    if D2<resultChi2_5(nbClasses-1) then
        boolean="L hypothese initiale est valide, donc on l a garde";
    else
        boolean='On observe un evenement qui ne peut se produire que rarement, on rejette donc l hypothese initiale';
    end
endfunction
//-------------------------------------------------------------------------

//Exercice2 - fonction qui prend en parametre une distance 's', une periode (en sec)'T' et le nombre de mouvement 'n'
// Simule une marche aleatoire dans 2 sens : gauche ou droite d'une distance 's' qui se repete toutes les T secondes 'n' fois
function X=marcheAlea1D(s,T,n)
    //Avec s la longueur du deplacement pour un lancé
    //Avec T la periode en seconde du lancé de piece
    //Avec n le nombre de lancé
    
    //--> pile = 0 = a gauche
    //--> face = 1 = a droite
    //clf;
    X=[0]
    for i=1:n
        val=lancePiece();
        if val==0 then
            X=[X X(i)+s];
        else
            X=[X X(i)-s];
        end
        
        //disp(X(i));
        //sleep(T*1000);
    end
    temps=[0:T:n*T];
    afficheMarche1D(temps,X);
    
endfunction
//-------------------------------------------------------------------------

//Fonction qui prend en parametre une distance 's', une periode (en sec)'T' et le nombre de mouvement 'n'
// Simule une marche aleatoire dans 4 sens : gauche ou droite, et haut ou bas d'une
// distance 's' qui se repete toutes les T secondes 'n' fois
function [X,Z]=marcheAlea2D(s,T,n)
    //Avec s la longueur du deplacement pour un lancé
    //Avec T la periode en seconde du lancé de piece
    //Avec n le nombre de lancé
    
    //--> pileX = 0 = a gauche
    //--> faceX = 1 = a droite
    //--> pileZ = 0 = en haut
    //--> faceZ = 1 = en bas

    X=[0];
    Z=[0];
    for i=1:n
        valX=lancePiece();
        valZ=lancePiece();
        if valX==0 then
            X=[X X(i)+s];
        else
            X=[X X(i)-s];
        end
        if valZ==0 then
            Z=[Z Z(i)+s];
        else
            Z=[Z Z(i)-s];
        end
        
        //disp(X(i));
        //sleep(T*1000);
    end
    temps=[0:T:n*T];
    afficheMarche2D(temps,X,Z);
    //param3d(temps,X,Z);
    //plot3d(temps,temps,[Z' X'])
    //xtitle("X(nT,omega)","Temps (s)","Distance parcourue (gauche/droite)","Distance parcourue (haut/bas)");
endfunction
//-------------------------------------------------------------------------

//Affiche 3 graphes : le 1er en 3d, les 2 derniers en 2d
function afficheMarche1D(axeX,axeY)
    plot(axeX,axeY);
    xtitle("X(nT,omega)","Temps (s)","Distance parcourue");
endfunction
//-------------------------------------------------------------------------

//Affiche 3 graphes : le 1er en 3d, les 2 derniers en 2d
function afficheMarche2D(axeX,axeY,axeZ)
    subplot(131)
    param3d(axeX,axeY,axeZ);
    xtitle("Z(nT,omega)","Temps (s)","Distance parcourue (gauche/droite)","Distance parcourue (haut/bas)");
    subplot(132)
    plot(axeX,axeY);
    xtitle("Z(nT,omega)","Temps (s)","Distance parcourue (gauche/droite)");
    subplot(133)
    plot(axeX,axeZ);
    xtitle("Z(nT,omega)","Temps (s)","Distance parcourue (haut/bas)");
endfunction
//-------------------------------------------------------------------------

//Affiche 9 graphes avec comme param 'n' qui qui represente le nombre de mouvements
//On prend T de plus en plus petit en commencant a 1, et en divisant a chaque fois par 10
function marcheAleaRapide(n)
    T=1;temps=[0:T:n*T];
    subplot(331)
    plot(temps,marcheAlea1D(sqrt(T),T,n))
    T=0.1;temps=[0:T:n*T];
    subplot(332)
    xtitle("9 graphes pour la marche aleatoire rapide");
    plot(temps,marcheAlea1D(sqrt(T),T,n))
    T=0.01;temps=[0:T:n*T];
    subplot(333)
    plot(temps,marcheAlea1D(sqrt(T),T,n))
    T=0.001;temps=[0:T:n*T];
    subplot(334)
    plot(temps,marcheAlea1D(sqrt(T),T,n))
    T=0.0001;temps=[0:T:n*T];
    subplot(335)
    plot(temps,marcheAlea1D(sqrt(T),T,n))
    T=0.00001;temps=[0:T:n*T];
    subplot(336)
    plot(temps,marcheAlea1D(sqrt(T),T,n))
    T=0.000001;temps=[0:T:n*T];
    subplot(337)
    plot(temps,marcheAlea1D(sqrt(T),T,n))
    T=0.0000001;temps=[0:T:n*T];
    subplot(338)
    plot(temps,marcheAlea1D(sqrt(T),T,n))
    T=0.00000001;temps=[0:T:n*T];
    subplot(339)
    plot(temps,marcheAlea1D(sqrt(T),T,n))
endfunction
//-------------------------------------------------------------------------

//Simule un lancer de piece en suivant le loi de bernoulli (loi binomiale pour n=1 et p=0.5)
function val=lancePiece()
    val=grand(1,1,"bin",1,0.5)
endfunction
//-------------------------------------------------------------------------

//Affiche 4 graphes pour la loi uniforme pour 10,100,1000 et 10000 nombres
function plotLoiUniform()
    subplot(221)
    xtitle("4 graphes pour la loi uniforme pour n=10,100,1000 ,10000");
    plot(genLoiUniform(10))
    subplot(222)
    plot(genLoiUniform(100))
    subplot(223)
    plot(genLoiUniform(1000))
    subplot(224)
    plot(genLoiUniform(10000))
endfunction
//-------------------------------------------------------------------------

//Affiche 12 graphes pour la loi de Poisson pour 10,100,1000 et 10000 nombres
// et pour lambda 1, 10 et 100
function plotLoiPoisson()
    subplot(431)
    plot(genLoiPoisson(10,1))
    subplot(432)
    xtitle("12 graphes pour la loi de Poisson pour n=10,100,1000,10000 et lambda=1,10,100");
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
//-------------------------------------------------------------------------

//Affiche 16 graphes pour la loi de Normale pour 10,100,1000 et 10000 nombres,
// pour une esperance a 10 et 100 et pour un ecart-type a 1 et 10
function plotLoiNormale()
    subplot(441)
    plot(genLoiNormale(10,10,1))
    subplot(442)
    xtitle("16 graphes pour la loi de Normale pour n=10,100,1000,10000 m=10,100 sigma=1,10");
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
//-------------------------------------------------------------------------

//Affiche 4 histogrammes pour la loi uniforme pour 10,100,1000 et 10000 nombres
function histplotLoiUniform()
    X1=genLoiUniform(10)
    X2=genLoiUniform(100)
    X3=genLoiUniform(1000)
    X4=genLoiUniform(10000)
    xtitle("4 histogrammes pour la loi uniforme n=10,100,1000,10000");
    subplot(221)
    histplot([0:0.1:1],X1);
    subplot(222)
    histplot([0:0.1:1],X2);
    subplot(223)
    histplot([0:0.1:1],X3);
    subplot(224)
    histplot([0:0.1:1],X4);
    
endfunction
//-------------------------------------------------------------------------
