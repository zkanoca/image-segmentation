 clc;
clear all;

 
kume = uint8(input('Küme sayýsýný giriniz: '));
iRGB = double(imread('Bird.png'));

tic

% 0 - 255 aralýðýndaki RGB resmi 0-1 deðer aralýðýna indirgedikten sonra 
% rgb2hsl fonksyionuna göndererek resim uzayýný HSL'ye dönüþtür ve tekrar
% 0 - 255 deðer aralýðýna getir
iHSL = uint8(rgb2hsl(iRGB / 255) * 255);

 

[satir sutun] = size(iHSL(:,:,3));
etiketler = zeros(satir, sutun);
% enYakin = ones(satir, sutun) * 256;
% farklar = ones(kume,1) * 256;

%Resim üzerinde rastgele kume merkezleri belirle
noktalar = [randi(satir, kume,1) randi(sutun, kume,1)];

eskiNoktalar = zeros(kume,2);


% while (true)
    % Deðiþim olup olmadýðýný anlamak için önceki adýmdaki orta noktalarý
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
    
    % Önceki iterasyon ile þu anki iterasyonda orta noktalar deðiþmediyse
    % while döngüsünü bitir.
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
