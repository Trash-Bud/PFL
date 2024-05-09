%flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

get_all_nodes(ListOfAirports) :-
    findall(Origin,flight(Origin,_,_,_,_,_),ListOfAirports1),
    findall(Origin,flight(_,Origin,_,_,_,_),ListOfAirports2),
    append(ListOfAirports1,ListOfAirports2,ListOfAirports3),
    sort(ListOfAirports3,ListOfAirports).


get_all_companies(Company) :-
    flight(_,_,Company,_,_,_).

number_of_destinations(Company,N) :-
    setof(Destination,Origin^Code^Hour^Duration^flight(Origin,Destination,Company,Code,Hour,Duration),DestinationByCompany),
    length(DestinationByCompany,N).

most_diversified(Company) :-
    setof(Company1-Number,
        (get_all_companies(Company1),
        number_of_destinations(Company1,Number)),
        List
    ),
    find_biggest(List,_,Company).

find_biggest([C-N|T],Big, CBig) :-
    find_biggest(T, Big1, C1),
    ((N > Big1) ->
        Big is N + 0,
        CBig = C;
        Big is Big1 + 0,
        CBig = C1
        ).

find_biggest([C-N|[]], N, C).

find_flights(Origin, Destination, Flights) :-
    find_flights_aux(Origin,Destination,Flights,[Origin]).

find_flights_aux(Destination,Destination,[],_).
find_flights_aux(Origin, Destination, Flights,Visited) :-
    flight(Origin,N,_,Code,_,_),
    \+ member(N,Visited),
    append(Visited,[N],Visited1),
    find_flights_aux(N,Destination,Flights1,Visited1),
    append([Code],Flights1,Flights).

find_flights_breadth(Origin, Destination, Flights) :-
    find_flights_breadth_aux([first-Origin],Destination,VisitedRes,[]),
    reverse(VisitedRes,Reverse),
    find_flights_v(Reverse,Destination,Flights).


find_flights_v([],_,[]).

find_flights_v([Last-Destination|T], L, Flights) :-
    ((Destination = L, \+ (Last = first)) ->
        find_flights_v(T,Last,Flights1),
        flight(Last,Destination,_,Code,_,_),
        append([Code],Flights1,Flights);
        find_flights_v(T,L,Flights1),
        append([],Flights1,Flights)
    ).


find_flights_breadth_aux([Last-Destination|_],Destination,VisitedRes,Visited) :-
    append(Visited,[Last-Destination],VisitedRes).
find_flights_breadth_aux([Next-Origin|Queue],Destination,VisitedRes,Visited) :-
    findall(Origin-Dest,
        (flight(Origin,Dest,_,_,_,_),
        \+ member(_-Dest,Visited),
        \+ member(Dest-_,Visited),
        \+ member(_-Dest,[Next-Origin|Queue]),
        \+ member(Dest-_,[Next-Origin|Queue])
        ),
        List
    ),
    append(Queue,List,NewQueue),
    append(Visited,[Next-Origin],Visited1),
    find_flights_breadth_aux(NewQueue, Destination, VisitedRes1,Visited1),
    append([],VisitedRes1,VisitedRes).


find_all_flights(Origin, Destination, ListOfFlights) :-
    findall(Path,find_flights(Origin,Destination,Path),ListOfFlights).

find_flights_least_stops(Origin, Destination, ListOfFlights) :-
   find_all_flights(Origin,Destination,ListOfFlights1),
   get_smallest(ListOfFlights1,900,_,ListOfFlights).

get_smallest([], Min, Min, []).
get_smallest([L|T], Min, Min1, List) :-
    length(L, Len),
    ((Len =< Min) ->
        get_smallest(T,Len, Min2, List1),
        Min1 is Min2 + 0,
        ((Len =< Min2) ->
        append(List1,[L],List);
        append(List1,[],List)
        );
        get_smallest(T,Min,Min2,List1),
        Min1 is Min2 + 0,
        append(List1,[],List)
    ).



    

    
