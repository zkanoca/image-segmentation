 clc;
clear all;

 
kume = uint8(input('Küme sayýsýný giriniz: '));
iRGB = double(imread('Bird.png'));

tic

%0 - 255 aralýðýndaki RGB resmi 0-1 deðer aralýðýna indirgedikten sonra 
%rgb2hsl fonksyionuna göndererek resim uzayýný HSL'ye dönüþtür.
iHSL = rgb2hsl(iRGB / 255);

% HSL uzayýndaki resmin L boyutunu 0 - 255 deðer aralýðýna dönüþtürerek
% kmeans algoritmasýna göndermek üzere hazýrla
luminance = iHSL(:,:,3) * 255;

[satir sutun] = size(luminance);
etiketler = zeros(satir, sutun);
% enYakin = ones(satir, sutun) * 256;
% farklar = ones(kume,1) * 256;

%Resim üzerinde rastgele kume merkezleri belirle
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
