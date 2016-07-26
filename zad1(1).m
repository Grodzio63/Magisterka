clear all; clc;

osoby = {'D_Durlak','M_Gawlik','D_Gorecki'}; % nawiasy {} bo string
liczba_osob = length(osoby);
gloski ={'aaa_', 'eee_', 'iii_', 'uuu_'};
%wspolczynnik_jitter(liczba_osob,4,3)=zeros();
nr_osoby=1;
for osoba = osoby
    nr_gloski=1;
    for gloska = gloski
        for proba =1:3
            file_path = (strcat(osoba, '/', gloska, int2str(proba), '.wav')); %tworzenie sciezki do pliku
            file_path = file_path{1}; %znowu macierz stringow (z jednym elementem)
            wspolczynnik_jittera_zdrowy(nr_osoby,nr_gloski,proba) = Jitt(file_path);   
            wspolczynnik_shimmera_zdrowy(nr_osoby,nr_gloski,proba) = Shim(file_path);
            macierz_F0_zdrowy(nr_osoby,nr_gloski,proba) = F0(file_path);
        end
        nr_gloski=nr_gloski+1;
    end
    nr_osoby = nr_osoby+1;
end


osoby = {'m_rak_1','m_rak_2','m_rak_3','m_polip_1','m_polip_2','m_guz_1','m_zmiany_1', 'm_zapalenie_1', 'm_zapalenie_2'}; % nawiasy {} bo string
liczba_osob = length(osoby);
gloski ={'aaa_', 'eee_', 'iii_', 'uuu_'};
%wspolczynnik_jitter(liczba_osob,4,3)=zeros();
nr_osoby=1;
for osoba = osoby
    nr_gloski=1;
    for gloska = gloski
        for proba =1:3
            file_path = (strcat(osoba, '/', gloska, int2str(proba), '.wav')); %tworzenie sciezki do pliku
            file_path = file_path{1}; %znowu macierz stringow (z jednym elementem)
            wspolczynnik_jittera_chory(nr_osoby,nr_gloski,proba) = Jitt(file_path);   
            wspolczynnik_shimmera_chory(nr_osoby,nr_gloski,proba) = Shim(file_path);
            macierz_F0_chory(nr_osoby,nr_gloski,proba) = F0(file_path);
        end
        nr_gloski=nr_gloski+1;
    end
    nr_osoby = nr_osoby+1;
end



% ladne wyswietlenie wynikow
% [x,y,z] = size(wspolczynnik_jittera);
% for i=1:x
%     for j=1:y
%         disp(['Dla',' ',osoby{i},':']); %latwiej sie tworzy string jak strcat()
%         if j == 1
%         disp('dla aaa:');
%         end
%         if j == 2
%         disp('dla eee:');
%         end 
%         if j == 3
%         disp('dla iii:');
%         end
%         if j == 4
%         disp('dla uuu:');
%         end
%         disp('sredni wspolczynnik Jittera:');
%         disp(mean(wspolczynnik_jittera(i,j)));
%         disp('sredni wspolczynnik Shimmera:');
%         disp(mean(wspolczynnik_shimmera(i,j)));
%         disp('srednie F0:');
%         disp(mean(macierz_F0(i,j)));
%     end
% end


% obliczanie dla wiekszej ilosci osob


% disp('dla aaa:');
% disp('sredni wspolczynnik Jittera:');
% disp(mean(mean(wspolczynnik_jittera(:,1,:))));
% disp('sredni wspolczynnik Shimmera:');
% disp(mean(mean(wspolczynnik_shimmera(:,1,:))));
% disp('srednie F0:');
% disp(mean(mean(macierz_F0(:,1,:))));
% 
% disp('dla eee:');
% disp('sredni wspolczynnik Jittera:');
% disp(mean(mean(wspolczynnik_jittera(:,2,:))));
% disp('sredni wspolczynnik Shimmera:');
% disp(mean(mean(wspolczynnik_shimmera(:,2,:))));
% disp('srednie F0:');
% disp(mean(mean(macierz_F0(:,2,:))));
% 
% disp('dla iii:');
% disp('sredni wspolczynnik Jittera:');
% disp(mean(mean(wspolczynnik_jittera(:,3,:))));
% disp('sredni wspolczynnik Shimmera:');
% disp(mean(mean(wspolczynnik_shimmera(:,3,:))));
% disp('srednie F0:');
% disp(mean(mean(macierz_F0(:,3,:))));
% 
% disp('dla uuu:');
% disp('sredni wspolczynnik Jittera:');
% disp(mean(mean(wspolczynnik_jittera(:,4,:))));
% disp('sredni wspolczynnik Shimmera:');
% disp(mean(mean(wspolczynnik_shimmera(:,4,:))));
% disp('srednie F0:');
% disp(mean(mean(macierz_F0(:,4,:))));


% rysowanie wykresow
figure(1)
plot(reshape(wspolczynnik_jittera_zdrowy,1,[]),reshape(wspolczynnik_shimmera_zdrowy,1,[]), '*');
title('Sygna³ EEG')
xlabel('Jitt')
ylabel('Schim')
hold on
plot(reshape(wspolczynnik_jittera_chory,1,[]),reshape(wspolczynnik_shimmera_chory,1,[]), 'r*');
hold off


figure(2)
title('Sygna³ EEG')
plot3(reshape(wspolczynnik_jittera_zdrowy,1,[]),reshape(wspolczynnik_shimmera_zdrowy,1,[]),reshape(macierz_F0_zdrowy,1,[]), '*');
hold on
plot3(reshape(wspolczynnik_jittera_chory,1,[]),reshape(wspolczynnik_shimmera_chory,1,[]),reshape(macierz_F0_chory,1,[]), 'r*');
hold off
xlabel('Jitt')
ylabel('Schim')
zlabel('F0')