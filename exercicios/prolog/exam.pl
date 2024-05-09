:- dynamic round/4.
:- use_module(library(lists)).

% round(RoundNumber, DanceStyle, Minutes, [Dancer1-Dancer2 | DancerPairs])
% round/4 indica, para cada ronda, o estilo de dança, a sua duração, e os pares de dançarinos participantes.
round(1, waltz, 8, [eugene-fernanda]).
round(2, quickstep, 4, [asdrubal-bruna,cathy-dennis,eugene-fernanda]).
round(3, foxtrot, 6, [bruna-dennis,eugene-fernanda]).
round(4, samba, 4, [cathy-asdrubal,bruna-dennis,eugene-fernanda]).
round(5, rhumba, 5, [bruna-asdrubal,eugene-fernanda]).

% tempo(DanceStyle, Speed).
% tempo/2 indica a velocidade de cada estilo de dança.
tempo(waltz, slow).
tempo(quickstep, fast).
tempo(foxtrot, slow).
tempo(samba, fast).
tempo(rhumba, slow).


getalldancers(List) :-
    setof(Dancer1, Dancer2^T^RoundNumber^DanceStyle^Minutes^round(RoundNumber,DanceStyle,Minutes,[Dancer1-Dancer2|T]), Dancers1),
    setof(Dancer2, Dancer1^T^RoundNumber^DanceStyle^Minutes^round(RoundNumber,DanceStyle,Minutes,[Dancer1-Dancer2|T]), Dancers2),
    append(Dancers1,Dancers2,List1),
    sort(List1,List).


danced_in_round(RoundNumber,Dancer) :- 
    round(RoundNumber,_,_,Dancers),
    member(DancerPair, Dancers),
    get_dancer(DancerPair,Dancer).

get_dancer(Dancer1-Dancer2,Dancer2).
get_dancer(Dancer1-Dancer2,Dancer1).



total_dance_time(Dancer, Time) :-
    dance_time_acc(Dancer,Time,1).

dance_time_acc(Dancer,Time,Round) :-
    ((round(Round,_,M,_))->
        R1 is Round + 1,
        dance_time_acc(Dancer,Time1,R1),
        ((danced_in_round(Round,Dancer))->
            Time is Time1 + M; 
            Time is Time1 + 0
        );
        Time is 0
    ).

print_program :-
    print_round(1).
print_program.
print_round(R):-
    round(R,T,M,D),
    length(D,L),
    write(T), write(' ('),write(M),write(') - '),write(L),nl,
    R1 is R +1,
    print_round(R1).

dancer_n_dances(Dancer,NDances) :-
    findall(R,(danced_in_round(R,Dancer)),
            Dances),
    length(Dances,NDances).

most_tireless_dancer(Tireless):-
    setof(Dancer-Time,(Round^(danced_in_round(Round, Dancer), total_dance_time(Dancer,Time))),List),
    get_biggest(List,Tireless,0,_).

get_biggest([],_,MaxIntTime,MaxIntTime).
get_biggest([Dancer-Time|T], Biggest, MaxIntTime, MaxTime) :-
    ((Time >= MaxIntTime) ->
        get_biggest(T,Biggest1,Time,MaxTime1),
            MaxTime = MaxTime1,
            ((Time >= MaxTime1) ->
            Biggest = Dancer;
            Biggest = Biggest1
            )
        ;
        get_biggest(T,Biggest1,MaxIntTime,MaxTime1),
        Biggest = Biggest1,
        MaxTime = MaxTime1
    ).

predX([],0).
predX([X|Xs],N):-
    X =.. [_|T],
    length(T,2),
    !,
    predX(Xs,N1),
    N is N1 + 1.
predX([_|Xs],N):-
    predX(Xs,N).