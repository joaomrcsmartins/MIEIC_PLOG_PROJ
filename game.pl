%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDE FILES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- consult('boardDisplay.pl').
:- consult('boards.pl').
:- consult('verifyGameState.pl').
:- consult('filling.pl').
:- consult('adjacents.pl').
:- consult('computer.pl').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HELPER FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

list_empty([]).

switch(X,[Val:Goal | Cases]) :-
  (X=Val -> call(Goal) ; switch(X, Cases)).

printPossibleMoves([]).
printPossibleMoves([[Coord|_]|Rest]):-
  print(Coord),print(','),
  printPossibleMoves(Rest).

getTriangleUp(X,Y,Board,Piece):-
  getPiece(X,Y,Board,PieceAux),
  PieceAux = [Piece|_].   

getTriangleDown(X,Y,Board,Piece):-
  getPiece(X,Y,Board,PieceAux),
  PieceAux = [_|[Piece|_]].

isT(Id):- (Id == 3;Id ==4; Id ==5; Id ==6).

% Get Id from Pieces [ [Row,Col], [Cor,Id] ] 
% Use in auxiliar structure and valid_plays
getId(Piece,Id):-
  [_|[Id|_]] = Piece.

isR(Id):- (Id == 1;Id ==2).

isRectangle(Piece,Id):-
  getId(Piece,IdAux),
  isR(IdAux),
  Id is IdAux.

%Conversion from Id to T 
%used for functions
isTri(ID,Tri) :-
  ID == 0, Tri = -1;
  (ID == 1; ID == 2), Tri = -2;
  (ID == 3; ID == 5), Tri = 0;
  (ID == 4; ID == 6), Tri = 1.

getOposPlayer(Player,Opos) :-
  (Player == 1, Opos = 2);
  (Player == 2, Opos = 1).  

%get piece full info
getFullPiece(Col,Row,Board,[[_,_],Info]) :-
  getPiece(Col,Row,Board,Info).

%get piece from board based on X and Y position
getPiece(Col,Row,Board,Piece):-
  nth1(Row,Board,RowAux,_),
  nth1(Col,RowAux,Piece,_).

getShapeRecSq(Row,Col,Board,PieceAux,T):-
      getPiece(Col,Row,Board,PieceAux),
      getId(PieceAux,Id),
      isTri(Id,T).

%get shape 
getShapeAddCoord(Board,Row,Col,Tri,Tout,Piece) :-
  switch(Tri,[
    -1:getShapeRecSq(Row,Col,Board,PieceAux,Tout),
    0: (getTriangleUp(Col,Row,Board,PieceAux), Tout is Tri),
    1: (getTriangleDown(Col,Row,Board,PieceAux),  Tout is Tri)
  ]),
  append([[Row,Col]],[PieceAux],Piece).


%___________________Auxiliar structure Aux - help functions _______________________%

%add other pieces to auxiliar structure
addAuxSq(X,Y,Board,AuxIn,AuxOut):-
    getPiece(X,Y,Board,Piece),               %get piece
    append([[[Y,X],Piece]], AuxIn, AuxOut).        %add to auxiliar structure

addAuxRec(X,Y,Board,AuxIn,AuxOut):-
    getPiece(X,Y,Board,Piece),               
    adjRect(Board,Y,_,X,Pieces,Piece), 
    append(Pieces, AuxIn, AuxOut).



%add triangle up to auxiliar structure
addAuxTriangleUp(X,Y,Board,AuxIn,AuxOut):-
  getTriangleUp(X,Y,Board,Piece),          
  append([[[Y,X],Piece]], AuxIn, AuxOut).

%add triangle down to auxiliar structure
addAuxTriangleDown(X,Y,Board,AuxIn,AuxOut):-
  getTriangleDown(X,Y,Board,Piece),
  append([[[Y,X],Piece]], AuxIn, AuxOut).


%____________________ Possible plays - help functions ________________________________%

%Adds to a list adjacent pieces of the ones already played on board
validMovesAux(_,[],PossiblePlaysOut,PossiblePlaysOut).
validMovesAux(Board,[Piece|Rest],PossiblePlaysIn,PossiblePlaysOut):-
  lookForAdjacent(Board,Piece, Adjacents),
  append(Adjacents,PossiblePlaysIn,T),
  sort(T,T1),
  validMovesAux(Board,Rest,T1,PossiblePlaysOut).

