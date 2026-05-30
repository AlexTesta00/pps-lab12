% last(List, Elem), element is the last of the list
last(cons(E, nil), E). %E l'ultimo se effettivamente si trova in fondo
last(cons(_, Xs), E) :- last(Xs, E). %Se la lista ha piu elementi, ignoro la testa e cerco l'ultimo elemento della coda

% map(List, Result), adding 1 of all element in list
map(nil, nil). %Una lista vuota produce un risultato vuoto
map(cons(X, Xs), cons(s(X), R)) :- map(Xs, R). %Se la testa e X, nella lista risultato la testa diventa s(X). Poi continuo sulla cosa

% filter_pos(List, Result), contains only the positive elements in list
filter_pos(nil, nil). %La lista vuota filtrata rimane vuota

filter_pos(cons(zero, T), R) :- filter_pos(T, R). %Se la testa e zero la scarto

filter_pos(cons(s(N), T), cons(s(N), R)) :- filter_pos(T, R). %Se la testa non e zero, la tengo

% count(List, Count), count the number of elements in list
count_pos(nil, zero). %La lista vuota mi produce zero
count_pos(cons(zero, T), N) :- count_pos(T, N). %Se trovo zero, non incremento, lo ignoro
count_pos(cons(s(_), T), s(N)) :- count_pos(T, N). %Se trovo un numero diverso da zero, incremento il risultato

% find_pos(List, Elem), element is the first positivi element in list
find_pos(cons(s(N), _), s(N)). %Se la testa e positiva, è il risultato.
find_pos(cons(zero, T), E) :- find_pos(T, E). %Se la testa e zero, continuo sulla coda

% reversed(List, Result), result is list reversed
% snoc(List, Elem, Result), result is list with element added at the end
snoc(nil, E, cons(E, nil)). %Aggiungere E alla lista vuota produce E
snoc(cons(H, T), E, cons(H, R)) :- snoc(T, E, R). %Per aggiungere E in fondo a una lista non vuota, tengo la testa H e aggiungo E in fondo alla coda
reversed(nil, nil). %Il reverse di una lista vuota, è una lista vuota
reversed(cons(H, T), R) :- reversed(T, RT), snoc(RT, H, R). %Per invertire [H|T], prima inverto T poi aggiungo H.

% drop(N, List, Result), result is list without its first N elements
drop(zero, cons(H, T), cons(H, T)). % Se devo togliere zero elementi la lista rimane uguale
drop(s(_), nil, nil). % Se la lista e vuota. Rimane vuota anche se voglio togliere elementi
drop(s(N), cons(_ , T), R) :- drop(N, T, R). %Se devo togliere s(N), scarto la testa e poi tolgo N elementi dalla coda

% take(N, List, Result), result contains the first n elements of list
take(zero, _, nil). %Se devo prendere zero elementi, la lista risultante e vuota
take(s(_), nil, nil). %Se devo prendere qualcosa dalla lista vuota, il risultato e vuoto
take(s(N), cons(H, T), cons(H, R)) :- take(N, T, R). %Se devo prendere almeno un elemento, tengo la testa H, e poi prendo N elementi dalla coda

% drop_right(N, List, Result), result is list without its last N elements
drop_right(N, L, R) :- reversed(L, RL), drop(N, RL, RD), reversed(RD, R). %Inverto la lista, tolgo i primi n elementi, inverto di nuovo

% drop_while(List, Result), result is obtained by dropping positive elements from list
drop_while_pos(nil, nil). % Se la lista e vuota il risultato e vuoto
drop_while_pos(cons(zero, T), cons(zero, T)). % Se trovo zero, mi fermo e restituisco la lista da quel punto in poi
drop_while_pos(cons(s(_), T), R) :- drop_while_pos(T, R). % Se la testa e positiva, la scarto e cotinuo

% partition_pos(List, Positive, NonPositive), positive contains all positive elements, non positive contains non positive elements
% filter_zero(List, Zeros)
% Zeros contiene solo gli elementi uguali a zero
% filter_pos(List, Positives)
% Positives contiene solo gli elementi positivi della lista
filter_pos(nil, nil).
filter_pos(cons(zero, T), R) :- filter_pos(T, R).
filter_pos(cons(s(N), T), cons(s(N), R)) :- filter_pos(T, R).
% filter_zero(List, Zeros)
% Zeros contiene solo gli elementi uguali a zero
filter_zero(nil, nil).
filter_zero(cons(zero, T), cons(zero, R)) :- filter_zero(T, R).
filter_zero(cons(s(_), T), R) :- filter_zero(T, R).
% partition_pos(List, Positives, NonPositives)
% Positives contiene gli elementi > 0
% NonPositives contiene gli elementi non > 0
partition_pos(L, P, NP) :- filter_pos(L, P), filter_zero(L, NP).

% zip(List1, List2, Result), result contains pairs of corresponding elements from List1 and List2
zip(nil, _, nil). % Se la prima lista e vuota, il risultato e vuoto
zip(cons(_,_), nil, nil). % Se la seconda lista e vuota il risultato e vuoto
zip(cons(H1, T1), cons(H2, T2), cons(pair(H1, H2), R)) :- zip(T1, T2, R). %Se entrambe le liste hanno una testa, creo una coppia sulle teste e continuo sulle code