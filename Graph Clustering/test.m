A = [0 0 0 1 1 0;
    0 0 0 0 1 1;
    0 0 0 0 0 1;
    1 0 0 0 1 0;
    1 1 0 1 0 0;
    0 1 1 0 0 0];

k = 3;
technique = 'r';
tic;
degs = sum(A,2);
deg_sqrt = sqrt(degs);
del = diag(degs);
L = (del - A);

if (technique == 'r')
    [V,D] = eig(L);
end
if (technique == 'n')
    tic
    toc
    del_pos = diag(deg_sqrt);
    del_neg = diag(1./deg_sqrt);
    Ls = del_neg * L * del_neg;
    La = (diag(1./degs)) * L;
    [V,D] = eig(La);
end
    
k_vecs = V(:,1:k);
% calculate the normalization factor
n_factor = 1./(sqrt((diag(k_vecs*k_vecs')))); 
y = (diag(n_factor))*k_vecs;
C = kmeans(y,k)
timex = toc;