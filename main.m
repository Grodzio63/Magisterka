clear all; clc;
disp('Wczytywanie danych');
file_path = 'Dawid-Durlak.wav';
[x,Fp,bits] = wavread(file_path);
% meski = true ;
% Syg=x(:,1)';
% n= length(x);
% m = 0:n-1;
% f = Fp*m/n;
%Syg = Syg(0.1*n:0.9*n);
% n = length(Syg);
% disp('Filtrowanie danych');
% Syg = filtracja(Syg,Fp,meski);
disp('Preemfaza');
% Syg = preemfaza(Syg);
disp('Tlo');
[dolny_prog_energ, gorny_prog_energ, prog_ZCA] = szum_tla(file_path);
% n = length(Syg);

disp('Krecimy kola');
slowa = dzielenie_slow_test2(file_path,dolny_prog_energ, gorny_prog_energ, prog_ZCA);


  
[d f] = size(slowa);
for i = 1:d
    %figure(i);
    %plot(slowa(i,:));
    s = slowa(i,:);
    s = s(find(s));
    plik = ['C:\Documents and Settings\Dawid\Pulpit\magisteka\kod\œmieci\' 'slowa' num2str(i) '.wav'];
    wavwrite(s,Fp,plik);
end
% wavwrite(Syg,Fp,'C:\Documents and Settings\Dawid\Pulpit\magisteka\kod\œmieci\Dawid-Durlak.wav');


        



 