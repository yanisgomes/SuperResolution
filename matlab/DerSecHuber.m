function res = DerSecHuber(dx,seuil)
% DERIVHUBER - Derive seconde de la fonction de Huber 
%   
%   inputs : dx     vecteur des diff�rences ou image des differences 
%            seuil  seuil entre le comportement quadratique et 
%                   comportement lin�aire.
%
%   output : res    vecteur resultat de la fonction 


res = dx;
res(find(abs(dx)>seuil))=0;
res(find(abs(dx)<=seuil))=1;




