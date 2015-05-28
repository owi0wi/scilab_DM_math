//Réthoré Sophie
//Ghazouani Soukaina
//***************Exercice 1: simulation de lois de probabilité********************//

//_______Partie 1_______
//1. cette fonction permet de générer N nombres aléatoires de loi uniforme sur [0,1]
function X=genere_nb_aleatoire(n, x0)
    
    //méthode minimal standard : générateurs a congruence linéaire non optimisés
    a= 16807;
    m=(2^31)-1
    c=0;
    //m=10^8;    
    X = zeros(n,1);
    X(1,1) = x0
    for k = 1 : n
       X(k+1,1) = modulo(a*X(k,1) + c,m) ;
       //X(k+1,1) = a*X(k,1) + c * modulo(m); 
    end  
    //on ramène les valeurs générées à des valeurs comprises entre 0 et 1
    for i=1:n+1
        X(i)=X(i)/max(X);
    end
    
    //affichage du résultat
    //plot(X);
endfunction

//3. cette fonction permet de réaliser un test du Chi2 : "les nombres générés suivent la loi uniforme sur [0,1]"
function test_chi2(X)
    // sous l'hypothèse : la sequence en paramètres suit la loi Uniforme sur [0,1]
    // loi uniforme de parametre p = 1/N
    //les valeurs obtenues sont situées entre 0 et 1
    //disp ('valeur de X',X)
    //n : nombre de valeurs pseudo aléatoires générées
    n= size(X,1)-1;
    //disp('valeur de n');
    //disp (n);
    classe1 = 0;
    classe2 = 0;
    classe3 = 0;
    classe4 = 0;
    classe5 = 0;
    classe6 = 0;
    classe7 = 0;
    classe8 = 0;
    classe9 = 0;
    classe10 = 0;
    
    //on récupère un tableau contenant les valeurs générées aléatoirement
    // on parcours ce tableau et on classifie les valeurs selon plusieurs classes.
    for i=1:1:n
        //disp (X(i));
        if X(i)>=0 & X(i) <0.1             
            //classe1(i)=X(i);
            classe1=classe1+1;
        elseif X(i)>=0.1 & X(i) <0.2  
            //classe2(i)=X(i);
            classe2=classe2+1;
        elseif X(i)>=0.2 & X(i) <0.3  
            //classe3(i)=X(i);
            classe3=classe3+1;
        elseif X(i)>=0.3 & X(i) <0.4  
            //classe4(i)=X(i);
            classe4=classe4+1;
        elseif X(i)>=0.4 & X(i) <0.5  
            //classe5(i)=X(i);
            classe5=classe5+1;
        elseif X(i)>=0.5 & X(i) <0.6  
            //classe6(i)=X(i);
            classe6=classe6+1;
        elseif X(i)>=0.6 & X(i) <0.7  
            //classe7(i)=X(i);
            classe7=classe7+1;
        elseif X(i)>=0.7 & X(i) <0.8  
            //classe8(i)=X(i);
            classe8=classe8+1;
        elseif X(i)>=0.8 & X(i) <0.9  
            //classe9(i)=X(i);
            classe9=classe9+1;
        elseif X(i)>=0.9 & X(i) <=1  
            //classe10(i)=X(i);
            classe10=classe10+1;
        end
    end
    
    //disp ('class', classe1);
    p=1/10;
    
    //calcul de D^2
    //d2=somme de k=1 à 10 de (nb de familles concernées par ce cas - n . p)/ n.p
    d2= (((classe1-n*p)^2)/(n*p)) + (((classe2-n*p)^2)/(n*p)) + (((classe3-n*p)^2)/(n*p)) + (((classe4-n*p)^2)/(n*p)) + (((classe5-n*p)^2)/(n*p)) + (((classe6-n*p)^2)/(n*p)) + (((classe7-n*p)^2)/(n*p)) + (((classe8-n*p)^2)/(n*p)) + (((classe9-n*p)^2)/(n*p)) + (((classe10-n*p)^2)/(n*p));
    
    disp('d2', d2);
    
    // d2 suit la loi du chi2 de 9 
    // pour un seuil de 5%
    // selon le tableau le résultat seuil est 16,919
    
    if d2 > 16.919 then
        disp('le phénomène observé navait que 5% de chance de se produire donc on rejette H0 et la séquence observée ne suit pas une loi uniforme sur [0,1]');
    else
       disp('la séquence observée suit une loi uniforme selon le test du chi2') ;
    end
    
