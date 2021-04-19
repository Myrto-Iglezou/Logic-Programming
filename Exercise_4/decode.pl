% Logic Programming
% 4th Exercise

% Iglezou Myrto - 1115201700038


:- lib(ic).

%%%%%%%%%%%%%%%%%%%%%%%%%  Matrix  %%%%%%%%%%%%%%%%%%%%%%%%%%

make_matrix(M, N, Matrix) :-
   length(Matrix, M),
   make_lines(N, Matrix).

make_lines(_, []).
make_lines(N, [Line|Matrix]) :-
   length(Line, N),
   make_lines(N, Matrix).

del_first([], [], []).
del_first([[X|L]|R], [X|RX], [L|RL]) :-
   del_first(R, RX, RL).

empty_lists([]).
empty_lists([[]|M]) :-
   empty_lists(M).

matr_transp(M, []) :-
   empty_lists(M).
matr_transp(M, [C|TM]) :-
   del_first(M, C, RM),
   matr_transp(RM, TM).

%%%%%%%%%%%%%%%%%%%%%%%%%%   Diags  %%%%%%%%%%%%%%%%%%%%%%%%%%


get_last([X],X).
get_last([_|L],X):-
	get_last(L,X).

without_last([_], []).
without_last([X|Xs], [X|WithoutLast]) :- 
    without_last(Xs, WithoutLast).


combine([],[],[]).
combine([Head|L],[Start|L1],[[Head|Start]|X]):-  % combine two lists like [1,2,3] and [[7,8]] --> [[1,7],[2,8],[3]]
	combine(L,L1,X).

combine2([],[],[]).
combine2([Head|L],[Start|L1],[[Head,Start]|X]):-  % combine two lists like [1,2,3] and [[4,5],[6]] --> [[1,4,5],[2,6],[3]]
	combine2(L,L1,X).

create_diag([Head|Tail],List,L):-		% this is in case diag is like [[.],[.],[.]]
	without_last([Head|Tail], X),
	combine(X,List,Y),
	get_last(Tail,Last),
	append(Y,[[Last]],L).


create_diag([Head|Tail],[List],L):-   % this is in case diag is like [[.]]
	without_last([Head|Tail], X),
	combine2(X,List,Y),
	get_last(Tail,Last),
	append(Y,[[Last]],L).

get_first_row([X|Y],X,Y).


diagonal([X|Tail],[],[[X]],[Tail]).		% base case, where is one line left in the matrix

diagonal(X,Y,Final,L):-
	get_first_row(Y,X1,Y1),
	diagonal(X1,Y1,Start,End),			% start from the smallest array
	
	create_diag(X,End,[Diag|L]),
	append(Start,[Diag],Final).			% Keep the first element of the diagonal returned to another list, because it is not needed to next recursion

reverse_all_diags([],[]).
reverse_all_diags([Start|End],[X|L]):-
	reverse(Start,X),
	reverse_all_diags(End,L).

diagsDown(Matrix,Diag):-
	get_first_row(Matrix,X,Y),
	diagonal(X,Y,First,Second),
	append(First,Second,Diag). 			% join the upper and down diagonals 

diagsUp(Matrix,RevDiag):-
	reverse(Matrix,RevMatrix),
	get_first_row(RevMatrix,X,Y),
	diagonal(X,Y,First,Second),
	append(First,Second,Diag),  		% join the upper and down diagonals 
	reverse_all_diags(Diag,RevDiag).		

diags(Matrix,DiagsD,DiagsU):-
	diagsDown(Matrix,DiagsD),
	diagsUp(Matrix,DiagsU).


%%%%%%%%%%%%%%%%%%%%%%%%% Decode %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

decode(Rows,Columns,DownDiags,Updiags):-
	length(Rows,M),
	length(Columns,N),
	make_matrix(M,N,Matrix),		% create a MxN matrix
	Matrix #:: [1,0],				% the two possible values of every position are 0 or 1. we want 1 for ' * ' and 0 for ' . '
	findSum(Matrix,Rows),				% state the constraint of rows sum
	matr_transp(Matrix,TransMatrix),	% find the columns of the matrix
	findSum(TransMatrix,Columns),		% state the constraint of columns sum
	diags(Matrix,DiagsD,DiagsU),		% find the diagonals of the matrix
	findSum(DiagsD,DownDiags),			% state the constraint of down diagonals sum
	findSum(DiagsU,Updiags),			% state the constraint of up diagonals sum
	search(Matrix, 0, input_order, indomain, complete, []),		% search for solution
	paintMatrix(Matrix).				% paint the result

findSum([],[]).
findSum([Row|RestRows],[X|End]):-
	X #= sum(Row),
	findSum(RestRows,End).

paintMatrix([]).
paintMatrix([Row|RestRows]):-
	paintRow(Row),
	paintMatrix(RestRows).

paintRow([]):-
	write("\n").

paintRow([Pixel|RestPixels]):-
	Pixel is 0,
	write(" . "),
	paintRow(RestPixels).

paintRow([Pixel|RestPixels]):-
	Pixel is 1,
	write(" * "),
	paintRow(RestPixels).




