
%adjacents to triangle5
adjacentUp5(Board,Row,Col,Adjacents):-
  Colmore is Col +1,
  Rowless is Row-1,
  getPiece(Colmore,Row,Board,Piece1), %este
  getTriangleDown(Col,Row,Board,Piece2),
  getPiece(Col,Rowless,Board,Piece3), %este
   ((isRectangle(Piece1,_),isRectangle(Piece3,_),
  adjRect(Board,Row,Colmore,Pieces1,Piece1),
  adjRect(Board,Rowless,Col,Pieces2,Piece3),
  append(Pieces1,Pieces2,Aux),
  append([ [[Row,Col],Piece2] ] ,Aux,Adjacents));
  (isRectangle(Piece1,_),
  adjRect(Board,Row,Colmore,Pieces1,Piece1),
  append([ [[Row,Col],Piece2] , [[Col,Rowless],Piece3] ] ,Pieces1,Adjacents));
  (isRectangle(Piece3,_),
  adjRect(Board,Rowless,Col,Pieces1,Piece3),
  append([ [[Row,Col],Piece2] , [[Row,Colmore],Piece1] ] ,Pieces1,Adjacents));
  append([  [[Row,Colmore],Piece1],  [[Row,Col],Piece2], [ [Rowless,Col], Piece3]],[],Adjacents)).

%adjacents to triangle3
adjacentUp3(Board,Col,Row,Adjacents):-
  Colless is Col-1,
  Rowless is Row-1,
  getPiece(Colless,Row,Board,Piece1),
  getTriangleDown(Col,Row,Board,Piece2),
  getPiece(Col,Rowless,Board,Piece3),
  ((isRectangle(Piece1,_),
  adjRect(Board,Row,Colless,Pieces,Piece1),
  append([ [[Row,Col],Piece2], [ [Rowless,Col], Piece3]],Pieces,Adjacents));
  append([  [[Row,Colless],Piece1],  [[Row,Col],Piece2], [ [Rowless,Col], Piece3]],[],Adjacents)).

%adjacents to triangle4
adjacentDown4(Board,Col,Row,Adjacents):-
  Colmore is Col +1,
  Rowmore is Row+1,
  getPiece(Colmore,Row,Board,Piece1),
  getTriangleUp(Col,Row,Board,Piece2),
  getPiece(Col,Rowmore,Board,Piece3),
  ((isRectangle(Piece3,_),
  adjRect(Board,Rowmore,Col,Pieces,Piece3),
  append([  [[Row,Colmore],Piece1],[[Row,Col],Piece2]],Pieces,Adjacents));
  append([  [[Row,Colmore],Piece1],  [[Row,Col],Piece2], [ [Rowmore,Col], Piece3]],[],Adjacents)).

%adjacent to triangle6
adjacentDown6(Board,Col,Row,Adjacents):-
  Colless is Col -1,
  Rowmore is Row+1,
  getPiece(Colless,Row,Board,Piece1),
  getTriangleUp(Col,Row,Board,Piece2),
  getPiece(Col,Rowmore,Board,Piece3),
  append([  [[Row,Colless],Piece1],  [[Row,Col],Piece2], [ [Rowmore,Col], Piece3]],[],Adjacents).

%adjacents of squares in case of left top unit in board (not counting rectangles)
adjacentSquareLeftTop(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless):-
  getTriangleDown(Colmore,Row,Board,Piece1),
  getPiece(Colless,Row,Board,Piece2),
  adjRect(Board,Row,Colless,Pieces1,Piece2),
  getTriangleUp(Col,Rowmore,Board,Piece4),
  getPiece(Col,Rowless,Board,Piece3),
  adjRect(Board,Rowless,Col,Pieces2,Piece3),
  append(Pieces1,Pieces2,Aux),
  append([  [[Row,Colmore],Piece1], [[Rowless,Col],Piece4]],Aux,Adjacents).

%adjacents of squares in case of left column in board (not counting rectangles)
adjacentSquareLeft(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless):-
  getTriangleDown(Colmore,Row,Board,Piece1),
  getPiece(Colless,Row,Board,Piece2),
  adjRect(Board,Row,Colless,Pieces1,Piece2),
  getTriangleDown(Col,Rowmore,Board,Piece3),
  getTriangleUp(Col,Rowless,Board,Piece4),
  append([  [[Row,Colmore],Piece1],[ [Rowmore,Col], Piece3], [[Rowless,Col],Piece4]],Pieces1,Adjacents).