endfunction


function methode_du_rejet()
     //méthode du rejet
//     X=zeros( 1 , 10000 ) ;
//    for i =1:10000;
//        x=rand ( 1 , 2 ) ;
//        while x(2)> sin (%pi * x( 1 ) ) ,
//            x=rand ( 1 , 2 ) ;
//        end ;
//        X( i )=x ( 1 ) ;
//    end ;
//histplot(100 ,X) ;
//Y=[ 0 : 0.05 : 1 ] ;
//plot2d (Y,%pi * sin(%pi * Y) / 2 ) ;
endfunction

function loi_deux(X,lambda)
    n=size(X,1)-1;
    x=zeros(n);
    
    //disp('n=',n);
    for i=1:n
        //j=1-X(i);
        //disp('X(i)=',X(i));
        if (X(i)<>0) then
            x(i) = -(log2(1-X(i))/lambda);
        end
    end
    disp ('x=',x); 
    histplot([0:0.1:1] ,X) ;
endfunction

// exercice 2 loi des grands nombres 

//Question 1  on choisi une loi de Bernoulli pour pour les variables Xi avec 1<i<N
// On note p le paramètre de la variable aléatoire Xi.
// Alors : E[Xi]=p l'ecart-type = sqrt(pq) avec q= 1-p.

//n représente le nombre d'éxpériences
//k représente le nombre de réalisations
function [x,m,sigma,v]=repres4(n,k)

    x = rand(k,n); // vecteur ligne aleatoire
    m=mean(x);
    disp(' la moyenne est:', m);
    //calcule de la variance
    v=variance(x);
    // calcule de l'écart type
    sigma=sqrt(v);
    disp(' l écart type est :' ,v);

    
    plot(x);
endfunction



// Exercice 3 : Simulation du théorème de la limite centrale

//partie 1: representation de l'histogramme de la va Yn selon la loi uniforme

function Yn=hist_loi_uniforme(n,k)
    // choisir la taille de N
   // n=input('Taille de l''echantillon, N=');
    //choisir le nombre de réalisations
   // k=input('Nombre de réalisations, k=');

    x=rand(k,n); 
    // la moyenne d'une loi uniforme
    E=.5; 
    // l'ecart type est donné par :
    sigma=1/sqrt(12); 

    // initialisation de la matrice Yn
    Yn=zeros(1,k);

    for i=1:k
        Yn(i)=(sum(x(i,:))-n*E)/(sqrt(n)*sigma);
    end
    clf();
    histplot(50,Yn);
endfunction

//partie 1: representation de l'histogramme de la va Yn selon une loi continue 
function Yn= loiexp2(n,lambda,k)
    
        // choisir la taille de N
  //  n=input('Taille de l''echantillon, n=');
   //lambda=input('choisir lambda, lambda=');
    //choisir le nombre de réalisations
    //k=input('Nombre de réalisations, k=');
  
    x = grand(n,k,"exp",1/lambda);

    // la moyenne de la loi exp 
       E=1/lambda; 
       
    // l'ecart type est donné par :

       sigma=1/sqrt(lambda*lambda); 

    // initialisation de la matrice Yn
    Yn=zeros(1,k);

    for i=1:k
        Yn(i)=(sum(x(i,:))-n*E)/(sqrt(n)*sigma)
    end
    clf();

    histplot(10,Yn)

endfunction




//partie 2: representation de l'histogramme de la va Yn selon une loi binomiale 

function Yn=hist_loi_binomiale(n,N,p)

    // choisir la taille de N
    //n=input('Taille de l''echantillon, n=');

    //choisir le nombre de réalisations
    //N=input('Nombre de réalisations, N=');
    //p=input('Entrez le parametre , p=');


   //grand permet de generer des nombres aléatoires entre 1 et N suivant une loi binomiale 
    x = grand(N,1,"bin", n,p);


    // la moyenne d'une loi binomiale

    E=n*p; 
    q=1-p;

    // l'ecart type est donné par :

    sigma=sqrt(E*q) ;

    // initialisation de la matrice Yn

    Yn=zeros(1,N);

    for i=1:N
        Yn(i)=(sum(x(i,:))-n*E)/(sqrt(n)*sigma);
    end

  clf();

    classes = linspace(0,10,0.5);
  histplot(classes,Yn);
   

