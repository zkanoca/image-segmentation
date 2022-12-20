X = [rand(222,2) + 3  *  ones(222,2); rand(222,2) - 2 * ones(222,2)];

opts = statset('maxiter',1);

C = X(1:2,:);

plot(X(:,1), X(:,2), 'k.', 'MarkerSize', 12);

hold on;

plot(C(:,1), C(:,2), 'kx', 'MarkerSize', 12, 'LineWidth', 2);
 
for i=1:15
    pause(1);
    
    hold off;
    
    [idx,C] = kmeans(X,2,'Options',opts,'start',C);
    
    plot(X(idx==1,1), X(idx==1,2), 'r.', 'MarkerSize', 12);
    
    hold on;
    
    plot(X(idx==2,1), X(idx==2,2), 'b.', 'MarkerSize', 12);
    
    plot(C(:,1), C(:,2), 'kx', 'MarkerSize', 12, 'LineWidth', 2);
    
    axis([-1.1 2.1 -1.1 2.1]);
    
    legend('Cluster 1', 'Cluster 2', 'Centroids', 'Location', 'NW');
    
end