%adjacents of squares in case of top line in board (not counting rectangles)
adjacentSquareTop(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless):-
  getTriangleDown(Colmore,Row,Board,Piece1),
  getTriangleUp(Colless,Row,Board,Piece2),
  getTriangleUp(Col,Rowmore,Board,Piece3),
  getPiece(Col,Rowless,Board,Piece4),
  adjRect(Board,Rowless,Col,Pieces1,Piece4),
  append([  [[Row,Colmore],Piece1],  [[Row,Colless],Piece2], [ [Rowmore,Col], Piece3]],Pieces1,Adjacents).

%adjacents of squares in case of right bottom unit in board (not counting rectangles)
adjacentSquareRightBottom(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless):-
  getPiece(Colmore,Row,Board,Piece1),
  adjRect(Board,Row,Colmore,Pieces1,Piece1),
  getTriangleDown(Colless,Row,Board,Piece2),
  getPiece(Col,Rowmore,Board,Piece4),
  adjRect(Board,Rowmore,Col,Pieces2,Piece4),
  print(Pieces2),nl,
  getTriangleDown(Col,Rowless,Board,Piece3),
  append(Pieces1,Pieces2,Aux),
  append([  [[Row,Colless],Piece2], [ [Rowmore,Col], Piece3] ],Aux,Adjacents).

%adjacents of squares in case of bottom line in board (not counting rectangles)
adjacentSquareBottom(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless):-
  getTriangleUp(Colmore,Row,Board,Piece1),
  getTriangleDown(Colless,Row,Board,Piece2),
  getPiece(Col,Rowmore,Board,Piece3),
  adjRect(Board,Rowmore,Col,Pieces,Piece3),
  getTriangleDown(Col,Rowless,Board,Piece4),
  append([  [[Row,Colmore],Piece1],  [[Row,Colless],Piece2], [[Rowless,Col],Piece4]],Pieces,Adjacents).

%adjacents of squares in case of right column in board (not counting rectangles)
adjacentSquareRight(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless):-
  getPiece(Colmore,Row,Board,Piece1),
  adjRect(Board,Row,Colmore,Pieces,Piece1),
  getTriangleDown(Colless,Row,Board,Piece2),
  getTriangleDown(Col,Rowmore,Board,Piece3),
  getTriangleUp(Col,Rowless,Board,Piece4),
  append([ [[Row,Colless],Piece2], [ [Rowmore,Col], Piece3], [[Rowless,Col],Piece4]],Pieces,Adjacents).

%adjacents of squares in even rows
adjacentSquareEvenRows(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless):-
  getTriangleDown(Colmore,Row,Board,Piece1),
  getTriangleUp(Colless,Row,Board,Piece2),
  getTriangleUp(Col,Rowmore,Board,Piece3),
  getTriangleDown(Col,Rowless,Board,Piece4),
  append([  [[Row,Colmore],Piece1],  [[Row,Colless],Piece2], [ [Rowmore,Col], Piece3], [[Rowless,Col],Piece4]],[],Adjacents).

%adjacents of squares in odd rows
adjacentSquareOddRows(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless):-
  getTriangleUp(Colmore,Row,Board,Piece1),
  getTriangleDown(Colless,Row,Board,Piece2),
  getTriangleUp(Col,Rowmore,Board,Piece3),
  getTriangleDown(Col,Rowless,Board,Piece4),
  append([  [[Row,Colmore],Piece1],  [[Row,Colless],Piece2], [ [Rowmore,Col], Piece3], [[Rowless,Col],Piece4]],[],Adjacents).

%adjacents of squares 
adjacentSquare(Board,Col,Row,Adjacents):-
  Colless is Col -1,
  Rowmore is Row+1,
  Colmore is Col +1,
  Rowless is Row-1,
  Mod is Col mod 2,

  ((Col == 2, Row==2,
    adjacentSquareLeftTop(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless));
  (Col== 2,
    adjacentSquareLeft(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless));
  (Row == 2,
    adjacentSquareTop(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless));
  (Col==9,Row==9,
    adjacentSquareRightBottom(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless));
  (Row ==9,
    adjacentSquareBottom(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless));
  (Col==9,
    adjacentSquareRight(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless));
  (Mod == 0,
    adjacentSquareEvenRows(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless));
  adjacentSquareOddRows(Col,Row,Board,Adjacents,Colmore,Colless,Rowmore,Rowless)).


