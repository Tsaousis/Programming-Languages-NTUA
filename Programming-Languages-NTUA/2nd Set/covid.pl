%%prefixSum Old=0

/*
 * A predicate that reads the input from File and returns it in
 * the last three arguments: N, K and C.
 * Example:
 *
 * ?- read_input('c1.txt', N, K, C).
 * N = 10,
 * K = 3,
 * C = [1, 3, 1, 3, 1, 3, 3, 2, 2|...].
 */
read_input(File, N, K, C) :-
    open(File, read, Stream),
    read_line(Stream, [N, K]),
    read_line(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

%%%prefix sum
pref([],Old,[]).
pref([H|T],Old,[H1|T1]):- 
    H1 is H+Old,
    pref(T, H1, T1).

%%%kanw ton pinaka antitheto(ola ta stoixeia -) kai afero to K
modify([],N,[]).
modify([H|T],N,[H1|T1]):- 
    H1 is -H-N,
    modify(T, N, T1).

%%%%MAIN
longest(File,Final):-
    read_input(File, N, X, L),
    length(L,StartL),
    writeln(StartL),
    modify(L,X,X1),
    length(X1,ModLeng),
    writeln(ModLeng),
    pref(X1,0,PrefSum),
    writeln('Prefix Sum'),
    length(PrefSum,Pref),
    writeln(Pref),
    lmin(PrefSum,200000000000000,Lmin), %2000....ws max number
    writeln('Lmin '),
    reverse(PrefSum,Rev),
    rmax(Rev,-20000000000000,RmaxRev), %-2000.. ws min number
    reverse(RmaxRev,Rmax),
    writeln('Rmax '),
    length(Lmin,Xl),
    length(Rmax,Xr),
    writeln(Xl),
    writeln(Xr),
    merge(Maximum,Lmin,Rmax,0,-1),
    print("merge"),
    ((Maximum=:=N-1)->Final is Maximum+1;
    (Maximum=\=N-1)->Final is Maximum).





% Ftiaxnw LMin tetoia wste LMin[i]
%  exei to minimum value
%  from (arr[0], arr[1], ... arr[i])
lmin([],Old1,[]).
lmin([H|T],Old1,[H1|T1]):- 
   ((Old1<H) -> H1 is Old1;
    (Old1>=H) -> H1 is H),
    lmin(T, H1, T1).


% Ftiaxnw RMax[] tetoia wste RMax[j]
% exei to maximum value
% from (arr[j], arr[j+1], ..arr[n-1])
%%tha exei input reversed lista kai meta tha thn ksanakanw reverse
rmax([],Old2,[]).
rmax([H|T],Old2,[H1|T1]):- 
   ((Old2>=H) -> H1 is Old2;
(Old2<H) -> H1 is H),
 
   rmax(T, H1, T1).





% !!!!!!!!!!!!!!!!!!! Traverse both arrays from left to right
%%% to find optimum j - i(Maxidiff)
merge(MaxDiff,[],_,JI,MaxOld):- MaxDiff is MaxOld.
merge(MaxDiff,_,[],JI,MaxOld):- MaxDiff is MaxOld.
merge(MaxDiff,[HL|TL],[HR|TR],JI,MaxOld):-
    L=[HL|TL],
    R=[HR|TR],
    % writeln(R),
    % writeln(TR),
    % length(L,Xl),
    % length(R,Xr),
    % writeln(Xl),
    % writeln(Xr),
    
    (((HL<HR)->

        MaxiMax is max(MaxOld,JI),
        JI2 is JI+1,
        merge(MaxDiff,L,TR,JI2,MaxiMax));        


    ((HL>=HR)-> 
        JI2 is JI-1,
        merge(MaxDiff,TL,R,JI2,MaxOld))).


                                
