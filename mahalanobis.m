function d = mahalanobis(Y,X)

S = cov(X);

mu = mean(X);

d = (Y-mu) * inv(S) * (Y-mu)';
% d = ((Y-mu)/S)*(Y-mu)'; %MATLAB tavsiyesi


end

