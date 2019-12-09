% Main function, start the game
main:-
get_input(Mines),
numList(Mines, MinesList),
get_input2(MinesList, [], PList, CList, NewCList, 1).




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
nl, nl, write('Choice(Type e, m, or h): '), read(Choice),
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
random(1, 12, X),
append(L1, [X], XList).


getXList(Loop, L1, XList):-
random(1, 12, X),
append(L1, [X], Result),
L is Loop-1, getXList(L, Result, XList).

%produce YList
getYList(1, L1, YList):-
random(1, 10, Y),
append(L1, [Y], YList).


getYList(Loop, L1, YList):-
random(1, 10, Y),
append(L1, [Y], Result),
L is Loop-1, getYList(L, Result, YList).
%%%%__________MaKing List of Mine Location section end________________________%


%Ending the game without win or lose
get_input2(MinesList, PList, PList, CList, NewCList, 0):-
nl, write('User chose to quit'), nl.


%A loop to keep asking for player input of guesses and flags
get_input2(MinesList, PList, NewPList, CList, NewCList, 1):-
nl, printboard(PList,MinesList,CList),
nl, write('Guess X Location(Enter one number): '), read(X),
write('Guess Y Location(Enter one number): '), read(Y),
checkList([X,Y], MinesList),
nl, write('Type 1 to continue guessing, 2 to put down a flag and anything else to stop: '), read(Choice),
(Choice is 1 -> get_input2(MinesList, [[X,Y]|PList], NewPList, CList, NewCList, 1);
Choice is 2 -> flag(MinesList, PList, NewPList, CList, NewCList, X,Y);
get_input2(MinesList, [[X,Y]|PList], NewPList, CList, NewCList, 0)),!.


%Take user input and mark flag location
flag(MinesList, PList, NewPList, CList, NewCList, X,Y):-
nl, write('Flag X Location(Enter one number): '), read(Q),
write('Flag Y Location(Enter one number): '), read(W),
get_input2(MinesList, [[X,Y]|PList], NewPList, [[Q,W]|CList], NewCList, 1).


%the UserGuess should be sent in format [X, Y]
checkList(Guess, []).

checkList(Guess, [Guess|_]):-
nl, write('Hit a mine, GAME OVER!'),
halt.

checkList(Guess, [_|Rest]):-
checkList(Guess, Rest).

%Use player input to make a list to update the board
checkPList([X,Y], [],[],MinesList):-
write(' ').

checkPList([X,Y], [[X,Y]|_],_,MinesList):-
checkAround(X,Y,MinesList).

checkPList([X,Y], [_|Rest],_,MinesList):-
checkPList([X,Y], Rest,_,MinesList).


%Use player input to update the board with flags
checkCList([X,Y], [],MinesList).

checkCList([X,Y], [[X,Y]|_],MinesList):-
write('\bF').

checkCList([X,Y], [_|Rest],MinesList):-
checkCList([X,Y], Rest,MinesList).


%Member function to check a list
member(X, [Y|T]) :- X = Y; member(X, T).


%Checking each unit on the board
board(X,Y,PList,MinesList,CList):-
checkPList([X,Y], PList,CList,MinesList),
checkCList([X,Y], CList,MinesList).


