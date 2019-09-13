#*************************************************************
# Assignment 2 CSL 868
#*************************************************************


def computeSupport(sets):
    # in most cases sets ll be a list
    global data
    # print ("inside computeSupport", sets )
    count = 0
    
    if(not sets):
        return count
    
    for i in range(0,len(data)):
        high = 1
        for j in sets:
            if(data[i][j] == 0):
                high = 0
                break
        if(high == 1):
            count +=1
    # print ("before getting out: ",sets )
    return count

def extendPrefixTree(ck,k):
    # ck is list of lists, k is an integer
    # print ("inside extendPrefixTree")
    nextlist = set([])
    for xa in ck:
        sxa = set(xa)
        si = siblings(sxa,ck,k) # returns list of sibling sets 
        for each in si:
            temp = frozenset(sxa|(each - sxa)) #temp is a set
            flag = 1
            subsets = set(itertools.combinations(temp,k)) #subsets is set of all subsets of length k 
            for every in subsets: #every is a tuple 
                if(list(every) not in ck):
                    flag = 0
                    break
            if(flag ==1 ):
                nextlist.add(temp) #nextlist is a set of frozen sets but we have to return list of lists 
    retlist = []

    for each in nextlist: # each is a frozen set 
        retlist.append(list(each))
    return retlist

        
def siblings(sxa,ck,k):
    # print ("inside siblings")
    si = []
    for i in ck:
        temp = set(i)
        if(len(temp & sxa) == k-1):
            si.append(temp)
            
    return si    



    
def apriori(items,minsup):
    # items assumed to be a list, minsup an integer
    print ("inside apriori")
    freq = []
    ck = [] 
    sup = []
    for i in items:
        ck.append([i])
        sup.append(0)
    k = 1
    
    while(ck):
        tempck = []
        for sets in ck:
            tempck.append(sets)
        
        # print (ck,k)
        for sets in ck:
            support = computeSupport(sets) # in most cases sets ll be a list
            # print ("support for " ,sets ," is " ,support)
            if(support >= minsup):
                # print ("goin to append ",sets)
                freq.append(sets)
            else:
                # print ("coming here for ",sets)
                tempck.remove(sets)
                
        ck = extendPrefixTree(tempck,k)
        k +=1

    return freq


def compute_ass_rules(f,threshold):
    ass_rule = []
    for sets in f:          # sets is a list
        if(len(sets)==1):
            continue
        for i in range(1,len(sets)):
            sub = list(itertools.combinations(sets,i)) # find subsets of length i
            for each in sub: #each is a tuple
                lhs = set(each)
                rhs = set(sets) - lhs
                conf = computeSupport(list(lhs | rhs))/computeSupport(list(lhs)) #list should be passed here
                # print ("confidence for ",lhs," -> ",rhs," is ",conf)
                if(conf >= threshold):
                    add = str(lhs) + " -> " + str(rhs)
                    ass_rule.append(add)
                
            
    return ass_rule 




import itertools
import random 
data = [[random.randrange(2) for i in range(4)] for i in range(10)]


fout = open("data.txt","w")

for i in range(0,len(data)):
    stx = ''.join(str(data[i]))
    fout.write(stx)
    fout.write('\n')
fout.close()

col = list(range(0,len(data[0])))
f = apriori(col,4)  
print ("after apriori")
# print (f)
rules = compute_ass_rules(f,0.4)

##for i in rules:
##    print (i)

fx = open("output_rules.txt",'w')
for i in rules:
	fx.write(i)
	fx.write('\n')
fx.close()

fo = open("freq_set.txt",'w')
for i in f:
    fo.write(i)
    fo.write('\n')
fo.close()
