factorial(0,1).
factorial(N,F) :- 
N > 0,
N1 is N - 1,
factorial(N1,F1),
F is N*F1.

somaRec(1,1).
somaRec(N,S) :-
N > 0,
N1 is N-1,
somaRec(N1,S1),
S is S1 + N.


fibonnaci(0,0).
fibonnaci(1,1).
fibonnaci(N,F) :-
N >= 0,
N1 is N - 1,
N2 is N - 2,
fibonnaci(N1,F1),
fibonnaci(N2,F2),
F is F1 + F2.


hasDivisers(_,1,0).
hasDivisers(1,_,0).
hasDivisers(N,M,R) :-
M >1,
M1 is M -1,
hasDivisers(N,M1,R1),
((0 is mod(N,M)) -> R is R1 + 1; R is R1+0).


isPrime(X):- hasDivisers(X,X-1,0).