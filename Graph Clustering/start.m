%% Input Graph properties
N=2500;
k=3;

%% Generate Graph
% a=0;
% b=2;
% d = (b-a)*rand(N,1) + a;
% d = rand(N,1); % The diagonal values
% t = triu(bsxfun(@min,d,d.').*rand(N),1); % The upper trianglar random values
% M = diag(d)+t+t.'; % Put them together in a symmetric matrix
% M(find(M >= 1.5)) = 0;
% M = round(M);
% A = (M - diag(diag(M)));

% M = floor(rand(N,N)*2); %generate graph
% M = M - diag(diag(M)); % make all diagonal elemnets 0
% M = floor((M + M')/2);

M = [0 0 0 1 1 0;
    0 0 0 0 1 1;
    0 0 0 0 0 1;
    1 0 0 0 1 0;
    1 1 0 1 0 0;
    0 1 1 0 0 0];

% M = [0 1 0 1 0 1 0;
%     1 0 1 1 0 0 0;
%     0 1 0 1 0 0 1;
%     1 1 1 0 1 0 0;
%     0 0 0 1 0 1 1;
%     1 0 0 0 1 0 1;
%     0 0 1 0 1 1 0];

[Cl,time] = clusterify(M,k,'r');

for i = 1:k 
    (find(Cl == i))
    pause;
end