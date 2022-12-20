clear all;
close all; 
clc;

warning('off','all');

kume = uint8(input('Küme sayýsýný giriniz: '));
iRGB = double(imread('peppers.png'));

tic

%Resmi HSL uzayýna dönüþtür
iHSL = rgb2hsl(iRGB/255);

%Resmin boyutlarýný bul
[satir sutun renkDerinligi ] = size(iHSL);

%resim üzerinde kume merkez koordinatlarýný rastgele belirle
merkezler = [randi(satir, kume,1) randi(sutun, kume,1)];

%Resimdeki her bir pikselin küme numarasýný tutacak resim 
% boyunda bir matris oluþtur
etiketler = zeros(satir, sutun);

%Resimdeki güncel etiketler ile önceki adýmdaki etiketleri kýyaslamak 
% üzere ikinci bir matris daha oluþtur
etiketler_onceki = ones(satir, sutun);

%Mesafeleri kaydetmek için küme sayýsý uzunluðunda bir vektör oluþtur.
mesafe = zeros( 1, kume );

%
kmerkez = zeros(kume, 3);

for k=1:kume
    kmerkez(k,:) = iHSL(merkezler(k,1),merkezler(k,2),:);
end
 
 
while (true)
    
    disp('.');
    
    etiketler_onceki = etiketler;
    
    % her bir pikselin her bir merkezle olan mesafelerini hesapla
    for sa = 1:satir
        for su = 1:sutun 
            for k = 1:kume
                 mesafe(k) = sqrt((iHSL(sa,su,1) - kmerkez(k,1))^2 +...
                                  (iHSL(sa,su,2) - kmerkez(k,2))^2 +...
                                  (iHSL(sa,su,3) - kmerkez(k,3))^2);
            end
            
            %Ýlgili noktaya en yakýn küme merkezini bul
            r = find(mesafe(:) == min(mesafe));
            
            %Ýlgili noktayý en yakýn küme merkezine dahil et
            etiketler(sa,su) = r(1);
        end
    end
    
    H = zeros(1,kume);
    S = zeros(1,kume);
    L = zeros(1,kume);
    Say = zeros(1,kume);

    % Yeni merkez noktalarýný belirle
    for sa = 1:satir
        for su = 1:sutun
            H( etiketler(sa,su) ) = H( etiketler(sa,su) ) + iHSL(sa,su,1);
            S( etiketler(sa,su) ) = S( etiketler(sa,su) ) + iHSL(sa,su,2);
            L( etiketler(sa,su) ) = L( etiketler(sa,su) ) + iHSL(sa,su,3);
            Say( etiketler(sa,su) ) = Say( etiketler(sa,su) ) + 1;
        end
    end

    %Her bir kümenin aðýrlýk merkezini yeniden hesapla    
    for k = 1:kume 
        kmerkez(k,1) = H(k) / Say(k);
        kmerkez(k,2) = S(k) / Say(k);
        kmerkez(k,3) = L(k) / Say(k);

    end
    
    %Bütün etiketlenmiþ veriler önceki etiketlerle ayný ise döngüden çýk.
    if isequal(etiketler_onceki, etiketler)
        break;
    end
end

%Her bir pikselin renk deðerini küme merkezine eþitle
for sa = 1:satir
    for su = 1:sutun

        iHSL(sa,su,1) = kmerkez(etiketler(sa,su), 1);
        iHSL(sa,su,2) = kmerkez(etiketler(sa,su), 2);
        iHSL(sa,su,3) = kmerkez(etiketler(sa,su), 3);

    end
end

sonuc = hsl2rgb(iHSL)*255;

toc

figure(1);

subplot(1,2,1);
imshow(uint8(iRGB));
subplot(1,2,2);
imshow(uint8(sonuc));



 