adjRectVert(_,Row,Col,ID,IDB,PiecesOutA,PiecesOut,Piece)  :-
  (Row @< 1; Row @>10; ID \= IDB; member([[Row,Col],Piece],PiecesOutA)),
  PiecesOut = PiecesOutA.

adjRectVert(Board,Row,Col,Id,Id,Pieces,PiecesOut,Piece) :-
  append( [[[Row,Col],Piece]] ,Pieces,PiecesAux),
  RowB is Row - 1,
  RowA is Row + 1,
  (RowB @< 1; 
  RowA @> 10;
  (getPiece(Col,RowA,Board,Piece1),
  getId(Piece1,IdA),
  getPiece(Col,RowB,Board,Piece2),
  getId(Piece2,IdB))),
  adjRectVert(Board,RowA,Col,Id,IdA,PiecesAux,PiecesOut2,Piece1),
  adjRectVert(Board,RowB,Col,Id,IdB,PiecesOut2,PiecesOut,Piece2).

adjRectHorz(_,Row,Col,ID,IDB,PiecesOutA,PiecesOut,Piece) :-
  (Col @< 1; Col @>10; ID \= IDB; member([[Row,Col],Piece],PiecesOutA)),
  PiecesOut = PiecesOutA.

adjRectHorz(Board,Row,Col,Id,Id,Pieces,PiecesOut,Piece) :-
  append(  [[[Row,Col],Piece]] ,Pieces, PiecesAux),
  ColB is Col - 1,
  ColA is Col + 1,
  (ColB @< 1; 
  ColA @> 10;
  (getPiece(ColA,Row,Board,Piece1),
  getId(Piece1,IdA),
  getPiece(ColB,Row,Board,Piece2),
  getId(Piece2,IdB))),
  adjRectHorz(Board,Row,ColA,Id,IdA,PiecesAux,PiecesOut2,Piece1),
  adjRectHorz(Board,Row,ColB,Id,IdB,PiecesOut2,PiecesOut,Piece2).


adjRect(Board,Row,Col,Pieces,Piece1) :-
  getId(Piece1,Id),
  ((Row == 1, Col \= 1, adjRectHorz(Board,Row,Col,Id,Id,[],PiecesAux,Piece1));
  (Row == 10, Col \= 10,  adjRectHorz(Board,Row,Col,Id,Id,[],PiecesAux,Piece1));
 adjRectVert(Board,Row,Col,Id,Id,[],PiecesAux,Piece1)),
  append(PiecesAux,[],Pieces).


adjRect1(Board,Adjacents):-
    Col is 2,
    getPiece(Col,2,Board,Piece1),
    getTriangleUp(Col,3,Board,Piece2),
    getPiece(Col,4,Board,Piece3),
    getTriangleUp(Col,5,Board,Piece4),
    getPiece(Col,1,Board,Piece5),
    adjRect(Board,1,Col,Pieces1,Piece5),
    getPiece(1,6,Board,Piece6),
    adjRect(Board,6,1,Pieces2,Piece6),
    append(Pieces1,Pieces2,Aux),
    append([ [[2,Col],Piece1], [ [3,Col], Piece2], [[4,Col],Piece3],[[5,Col],Piece4] ],Aux,Adjacents).

adjRect2(Board,Adjacents):-
    Row is 2,
    getPiece(2,Row,Board,Piece1),
    getTriangleUp(3,Row,Board,Piece2),
    getPiece(4,Row,Board,Piece3),
    getTriangleUp(5,Row,Board,Piece4),
    getPiece(1,1,Board,Piece5),
    adjRect(Board,1,1,Pieces1,Piece5),
    getPiece(6,1,Board,Piece6),
    adjRect(Board,1,6,Pieces2,Piece6),
    append(Pieces1,Pieces2,Aux),
    append([  [[Row,2],Piece1],  [[Row,3],Piece2], [ [Row,4], Piece3], [[Row,5],Piece4]],Aux,Adjacents).


adjRect3(Board,Adjacents):-
    Row is 2,
    getPiece(6,Row,Board,Piece1),
    getTriangleUp(7,Row,Board,Piece2),
    getPiece(8,Row,Board,Piece3),
    getTriangleUp(9,Row,Board,Piece4),
    getPiece(10,Row,Board,Piece5),
    adjRect(Board,Row,10,Pieces1,Piece5),
    getPiece(5,1,Board,Piece6),
    adjRect(Board,1,5,Pieces2,Piece6),
    append(Pieces1,Pieces2,Aux),
    append([  [[Row,6],Piece1],  [[Row,7],Piece2], [ [Row,8], Piece3], [[Row,9],Piece4]],Aux,Adjacents).

