function [signal_sortie] = differentiator(signal_entree)
%coeff 
a=zeros(1,7);
a(1)=1;
a(7)=-6;
b=1;
%sortie du filtre 
signal_sortie=filter(a,b,signal_entree);
end