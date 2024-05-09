
:- dynamic female/1.
:- dynamic male/1.

female(joana).
male(dino).

add_person :-
    repeat,
    format("~s", ["Gender? (f/m)"]),nl,
    read(G),
    ((G = f; G = m) -> true; false),
    format("~s", ["Name?"]), nl,
    read(N),
    ((G = f) -> assert(female(N)); assert(male(N))).
    