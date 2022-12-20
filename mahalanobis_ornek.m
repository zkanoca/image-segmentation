clc,clear
A = [0.7 -0.3; 0.3 0.7] * [5 0; 0 2]; % �l�ekleme ve d�nd�rme 
% A = [4 -0.2;2 0.7]; % Ba�ka bir d�n���m 
xRef= [2 -1]'; % Uzakl�k i�in referans nokta. Merkez i�in [0 0]' yap�n

N = 100; % Nokta say�s�
X = A*randn(2,N); 
% A ile d�n��t�r�lm�� (yakla��k) birim �ember i�indeki rastgele noktalar

C = cov(X'); % Kovaryans (de�i�inti) matrisi
pinvC = pinv(C); % ve tersi (d�ng�de tekrar tekrar hesaplamamak i�in)

d = zeros(1,N); % Uzakl�klar
for i = 1:N
    d(i) = sqrt((X(:,i)-xRef)' * pinvC * (X(:,i)-xRef));
end

idx = abs(d-1.0) < 0.05; 
% Referans ile uzakl��� yakla��k 1.0 olan noktalar�n indisleri
% Buradaki 1.0 birimi, iki noktan�n do�rultusundaki standart sapma
%  cinsindendir.

% T�m noktalar� siyah �iz, 1.0 uzakl���ndakileri k�rm�z� �iz
plot(X(1,:), X(2,:), 'k.')
hold on
plot(X(1,idx), X(2,idx), 'r.')
plot(xRef(1), xRef(2), 'ro')
hold off
axis equal tight
