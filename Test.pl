% Main function, start the game
main:-
get_input(Mines),
nl, write('Amount of Mines: '),
write(Mines),
numList(Mines, MinesList),
nl, write('Mines List: '), minesList(MinesList),
nl,
get_input2(MinesList, [], PList),
nl,
write(PList), nl,
printboard.




%%%%__________MaKing List of Mine Location code below________________________%
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
append(Rest, [X, Y], L2), checkIfRepeat(L2, NewList).


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
%%%%__________MaKing List of Mine Location section end________________________%

get_input2(MinesList, PList, NewPList):-
nl, write('Taking User Guess.'),
nl, write('Guess X Location: '), read(X),
nl, write('Guess Y Location: '), read(Y),
checkList([X,Y], MinesList), 
append(PList, [X,Y], NewPList),
!.


%the UserGuess should be sent in format [X, Y]
checkList(Guess, []):-
nl, write('No mine at the location.').

checkList(Guess, [Guess|_]):-
nl, write('Found a mine').

checkList(Guess, [_|Rest]):-
checkList(Guess, Rest).


checkPList(Guess, []):-
write('?').

checkPList(Guess, [Guess|_]):-
write(' ').

checkPList(Guess, [_|Rest]):-
checkList(Guess, Rest).

board(X,Y):-
checkPList([X,Y], PList).

printboard:-
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,1), write(' | '), board(2,1), write(' | '), board(3,1), write(' | '), board(4,1), write(' | '), board(5,1), write(' | '), board(6,1), write(' | '), board(7,1), write(' | '), board(8,1), write(' | '), board(9,1), write(' | '), board(10,1), write(' | '), board(11,1), write(' | '), board(12,1), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,2), write(' | '), board(2,2), write(' | '), board(3,2), write(' | '), board(4,2), write(' | '), board(5,2), write(' | '), board(6,2), write(' | '), board(7,2), write(' | '), board(8,2), write(' | '), board(9,2), write(' | '), board(10,2), write(' | '), board(11,2), write(' | '), board(12,2), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,3), write(' | '), board(2,3), write(' | '), board(3,3), write(' | '), board(4,3), write(' | '), board(5,3), write(' | '), board(6,3), write(' | '), board(7,3), write(' | '), board(8,3), write(' | '), board(9,3), write(' | '), board(10,3), write(' | '), board(11,3), write(' | '), board(12,3), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,4), write(' | '), board(2,4), write(' | '), board(3,4), write(' | '), board(4,4), write(' | '), board(5,4), write(' | '), board(6,4), write(' | '), board(7,4), write(' | '), board(8,4), write(' | '), board(9,4), write(' | '), board(10,4), write(' | '), board(11,4), write(' | '), board(12,4), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,5), write(' | '), board(2,5), write(' | '), board(3,5), write(' | '), board(4,5), write(' | '), board(5,5), write(' | '), board(6,5), write(' | '), board(7,5), write(' | '), board(8,5), write(' | '), board(9,5), write(' | '), board(10,5), write(' | '), board(11,5), write(' | '), board(12,5), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,6), write(' | '), board(2,6), write(' | '), board(3,6), write(' | '), board(4,6), write(' | '), board(5,6), write(' | '), board(6,6), write(' | '), board(7,6), write(' | '), board(8,6), write(' | '), board(9,6), write(' | '), board(10,6), write(' | '), board(11,6), write(' | '), board(12,6), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,7), write(' | '), board(2,7), write(' | '), board(3,7), write(' | '), board(4,7), write(' | '), board(5,7), write(' | '), board(6,7), write(' | '), board(7,7), write(' | '), board(8,7), write(' | '), board(9,7), write(' | '), board(10,7), write(' | '), board(11,7), write(' | '), board(12,7), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,8), write(' | '), board(2,8), write(' | '), board(3,8), write(' | '), board(4,8), write(' | '), board(5,8), write(' | '), board(6,8), write(' | '), board(7,8), write(' | '), board(8,8), write(' | '), board(9,8), write(' | '), board(10,8), write(' | '), board(11,8), write(' | '), board(12,8), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,9), write(' | '), board(2,9), write(' | '), board(3,9), write(' | '), board(4,9), write(' | '), board(5,9), write(' | '), board(6,9), write(' | '), board(7,9), write(' | '), board(8,9), write(' | '), board(9,9), write(' | '), board(10,9), write(' | '), board(11,9), write(' | '), board(12,9), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,10), write(' | '), board(2,10), write(' | '), board(3,10), write(' | '), board(4,10), write(' | '), board(5,10), write(' | '), board(6,10), write(' | '), board(7,10), write(' | '), board(8,10), write(' | '), board(9,10), write(' | '), board(10,10), write(' | '), board(11,10), write(' | '), board(12,10), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('    1   2   3   4   5   6   7   8   9   10  11  12').

%%%%__________Player Inputs________________________%
%Hit a mine
