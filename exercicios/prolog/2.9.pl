rle1([H|T], List2) :-
    del_all(H,T,L1,A),
    rle(L1,List2c),
    A1 is A +1,
    append([H-A1],List2c,List2).

rle1([], []).


del_all(Elem, [H|T], List2, A) :-
    del_all(Elem, T, List2c,A1),
    ((Elem = H) -> 
        append([],List2c,List2),
        A is A1 + 1;
        append([H],List2c,List2),
        A is A1 + 0
    ).
del_all(Elem, [H|[]], List2, A) :-
    ((Elem = H) -> 
        append([],[],List2),
        A is 1;
        append([H],[],List2),
        A is 0
    ).
del_all(Elem,[],[], 0).
