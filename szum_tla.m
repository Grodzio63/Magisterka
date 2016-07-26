function [dolny_prog_energ, gorny_prog_energ, prog_ZCA] = szum_tla(file_path)
    %[Syg,Fp,] = wavread(file_path);
    %detekcja t³a
    %czas_tla = 0.1s
    [x,Fp] = wavread(file_path,[1 1]);
    szerokosc_tla = 0.01*Fp;
    % bierzemy okna 0,1s i 10 razy liczymy energiê i przejœcia przez 0
    i = 1;
    for ramka=0:9
        [Syg_tla,Fp] = wavread(file_path,[ramka*szerokosc_tla+1 (ramka+1)*szerokosc_tla]);
        Syg_tla = Syg_tla(:,1);
        energia_ramki(i) = sum(Syg_tla.^2);
        ZCA_ramki(i) = ZCA(Syg_tla); %Zero-Cross Analysis - analiza przejsc przez 0
        i = i+1;
    end
    energia_tla_avg = sum(energia_ramki)/10;
    energia_tla_max = max(energia_ramki);
    ZCA_tla = sum(ZCA_ramki(1:9))/9;
    I1 = 0.03*(energia_tla_max - energia_tla_avg) + energia_tla_max;
    I2 = 4*energia_tla_avg;
    dolny_prog_energ = min(I1,I2);
    gorny_prog_energ = 15*dolny_prog_energ;
    ZCA_odchyl_stand = std(ZCA_ramki);
    prog_ZCA = min(25,ZCA_tla+2*ZCA_odchyl_stand);
%     prog_ZCA = min(median(ZCA_ramki),ZCA_tla);
end

