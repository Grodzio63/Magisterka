function [licznik] = ZCA(Syg)
    %%%%%%%%%%%%%%%%%% Przejscia przez 0 %%%%%%%%%%%%%%%%%%%    
    N = length(Syg);       
    i=1;
    licznik = 0;
    while i < N-2
        przejscie = abs(sign(Syg(i+1))- sign(Syg(i)))/2;
        if przejscie==1    
            licznik = licznik + 1;
        end
        i = i+1;
    end
end

