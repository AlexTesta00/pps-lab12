% Search element in list
% search(X, cons(X, _)). % X si trova in una lista se X e il primo elemento della lista
% search(X, cons(_, Xs)) :- search(X, Xs). % X si trova nella lista se si trova nella coda della lista
% Quel search(X, Xs) è ricorsivo

% Search two consecutive element in list
% search2(X, cons(X, cons(X, _))).
% search2(X, cons(_, Xs)) :- search2(X, Xs).

% search_two
% search_two(X, cons(X, cons(_, cons(X, _)))).
% search_two(X, cons(_, Xs)) :- search_two(X, Xs).

% search_anytwo
% search_anytwo(X, cons(X, Xs)) :- search(X, Xs). % X compare almeno due vole in una lista X se è in testa e comapare nella coda
% search_anytwo(X, cons(_, Xs)) :- search_anytwo(X, Xs). % Se la testa non è utile, ignoro la testa e continuo a cercare nella coda

% size(nil, zero). % La lista vuota ha dimensione zero
% size(cons(_, Xs), s(N)) :- size(Xs, N). % Una lista non vuota ha dimensione s(N) se la sua coda T ha dimensione N

% sum(X, zero, X). % La somma di un qualsiasi numero con zero rimane X
% sum(X, s(Y), s(Z)) :- sum(X,Y,Z). % La somma di X e s(Y) è s(Z) se la somma di X e Y è Z, X + (Y + 1) = (X + Y) + 1

% sum(List, Sum)
% Sum e la somma degli elementi della lista
% sum_list(nil, zero). % La somma di una lista vuota e zero
% sum_list(cons(X, Xs), Sum) :- sum_list(Xs, Tailsum), %La somma della coda Xs e Tailsum 
%			      sum(X, Tailsum, Sum). % La somma tra la testa H e Tailsum e Sum

% max(List, Max)
% greater(s(_), zero).

% greater(s(X), s(Y)) :-
%     greater(X, Y).

% max(cons(H, T), Max) :-
%     max(T, H, Max).

% max(nil, TempMax, TempMax).

% max(cons(H, T), TempMax, Max) :-
%     greater(H, TempMax),
%     max(T, H, Max).

% max(cons(H, T), TempMax, Max) :-
%     greater(TempMax, H),
%     max(T, TempMax, Max).

% max(cons(H, T), TempMax, Max) :-
%     H = TempMax,
%     max(T, TempMax, Max).

% same(List1, List2)
% same(nil, nil). %La lisa vuota e uguale alla lista vuota
% same(cons(X, Xt), cons(X, Xs)) :- same(Xt, Xs). %Due liste non vuote sono uguali se hanno la stessa testa e le loro code sono uguali

% all_bigger(List1, List2)
% greater(s(_), zero). %Qualunque numero positivo e maggiore di zero
% greater(s(X), s(Y)) :- greater(X, Y). %s(X) e maggiore di s(Y) se X e maggiore di Y
% all_bigger(nil, nil). %Lelemento piu grande di due liste vuote e la lista vuota
% La prima lista e maggiore della seconda se: 
% La testa della prima lista e maggiore della testa della seconda lista
% Anche la coda della prima lista e maggiore della coda della seconda
% all_bigger(cons(X, Xs), cons(Y, Ys)) :- greater(X , Y),
%				          all_bigger(Xs, Ys).

% sublist(List1, List2)
% search(X, cons(X, _)). % X si trova in una lista se X e il primo elemento della lista
% search(X, cons(_, Xs)) :- search(X, Xs). % X si trova nella lista se si trova nella coda della lista
% sublist(nil, _). %La lista vuota e sottolista di qualsiasi lista
% sublist(cons(X, Xs), cons(Y, Ys)) :- search(X, cons(Y, Ys)), sublist(Xs, cons(Y, Ys)).

% Creating list (seq)
%seq(zero, _, nil). %Una sequenza lunga zero e una lista vuota
%seq(s(N), E, cons(E, T)) :- seq(N, E, T). %Una sequenza lunga s(N) di elementi E è una lista che comincia con e la cui coda T è una sequenza lunga N di elementi E

% seqR(N, List)
seqR(zero, nil). %Una sequenza di lunghezza zero, produce una sequenza vuota
seqR(s(N), cons(X, Xs)) :- seqR(X, Xs). %La sequenza di s(N) elementi comincia con N, e poi continua con la sequenza discendente di N