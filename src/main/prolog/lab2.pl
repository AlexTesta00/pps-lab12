% search2(elem, list)
% looks for two consecutive occurrences of Elem
search2(E, [E, E | _]). %E compare due volte consecutive se la lista comincia con E, E
search2(E, [_ | T]) :- search2(E, T). %Se le prime due occorrenze non sono nella testa, continuo a cercare in coda

% search_two(elem, list)
% looks for two occurrences of Elem with any element in between !
search_two(E, [E, _, E | _]).
search_two(E, [_ | T]) :- search_two(E, T).

% size(list, size)
% size will contain the number of elements in List
size([], 0).
size([_ | T], N) :- size(T, N2), N is N2 + 1.

% sum(list, sum)
% sum([1,2,3], X). -> yes. X/6
sum([], 0).
sum([H | T], S) :- sum(T, S2), S is S2 + H.

% max(list, max, min)
% suppose the list has at least one element
max([E], E, E). %Se ha un elemento sara il massimo ma anche il minimo.
max([H | T], H, Min) :- max(T, MaxT, Min), H > MaxT. %Se H e maggiore del massimo della coda. allora H e il massimo
max([H | T], Max, H) :- max(T, Max, MinT), H < MinT. %Se H e il minore del minimo della coda, allora H e il minimo della lista
max([H | T], Max, Min) :- max(T, Max, Min), H =< Max, H >= Min. %Copre il caso in cui H non sia ne massimo ne minimo

% split(List, Elements, SubList1, SubList2)
split(L, 0, [], L). %Se non splitto, mi restituisce la lista e una lista vuota
split([H | T], N, [H | L1], L2) :- N > 0, N1 is N - 1, split(T, N1, L1, L2).
%Se devo prendere N elementi dalla lista, prendo la testa H, la metto nella prima sottolista, poi continuo a prendere N - 1 element dalla coda

% rotate(list, rotatedList)
% rotate([10,20,30,40], L) -> [20,30,40,10]
rotate([], []).
rotate([H | T], L) :- append(T, [H], L). %Appendo H che e una lista di un solo elemento a T

% count_occurrences(element, list, count)
% count is the number of times Element appears in list.
count_occurrences(_, [], 0). %La conta in una lista vuota e zero
%Se la testa e = ad E allora conto le occorrenze nella coda e poi aggiungo 1
count_occurrences(E, [H | T], N) :- H =:= E, count_occurrences(E, T, N2), N is N2 + 1.
%Se la testa e diversa, allora la ignoro a continuo sulla coda
count_occurrences(E, [H | T], N) :- H =\= E, count_occurrences(E, T, N).

% dices(X)
% Generates all possible outcomes of throwing a dice .
dice(X) :- member(X, [1,2,3,4,5,6]). %Member e una funzione che controlla se un elemento e interno alla lista

% three_dice(L).
% Generates all possible outcomus of throwing three dices
three_dice([X, Y, Z]) :- dice(X), dice(Y), dice(Z).

% distinct(list, distinctList)
distinct([], []). %La lista vuota non ha duplicati
distinct([H | T], L) :- member(H, T), !, distinct(T, L). %Se H compare nella coda T allora lo scarto, se vedo che H si duplica non prova l'altra regola
distinct([H | T], [H | L]) :- distinct(T, L). %Se H non compare nella coda allora lo tengo e lo aggingo ad L

% dropAny(?Elem, ?List, ?Outlist)

dropAny(X, [X | T], T). %Se la lista comincia con X, eliminiamo proprio quella X
dropAny(X, [H | Xs], [H | L]) :- dropAny(X, Xs, L). %Provo ad eliminare la X dalla coda Xs

% dropFirst(?Elem, ?List, ?OutList)
dropFirst(X, [X | T], T) :- !. %Se la lista incomincia con X, la elimino e tengo la coda T
droptFirst(X, [H | T], [H | L]) :- dropFirst(X, T, L). % Se non ho ancora eliminato la X, tengo la testa H e cerco nella coda

% dropLast(?Elem, ?List, ?Outlist)
dropLast(X, [X | T], T) :- \+ member(X, T), !. %Posso eliminare X dalla testa solo se non ci sono altre occorrenze di X
dropLast(X, [H | T], [H | L]) :- dropLast(X, T, L). %Tengo la testa H e cerco piu avanti altre occorrenze da eliminare.

% dropAll(?Elem, ?List, ?OutList)
dropAll(_, [], []). %Se la lista e vuota, il risultato e una lista vuota
dropAll(X, [X | T], L) :- !, dropAll(X, T, L). %Se la testa e X, la elimino e continuo sulla coda, ! se devo eliminare la testa non voglio esplorare la regola successiva
dropAll(X, [H | T], [H | L]) :- dropAll(X, T, L).%Se la testa non e X, la tengo e continuo sulla coda.

% fromList(+List, -Graph)
fromList([_], []). %Se la lista ha un solo elemento, non posso creare archi
fromList([H1, H2 | T], [e(H1, H2) | L]) :- fromList([H2 | T], L). %prendo i primi due nodi H1, H2, creo un arco e(H1,H2) poi continuo dalla lista [H2 | T]

% outDegree(+Graph, +Node, -Deg)
outDegree([], _, 0). %In un grafo vuoto, nessun nodo ha archi uscenti
outDegree([e(Node, _) | T], Node, Deg) :- !, outDegree(T, Node, D), Deg is D + 1. %Se il primo arco parte da Node, lo conto
outDegree([_ | T], Node, Deg) :- outDegree(T, Node, Deg). %Se il primop arco non parte da Node, ignoro e vado alla coda

% reaching(+Graph, +Node, -List)
reaching(Graph, Node, List) :- findall(X, member(e(Node, X), Graph), List). %Trovo tutti gli X tali che e(Node, X) appartengono al grafo e mettili in una List

% nodes(+Graph,-Nodes)
nodes(Graph, Nodes) :- all_nodes(Graph, L), distinct(L, Nodes).
% all_nodes(+Graph, -List)
% Extracts all nodes from all edges, including duplicates.
all_nodes([], []).
all_nodes([e(A, B) | T], [A, B | L]) :- all_nodes(T, L).
% distinct(+List, -DistinctList)
% Removes duplicates, keeping the first occurrence.
distinct(L, R) :- distinct_acc(L, [], R).
distinct_acc([], _, []).
distinct_acc([H | T], Seen, R) :- member(H, Seen), !, distinct_acc(T, Seen, R).
distinct_acc([H | T], Seen, [H | R]) :- distinct_acc(T, [H | Seen], R).
% Prima estraggo tutti gli archi e poi rimuovo i duplicati

% anypath(+Graph, +Node1, +Node2, -ListPath)
anypath(Graph, N1, N2, [e(N1, N2)]) :- member(e(N1, N2), Graph). %Esiste un cammino da N1 a N2 se nel grafo esiste direttamente l'arco e(N1, N2)
anypath(Graph, N1, N2, [e(N1, N3) | Path]) :- member(e(N1, N3), Graph), anypath(Graph, N3, N2, Path). %Esiste un cammino da N1 a N2 se posso andare da N1 a un nodo intermedio N3, e poi da N3 posso arrivare a N2

% allreaching(+Graph, +Node, -List)
allreaching(Graph, Node, List) :- findall(X, anypath(Graph, Node, X, _), Raw), distinct(Raw, List).
%Trova un nodo X tale che esiste un cammino da Node a X
%Raccoglie tutti i nodi trovati
%Eliminiamo i duplicati

