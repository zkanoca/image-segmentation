clc;
clear all;

 
kume = input('Küme sayýsýný giriniz: ');
RGB = double(imread('Bird.png'));
m = zeros(kume,2);
kcenter = zeros(kume, 3);

tic

[satir sutun renk] = size(RGB);

map=zeros(satir,sutun);

pk_uzun = zeros(1, kume);

for i=1:kume
    m(i,:) = [randi([1,240]) randi([1,320])];    
    kcenter(i,:) = RGB(m(i),m(i,2),:);
end
 
for i=1:satir
    for j=1:sutun 
        for o=1:kume
            pk_uzun(o) = sqrt(((RGB(i,j,1) - kcenter(o,1))^2 + ...
                               (RGB(i,j,2) - kcenter(o,2))^2 + ...
                               (RGB(i,j,3) - kcenter(o,3))^2));
        end
        r = find(pk_uzun(:) == min(pk_uzun));
        map(i,j) = r(1);    
    end
end
red = zeros(1,kume);
green = zeros(1,kume);
blue = zeros( 1,kume );
counter = zeros(1,kume);

for i=1:satir
    for j=1:sutun
        red( map(i,j) ) = red( map(i,j) ) + RGB(i,j,1);
        green( map(i,j) ) = green( map(i,j) ) + RGB(i,j,2);
        blue( map(i,j) ) = blue( map(i,j) ) + RGB(i,j,3);
        counter( map(i,j) ) = counter( map(i,j) ) + 1;
    end
end

for p=1:kume
    kcenter(p,1) = red( p ) / counter( p );
    kcenter(p,2) = green( p ) / counter( p );
    kcenter(p,3) = blue( p ) / counter( p );
end
 

for i=1:satir
    for j=1:sutun
        RGB( i,j,1 ) = kcenter( map(i,j), 1  );
        RGB( i,j,2 ) = kcenter( map(i,j), 2  );
        RGB( i,j,3 ) = kcenter( map(i,j), 3  );
    end
end
toc
subplot(1,2,1);
imshow('Bird.png');
subplot(1,2,2);
imshow(uint8(RGB));