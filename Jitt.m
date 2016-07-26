function [output_jitt] = Jitt(path)

    % wyliczanie dewiacji
    [x,Fp,bits] = wavread(path); 
    EEG = x(:,2);
    N = length(EEG);
    % filtracja
    n=1024;
    F=[0,2*140/Fp, 2*150/Fp,1];
    M=[1,1,0,0];
    FIR=fir2(n,F,M);
    EEG_po_filtracji = filter(FIR,1,EEG);
    EEG_po_filtracji =EEG_po_filtracji(round(0.1*N):round(0.9*N));
    N = length(EEG_po_filtracji);
        
    % chwilowe czestotliwosci
    i = 1;
    j = 1;
    T=0;
    licznik_okresu_sygnalu = 0;
    while i < N-2
        p = abs(sign(EEG_po_filtracji(i+1))- sign(EEG_po_filtracji(i)))/2;
        if p==1    
            licznik_okresu_sygnalu = licznik_okresu_sygnalu+1;
            if licznik_okresu_sygnalu == 1
                T_poprzedni = 1/Fp*i;
            end
            if licznik_okresu_sygnalu == 3
                T_aktualny = 1/Fp*i;
                T(j) = T_aktualny - T_poprzedni;
                j = j+1;
                T_poprzedni = T_aktualny;
                licznik_okresu_sygnalu = 0;
            end
        end
        i = i+1;
    end
    f_chwilowe = 1./T;

    % liczenie wspolczynnika    
    f_poprzednie = 0;
    licznik = 0;
    
    for f = f_chwilowe
        if f_poprzednie ~= 0
            licznik = licznik + abs(f_poprzednie - f);
        end
        f_poprzednie = f;
    end
    ilosc_f_chwilowych = length(f_chwilowe);
    licznik = licznik/(ilosc_f_chwilowych-1);
    output_jitt = licznik/mean(f_chwilowe);   
end

