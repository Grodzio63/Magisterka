clear all; clc;
disp('Wczytywanie danych');
file_path = 'Dawid-Durlak.wav';
size1 = wavread(file_path,'size');
[Syg,Fp] = wavread(file_path,[1, 1]);
meski = true ;
n= length(x);
f = Fp*m/n;
% disp('Filtrowanie danych');
% Syg = filtracja(Syg,Fp,meski);
disp('Preemfaza');
Syg = preemfaza(Syg);
disp('Tlo');
[dolny_prog_energ, gorny_prog_energ, prog_ZCA] = szum_tla(Syg,Fp);
n = length(Syg);
i=1;
width = 0.01*Fp; % czas g³oski 40ms
disp('Krecimy kola');
liczba_slow = 0;
nowe_slowo = true;
% dlugosc_slowa = 0;
poprzedni_fonem = 0;
energia_poprzedniego_fonemu = 0;
slowa =[];
p=1;
while okno<size
    fonem = wavread(file_path,[okno,okno+width-1]);
    energia_syg(p) = sum(fonem.^2);
    p =p+1;
    energia_fonemu = sum(fonem.^2);
    
    if energia_fonemu < dolny_prog_energ && energia_poprzedniego_fonemu < dolny_prog_energ %szum
        continue
    elseif energia_fonemu < dolny_prog_energ && energia_poprzedniego_fonemu > gorny_prog_energ %s³owo siê koñczy
        for drugie_okno = okno:width:(okno+width*5)
            ZCA_ramki = ZCA(wavread(file_path,[drugie_okno,drugie_okno+width]));
            if ZCA_ramki > prog_ZCA
                dodatkowy_fonem = [dodatkowy_fonem wavread(file_path,[drugie_okno,drugie_okno+width-1])];
            else
                break
            end
        end
        slowo = [slowo poprzedni_fonem dodatkowy_fonem];
        slowa(liczba_slow,:) = zeros(1,100*width);
        dlugosc_dlugosc_slowa = length(slowo);
        slowa(liczba_slow,1:dlugosc_dlugosc_slowa) = slowo; % zapisanie s³owa do tablicy s³ów
        okno = drugie_okno; %przesuniêcie ramki
    elseif energia_fonemu > gorny_prog_energ  && energia_poprzedniego_fonemu < dolny_prog_energ   %s³owo siê zaczyna
        if ismember(slowa,fonem)
            dips('jestem')
            continue
        end
        dodatkowy_fonem = [];
        for drugie_okno = okno:-width:(okno-width*5)
            ZCA_ramki = ZCA(wavread(file_path,[drugie_okno-width,drugie_okno]));
            if ZCA_ramki > prog_ZCA
                dodatkowy_fonem = [dodatkowy_fonem wavread(file_path,[drugie_okno-width,drugie_okno])];
            else
                break
            end
        end    
        liczba_slow = liczba_slow +1;
        slowo = [dodatkowy_fonem poprzedni_fonem fonem];
    elseif energia_fonemu > gorny_prog_energ  && energia_poprzedniego_fonemu > gorny_prog_energ %fonemy w trakcie s³owa
        slowo = [slowo fonem];
    else
        continue
    end
    poprzedni_fonem = fonem;
    energia_poprzedniego_fonemu = energia_fonemu;
    okno = okno+width;
end  
    

%     if energia_ramki < dolny_prog_energ
%         nowe_slowo = true;   
%     elseif energia_ramki > dolny_prog_energ && energia_ramki < gorny_prog_energ
%         kandydat_na_slowo = Syg_ramka;
%         if nowe_slowo == false
%             if liczba_slow == 0
%                 continue
%             end
%             slowa(liczba_slow,:) = zeros(1,100*width);
%             dlugosc_dlugosc_slowa = length(slowo);
%             slowa(liczba_slow,1:dlugosc_dlugosc_slowa) = slowo;
%         else
%             
%     else
%         if nowe_slowo
%             liczba_slow = liczba_slow +1;
%             slowo = kandydat_na_slowo;
%             nowe_slowo = false;
%         else
% %         dlugosc_slowa =length(slowo);    
%         slowo = [slowo, kandydat_na_slowo];
%         nowe_slowo = false;
%         end
%     end
% end    
[d f] = size(slowa);
for i = 1:d
    %figure(i);
    %plot(slowa(i,:));
    plik = ['C:\Documents and Settings\Dawid\Pulpit\magisteka\kod\œmieci\' 'slowa' num2str(i) '.wav'];
    wavwrite(slowa(i,:),Fp,plik);
end

ne = length(energia_syg);
t = 0:ne-1;
figure(1)
hold on
plot(energia_syg)
plot(dolny_prog_energ*ones(1,ne),'r')
plot(gorny_prog_energ*ones(1,ne),'g')
hold off   


        
%         u = Syg_po_filtracji(okno:okno+width-1);
%         z = abs(fft(u));
%         l = length(z);
%         z=z(1:l/2);
%         figure(i)
%         plot(z);
        



 