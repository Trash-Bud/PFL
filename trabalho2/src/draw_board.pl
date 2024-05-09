:- consult('draw_menu.pl').

draw_cell(0) :- write('_').
draw_cell(1) :- write('o').
draw_cell(2) :- write('x').

draw_x([]).
draw_x([(X, _) | N]) :- write(' '), draw_cell(X), write(' '), draw_x(N).

draw_y([], _)  :- 
    nl, write('        ----------------------------'), 
    nl, write('          0  1  2  3  4  5  6  7  8 '), 
    nl, write('        ----------------------------'), 
    nl, write('                      X'), nl.
draw_y([Y | N], Line) :- 
    nl, 
    (Line == 4 -> 
    write(' Y | '); 
    write('   | ')), 
    write(Line), write(' | '), draw_x(Y), 
    Line2 is Line + 1, draw_y(N, Line2).

draw_player(CurrentPlayer) :-
    nl, write('.-----------.'),
    nl, write('|  player '), write(CurrentPlayer), write(' |'),
    nl, write(' -----------'), nl.

display_game(GameState) :- FirstLine = 0,
              nl, draw_y(GameState, FirstLine), nl.
