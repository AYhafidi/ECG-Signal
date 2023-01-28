function [signal_sortie] = low_pass(signal_entree)
%coeff 
%nominateur
a=zeros(1,9);
a(1)=1;
a(9)=-1;
%denominateur
b=zeros(1,2);
b(1)=1;
b(2)=-1;
%sortie du filtre 
signal_sortie=filter(a,b,signal_entree);
end