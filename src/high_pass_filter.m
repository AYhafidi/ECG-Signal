function [signal_sortie] = high_pass_filter(signal_entre)
%filtre pass haut
    %Numerateur
a=zeros(1,33);
a(1)=-1;
a(17)=32;
a(18)=-32;
a(33)=1;
    %denuminateur
b=[1 -1];
    %Sortie du filter
signal_sortie=filter(a,b,signal_entre);
end

