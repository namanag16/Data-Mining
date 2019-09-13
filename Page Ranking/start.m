%% input parameters 
n = 200; % this is the number of web pages 
k = 15; % number of clusters to be formed of web pages 
query = {'abcd';'ljdjdp';'sdfcxow';'ndkkuai'};



%% Generate a random matrix of size nxn representing links between web pages 
SET = [0,1];
NSET = length(SET) ;

A = zeros([n n]);
for x = 1:n
    i = ceil(NSET*rand(1,n)) ; % with repeat
    A(x,:) = (SET(i));
end 
A;
% clearvars SET NSET i;

%% Generate contents of web pages 
SET = char(['a':'z' '0':'9' ' ']) ;
NSET = length(SET) ;
len = 100 ; % each web page has content of this length 

R = zeros([n len]);
for x = 1:n
    i = ceil(NSET*rand(1,len)) ; % with repeat
    R(x,:) = (SET(i));
end 
R = char(R);

%% calculate distance of each node(webpage) from keywords 

minarr = zeros([size(R,1) size(query,1)]);
for i = 1:size(R,1)
    doc_vec = strsplit(R(i,:));
    for j = 1:size(query,1)
        clearvars dist
        dist = zeros([size(doc_vec,2) 1]);
        for y = 1:size(doc_vec,2)
           dist(y,:) = EditDistance(char(doc_vec(:,y)),char(query(j,:)));
           
        end
        minarr(i,j) = min(dist);
    end
end

% now the minimum distance with the node 
for i=1:size(minarr,1)
    final(i,:) = rms(minarr(i,:));
end

%% cluster the nodes with k means
clusters = kmeans(final,k);

% ind = {}
for i= 1:k
   x = find(clusters == i);
   ind{i,1} = x;
end

%% create a new weighted matrix for page ranking 
A_clustered = zeros([k k]);
A_clustered_Nor = zeros([k k]);
for i =1:k
   for j = 1:k
      if (j==i)
          continue
      end
      submatrix = A(ind{i,1},ind{j,1});
      A_clustered(i,j) = sum(sum(submatrix)); 
   end    
   A_clustered_Nor(i,:) = A_clustered(i,:)/sum(A_clustered(i,:));
end

%% Apply page rank to the normalized weighted clustered matrix 

A_random_Nor(1:k,1:k) = 1/k;
alpha = 0.8; 
A_final = alpha*A_clustered_Nor + (1-alpha)*A_random_Nor;


[V,D] = eig(A_final');
lambda = max(diag(D))
x = find(diag(D) == max(diag(D)));

V(:,x) 
if (V(1:x) < 0)
    V(:,x) = - V(:,x)
end

[Y,I] = sort(V(:,x),'descend'); % for negative entries what to do 
I

