readInput(File, T, C, C_loc) :-
    open(File, read, Stream),
    readLine(Stream, [T, C]),
    readLine(Stream, C_loc).

readLine(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms,' ', Atom),
    maplist(atom_number, Atoms, L).



replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).


transform([],Towns,CarN,Towns).
transform(Cars,Towns,CarN,Result):-
Cars=[CarH|CarT],
nth0(CarH,Towns, Elem, Rest),
X is Elem+1,


replace(Towns,CarH,X,Towns2),
transform(CarT,Towns2,CarN,Result).

%find sum for 0
loop([], First ,Cars, Towns, Towns, Sum,Res):-
    Res is Sum-(First*Towns).
loop([H|T], First, Cars, Towns, 0, Sum, Res ):-
    NewSumi is Sum+H*(Towns),
loop(T, H, Cars, Towns, 1, NewSumi,Res).
loop([H|T], First, Cars, Towns, I, Sum, Res ):-    
    NewSumi is Sum+H*(Towns-I),J is I+1,
    loop(T, First, Cars, Towns, J, NewSumi,Res).



next([CityarrH|CityarrT],Second,I,Towns,Dist,Flag,FinalDist,Count):-    
    Count<I,     
    Counter is Count+1, 
    next(CityarrT,Second,I,Towns,0,Flag,FinalDist,Counter).

next([CityarrH|CityarrT],Second,I,Towns,0,Flag,FinalDist,I):-    
    next(CityarrT,Second,I,Towns,1,Flag,FinalDist,I).    

next([H|T],Second,J,Towns,Dist,Flag,FinalDist,J):-    
    H\=0,    
    FinalDist is Towns-Dist.

next([],Second,J,Towns,Dist,Flag,FinalDist,J):-     
    next(Second,Second,J,Towns,Dist,Flag,FinalDist,J).
    %nextfromstart(Second,Towns,Dist,FinalDist).

next([0|T],Second,J,Towns,Dist,Flag,FinalDist,J):-    
    NiDi is Dist+1, 
    next(T,Second,J,Towns,NiDi,Flag,FinalDist,J).


nextfromstart([H|T],Towns,Dist,FinalDist):-    
    H\=0,    
    FinalDist is Towns-Dist.
nextfromstart([0|T],Towns,Dist,FinalDist):-    
    NiDi is Dist+1, 
    nextfromstart(T,Towns,Nidi,Flag).





main([],Second,Cars,Towns,I, OldSum, Pos, Minsum, Final, FinPos):-    
    Final is Minsum,    
    FinPos is Pos.

main([H|T],Second,Cars,Towns,0, OldSum, Pos, Minsum, Final, FinPos):- 
    loop([H|T], First, Cars, Towns, 0, 0, X ), 
    
    next(Second,Second,0,Towns,0,Flag,Nexti,0),  
    (X-Nexti+1>=Nexti->
        main(T,[H|T],Cars,Towns,1,X,0,X, Final, FinPos)
    ;
        main(T,[H|T],Cars,Towns,1,X,0,Minsum, Final, FinPos)
    ).


main([H|T],Second,Cars,Towns,I, OldSum, Pos, Minsum, Final, FinPos):- 
    next(Second,Second,I,Towns,0,Flag,Nexti,0),     
    Sum is OldSum+Cars-Towns*H, 
    L is Sum-Nexti+1, 
    J is I+1, 
    (Nexti=<L -> 
        (Sum<Minsum -> 
            main(T,Second,Cars,Towns, J, Sum, I, Sum, Final, FinPos)
            ;
            main(T,Second,Cars,Towns,J,Sum,Pos,Minsum, Final, FinPos))
    ;
        main(T,Second,Cars,Towns,J,Sum,Pos,Minsum, Final, FinPos)
    ).
     
dummy(Towns,Start,Result,Towns):-
    Result=Start.
dummy(Towns,Start,Result,I):-
    J is I+1,
    dummy(Towns,[0|Start],Result,J).
     

%%%%MAIN
round(File,Ulti_Sum,Ulti_Cit):-
    readInput(File, Towns, Cars, C_loc),
    
    dummy(Towns,[],Zeros,0),
    transform(C_loc,Zeros,Towns,T_pop),
    main(T_pop,T_pop,Cars,Towns,0,0,0,49999999951713,Ulti_Sum,Ulti_Cit),
    !.
        