%remove pieces from possible plays -
%used to remove pieces that were already played
removePiecesOnBoard([],List2,List2).
removePiecesOnBoard([Piece|Rest],List,List2):-
  delete(List,Piece,T),
  removePiecesOnBoard(Rest,T,List2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GAME LOGIC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% State: 0 - continue; 1- Player 1 wins; 2- Player 2 wins; 3- Tie game
game_over(State):-
  (State == 0);
  (State == 1, winMessage(State),fail);
  (State == 2, winMessage(State),fail);
  (State == 3, tieMessage(),fail).

%validate play
%Pieces - [ [Row,Col], [Color,Id] ]
validPlay(Piece,PossiblePlays):-
  (list_empty(PossiblePlays),
   Piece = [_|[Info|_]],
   getId(Info,Id),
   isT(Id));
  member(Piece,PossiblePlays).

%calculate next possible plays based on already played pieces(aux)
valid_moves(Board,Aux,NoAux):-
  validMovesAux(Board,Aux,[],PossiblePlaysOut),          %adds all adjacent pieces to the ones played on the board
  removePiecesOnBoard(Aux,PossiblePlaysOut,NoAux).          %removes from list of adjacents the pieces that were already played

%add piece to auxiliar structure
addPlayAux(AuxIn,Board,X,Y,T, AuxOut):-
    switch(T,[
    -1:addAuxSq(X,Y,Board,AuxIn,AuxOut),
    -2:addAuxRec(X,Y,Board,AuxIn,AuxOut),
    0:addAuxTriangleUp(X,Y,Board,AuxIn,AuxOut),
    1:addAuxTriangleDown(X,Y,Board,AuxIn,AuxOut)
  ]).

%need to calculate for rectangles too
lookForAdjacent(Board,[Coord|[Info|_]],Adjacents):-
    (getId(Info,Id),
    Coord = [Row|[Col|_]]),
    ((Id == 3, adjacentUp3(Board,Col,Row,Adjacents));
    (Id == 4, adjacentDown4(Board,Col,Row,Adjacents));
    (Id == 5, adjacentUp5(Board,Row,Col,Adjacents));
    (Id == 6, adjacentDown6(Board,Col,Row,Adjacents));
    (Id == 0,adjacentSquare(Board,Col,Row,Adjacents));
    ((Id == 1; Id == 2),adjacentRectangle(Board,Col,Row,Adjacents) )
    ).
  
move(Player, Board, AuxIn, AuxOut,BoardOut,StateOut):-
    display_game(Board,Player),!,                   %display board
    valid_moves(Board,AuxIn,PossiblePlays),
    print('Possible Plays'),nl,
    printPossibleMoves(PossiblePlays),nl,
    repeat,
    getPlayInfo(Col,Row,T),
    getShapeAddCoord(Board,Row,Col,T,Tout,Piece),
    validPlay(Piece,PossiblePlays),
    fillPiece(Board,Row,Col,Tout,Player,BoardOut),        %fill piece with player color
    addPlayAux(AuxIn,BoardOut,Col,Row,Tout, AuxOut),
    value(BoardOut,AuxOut,StateOut).

twoPlayerGame(Board,Aux):-
    move(1,Board,Aux,Aux2,BoardOut,StateOut),!,
    game_over(StateOut),
    move(2,BoardOut,Aux2,AuxF,BoardOut2,StateOut2),!,
    game_over(StateOut2),!,
    twoPlayerGame(BoardOut2,AuxF).                      

cpuHumanGame(Board,Aux) :-
  moveCPU(1,Board,Aux,Aux2,BoardOut,StateOut),!,
  game_over(StateOut),
  move(2,BoardOut,Aux2,AuxF,BoardOut2,StateOut2),!,
  game_over(StateOut2),!,
  cpuHumanGame(BoardOut2,AuxF).

humanCPUGame(Board,Aux) :-
  move(1,BoardOut,Aux,Aux2,BoardOut,StateOut),!,
  game_over(StateOut),
  moveCPU(2,Board,Au2,AuxF,BoardOut2,StateOut2),!,
  game_over(StateOut2),!,
  humanCPUGame(BoardOut2,AuxF).

twoComputerGame(Board,Aux) :-
  moveCPU(1,Board,Aux,Aux2,BoardOut,StateOut),!,
  game_over(StateOut),
  moveCPU(2,BoardOut,Aux2,AuxF,BoardOut2,StateOut2),!,
  game_over(StateOut2),!,
  twoComputerGame(BoardOut2,AuxF).

play_mode(Option) :-
  buildBlankList(L),
  ((Option == 0, twoPlayerGame(L,[]));
  (Option == 1, cpuHumanGame(L,[]));
  (Option == 2, humanCPUGame(L,[]));
  (Option == 3, twoComputerGame(L,[]))).

getOption(Option) :-
  read_line_to_codes(user_input,Codes),
  length(Codes,N), 
  (N == 1; (writef("Invalid option selected"),nl)),
  nth0(0,Codes,Code),
  Option is Code - 48.
  
play() :-
  writef("Welcome to Boco. Choose game mode: "),nl,
  repeat,
  writef('0 - Human Vs Human'),nl,
  writef('1 - Human Vs Computer'),nl,
  writef('2 - Computer Vs Human'),nl, 
  writef('3 - Computer Vs Computer'),nl,
  getOption(Option),
  play_mode(Option).