function [c] = Correlation(ref,cible,depX,depY)
%
% REF image de r�f�rence
% CIBLE image cible que l'on veut comparer la taille de l'image
% cible doit �tre inf�rieur ou �gale � la taille de l'image de r�f�rence
% DEPX D�placement suivant X en pixel image sous r�solue (gros pixel)
% DEPY D�placement suivant Y en pixel image sous r�solue
%
%
% exemple : 
%  A = [ 1 3 2 4 ; 5 16 17 8 ; 9 4 11 12 ; 13 14 15 16 ]; 
%  B= conv2(A,ones(2)/4,'valid')
% Correlation(A,B,0,1)
% Correlation(A,B,0,0) 
% Correlation(A,B,1,1)
% Correlation(A,B,0.5,0.5) 
% le maximum de corr�lation comme on pouvait le pr�voir se trouve
% en 0.5 0.5
% Fait par T. Rodet Mars  2012


cible= cible(1:end-1,1:end-1); 


[N,M]=size(cible); 

Ivec=(1:N) + depX; 
Jvec=(1:M) + depY;

[xi,yi] = meshgrid(Ivec,Jvec);

StdCible= std(cible(:));
MeanCible= mean(cible(:));

 Comp = (interp2(ref,yi,xi,'linear',0))';

 %toto = Comp(:);
 %Comp = Comp(~isnan(Comp));
 StdC=std(Comp(:));
 MeanC=mean(Comp(:));

 c = sum2((cible-MeanCible).*(Comp-MeanC))/(StdCible*StdC); 
 