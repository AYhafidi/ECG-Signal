%%five-point differentiation filter
function signal_sortie=fivepoint_diff_filter(signal_entre,Ts)
        %Numeratuer
    a=(1/(8*Ts))*[1 2 0 -2 -1];
        %Denuminateur
    b=1;
        %Application du filtre
    signal_sortie=filter(a,b,signal_entre);
end