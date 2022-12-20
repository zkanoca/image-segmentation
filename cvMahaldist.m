function d = cvMahaldist(X, Y)
% cvMahaldist - Mahalanobis distance
%
% Synopsis
% [d] = cvMahaldist(X, Y)
%
% Description
% Compute mahalanobis distance between X and Y.
%
% Inputs ([]s are optional)
% (matrix) X D x N matrix where D is the dimension of vectors
% and N is the number of vectors.
% (matrix) Y D x P matrix where D is the dimension of vectors
% and P is the number of vectors.
%
% Outputs ([]s are optional)
% (matrix) d N x P matrix where d(n,p) represents the mahalanobis
% distance between X(:,n) and Y(:,p).
%
% Examples
% X = [1 2
% 1 2];
% Y = [1 2 3
% 1 2 3];
% d = cvMahaldist(X, Y)
%

[D N] = size(X);
[D P] = size(Y);
A = [X Y];
invcov = inv(cov(A'));
for i=1:N
    diff = repmat(X(:,i), 1, P) - Y;
    dsq(i,:) = sum((invcov*diff).*diff , 1);
end
d = sqrt(dsq);

end