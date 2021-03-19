

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


combine([],[],[]).
combine([Head|L],[Start|L1],[[Head|Start]|X]):-
	combine(L,L1,X).

combine2([],[],[]).
combine2([Head|L],[Start|L1],[[Head,Start]|X]):-
	combine2(L,L1,X).

create_diag([Head|Tail],[Start|End],L):-
	without_last([Head|Tail], X),
	combine(X,End,Y),
	get_last(Tail,Last),
	append(Y,[[Last]],L).


create_diag([Head|Tail],[List],L):-
	without_last([Head|Tail], X),
	combine2(X,List,Y),
	get_last(Tail,Last),
	append(Y,[[Last]],L).

get_first_row([X|Y],X,Y).
%get_first_row([[]|[]],[],[]).


% diagonal([[X|_]],[],[[X]]).
% diagonal([X|_],[],[[X]]).

% diagonal(X,[[Y|End]],Newdiag):-
%	create_diag(X,[End],Newdiag).

diagonal([X|Tail],[],[[X]|[Tail]]).		% base case, where is one line in the matrix.

diagonal(X,Y,[Start|L]):-
	get_first_row(Y,X1,Y1),
	diagonal(X1,Y1,[Start|End]),
	
	create_diag(X,End,L).


diags(Matrix,diag):-
	% get_first_row(Matrix,X,Y),
	diagonal([],Matrix,Diag).


% diags(Matrix,[[Start]|Diag]):-
%	get_first_row(Matrix,X,[[Start|L]]),

%	diags()

%	create_diag(X,[L],Diag).


diag1(Matrix, Diag) :-
    diag1(Matrix, [], Diag).

diag1([], _, []).
diag1([Row|Rows], Fs, [D|Ds]) :-
    front_same_length(Fs, D, Row),
    diag1(Rows, [_|Fs], Ds).

front_same_length([], D, [D|_]).
front_same_length([_|Xs], D, [_|Rs]) :-
    front_same_length(Xs, D, Rs).

% find_all_diags([Head|Tail],[[Start|End]],L):-

