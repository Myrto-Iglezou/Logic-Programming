% Logic Programming
% Third exercise

% Iglezou Myrto - 1115201700038

play(Capacity, InitialMarks, Times, GiftMarks, FinalMarks):-		% calculate the marks after playing a game
	AfterMarks is InitialMarks - Times,
	NewMarks is AfterMarks + GiftMarks,
	compareMarks(Capacity,NewMarks,FinalMarks).

compareMarks(Capacity,NewMarks,Capacity):-			% check that there are no more than the initial number of marks in the bucket
	NewMarks >= Capacity,!.
compareMarks(_,NewMarks,NewMarks).


between(LBound, RBound, LBound) :-
    RBound >= LBound. 
between(LBound, RBound, Result) :-
    LBound < RBound,
    NextLBound is LBound + 1,
    between(NextLBound, RBound, Result).


solution([], _, _, _, [], CurPl ,Pl):-		% return the final pleasure
 	Pl is CurPl.

solution([Game|RestGames], T, K, CurrentMarks, [FTimes|RestTimes],CurPl, Pl):-		% in case of positive pleasure, check all possible senarios of time playing
	Game >= 0,
	between(1,CurrentMarks,FTimes),
	CurPles is Game*FTimes,
	NewPl is CurPl + CurPles,
	play(T, CurrentMarks, FTimes, K, FinalMarks),
	solution(RestGames, T, K, FinalMarks, RestTimes, NewPl, Pl).

solution([Game|RestGames], T, K, CurrentMarks, [FTimes|RestTimes],CurPl, Pl):-		% in case of negative pleasure, the game will be played only once
	Game < 0,
	FTimes = 1, 
	CurPles is Game*FTimes,
	NewPl is CurPl + CurPles,
	play(T, CurrentMarks, FTimes, K, FinalMarks),
	solution(RestGames, T, K, FinalMarks, RestTimes, NewPl, Pl).


games(Ps,T,K,FinalGs,MaxP):-
	findall(p(Gs,P),solution(Ps,T,K,T,Gs,0,P), L),  
	findmax(L,MaxP),
	member(p(FinalGs,MaxP), L).

findmax([p(_,A)],A).
findmax([p(_,A1)|L], MaxA):-
	findmax(L, MaxL),
	max2(A1, MaxL, MaxA).

max2(X, Y, X):- X >= Y.
max2(X, Y, Y):- X < Y.

