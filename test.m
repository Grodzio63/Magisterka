clear all; clc;
disp('Wczytywanie danych');
file_path = 'œmieci\Dawid-Durlak.wav';
size1 = wavread(file_path,'size')
[x,Fp]=wavread(file_path);
[Syg,Fp] = wavread(file_path,[1, 1]);
i=0;
poczatek=i*0.01*Fp +1;
koniec = (i+1)*0.01*Fp;
size2=0;
Syg2=[];
while koniec<size1(1)
    Syg =wavread(file_path,[poczatek,koniec]);
    poczatek= floor(i*0.01*Fp +1);
    koniec = floor((i+1)*0.01*Fp);
    Syg2 = [Syg2, Syg'];
    i = i+1;
end

plik = 'C:\Documents and Settings\Dawid\Pulpit\magisteka\kod\œmieci\test.wav';
wavwrite(Syg2,Fp,plik);