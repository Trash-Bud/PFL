/*check_pos(Array, Index, Value)*/

check_pos([Head | _], 0, Head) :-
    !.

check_pos([_ | Tail], Index, Value) :-
    Index1 is Index - 1,
    check_pos(Tail, Index1, Value).

/*replace(Array, Index, Value, NewArray)*/

replace([_ | Tail], 0, Value, [Value | Tail]).
replace([Head | Tail], Index, Value, [Head | Rest]) :-
    Index > 0,
    Index1 is Index - 1,
    replace(Tail, Index1, Value, Rest).

/*replace2D(Array, X, Y, Value, NewArray)*/

replace2D([[_ | Tail1] | Tail2], 0, 0, Value, [[Value | Tail1] | Tail2]).
replace2D([[Head | Tail1] | Tail2], X, 0, Value, [[Head | Rest1] | Rest2]) :-
    X > 0,
    X1 is X - 1,
    replace2D([Tail1 | Tail2], X1, 0, Value, [Rest1 | Rest2]).

replace2D([Head | Tail], X, Y, Value, [Head | Rest]) :-
    Y > 0,
    Y1 is Y - 1,
    replace2D(Tail, X, Y1, Value, Rest).

/*get_pieces_in_board(Array, X, Y, Length, Value, PositionsArray)*/

get_pieces_in_board(Array, _, Length, Length, Value, PositionsArray).
get_pieces_in_board(Array, Length, Y, Length, Value, PositionsArray):-
    Y1 is Y + 1,
    get_pieces_in_board(Array, 0, Y1, Length, Value, PositionsArray).

get_pieces_in_board(Array, X, Y, Length, Value, PositionsArray) :-
    Y < Length,
    X < Length,
    check_pos(Array, Y, Intermediate), check_pos(Intermediate, X, (J, _)),
    X1 is X + 1,
    (Value == J ->
        append(NewPositionsArray, [(X, Y)], PositionsArray), get_pieces_in_board(Array, X1, Y, Length, Value, NewPositionsArray);
        get_pieces_in_board(Array, X1, Y, Length, Value, PositionsArray)
    ).


/*
build_line(Length, Length, Line, _).
build_line(X, Length, Line, NewLine) :-
    X < Length,
    X1 is X + 1,
    append(Line, [(0, 0)], NewLine),
    write(Line), write(', '), write(NewLine), nl,
    build_line(X1, Length, NewLine, _),
    write(Line), write(', '), write(NewLine), nl.


build_board(Length, Length, Board, _).
build_board(Y, Length, Board, BoardLine) :-
    Y1 is Y + 1,
    build_line(0, Length, Line),
    append(B, Line, Board),
    build_board(Y1, Length, B, _).


test :-
    build_board(0, 2, Board, _),
    write(Board).

test2 :-
    build_line(0, 5, Line, _), write(Line).
*/