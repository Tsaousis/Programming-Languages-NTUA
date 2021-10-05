
import sys

def find_dads_ijv (lists,this_i,this_j):
    k=l=-99

    if (lists[this_i][this_j]=='R'):
        k=this_i
        l=this_j+1
    else:
        if (lists[this_i][this_j]=='L'):
            k=this_i
            l=this_j-1
        else:
            if (lists[this_i][this_j]=='U'):
                k=this_i-1
                l=this_j
            else:
                if (lists[this_i][this_j]=='D'):
                    k=this_i+1
                    l=this_j
                else:
                    if (lists[this_i][this_j]=='o' or lists[this_i][this_j]=='t'):
                        return (this_i,this_j,lists[this_i][this_j])
                    else:
                        print('ijv error')
    return (k,l,lists[k][l])

def find_route(lists,i,j):
    route=[(i,j)]
    f=True
    father='unknown'
    dadtemp=father
    banana= find_dads_ijv(lists,i,j)
    
    lists[i][j]='t'
    k=banana[0]
    l=banana[1]
    dad_value=banana[2]
    dad_position=(k,l)
    while(f):
        if (dad_value=='t' or dad_value=='o'):
            f=0
            father=dad_value
        else:
                 
            banana= find_dads_ijv(lists,dad_position[0],dad_position[1])
            gdad_position=(banana[0],banana[1])
            gdad_value=banana[2]
            lists[dad_position[0]][dad_position[1]]='t'
            route.append((dad_position[0],dad_position[1]))
            dad_position=gdad_position
            dad_value=gdad_value

    change_parent(lists,route, father)

def change_parent(lists,route, father):
    if (father=='t'): 
        exit
    else:
        for i in range(0,len(route)):
            lists[route[i][0]][route[i][1]]=father
        route.clear()

def cout_out(lists,lines,colums):
    res=0
    for i in range(0,lines):
        for j in range(0,colums):
            if (lists[i][j]!='o' ):
                res=res+1
    return res


myarguments=(sys.argv)


with open(myarguments[1]) as f:
    lines, colums = [int(x) for x in next(f).split()]
    strings =f.readlines()

lists=[0]*lines

for i in range(0,lines):
    lists[i]=list(strings[i])


for j in range(0,colums):
    if (lists[0][j] == 'U'):
        lists[0][j] = "o"
    if (lists[lines-1][j] == 'D'):
        lists[lines-1][j] = 'o'

for i in range(0,lines):
    if (lists[i][0] == 'L'):
        lists[i][0] = 'o'
    if (lists[i][colums-1] == 'R'):
        lists[i][colums-1] = 'o'

for i in range(0,lines):
    for j in range(0,colums):
        if (lists[i][j]!='o' and lists[i][j]!='t'):
            find_route(lists,i,j)

print(cout_out(lists,lines,colums))       