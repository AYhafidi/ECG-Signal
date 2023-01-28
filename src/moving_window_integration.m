function signal_sortie = moving_window_integration(Signal_entree,N)

signal_sortie=conv((1/N)*ones(1,N),Signal_entree);

end