%Display the board
printboard(PList,MinesList,CList):-
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('1 | '), board(1,1,PList,MinesList,CList), write(' | '), board(2,1,PList,MinesList,CList), write(' | '), board(3,1,PList,MinesList,CList), write(' | '), board(4,1,PList,MinesList,CList), write(' | '), board(5,1,PList,MinesList,CList), write(' | '), board(6,1,PList,MinesList,CList), write(' | '), board(7,1,PList,MinesList,CList), write(' | '), board(8,1,PList,MinesList,CList), write(' | '), board(9,1,PList,MinesList,CList), write(' | '), board(10,1,PList,MinesList,CList), write(' | '), board(11,1,PList,MinesList,CList), write(' | '), board(12,1,PList,MinesList,CList), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('2 | '), board(1,2,PList,MinesList,CList), write(' | '), board(2,2,PList,MinesList,CList), write(' | '), board(3,2,PList,MinesList,CList), write(' | '), board(4,2,PList,MinesList,CList), write(' | '), board(5,2,PList,MinesList,CList), write(' | '), board(6,2,PList,MinesList,CList), write(' | '), board(7,2,PList,MinesList,CList), write(' | '), board(8,2,PList,MinesList,CList), write(' | '), board(9,2,PList,MinesList,CList), write(' | '), board(10,2,PList,MinesList,CList), write(' | '), board(11,2,PList,MinesList,CList), write(' | '), board(12,2,PList,MinesList,CList), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('3 | '), board(1,3,PList,MinesList,CList), write(' | '), board(2,3,PList,MinesList,CList), write(' | '), board(3,3,PList,MinesList,CList), write(' | '), board(4,3,PList,MinesList,CList), write(' | '), board(5,3,PList,MinesList,CList), write(' | '), board(6,3,PList,MinesList,CList), write(' | '), board(7,3,PList,MinesList,CList), write(' | '), board(8,3,PList,MinesList,CList), write(' | '), board(9,3,PList,MinesList,CList), write(' | '), board(10,3,PList,MinesList,CList), write(' | '), board(11,3,PList,MinesList,CList), write(' | '), board(12,3,PList,MinesList,CList), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('4 | '), board(1,4,PList,MinesList,CList), write(' | '), board(2,4,PList,MinesList,CList), write(' | '), board(3,4,PList,MinesList,CList), write(' | '), board(4,4,PList,MinesList,CList), write(' | '), board(5,4,PList,MinesList,CList), write(' | '), board(6,4,PList,MinesList,CList), write(' | '), board(7,4,PList,MinesList,CList), write(' | '), board(8,4,PList,MinesList,CList), write(' | '), board(9,4,PList,MinesList,CList), write(' | '), board(10,4,PList,MinesList,CList), write(' | '), board(11,4,PList,MinesList,CList), write(' | '), board(12,4,PList,MinesList,CList), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('5 | '), board(1,5,PList,MinesList,CList), write(' | '), board(2,5,PList,MinesList,CList), write(' | '), board(3,5,PList,MinesList,CList), write(' | '), board(4,5,PList,MinesList,CList), write(' | '), board(5,5,PList,MinesList,CList), write(' | '), board(6,5,PList,MinesList,CList), write(' | '), board(7,5,PList,MinesList,CList), write(' | '), board(8,5,PList,MinesList,CList), write(' | '), board(9,5,PList,MinesList,CList), write(' | '), board(10,5,PList,MinesList,CList), write(' | '), board(11,5,PList,MinesList,CList), write(' | '), board(12,5,PList,MinesList,CList), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('6 | '), board(1,6,PList,MinesList,CList), write(' | '), board(2,6,PList,MinesList,CList), write(' | '), board(3,6,PList,MinesList,CList), write(' | '), board(4,6,PList,MinesList,CList), write(' | '), board(5,6,PList,MinesList,CList), write(' | '), board(6,6,PList,MinesList,CList), write(' | '), board(7,6,PList,MinesList,CList), write(' | '), board(8,6,PList,MinesList,CList), write(' | '), board(9,6,PList,MinesList,CList), write(' | '), board(10,6,PList,MinesList,CList), write(' | '), board(11,6,PList,MinesList,CList), write(' | '), board(12,6,PList,MinesList,CList), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('7 | '), board(1,7,PList,MinesList,CList), write(' | '), board(2,7,PList,MinesList,CList), write(' | '), board(3,7,PList,MinesList,CList), write(' | '), board(4,7,PList,MinesList,CList), write(' | '), board(5,7,PList,MinesList,CList), write(' | '), board(6,7,PList,MinesList,CList), write(' | '), board(7,7,PList,MinesList,CList), write(' | '), board(8,7,PList,MinesList,CList), write(' | '), board(9,7,PList,MinesList,CList), write(' | '), board(10,7,PList,MinesList,CList), write(' | '), board(11,7,PList,MinesList,CList), write(' | '), board(12,7,PList,MinesList,CList), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('8 | '), board(1,8,PList,MinesList,CList), write(' | '), board(2,8,PList,MinesList,CList), write(' | '), board(3,8,PList,MinesList,CList), write(' | '), board(4,8,PList,MinesList,CList), write(' | '), board(5,8,PList,MinesList,CList), write(' | '), board(6,8,PList,MinesList,CList), write(' | '), board(7,8,PList,MinesList,CList), write(' | '), board(8,8,PList,MinesList,CList), write(' | '), board(9,8,PList,MinesList,CList), write(' | '), board(10,8,PList,MinesList,CList), write(' | '), board(11,8,PList,MinesList,CList), write(' | '), board(12,8,PList,MinesList,CList), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('9 | '), board(1,9,PList,MinesList,CList), write(' | '), board(2,9,PList,MinesList,CList), write(' | '), board(3,9,PList,MinesList,CList), write(' | '), board(4,9,PList,MinesList,CList), write(' | '), board(5,9,PList,MinesList,CList), write(' | '), board(6,9,PList,MinesList,CList), write(' | '), board(7,9,PList,MinesList,CList), write(' | '), board(8,9,PList,MinesList,CList), write(' | '), board(9,9,PList,MinesList,CList), write(' | '), board(10,9,PList,MinesList,CList), write(' | '), board(11,9,PList,MinesList,CList), write(' | '), board(12,9,PList,MinesList,CList), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('10| '), board(1,10,PList,MinesList,CList), write(' | '), board(2,10,PList,MinesList,CList), write(' | '), board(3,10,PList,MinesList,CList), write(' | '), board(4,10,PList,MinesList,CList), write(' | '), board(5,10,PList,MinesList,CList), write(' | '), board(6,10,PList,MinesList,CList), write(' | '), board(7,10,PList,MinesList,CList), write(' | '), board(8,10,PList,MinesList,CList), write(' | '), board(9,10,PList,MinesList,CList), write(' | '), board(10,10,PList,MinesList,CList), write(' | '), board(11,10,PList,MinesList,CList), write(' | '), board(12,10,PList,MinesList,CList), write(' | '), nl,
write('  +---+---+---+---+---+---+---+---+---+---+---+---+'), nl,
write('    1   2   3   4   5   6   7   8   9   10  11  12'), nl.


