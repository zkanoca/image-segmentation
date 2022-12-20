function [ortanoktalar,maske]=ozkmeans(imge,kume)

    % Resmin bir kopyas�n� al
    kopya = imge;      
    
    % Resmi s�tun vekt�re d�n��t�r
    imge = imge(:);
    
    % Resimdeki negatif ve 0 olan de�erleri pozitif yap
    mi = min(imge);
    imge = imge - mi + 1;

    % resmin s�tun say�s�n� bul
    s = length(imge);

    % Resmin histogram�n� bul
    m = max(imge) + 1;
    
    h = zeros(1,m);
    
    hc = zeros(1,m);

    for i = 1:s
      if(imge(i) > 0) 
          h(imge(i)) = h(imge(i)) + 1;
      end
    end
    
    % Histogramda 0 olmayan h�creleri bul
    ind = find(h);
    
    % 0 olmayan h�crelerin say�s�n� bul
    hl = length(ind);

    % Orta noktalar� belirle
    ortanoktalar = (1:kume) .* m / (kume + 1);

    % ��leme ba�la
    while(true)

        % Eski orta noktalar� kaydet
        eskion = ortanoktalar;

        % Orta noktalar� g�ncelle
        for i = 1:hl
            c = abs(ind(i) - ortanoktalar);
            cc = find(c == min(c));
            hc(ind(i)) = cc(1);
        end

        % Ortalamalar� tekrar hesapla  
        for i=1:kume
            a = find( hc == i );
            ortanoktalar(i) = sum( a .* h(a)) / sum(h(a));
        end

        % E�er g�ncel k�me merkezleri ile �nceki k�me merkezleri ayn�ysa 
        % i�lemi durdur
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