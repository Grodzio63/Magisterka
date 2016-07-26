function [ Syg_po_filtracji] = filtracja(Syg,Fp,meski)
    %filtracja sygna³u
    n= length(Syg);
    if meski
        F=[0,2*140/Fp, 2*150/Fp,1];
    else
        F=[0,2*240/Fp, 2*250/Fp,1];
    end
    M=[1,1,0,0];
    FIR=fir2(n,F,M);
    Syg_po_filtracji = filter(FIR,1,Syg);
end

