clear all;
close all; 
clc;

warning('off','all');

kume = uint8(input('K�me say�s�n� giriniz: '));
iRGB = double(imread('peppers.png'));

tic

%Resmi HSL uzay�na d�n��t�r
iHSL = rgb2hsl(iRGB/255);

%Resmin boyutlar�n� bul
[satir sutun renkDerinligi ] = size(iHSL);

%resim �zerinde kume merkez koordinatlar�n� rastgele belirle
merkezler = [randi(satir, kume,1) randi(sutun, kume,1)];

%Resimdeki her bir pikselin k�me numaras�n� tutacak resim 
% boyunda bir matris olu�tur
etiketler = zeros(satir, sutun);

%Resimdeki g�ncel etiketler ile �nceki ad�mdaki etiketleri k�yaslamak 
% �zere ikinci bir matris daha olu�tur
etiketler_onceki = ones(satir, sutun);

%Mesafeleri kaydetmek i�in k�me say�s� uzunlu�unda bir vekt�r olu�tur.
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
            
            %�lgili noktaya en yak�n k�me merkezini bul
            r = find(mesafe(:) == min(mesafe));
            
            %�lgili noktay� en yak�n k�me merkezine dahil et
            etiketler(sa,su) = r(1);
        end
    end
    
    H = zeros(1,kume);
    S = zeros(1,kume);
    L = zeros(1,kume);
    Say = zeros(1,kume);

    % Yeni merkez noktalar�n� belirle
    for sa = 1:satir
        for su = 1:sutun
            H( etiketler(sa,su) ) = H( etiketler(sa,su) ) + iHSL(sa,su,1);
            S( etiketler(sa,su) ) = S( etiketler(sa,su) ) + iHSL(sa,su,2);
            L( etiketler(sa,su) ) = L( etiketler(sa,su) ) + iHSL(sa,su,3);
            Say( etiketler(sa,su) ) = Say( etiketler(sa,su) ) + 1;
        end
    end

    %Her bir k�menin a��rl�k merkezini yeniden hesapla    
    for k = 1:kume 
        kmerkez(k,1) = H(k) / Say(k);
        kmerkez(k,2) = S(k) / Say(k);
        kmerkez(k,3) = L(k) / Say(k);

    end
    
    %B�t�n etiketlenmi� veriler �nceki etiketlerle ayn� ise d�ng�den ��k.
    if isequal(etiketler_onceki, etiketler)
        break;
    end
end

%Her bir pikselin renk de�erini k�me merkezine e�itle
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



 

