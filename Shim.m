function [output_shim] = Shim(path)
    [x,Fp,bits] = wavread(path); 
    SYG = x(:,1);
    N = length(SYG);
    % filtracja
    n=1024;
    F=[0,2*140/Fp, 2*150/Fp,1];
    M=[1,1,0,0];
    FIR=fir2(n,F,M);
    SYG_po_filtracji = filter(FIR,1,SYG);
    SYG_po_filtracji =SYG_po_filtracji(round(0.1*N):round(0.9*N));
    N = length(SYG_po_filtracji);
    
        
    % chwilowe amplitudy sygnalu
    n=floor(N/50); % dlugosc okna
    j=1;
    for i=1:n:N-n
        A_chwilowe(j) = abs(max(SYG_po_filtracji(i:i+n)));
        j=j+1;
    end    

    % liczenie wspolczynnika    
    licznik = 0;
    A_poprzednie = 0;
    for A = A_chwilowe
        if A_poprzednie ~= 0
            licznik = licznik + abs(A_poprzednie - A);
        end
        A_poprzednie = A;
    end
    ilosc_A_chwilowych = length(A_chwilowe);
    licznik = licznik/(ilosc_A_chwilowych-1);
    output_shim = licznik/mean(A_chwilowe);
end

