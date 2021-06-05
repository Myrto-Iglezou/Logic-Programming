% Logic Programming
% 7th exercise

% Iglezou Myrto - 1115201700038

:- lib(ic).
:- lib(ic_global).
:- lib(branch_and_bound).


hcvrp(NCl, NVe, Timeout, Solution, MyClients, Demands):-
	length(Solution,NVe),
	createList(Solution,NCl),
	Solution #:: 0..NCl,
	clients(X),
	vehicles(Y),
	take(X, NCl, MyClients),
	take(Y, NVe, Capacities),
	listOfQuontity(MyClients, Quontities),
	appendFirst(0, Quontities,Demands),
	flatten(Solution,FlatSol),
	do_list(NCl,ListOfNumCL),
	firstConstrain(ListOfNumCL,FlatSol),
	secondConstrain(Solution,Capacities,Demands),
	%Cost #= sum(FinalCostList),
	search(Solution, 0, anti_first_fail, indomain_median, complete, []).

secondConstrain([],[],_).
secondConstrain([FVe|RestVe],[FQVe|RestQVe],Demands):-
	writeln(FVe),
	writeln(Demands),
	checkQuontity(Fve,Demands,ClientsQuontities),
	writeln(sum(ClientsQuontities)),
	writeln(FQVe),
	sum(ClientsQuontities) #=< FQVe,
	secondConstrain(RestVe, RestQVe,Demands).

checkQuontity(List,_,[]):-
	List #= [].

checkQuontity([FirstClient|RestClients],Demands,[X|Tail]):-
	writeln(FirstClient),
	writeln(Demands),
	N #= FirstClient + 1,
	element(N, Demands, X),
	writeln(X),
	checkQuontity(RestClients,Demands,Tail).

listOfQuontity([],[]).
listOfQuontity([c(X,_,_)|T],[X|Rest]):- 
	listOfQuontity(T,Rest).

createList([],_).
createList([F|Rest],NCl):-
	length(F,NCl),
	createList(Rest,NCl).

appendFirst(Item, List, [Item|List]).

do_list(N, L):- 
  findall(Num, between(1, N, Num), L).


firstConstrain([],_).
firstConstrain([CL|RestCL],FlatSol):-
	occurrences(CL,FlatSol,1),
	firstConstrain(RestCL,FlatSol).


between(LBound, RBound, LBound) :-
    RBound >= LBound. 
between(LBound, RBound, Result) :-
    LBound < RBound,
    NextLBound is LBound + 1,
    between(NextLBound, RBound, Result).


take([H|_], 0, []).
take([H|_],1,[H]).
take([X|T1],N,[X|T2]):-
	N>=0,
	N1 is N-1,
	take(T1,N1,T2).