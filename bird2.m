 clc;
clear all;

 
kume = input('K�me say�s�n� giriniz: ');
iRGB = double(imread('Bird.png'));

tic
r = iRGB(:,:,1);
g = iRGB(:,:,2);
b = iRGB(:,:,3);


luminance = (0.299 * r + 0.587 * g + 0.114 * b);

[satir sutun] = size(luminance);
etiketler = zeros(satir, sutun);
enYakin = ones(satir, sutun) * 256;
farklar = ones(kume,1) * 256;

%Resim �zerinde rastgele kume merkezleri belirle
noktalar = [randi(satir, kume,1) randi(sutun, kume,1)]; 
    
for sa = 1:satir
    
    for su = 1:sutun
        
        for n = 1:kume
            
            %n'inci merkez ile s�radaki pikselin parlakl�k de�erini k�yasla
            
            r = noktalar(n,1);
            c = noktalar(n,2);
            
            %ilgili piksel daha �nceden bir k�meye dahil edilmemi� ise
            %parlakl�k de�eri en yak�n k�meye dahil et.
            if etiketler(sa, su) ~= 0
                farklar(n) = abs(luminance(sa, su) - luminance(r,c));
            end
            
            %En k���k fark�n oldu�u k�me numaras�n� bul
            [enKucukFark kumeNumarasi] = min(farklar);
            
            %ilgili pikseli ilgili kumeye dahil et.
            etiketler(sa, su) = kumeNumarasi;
        
        end
        
    end
    
end
 
 
bolutluImge = zeros(sa, su, 3); 

for sa = 1:satir
    for su = 1:sutun
        for k = 1:kume
            bolutluImge(sa, su, :) = iRGB(sa, su, :);
        end
    end
end

toc

 subplot(1,3,1); 
 imshow('Bird.png');
 
 subplot(1,3,2);
 imshow(uint8(luminance));
 
 subplot(1,3,3);
 imshow(uint8(bolutluImge));
