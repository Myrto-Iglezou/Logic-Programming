% Logic Programming
% 5th exercise

% Iglezou Myrto - 1115201700038

:- lib(ic).
:- lib(branch_and_bound).


games_csp(Ps,T,K,FinalGs,P):-
	length(Ps,N),
	length(FinalGs,N),				% list of the times a game is played
	length(CostList,N),				% list of pleasures
	FinalGs #:: 1..T,
	CurrentMarks #:: 0..T,			% current marks
	CurrentMarks is T,
	constrain(Ps,T, K, CurrentMarks, FinalGs, CostList),
	P #= sum(CostList),				% total pleasure
	Cost #= -P, 					% min cost is max pleasure
	bb_min(search(FinalGs, 0, most_constrained , indomain , complete, []),			% search for a solution with minimum cost
	Cost, bb_options{strategy:continue, solutions:all}).


constrain([],_,_,_,[],[]).
constrain([Game|RestGames],T, K, CurrentMarks, [FTimes|RestTimes],[Ples|RestPles]):-
	Game >= 0,
	FTimes #=< CurrentMarks,			% the times a game is played, are always less than the current marks
	CurrentMarks2 #= min(CurrentMarks - FTimes + K, T),
	Ples #= Game * FTimes,
	constrain(RestGames,T,K,CurrentMarks2,RestTimes,RestPles). 

constrain([Game|RestGames],T, K, CurrentMarks, [FTimes|RestTimes],[Ples|RestPles]):-			% in case pleasure is negative, the game is played once
	Game < 0,
	FTimes #= 1,
	CurrentMarks2 #= min(CurrentMarks - FTimes + K, T),
	Ples #= Game ,
	constrain(RestGames,T,K,CurrentMarks2,RestTimes,RestPles). 

