clc,clear
A = [0.7 -0.3; 0.3 0.7] * [5 0; 0 2]; % Ölçekleme ve döndürme 
% A = [4 -0.2;2 0.7]; % Baþka bir dönüþüm 
xRef= [2 -1]'; % Uzaklýk için referans nokta. Merkez için [0 0]' yapýn

N = 100; % Nokta sayýsý
X = A*randn(2,N); 
% A ile dönüþtürülmüþ (yaklaþýk) birim çember içindeki rastgele noktalar

C = cov(X'); % Kovaryans (deðiþinti) matrisi
pinvC = pinv(C); % ve tersi (döngüde tekrar tekrar hesaplamamak için)

d = zeros(1,N); % Uzaklýklar
for i = 1:N
    d(i) = sqrt((X(:,i)-xRef)' * pinvC * (X(:,i)-xRef));
end

idx = abs(d-1.0) < 0.05; 
% Referans ile uzaklýðý yaklaþýk 1.0 olan noktalarýn indisleri
% Buradaki 1.0 birimi, iki noktanýn doðrultusundaki standart sapma
%  cinsindendir.

% Tüm noktalarý siyah çiz, 1.0 uzaklýðýndakileri kýrmýzý çiz
plot(X(1,:), X(2,:), 'k.')
hold on
plot(X(1,idx), X(2,idx), 'r.')
plot(xRef(1), xRef(2), 'ro')
hold off
axis equal tight
