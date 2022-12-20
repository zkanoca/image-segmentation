function [ortanoktalar,maske]=ozkmeans(imge,kume)

    % Resmin bir kopyasýný al
    kopya = imge;      
    
    % Resmi sütun vektöre dönüþtür
    imge = imge(:);
    
    % Resimdeki negatif ve 0 olan deðerleri pozitif yap
    mi = min(imge);
    imge = imge - mi + 1;

    % resmin sütun sayýsýný bul
    s = length(imge);

    % Resmin histogramýný bul
    m = max(imge) + 1;
    
    h = zeros(1,m);
    
    hc = zeros(1,m);

    for i = 1:s
      if(imge(i) > 0) 
          h(imge(i)) = h(imge(i)) + 1;
      end
    end
    
    % Histogramda 0 olmayan hücreleri bul
    ind = find(h);
    
    % 0 olmayan hücrelerin sayýsýný bul
    hl = length(ind);

    % Orta noktalarý belirle
    ortanoktalar = (1:kume) .* m / (kume + 1);

    % Ýþleme baþla
    while(true)

        % Eski orta noktalarý kaydet
        eskion = ortanoktalar;

        % Orta noktalarý güncelle
        for i = 1:hl
            c = abs(ind(i) - ortanoktalar);
            cc = find(c == min(c));
            hc(ind(i)) = cc(1);
        end

        % Ortalamalarý tekrar hesapla  
        for i=1:kume
            a = find( hc == i );
            ortanoktalar(i) = sum( a .* h(a)) / sum(h(a));
        end

        % Eðer güncel küme merkezleri ile önceki küme merkezleri aynýysa 
        % iþlemi durdur
        if(ortanoktalar == eskion)
            break
        end
    end

    % Maskeyi hesapla
    s = size(kopya);
    maske = zeros(s);

    for i = 1:s(1)
        for j = 1:s(2)
            c = abs(kopya(i,j) - ortanoktalar);
            a = find(c == min(c));  
            maske(i,j) = a(1);
        end
    end
    
    % Recover real range
    ortanoktalar = ortanoktalar + mi - 1;   