% Logic Programming
% 6th exercise

% Iglezou Myrto - 1115201700038

:- lib(ic).
:- lib(branch_and_bound).

flights(I,Pairings,Cost):-
	get_flight_data(I, _, PairingList, CostList),
	findFlights(PairingList,Flights),
	length(PairingList,NumOfPairings),
	length(BinaryPairList,NumOfPairings),
	BinaryPairList #:: [0,1],
	constrain(Flights, PairingList, BinaryPairList),
	costFunction(BinaryPairList,CostList,FinalCostList),
	Cost #= sum(FinalCostList),
	bb_min(search(BinaryPairList, 0, anti_first_fail, indomain_median, complete, []),		% find the solution with the minimum cost
		Cost, bb_options{strategy:continue}),
	fixPairingList(BinaryPairList,PairingList,CostList,Pairings).


%%%%% function for returning the list of pairings from the binary list %%%%%%%


fixPairingList([],[],[],[]).
fixPairingList([BF|BRest],[_|RestPairs],[_|RestCosts],FinalPairings):-
	BF is 0,
	fixPairingList(BRest,RestPairs,RestCosts,FinalPairings).

fixPairingList([BF|BRest],[FPair|RestPairs],[FCost|RestCosts],[[FPair/FCost]|RestFinals]):-
	BF is 1,
	fixPairingList(BRest,RestPairs,RestCosts,RestFinals).


%%%%%%%% function that returns a list of all the flights %%%%%%%%%%


findFlights(PairingList,Flights):-
  flatten(PairingList,Flights1),
  sort(Flights1,Flights).


%%%%%%%%% function that returns the pairings of a flight %%%%%%%%%%%


findPairings(_,[],[],[]).

findPairings(Flight,[FPair|RestPairs],[BF|BRest],[BF|Rest]):-
	member(Flight,FPair),
	findPairings(Flight,RestPairs,BRest,Rest),!.

findPairings(Flight,[_|RestPairs],[_|RestBinary],PairingsOfFlight):-
	findPairings(Flight,RestPairs,RestBinary,PairingsOfFlight).


%%%%%%%%% Cost function %%%%%%%%%%%


costFunction([],[],[]).
costFunction([FP|RP],[FCost|RestCosts],[FC|RC]):-
	FC #= FP * FCost,
	costFunction(RP,RestCosts,RC). 


%%%%%%%%% Constrain of every flight %%%%%%%%%%%

constrain([],_,_).
constrain([FFlight|RestFlights], PairingList,BinaryPairList):-
	findPairings(FFlight,PairingList,BinaryPairList,PairingsOfFlight),		% returns a list of the values (0 or 1) of the Pairings that include the flight
	sum(PairingsOfFlight) #= 1,												% the sum must be 1, because every flight should appear once
	constrain(RestFlights,PairingList,BinaryPairList).

