 clc;
clear all;

 
kume = uint8(input('K�me say�s�n� giriniz: '));
iRGB = double(imread('Bird.png'));

tic

%0 - 255 aral���ndaki RGB resmi 0-1 de�er aral���na indirgedikten sonra 
%rgb2hsl fonksyionuna g�ndererek resim uzay�n� HSL'ye d�n��t�r.
iHSL = rgb2hsl(iRGB / 255);

% HSL uzay�ndaki resmin L boyutunu 0 - 255 de�er aral���na d�n��t�rerek
% kmeans algoritmas�na g�ndermek �zere haz�rla
luminance = iHSL(:,:,3) * 255;

[satir sutun] = size(luminance);
etiketler = zeros(satir, sutun);
% enYakin = ones(satir, sutun) * 256;
% farklar = ones(kume,1) * 256;

%Resim �zerinde rastgele kume merkezleri belirle
noktalar = [randi(satir, kume,1) randi(sutun, kume,1)];

eskiNoktalar = zeros(kume,2);

%%
 [idx maske] = ozkmeans(uint8(luminance), kume);
%%


toc

 subplot(1,3,1); 
 imshow('Bird.png');
 
 subplot(1,3,2);
 imshow(uint8(luminance));
 
  subplot(1,3,3);
 imshow(uint8(maske));
