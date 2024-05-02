function alphaOpt = AlphaOptDonneeManquante(Direct,Gradient,XK,Data,RI,MU,seuil)
% ALPHAOPT - determine le alpha optimal dans le cas quadratique
% Entrées :
%  GRADIENT : gradient du critere.
%   RI       : reponse impulsionnelle du filtre
%   MU       : Coefficient de regularisation
%   SEUIL    : seuil entre le comportement L2 et L1 .
% Sortie : 
%  ALPHAOPT : valeur du pas de descente optimum 
%               || gk||/gkT (HTHgk +DTD Phi''(Dgk))


retRI=flip(RI);

HG=conv2(Direct,RI,'same');
HG(find(isnan(Data)))=0; % prise en compte des données manquantes ??
HTHG= conv2(HG,retRI,'same'); 

%D=[0 0 0 ; 0 2 -1 ; 0 -1 0 ]; % opérateur de dérivation

Dx=[0 1 -1];
Dy=[0; 1;-1];


DX1=convn(XK,Dx,'same');
DX2=convn(XK,Dy,'same');
PhiG1=Direct.*DerSecHuber(DX1,seuil);
PhiG2=Direct.*DerSecHuber(DX2,seuil);
%DXK=conv2(XK,D,'same');
DG1=convn(PhiG1,Dx,'same');
DTDG1=conv2(DG1,flip(Dx),'same');

DG2=convn(PhiG2,Dy,'same');
DTDG2=conv2(DG2,flip(Dy),'same');


Denom =2* (HTHG+MU*(DTDG1+DTDG2)).*Direct;
Num =Direct.*Gradient;

alphaOpt = sum(Num(:))/sum(Denom(:));
