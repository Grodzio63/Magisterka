function [ slowa ] = dzielenie_slow(Syg, dolny_prog_energ, gorny_prog_energ, prog_ZCA, Fp)
%funkcja zwraca macierz slow wydzielonych z sygnalu
    i=1;
    width = 0.01*Fp; % czas g³oski 10ms
    liczba_slow = 0;
    nowe_slowo = false;
	n=length(Syg);
    poprzedni_fonem = 0;
    energia_poprzedniego_fonemu = 0;
    slowa =[];
    p=1;
    slowo = [];
    dodatkowy_fonem = [];
    pokaz_ramke = false;
    okno = 1;
    pierwszy_fonem = false;
    while okno<n-width
        fonem = Syg(okno:okno+width-1);
        energia_fonemu = sum(fonem.^2);
        energia_syg(p) = sum(fonem.^2); % zmienne do wyœwietlania wykresu
        p =p+1; 
        if energia_fonemu < dolny_prog_energ && nowe_slowo == false %szum
            slowo=[];
            nowe_slowo = false;
            pierwszy_fonem = false;

        elseif energia_fonemu > dolny_prog_energ && energia_fonemu < gorny_prog_energ && pierwszy_fonem == true % kandydat na slowo
            slowo = [slowo fonem];

        elseif energia_fonemu > dolny_prog_energ && energia_fonemu < gorny_prog_energ && pierwszy_fonem == false% kandydat na pierwszy fonem
            pierwszy_fonem = true;
            dodatkowy_fonem = [];
            
            if okno-width*25<1
                poczatek = 1+width;
            else
                poczatek = okno-width*24;
            end
            for drugie_okno = okno:-width:poczatek
                ZCA_ramki = ZCA(Syg(drugie_okno-width:drugie_okno));
                if ZCA_ramki > prog_ZCA
                    dodatkowy_fonem = [Syg(drugie_okno-width:drugie_okno) dodatkowy_fonem];
                else
                    break
                end
            end
            slowo = [dodatkowy_fonem fonem]; 

        elseif energia_fonemu > gorny_prog_energ % slowo
            slowo = [slowo fonem];
            nowe_slowo = true;

        elseif energia_fonemu < dolny_prog_energ && nowe_slowo == true %koniec s³owa
            dodatkowy_fonem = [];
            if okno+width*25>n-width
                koniec = n-width;
            else
                koniec = okno+width*25;
            end
            for drugie_okno = okno:width:koniec
                ZCA_ramki = ZCA(Syg(drugie_okno:drugie_okno+width));
                if ZCA_ramki > prog_ZCA
                    dodatkowy_fonem = [dodatkowy_fonem Syg(drugie_okno:drugie_okno+width)];
                else
                    break
                end
            end
            liczba_slow = liczba_slow+1; 
            dodatek(liczba_slow,:) = zeros(1,100*width);
            dlugosc_dodatku = length(dodatkowy_fonem);
            dodatek(liczba_slow,1:dlugosc_dodatku) = dodatkowy_fonem;

            slowo = [slowo dodatkowy_fonem];       
            slowa(liczba_slow,:) = zeros(1,1000*width);
            dlugosc_dlugosc_slowa = length(slowo);
            slowa(liczba_slow,1:dlugosc_dlugosc_slowa) = slowo;
            nowe_slowo = false;
            slowo =[];
            okno = drugie_okno;
            nowe_slowo = false;
            pierwszy_fonem = false;
        end
        okno = okno+width;   
    end

    ne = length(energia_syg);
    t = 0:ne-1;
    figure(1)
    hold on
    plot(energia_syg)
    plot(dolny_prog_energ*ones(1,ne),'r')
    plot(gorny_prog_energ*ones(1,ne),'g')
    hold off   


end

