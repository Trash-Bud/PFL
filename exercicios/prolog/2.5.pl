list_size([H|T], Size) :-
    list_size(T,Size1),
    Size is Size1 + 1.

list_size([],Size) :-
    Size is 0 + 0.

list_sum([H|T], Sum) :-
    list_sum(T,Sum1),
    Sum is Sum1 + H.

list_sum([H|[]],Sum) :-
    Sum is H + 0.

list_sum([],0).

list_prod([H|T], Prod) :-
    list_prod(T,Prod1),
    Prod is Prod1 * H.

list_prod([H|[]],Prod) :-
    Prod is H + 0.

list_prod([],0).

inner_product([H|T], [H1|T1], Result) :-
    inner_product(T,T1,Result1),
    Result is Result1 + (H*H1).

inner_product([H|[]], [H1|[]], Result) :-
    Result is (H*H1).

count(Elem, [H|T], N):-
    count(Elem,T,N1),
    ((Elem is H) -> N is N1 + 1; N is N1 + 0).
count(Elem, [H|[]], N):-
    ((Elem is H) -> N is 1; N is 0).