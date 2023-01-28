function Signal_sortie = low_pass_filter(signal_entre)
%%filter passe bas
    %Numerateur
a=zeros(1,13);
a(1)=1;
a(7)=-2;
a(13)=1;
    %denuminateur
b=[1 -2 1];
    %Sortie du filter
Signal_sortie=filter(a,b,signal_entre);
end

