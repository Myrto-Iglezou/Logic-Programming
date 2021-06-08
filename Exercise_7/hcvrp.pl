% Logic Programming
% 7th exercise

% Iglezou Myrto - 1115201700038

:- lib(ic).
:- lib(ic_global).
:- lib(branch_and_bound).

hcvrp(NCl, NVe, Timeout, FinalSolution, Cost, Time):-
	length(Solution,NVe),
	createList(Solution,NCl),
	flatten(Solution, FlatSol),
	FlatSol #:: [0..NCl],
	clients(X),
	vehicles(Y),
	take(X, NCl, MyClients),		% put clients in a list
	take(Y, NVe, Capacities),		% put vehicles in a list
	listOfQuantity(MyClients, Quantities),  % make a list of clients demands
	dimX(MyClients,Xd),			% a list of all Xs
	dimY(MyClients,Yd),			% a list of all Ys
	appendFirst(0, Xd,Xdim),
	appendFirst(0, Yd,Ydim),
	findDistances(Xdim, Ydim, Xdim, Ydim, Distances),		% create an array of all distances
	flatten(Distances,FLD),
	appendFirst(0, Quantities, Demands),
	do_list(NCl, ListOfNumCL),						% create a list of numbers representing clients, ex. [1,2,3,4,...]
	firstConstrain(ListOfNumCL, FlatSol),			% constrain that every client appears once
	secondConstrain(Solution, Capacities, Demands),  	% constrain that every vehicle carries certain amount 
	thirdConstrain(Solution),						% contrain of the order of clients, ex [1,2,0,0] and not [0,1,0,2] 
	computeCost(NCl, Solution, FLD, FinalCostList),		% cost function
	Cost #= sum(FinalCostList),
	bb_min(search(Solution, 0, input_order, indomain, complete, []),  % find the solution with min cost
		Cost, bb_options{strategy:continue, timeout:Timeout}),
	fixAppearance(Solution,FinalSolution),
	cputime(Time).
	

%%%%%%%%%%%%%%%%%%%%%%%%  CONSTRAINS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

firstConstrain([],_).
firstConstrain([CL|RestCL],FlatSol):-
	occurrences(CL,FlatSol,1),
	firstConstrain(RestCL,FlatSol).

secondConstrain([],[],_).
secondConstrain([FVe|RestVe],[FQVe|RestQVe],Demands):-
	checkQuantity(FVe,Demands,ClientsQuantities),
	sum(ClientsQuantities) #=< FQVe,
	secondConstrain(RestVe, RestQVe,Demands).

thirdConstrain([]).
thirdConstrain([FVe|RestVe]):-
	clientOrder(FVe),
	thirdConstrain(RestVe).

clientOrder([_]).
clientOrder([FirstClient, SecondClient|RestClients]):-
	FirstClient #= 0 => SecondClient#=0,
	clientOrder([SecondClient|RestClients]).


%%%%%%%%%%%%%%%%%%%%%%%  COST FUNCTION  %%%%%%%%%%%%%%%%%%%%%%%%%%%%

computeCost(_,[],_,[]).

computeCost(NCl, [FVe|RVe],FLD,[Cost|RestCosts]):-
	costForVe(NCl, FVe,FLD,CostList),
	Cost #= sum(CostList),
	computeCost(NCl, RVe, FLD, RestCosts).

costForVe(NCl,[FCl|RCl],FLD,[H|T]):-
	Index #= FCl+1, 
	element(Index,FLD,Cost), % first is the distance from the start point
	H #= Cost,
	restCost(NCl,[FCl|RCl],FLD,T).

restCost(_, [FCl],FLD,[H]):-
	Index #= FCl+1, 
	element(Index,FLD,H).

restCost(NCl, [FCl,SCl|RCl],FLD,[H|T]):-
	Index #= (((NCl+1)*FCl)+SCl+1),
	element(Index,FLD,Cost),
	H #= Cost,
	restCost(NCl,[SCl|RCl],FLD,T).


%%%%%%%%%%%%%%%%% ADDITIONAL FUNCTIONS %%%%%%%%%%%%%%%%


%%%% Distance %%%%

findDistances([],[],_,_,[]).
findDistances([X|RestX],[Y|RestY],XList,YList,[H|T]):-
	computeDistance(X,Y,XList,YList,H),
	findDistances(RestX,RestY,XList,YList,T).


computeDistance(_,_,[],[],[]).
computeDistance(X,Y,[FX|RX],[FY|RY],[S|T]):-
	Temp is (FX-X)^2 + (FY-Y)^2,
	SQ is round(sqrt(Temp)*10^3),
	S is integer(SQ),
	computeDistance(X,Y,RX,RY,T).

dimX([],[]).
dimX([c(_,X,_)|T],[X|Rest]):-
	dimX(T,Rest).

dimY([],[]).
dimY([c(_,_,X)|T],[X|Rest]):-
	dimY(T,Rest).

%%%%  Quantity  %%%%

checkQuantity([],_,[]).
checkQuantity([FirstClient|RestClients],Demands,[X|Tail]):-
	N #= FirstClient + 1,
	element(N, Demands, X),
	checkQuantity(RestClients,Demands,Tail).

listOfQuantity([],[]).
listOfQuantity([c(X,_,_)|T],[X|Rest]):- 
	listOfQuantity(T,Rest).


%%%%  List  %%%%


createList([],_).
createList([F|Rest],NCl):-
	length(F,NCl),
	createList(Rest,NCl).

appendFirst(Item, List, [Item|List]).

do_list(N, L):- 
  findall(Num, between(1, N, Num), L).

between(LBound, RBound, LBound) :-
    RBound >= LBound. 
between(LBound, RBound, Result) :-
    LBound < RBound,
    NextLBound is LBound + 1,
    between(NextLBound, RBound, Result).


take([_|_], 0, []).
take([H|_],1,[H]).
take([X|T1],N,[X|T2]):-
	N>=0,
	N1 is N-1,
	take(T1,N1,T2).


%%%%  Final Appearance  %%%%

fixAppearance([],[]).
fixAppearance([S|RS],[FS|RFS]):-
	fixVe(S,FS),
	fixAppearance(RS,RFS).

fixVe([],[]).
fixVe([FC|RC],[FC|RFC]):-
	FC>0,
	fixVe(RC,RFC).
	
fixVe([_|RC],FinalSol):-
	fixVe(RC,FinalSol).
