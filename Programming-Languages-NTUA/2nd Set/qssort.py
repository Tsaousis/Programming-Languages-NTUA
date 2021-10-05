import time
import sys
from copy import deepcopy

from collections import deque

start_time = time.time()
myarguments = (sys.argv)

with open(myarguments[1]) as f:
    number = [int(x) for x in next(f).split()]
    strings = f.readline()
#strings='21 22 37 48 28 48 30 8 26'
holy_que = tuple(map(int, strings.split()))

sorted_que = tuple(sorted(holy_que))
empty_stac=tuple()

#---------------------------------------------------------------------------------------------

initial_state=(holy_que,empty_stac)
final_state=(sorted_que,empty_stac)

#okay
def move_Q(state):
    new_que=state[0][1:]
    new_stac=state[1][:]
    new_stac=new_stac+(state[0][0],)
    nt=(new_que,new_stac)
    return nt


#okay
def move_S(state):
    new_stac=state[1][:-1]
    
    new_que=state[0][:]
    new_que=new_que+(state[1][-1],)
    nt=(new_que,new_stac)
    return nt

def next(state):
    new_que=state[0][:]
    new_stac=state[1][:]
    new_que1=state[0][:]
    new_stac1=state[1][:]
    if state[1]==tuple():
        next =[ move_Q((new_que,new_stac)),'Q']
        return next
    
    if state[0]==tuple():
        next =[ move_S((new_que,new_stac)),'S']
        return next
    if new_que[0] == new_stac[-1]:
        next =[ move_Q((new_que,new_stac)),'Q']
        return next
    if new_que[-1] == new_stac[-1]and 0:
        next =[ move_S((new_que,new_stac)),'S']
        return next
    next =[move_Q((new_que1,new_stac1)),'Q',move_S((new_que,new_stac)),'S']
    return next
  
prev={hash(initial_state)}
solved=False
d2lis=deque([initial_state])
road_list=deque([''])

if (initial_state!=final_state):
    while d2lis and 1:
        state_m=d2lis.popleft()
        
        road=road_list.popleft()
        #print(len(road))
        
        if state_m==final_state:
            solved=True
            break

        t=next(state_m)
        while t:
            if hash(t[0]) not in prev:
                    d2lis.append(t[0])
                    prev.add(hash(state_m))
                    t.pop(0)
                    road1=road+t[0]
                    road_list.append(road1[:])
                    t.pop(0)
            else:
                t.pop(0)
                t.pop(0)
    
    if solved:
        #print(state_m)
        print(road)

else:
    print('empty')