%The win condition, when all mines have a flag
win(MinesList, CList) :-
sort(MinesList, SortedMines),
sort(CList, SortedCList),
Sorted1 == Sorted2,
write('WINNER!').


%To calculate the numbers for each unit on the board that is not a mine by checking surrounding units
checkAround(X,Y,MinesList):-
C1 is 0,
Q is X-1,
W is X+1,
E is Y-1,
R is Y+1,
(member([Q,R], MinesList), C2 is C1+1; \+member([Q,R], MinesList), C2 is C1),
(member([X,R], MinesList), C3 is C2+1; \+member([X,R], MinesList), C3 is C2),
(member([W,R], MinesList), C4 is C3+1; \+member([W,R], MinesList), C4 is C3),
(member([Q,Y], MinesList), C5 is C4+1; \+member([Q,Y], MinesList), C5 is C4),
(member([W,Y], MinesList), C6 is C5+1; \+member([W,Y], MinesList), C6 is C5),
(member([Q,E], MinesList), C7 is C6+1; \+member([Q,E], MinesList), C7 is C6),
(member([X,E], MinesList), C8 is C7+1; \+member([X,E], MinesList), C8 is C7),
(member([W,E], MinesList), C9 is C8+1; \+member([W,E], MinesList), C9 is C8),
write(C9).
