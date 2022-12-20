 clc;
clear all;

 
kume = uint8(input('K�me say�s�n� giriniz: '));
iRGB = double(imread('Bird.png'));

tic

% 0 - 255 aral���ndaki RGB resmi 0-1 de�er aral���na indirgedikten sonra 
% rgb2hsl fonksyionuna g�ndererek resim uzay�n� HSL'ye d�n��t�r ve tekrar
% 0 - 255 de�er aral���na getir
iHSL = uint8(rgb2hsl(iRGB / 255) * 255);

 

[satir sutun] = size(iHSL(:,:,3));
etiketler = zeros(satir, sutun);
% enYakin = ones(satir, sutun) * 256;
% farklar = ones(kume,1) * 256;

%Resim �zerinde rastgele kume merkezleri belirle
noktalar = [randi(satir, kume,1) randi(sutun, kume,1)];

eskiNoktalar = zeros(kume,2);


% while (true)
    % De�i�im olup olmad���n� anlamak i�in �nceki ad�mdaki orta noktalar�
    % kaydet
    eskiNoktalar = noktalar;
    
    for sa = 1:satir
        for su = 1:sutun
            for k = 1:kume
                 
                  enYakinKume = mahal([sa su], noktalar)
                 
                etiketler(sa, su) = kume(enYakinKume);
            end
        end
    end
    
    % �nceki iterasyon ile �u anki iterasyonda orta noktalar de�i�mediyse
    % while d�ng�s�n� bitir.
    if (isequal(eskiNoktalar,noktalar))
        break;
    end
% end



toc

 subplot(1,3,1); 
 imshow('Bird.png');
 
 subplot(1,3,2);
 imshow(uint8(luminance));
 
  subplot(1,3,3);
 imshow(maske(:,:,1));