endfunction
//programme principal
function main()
    
//test avec le générateur pseudo-aléatoire créé
    subplot(221);
    X1=genere_nb_aleatoire(100,1);
    //plot(X1);
    test_chi2(X1);
    //fonction permettant de représenter une fonction par un histogramme
    histplot([0:0.1:1],X1);
    subplot(222);
    X2=genere_nb_aleatoire(1000, 1);
    //plot(X2);
    test_chi2(X2);
    histplot([0:0.01:1],X2);
    subplot(223);
    X3=genere_nb_aleatoire(10000, 1);
    histplot([0:0.01:1],X3);
    test_chi2(X3);
    //plot(X3);
    subplot(224);
    X4=genere_nb_aleatoire(10, 1);
    //plot(X4);
    histplot([0:0.01:1],X4);
    test_chi2(X4);
    
    
//test avec la méthode rand de scilab
    subplot(221);
    X1r=rand(100,1,"uniform");
    //fonction permettant de représenter une fonction par un histogramme
    histplot([0:0.01:1],X1r, style=2);
    subplot(222);
    X2r=rand(1000,1,"uniform");
    histplot([0:0.01:1],X2r, style = 2);
    subplot(223);
    X3r=rand(10000,1,"uniform");
    histplot([0:0.01:1],X3r, style=2);
    subplot(224);
    X4r=rand(10,1,"uniform");
    histplot([0:0.01:1],X4r, style=2);
    
    test_chi2(X1r);
    test_chi2(X2r);
    test_chi2(X3r);
    test_chi2(X4r);

    
    //partie 2
    for lambda=0.5:0.5:1.5
        //loi_deux(X2,lambda);
    end
    // exercice 2
    // representation graphique d'une réalisation avec N=100
    subplot(221);
    disp('representation graphique d une réalisation avec N=100')
    repres4(100,1);
    
    
    // la moyenne obtenue pour  N=10
    subplot(222);
    disp('calcul de la moyenne et l écart-type pour N 10')
    repres4(10,1)
    
    
     
    // la moyenne obtenue pour  N=20
    subplot(223);
   disp('calcul de la moyenne et l écart-type pour N 20')
    repres4(20,1);
    
    // representation graphique de 10 réalisations avec N=100
   subplot(224);
     disp('représentation graphique de 10 réalisations avec N=100 et calcul de la moyenne et l écart-type ')
    repres4(100,10);
    
    //exercice 3
    // partie 1
    // histogramme de Yn selon la loi uniforme avec N=100 et K=10 (  N représente la Taille de l''echantillon et K le nombre de réalisations)
    disp('histogramme de Yn selon la loi uniforme avec N=100 et K=10 (  N représente la Taille de l''echantillon et K le nombre de réalisations)')
    hist_loi_uniforme(100,10);
    xtitle("loi uniforme ");

    
    
    // histogramme de Yn selon la loi exponnentielle avec N=100 et K=10  et lambda 1.6 (  N représente la Taille de l''echantillon et K le nombre de réalisations)
    disp('histogramme de Yn selon la  exponnentielle avec N=100 et K=10 et lambda 1.6(  N représente la Taille de l''echantillon et K le nombre de réalisations)')
    loiexp2(1000,3,30);
    xtitle("loi exponnentielle");
    
   disp('histogramme de Yn selon la binomiale avec N=100 et K=7 et p 0.03(  N représente la Taille de l''echantillon et K le nombre de réalisations)')
    hist_loi_binomiale(100,7,0.03);
   xtitle("loi binomiale avec p=0.03");
   
       disp('histogramme de Yn selon la binomiale avec N=1000 et K=7 et p 0.5(  N représente la Taille de l''echantillon et K le nombre de réalisations)')
        hist_loi_binomiale(1000,7,0.5);
    xtitle("loi binomiale avec p =0.5");
endfunction

