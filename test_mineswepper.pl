main:-
get_input(Mines),
nl, write('Amount of Mines: '),
write(Mines),
%numList(Mines, XList, YList).
nl, write('X List: '), displayList(XList),
nl, write('Y List: '), displayList(YList).


difficulty(e, 15).
difficulty(m, 19).
difficulty(h, 25).



get_input(Mines):-
nl, write('Choose your difficulty:'),
nl, write('e: Easy'),
nl, write('m: Medium'),
nl, write('h: Hard'),
nl, read(Choice),
difficulty(Choice, Mines), !.

displayList([]).

displayList([H|T]):-
write(H), write(' '),
displayList(T).




%produce a list of X and Y values
numList(Loop, XList, YList):-
random(1, 10, X),
random(1, 12, Y),
L is Loop-1, numList(L, [XList|X], [YList|Y]).

numList(-1, _, _).
