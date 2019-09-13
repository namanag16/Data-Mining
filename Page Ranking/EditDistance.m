function [distance,table] = EditDistance(str1,str2)

m=length(str1);
n=length(str2);
table=zeros(m+1,n+1);
for i=1:1:m
    table(i+1,1)=i;
end
for j=1:1:n
    table(1,j+1)=j;
end
for i=1:m
    for j=1:n
        if (str1(i) == str2(j))
            table(i+1,j+1)=table(i,j);
        else
            table(i+1,j+1)=1+min(min(table(i+1,j),table(i,j+1)),table(i,j));
        end
    end
end
distance=table(m+1,n+1);
end