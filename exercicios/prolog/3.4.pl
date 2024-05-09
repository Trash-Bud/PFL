 print_n(S, N) :-
    N > 0 ,
    N1 is N -1,
    write(S),nl, 
    print_n(S, N1).

print_space(0).
print_space(Num):-
    Num1 is Num -1,
    write(' '),
    print_space(Num1).

print_line(Symbol,0).
print_line(Symbol, Size) :-
    write(Symbol),
    Size1 is Size-1,
    print_line(Symbol,Size1).


print_text(Text, Symbol, Padding) :-
    write(Symbol),
    print_space(Padding),
    atom_codes(P,Text),
    write(P),
    print_space(Padding),
    write(Symbol).


print_banner(Text, Symbol, Padding):-
    length(Text,S),
    L1 is S + (Padding*2) + 2,
    print_line(Symbol,L1), nl,
    write(Symbol), print_space(L1-2),write(Symbol),nl,
    write(Symbol), print_space(Padding),atom_codes(P,Text), write(P), print_space(Padding),write(Symbol),nl,
    write(Symbol), print_space(L1-2),write(Symbol),nl,
    print_line(Symbol,L1).




