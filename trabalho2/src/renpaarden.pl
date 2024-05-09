:- use_module(library(lists)).
:- use_module(library(random)).

:- consult('draw_menu.pl').
:- consult('draw_board.pl').
:- consult('validations_and_messages.pl').
:- consult('aux_functions.pl').

/* [[(0, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0)],
    [(1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0)], 
    [(0, 0), (2, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)], 
    [(2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0)], 
    [(1, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)]], 
    
    [
    [(2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0)], 
    [(2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)],
    [(1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0)], 
    [(1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0)]]
    
    
    [
    [(1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (0, 0), (1, 0), (1, 0)], 
    [(1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (2, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (2, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (2, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (2, 0), (0, 0), (0, 0), (0, 0), (0, 0), (2, 0)], 
    [(0, 0), (2, 0), (0, 0), (0, 0), (0, 0), (0, 0), (2, 0), (0, 0), (0, 0)],
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)], 
    [(1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)]]
    
    */

play :- GameState = [
    [(1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (0, 0), (1, 0), (1, 0)], 
    [(1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0), (1, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (2, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (2, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (2, 0), (0, 0), (0, 0), (0, 0)], 
    [(0, 0), (0, 0), (0, 0), (2, 0), (0, 0), (0, 0), (0, 0), (0, 0), (2, 0)], 
    [(0, 0), (2, 0), (0, 0), (0, 0), (0, 0), (0, 0), (2, 0), (0, 0), (0, 0)],
    [(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)], 
    [(1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)]], 
    draw_logo, 
    draw_options, choose_game_mode(GameMode),
    %choose_board_size(BoardSize),                  /* todo - build board with variable size */
    nl, write('player 1: o'), nl, write('player 2: x'), nl,
    game_cycle(GameState, 1, (X, Y), RepeatTurn, GameMode).


    
game_cycle(GameState, CurrentPlayer, (X, Y), RepeatTurn, GameMode) :-
    display_game(GameState),
    %display_state(GameState),
    game_over(GameState, Winner),

    ((Winner == 1; Winner == 2) ->
        announce_winner(Winner), play_again;
        draw_player(CurrentPlayer), game_flow(GameState, (X, Y), CurrentPlayer, RepeatTurn, GameMode)
    ).
    
game_flow(GameState, (X, Y), CurrentPlayer, RepeatTurn, GameMode) :-
    (GameMode == 1 ->
        turn(GameState, (X, Y), CurrentPlayer, RepeatTurn, GameMode, 0);
        true
    ),

    (GameMode == 4 ->
        turn(GameState, (X, Y), CurrentPlayer, RepeatTurn, GameMode, 1);
        true
    ),

    (((GameMode == 2, CurrentPlayer == 1); (GameMode == 3, CurrentPlayer == 2)) ->
        turn(GameState, (X, Y), CurrentPlayer, RepeatTurn, GameMode, 0);
        turn(GameState, (X, Y), CurrentPlayer, RepeatTurn, GameMode, 1)
    ).



turn(GameState, (X, Y), 1, RepeatTurn, GameMode, IsBot) :- 
    
    (IsBot == 0 ->
        check_valid_position(GameState, (X, Y), (X1, Y1), 1, RepeatTurn);
        choose_move(GameState, (X, Y), (X1, Y1), 1, RepeatTurn, 1)
    ),
    nl, nl,
    move(GameState, (X, Y), (X1, Y1), NewGameState, 1, RepeatTurn, NewRepeatTurn), 
    (NewRepeatTurn == 1 ->
    game_cycle(NewGameState, 1, (X1, Y1), 1, GameMode);
    game_cycle(NewGameState, 2, _, 0, GameMode)).

turn(GameState, (X, Y), 2, RepeatTurn, GameMode, IsBot) :- 
    (IsBot == 0 ->
        check_valid_position(GameState, (X, Y), (X1, Y1), 2, RepeatTurn);
        choose_move(GameState, (X, Y), (X1, Y1), 2, RepeatTurn, 1)
    ),
    nl, nl,
    move(GameState, (X, Y), (X1, Y1), NewGameState, 2, RepeatTurn, NewRepeatTurn),
    (NewRepeatTurn == 1 ->
    game_cycle(NewGameState, 2, (X1, Y1), 1, GameMode);
    game_cycle(NewGameState, 1, _, 0, GameMode)).





check_valid_position(GameState, (X, Y), (X1, Y1), Player, RepeatTurn) :-

    repeat,
    (RepeatTurn == 1 ->
    true;
    get_input(X, Y), validate_input(GameState, (X, Y), Player)),
    
    valid_moves(GameState, X, Y, Player, ListOfMoves, ArrayLength),

    ((ArrayLength > 0) ->
    true;
    write('no possible move from that cell'), RepeatTurn = 0, nl, fail),

    write('choose index of move to use:'), nl, read(ChosenIndex),

    (ChosenIndex =< ArrayLength, ChosenIndex >= 0 ->
    check_pos(ListOfMoves, ChosenIndex, (X1, Y1)), announce_move((X, Y), (X1, Y1));
    write('invalid index'), nl, fail).




choose_move(GameState, (X, Y), (X1, Y1), Player, RepeatTurn, Level) :-
    get_pieces_in_board(GameState, 0, 0, 9, Player, Positions),

    repeat,
    (RepeatTurn == 1 ->
    true;
    random_member((X, Y), Positions)),

    valid_moves(GameState, X, Y, Player, ListOfMoves, ArrayLength),

    ((ArrayLength > 0) ->
    random_member((X1, Y1), ListOfMoves), announce_move((X, Y), (X1, Y1));
    RepeatTurn = 0, fail).
    



validate_input(GameState, (X, Y), Player):-
    ((X > 8 ; X < 0 ; Y > 8 ; Y < 0) ->
    write('input error'), nl, fail;
    true),

    check_pos(GameState, Y, I), check_pos(I, X, (J, _)),

    (((Player == 1, J == 1); (Player == 2, J == 2))->
    true;
    write('invalid cell, not your piece'), nl, fail).





valid_moves(GameState, X, Y, Player, ListOfMoves, ArrayLength) :-
    X1 is X - 2, X2 is X - 1, X3 is X + 1, X4 is X + 2,
    Y1 is Y - 2, Y2 is Y - 1, Y3 is Y + 1, Y4 is Y + 2,

    PossibleMoves = [(X3, Y1), (X4, Y2), (X4, Y3), (X3, Y4), (X2, Y4), (X1, Y3), (X1, Y2), (X2, Y1)],

    validate_moves(GameState, Player, PossibleMoves, ListOfMoves),
    length(ListOfMoves, ArrayLength),
    write('Valid moves: '), 
    (ListOfMoves == [] ->
    write('[]');
    write(ListOfMoves)),
    nl, !.





validate_move(GameState, Player, (X, Y)) :- 
    X =< 8,
    X >= 0,
    Y =< 8,
    Y >= 0,
    check_pos(GameState, Y, I), check_pos(I, X, (J, _)),
    \+ ((Player == 1, J == 1); (Player == 2, J == 2)).





validate_moves(_, _, [], _).
validate_moves(GameState, Player, [(X, Y) | Tail], ValidMoves) :-

    (validate_move(GameState, Player, (X, Y)) ->
    append(V, [(X, Y)], ValidMoves), validate_moves(GameState, Player, Tail, V);
    validate_moves(GameState, Player, Tail, ValidMoves)).





move(GameState, (X, Y), (X1, Y1), NewGameState, Value, RepeatTurn, NewRepeatTurn) :-
    check_pos(GameState, Y, I), check_pos(I, X, (OldValue, Repeated)),

    (Repeated == 1 ->
        (OldValue == 1 ->
        replace2D(GameState, X, Y, (2, 0), Intermediate);
        replace2D(GameState, X, Y, (1, 0), Intermediate));
    replace2D(GameState, X, Y, (0, 0), Intermediate)),

    check_pos(GameState, Y1, I1), check_pos(I1, X1, (J, _)),
    
    (((Value == 1, J == 2);(Value == 2, J == 1)) ->
    NewRepeatTurn = 1;
    NewRepeatTurn = 0),
    replace2D(Intermediate, X1, Y1, (Value, NewRepeatTurn), NewGameState).





game_over([
    [(1, _), (1, _), (1, _), (1, _), (1, _), (1, _), (1, _), (1, _), (1, _)],
    [(1, _), (1, _), (1, _), (1, _), (1, _), (1, _), (1, _), (1, _), (1, _)], 
    _, 
    _, 
    _, 
    _, 
    _, 
    _, 
    _], Winner) :- Winner = 1.

game_over([_,
    _, 
    _, 
    _, 
    _, 
    _, 
    _, 
    [(2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0)], 
    [(2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0), (2, 0)]], Winner) :- Winner = 2.

game_over(_, _).
