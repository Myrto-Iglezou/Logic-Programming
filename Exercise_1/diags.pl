% Logic Programming
% First exercise

% Iglezou Myrto - 1115201700038


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

