% Logic Programming
% Third exercise

% Iglezou Myrto - 1115201700038

play(Capacity, InitialMarks, Times, GiftMarks, FinalMarks):-
	AfterMarks is InitialMarks - Times,
	NewMarks is AfterMarks + GiftMarks,
	compareMarks(Capacity,NewMarks,FinalMarks).


compareMarks(Capacity,NewMarks,Capacity):-
	NewMarks >= Capacity,!.
compareMarks(Capacity,NewMarks,NewMarks).


between(LBound, RBound, LBound) :-
    RBound >= LBound. 
between(LBound, RBound, Result) :-
    LBound < RBound,
    NextLBound is LBound + 1,
    between(NextLBound, RBound, Result).

firstGame(Game, T, K, Times, Pl):-
	between(1,T,Times),
	Pl is Game*Times.
	

restGames([], _, _, _, [], CurPl ,Pl):-
 	Pl is CurPl.

restGames([Game|RestGames], T, K, CurrentMarks, [FTimes|RestTimes], CurPl, Pl):-
	between(1,CurrentMarks,FTimes),
	CurPles is Game*FTimes,
	NewPl is CurPl + CurPles,
	play(T, CurrentMarks, FTimes, K, FinalMarks),
	restGames(RestGames, T, K, FinalMarks, RestTimes, NewPl, Pl).

solution([Game|RestGames], T, K, [FTimes|RestTimes], Pl):-
	firstGame(Game, T, K, FTimes, FirstPl),
	play(T, T, FTimes, K, FinalMarks),
	restGames(RestGames, T, K, FinalMarks, RestTimes, FirstPl, Pl).

games(Ps,T,K,FinalGs,MaxP):-
	findall(p(Gs,P),solution(Ps,T,K,Gs,P), L),  
	findmax(L,MaxP),
	member(p(FinalGs,MaxP), L).

findmax([p(_,A)],A).
findmax([p(_,A1)|L], MaxA):-
	findmax(L, MaxL),
	max2(A1, MaxL, MaxA).

max2(X, Y, X):- X >= Y.
max2(X, Y, Y):- X < Y.

