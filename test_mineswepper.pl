
main:-
get_input(Mines),
nl, write('Amount of Mines: '),
write(Mines),
numList(Mines, MinesList),
nl, write('Mines List: '), minesList(MinesList),
nl.


%list number of mines with each difficulty level
difficulty(e, 15).
difficulty(m, 19).
difficulty(h, 25).


%get number of mines after user select difficulty level
get_input(Mines):-
nl, write('Choose your difficulty:'),
nl, write('e: Easy'),
nl, write('m: Medium'),
nl, write('h: Hard'),
nl, nl, write('Choice: '), read(Choice),
difficulty(Choice, Mines), !.

%printing out what inside the XList and YList
minesList([]).

minesList([H|T]):-
write(H), write(' '),
minesList(T).


%produce a list of X and Y values
numList(Loop, NewMineList):-
getXList(Loop, [], XList),
getYList(Loop, [], YList),
makeMineList(XList, YList, MineList),
checkIfRepeat(MineList, NewMineList).

%check if any of the mines location repeat
checkIfRepeat(MineList, MineList).

checkIfRepeat([L1|Rest], NewList):-
member(L1, Rest), 
random(1, 10, X), random(1, 12, Y),
append(Rest, [x, Y], L2), checkIfRepeat(L2, NewList).


%combine each X in XList and Y in YList to make mineList [X, Y]
makeMineList([], [], []).

makeMineList([X|RestofX], [Y|RestofY], [[X, Y]|Rest]):-
makeMineList(RestofX, RestofY, Rest).


%produce XList
getXList(1, L1, XList):-
random(1, 10, X),
append(L1, [X], XList).


getXList(Loop, L1, XList):-
random(1, 10, X),
append(L1, [X], Result),
L is Loop-1, getXList(L, Result, XList).

%produce YList
getYList(1, L1, YList):-
random(1, 12, Y),
append(L1, [Y], YList).


getYList(Loop, L1, YList):-
random(1, 12, Y),
append(L1, [Y], Result),
L is Loop-1, getYList(L, Result, YList).