adjRect4(Board,Adjacents):-
    Col is 9,
    getTriangleUp(Col,2,Board,Piece1),
    getPiece(Col,3,Board,Piece2),
    getTriangleUp(Col,4,Board,Piece3),
    getPiece(Col,5,Board,Piece4),
    getPiece(10,1,Board,Piece5),
    adjRect(Board,1,1,Pieces1,Piece5),
    getPiece(10,6,Board,Piece6),
    adjRect(Board,1,1,Pieces2,Piece6),
    append(Pieces1,Pieces2,Aux),
    append([  [[2,Col],Piece1],  [[3,Col],Piece2], [ [4,Col], Piece3], [[5,Col],Piece4],[[1,10],Piece5]],Aux,Adjacents).

adjRect5(Board,Adjacents):-
    Col is 9,
    getTriangleUp(Col,6,Board,Piece1),
    getPiece(Col,7,Board,Piece2),
    getTriangleUp(Col,8,Board,Piece3),
    getPiece(Col,9,Board,Piece4),
    getPiece(Col,10,Board,Piece5),
    adjRect(Board,10,Col,Pieces1,Piece5),
    getPiece(10,5,Board,Piece6),
    adjRect(Board,5,10,Pieces2,Piece6),
    append(Pieces1,Pieces2,Aux),
    append([  [[6,Col],Piece1],  [[7,Col],Piece2], [ [8,Col], Piece3], [[9,Col],Piece4]],Aux,Adjacents).

adjRect6(Board,Adjacents):-
    Row is 9,
    getTriangleDown(6,Row,Board,Piece1),
    getPiece(7,Row,Board,Piece2),
    getTriangleDown(8,Row,Board,Piece3),
    getPiece(9,Row,Board,Piece4),
    getPiece(10,10,Board,Piece5),
    adjRect(Board,10,10,Pieces1,Piece5),
    getPiece(5,10,Board,Piece6),
    adjRect(Board,10,5,Pieces2,Piece6),
    append(Pieces1,Pieces2,Aux),
    append([  [[Row,6],Piece1],  [[Row,7],Piece2], [ [Row,8], Piece3], [[Row,9],Piece4]],Aux,Adjacents).

adjRect7(Board,Adjacents):-
    Row is 9,
    getTriangleDown(2,Row,Board,Piece1),
    getPiece(3,Row,Board,Piece2),
    getTriangleUp(4,Row,Board,Piece3),
    getPiece(5,Row,Board,Piece4),
    getPiece(1,Row,Board,Piece5),
    adjRect(Board,Row,1,Pieces1,Piece5),
    getPiece(6,10,Board,Piece6),
    adjRect(Board,10,6,Pieces2,Piece6),
    append(Pieces1,Pieces2,Aux),
    append([  [[Row,2],Piece1],  [[Row,3],Piece2], [ [Row,4], Piece3], [[Row,5],Piece4]],Aux,Adjacents).


adjRect8(Board,Adjacents):-
    Col is 2,
    getPiece(Col,6,Board,Piece1),
    getTriangleUp(Col,7,Board,Piece2),
    getPiece(Col,8,Board,Piece3),
    getTriangleUp(Col,9,Board,Piece4),
    getPiece(1,10,Board,Piece5),
    adjRect(Board,10,1,Pieces1,Piece5),
    getPiece(1,5,Board,Piece6),
    adjRect(Board,5,1,Pieces2,Piece6),
    append(Pieces1,Pieces2,Aux),
    append([  [[6,Col],Piece1],  [[7,Col],Piece2], [ [8,Col], Piece3], [[9,Col],Piece4]],Aux,Adjacents).

%adjacents of rectangles 
adjacentRectangle(Board,Col,Row,Adjacents):-

  ((Col == 1, Row < 6,
    adjRect1(Board,Adjacents));
  (Col== 1, Row >= 6, Row < 10,
    adjRect8(Board,Adjacents));
  (Row == 1, Col < 6,
    adjRect2(Board,Adjacents));
  (Row == 1, Col >= 6,
    adjRect3(Board,Adjacents));
  (Col == 10, Row < 6,
    adjRect4(Board,Adjacents));
  (Col == 10, Row >= 6,
    adjRect5(Board,Adjacents));
  (Row == 10, Col < 6,
    adjRect7(Board,Adjacents));
  (Row == 10, Col >= 6,
    adjRect6(Board,Adjacents))    
    ).