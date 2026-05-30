% map(+List, +Mapper, -OutList)
% Mapper = mapper(Input, Output, Operation)
map([], _, []).
map([H | T], M, [H2 | T2]) :-
    map(T, M, T2),
    copy_term(M, mapper(H, H2, OP)),
    call(OP).

% filter(+List, +Tester, -OutList)
% Tester = tester(Input, Condition)
filter([], _, []).
% Se H soddisfa lo condizione, lo tengo, uso ! per evitare di provare la condizione di scartarlo, se ho deciso di tenerlo
filter([H | T], P, [H | T2]) :-
    copy_term(P, tester(H, OP)),
    call(OP),
    !,
    filter(T, P, T2).
% Se H non soddisfa la condizione lo scarto
filter([_ | T], P, T2) :-
    filter(T, P, T2).

% foldleft(+List, +Folder, +Acc0, -Result)
% Folder = folder(AccIn, Elem, AccOut, Operation)
% foldleft([10,20,30], folder(Acc, X, R, R is Acc + X), 0, S).
foldleft([], _, Acc, Acc).
foldleft([H | T], F, Acc0, Result) :-
    copy_term(F, folder(Acc0, H, Acc1, OP)),
    call(OP),
    foldleft(T, F, Acc1, Result).