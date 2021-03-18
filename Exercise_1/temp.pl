
get_first_row([X|Y],X,Y).

add_first(L,X,[X|L]).


split_list([X|[]],[[X]]).
split_list([Head|Tail],[[Head]|Next]):-
	split_list(Tail,Next).

remove_first([Head|Tail],Head,Tail).

remove_last([_|[_,Last]],Last).

get_last([X],X).
get_last([_|L],X):-
	get_last(L,X).

without_last([_], []).
without_last([X|Xs], [X|WithoutLast]) :- 
    without_last(Xs, WithoutLast).


lists([], []).
lists([[Head|_]|Lists], [Head|L]):-
  lists(Lists, L).
lists([[_,Head|Tail]|Lists], L):-
  lists([[Head|Tail]|Lists], L).

% temp(Matrix,Lists):-
% 	get_first_row(Matrix,X,Y).
% 	create_diag(A,B).


combine([],[],[]).
combine([Head|L],[Start|L1],[[Head,Start]|X]):-
	combine(L,L1,X).


create_diag([Head|Tail],[[Start|End]],[[Start]|L]):-
	without_last([Head|Tail], X),
	combine(X,End,Y),
	get_last(Tail,Last),
	append(Y,[[Last]],L).

diags([],[]).
diags(Matrix,X,Y):-
	get_first_row(Matrix,X,Y).
	%create_diag(X,Y,Diag).



