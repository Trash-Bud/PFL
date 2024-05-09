invert([H|T], List2) :-
    invert(T,List2c),
    append(List2c,[H],List2).
invert([H|[]],List2) :-
    append([],[H],List2).


del_one(Elem,[Elem|T], List2) :-
    append([],T,List2).
del_one(Elem, [H|T], List2) :-
    del_one(Elem, T, List2c),
    append([H],List2c,List2).
del_one(_,[H|[]],List2) :-
    append([H],[],List2).


del_all(Elem, [H|T], List2) :-
    del_all(Elem, T, List2c),
    ((Elem is H) -> 
        append([],List2c,List2);
        append([H],List2c,List2)
    ).
del_all(Elem, [H|[]], List2) :-
    ((Elem is H) -> 
        append([],[],List2);
        append([H],[],List2)
    ).
del_all(Elem,[],[]).


del_all_list([H|T], List1, List2) :-
    del_all(H, List1,List2c),
    del_all_list(T,List2c,List2).
del_all_list([H|[]], List1, List2) :-
    del_all(H, List1,List2).


del_dups([H|T], List2) :-
    del_all(H,T,List2c),
    del_dups(List2c, List2c1),
    append([H],List2c1,List2).
del_dups([H|[]], List2) :-
    append([H],[],List2).
del_dups([], List2) :-
    append([],[],List2).
