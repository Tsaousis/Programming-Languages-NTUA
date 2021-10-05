%%%stack
pop([X|List],X,List).
push(X,List,[X|List]).

%%%queue
enqueue(L,X,L3):-
    append(L,[X],L3).

dequeue([],X,L1).    
dequeue(L,X,L1):-
    pop(L,X,L1).



% state(Q,S).


move(Q,S,q,Q1,S1,QsSoFar,LenthofMoves,QsSoFar1):- 
    Nu is div(LenthofMoves,2),
    QsSoFar =< Nu,
    dequeue(Q,X,Q1),
    push(X,S,S1),
    QsSoFar1 is QsSoFar+1.

move(Q,S,s,Q1,S1,QsSoFar,LenthofMoves,QsSoFar1):-
    Nu is div(LenthofMoves,2),
    QsSoFar =< Nu,
    QsSoFar=QsSoFar1,
    Q = [Hq|Tail1],
    S = [Hs|Tail2], 
    Hq=\= Hs,
    pop(S,X,S1),
    enqueue(Q,X,Q1).


%%%final state%%%%
final(SortedQ,[],SortedQ).

solve(Q,[],[],SortedQ,LenthofMoves,QsSoFar):- SortedQ=Q .
solve(Q,S,[Move|Moves],SortedQ,LenthofMoves,QsSoFar) :-
    
    move(Q,S,Move,Q1,S1,QsSoFar,LenthofMoves,QsSoFar1),
    not(illegal(move(Q,S,Move,Q1,S1,QsSoFar,LenthofMoves,QsSoFar1))),
    % legalqs(State1),
    % not(illegal(move(State,Move,State1))),
    solve(Q1,S1,Moves,SortedQ,LenthofMoves,QsSoFar1).

  

%%%%illegal moves%%%%%%%%
illegal(move(_,[],s,_,_,_,_,_)).
illegal(move([],_,q,_,_,_,_,_)).





%%%%list to string%%%%%
finalstring([],'empty').
finalstring(L,S):-
    atomics_to_string(L, String),
    string_upper(String, S).



%%%%%%%even length%%%
islengtheven(L):-
    mod(L,2) =:= 0.

islengtheven(L):-
    mod(L,2) =:= 0.


%%%%%%input file%%%%%%%%%%
read_input(File, N, C) :-
    open(File, read, Stream),
    read_line(Stream, N),
    read_line(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).



%%%%%%%%main %%%%%%%%%%%

qssort(File,Final):-
    read_input(File, N, L),
    % initial(L,[]),
    length(Moves,Mylength),
    islengtheven(Mylength),
    msort(L,SortedQ),
    once(solve(L,[],Moves,SortedQ,Mylength,0)),finalstring(Moves,Final),!.